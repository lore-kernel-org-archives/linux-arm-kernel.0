From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 3 Dec 2015 17:27:08 +0000
Subject: Domain faults when CONFIG_CPU_SW_DOMAIN_PAN is enabled
In-Reply-To: <20151203164118.GR8644@n2100.arm.linux.org.uk>
References: <1267b061b66c4d1fa8af1955825bc97a@EMAIL.axentia.se>
 <20151203110041.GK8644@n2100.arm.linux.org.uk>
 <f7774151e4a849e682ae5a607a98140b@EMAIL.axentia.se>
 <20151203115143.GM8644@n2100.arm.linux.org.uk>
 <533b0f1f264e42e78b94bbff9570fb50@EMAIL.axentia.se>
 <20151203133727.GN8644@n2100.arm.linux.org.uk>
 <94580382ca344ae2b64f66fb778c6ff7@EMAIL.axentia.se>
 <20151203164118.GR8644@n2100.arm.linux.org.uk>
Message-ID: <20151203172708.GT8644@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 03, 2015 at 04:41:18PM +0000, Russell King - ARM Linux wrote:
> On Thu, Dec 03, 2015 at 04:12:06PM +0000, Peter Rosin wrote:
> > * uaccess_with_memcpy.c:__copy_to_user() has a mode in which it copies
> >   "non-atomically" (if faulthandler_disabled() returns 0). If a fault
> >   happens during __copy_to_user, what prevents some other thread from
> >   clobbering DACR?
> 
> See the second point above.  Moreover, if we sleep in down_read(),
> then __switch_to() reads the current DACR value and saves it in the
> thread information, and will restore that value when resuming the
> thread - even if the thread has been migrated to a different CPU.

I thought this was correct, but it isn't - that's what my original solution
did, but I think when Will reviewed it, we decided it wasn't necessary -
and it isn't necessary for every single case with the exception of this
one.  This is exactly what's going wrong: the down_read() in these paths
calls into the scheduler, which switches away.  When we come back, the
DACR value is reset by the other thread to 0x51.

There's a few ways to solve this:

1. Make the thread switching code save and restore the DACR register as
   it would do for domains.  This imposes an overhead on every single
   context switch whether or not we happen to be in this _single_
   troublesome code.  (Patch attached - as there's several, I'm attaching
   them.)

2. Add additional code to the uaccess-with-memcpy stuff to reset the
   DACR value prior to using memcpy() or memset().  (Patch attached.)

3. Make uaccess-with-memcpy depend on !CPU_SW_DOMAINS_PAN (suggested by
   Will)

4. Delete the uaccess-with-memcpy code (also suggested by Will.)

I think the best thing I can do is say... "Discuss amongst yourselves" :)

-- 
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
-------------- next part --------------
 arch/arm/kernel/entry-armv.S       | 4 ++--
 arch/arm/kernel/process.c          | 2 +-
 arch/arm/lib/uaccess_with_memcpy.c | 0
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/kernel/entry-armv.S b/arch/arm/kernel/entry-armv.S
index 3ce377f7251f..ae8a3ad763d9 100644
--- a/arch/arm/kernel/entry-armv.S
+++ b/arch/arm/kernel/entry-armv.S
@@ -782,7 +782,7 @@ ENTRY(__switch_to)
  THUMB(	str	lr, [ip], #4		   )
 	ldr	r4, [r2, #TI_TP_VALUE]
 	ldr	r5, [r2, #TI_TP_VALUE + 4]
-#ifdef CONFIG_CPU_USE_DOMAINS
+#if defined(CONFIG_CPU_USE_DOMAINS) || defined(CONFIG_CPU_SW_DOMAIN_PAN)
 	mrc	p15, 0, r6, c3, c0, 0		@ Get domain register
 	str	r6, [r1, #TI_CPU_DOMAIN]	@ Save old domain register
 	ldr	r6, [r2, #TI_CPU_DOMAIN]
@@ -793,7 +793,7 @@ ENTRY(__switch_to)
 	ldr	r8, =__stack_chk_guard
 	ldr	r7, [r7, #TSK_STACK_CANARY]
 #endif
-#ifdef CONFIG_CPU_USE_DOMAINS
+#if defined(CONFIG_CPU_USE_DOMAINS) || defined(CONFIG_CPU_SW_DOMAIN_PAN)
 	mcr	p15, 0, r6, c3, c0, 0		@ Set domain register
 #endif
 	mov	r5, r0
diff --git a/arch/arm/kernel/process.c b/arch/arm/kernel/process.c
index 4adfb46e3ee9..9d80eb20488f 100644
--- a/arch/arm/kernel/process.c
+++ b/arch/arm/kernel/process.c
@@ -229,7 +229,7 @@ copy_thread(unsigned long clone_flags, unsigned long stack_start,
 
 	memset(&thread->cpu_context, 0, sizeof(struct cpu_context_save));
 
-#ifdef CONFIG_CPU_USE_DOMAINS
+#if defined(CONFIG_CPU_USE_DOMAINS) || defined(CONFIG_CPU_SW_DOMAIN_PAN)
 	/*
 	 * Copy the initial value of the domain access control register
 	 * from the current thread: thread->addr_limit will have been
-------------- next part --------------
 arch/arm/kernel/entry-armv.S       | 0
 arch/arm/kernel/process.c          | 0
 arch/arm/lib/uaccess_with_memcpy.c | 7 +++++++
 3 files changed, 7 insertions(+)

diff --git a/arch/arm/lib/uaccess_with_memcpy.c b/arch/arm/lib/uaccess_with_memcpy.c
index d72b90905132..110e3e272583 100644
--- a/arch/arm/lib/uaccess_with_memcpy.c
+++ b/arch/arm/lib/uaccess_with_memcpy.c
@@ -88,6 +88,7 @@ pin_page_for_write(const void __user *_addr, pte_t **ptep, spinlock_t **ptlp)
 static unsigned long noinline
 __copy_to_user_memcpy(void __user *to, const void *from, unsigned long n)
 {
+	unsigned long dacr;
 	int atomic;
 
 	if (unlikely(segment_eq(get_fs(), KERNEL_DS))) {
@@ -98,6 +99,7 @@ __copy_to_user_memcpy(void __user *to, const void *from, unsigned long n)
 	/* the mmap semaphore is taken only if not in an atomic context */
 	atomic = faulthandler_disabled();
 
+	dacr = get_domain();
 	if (!atomic)
 		down_read(&current->mm->mmap_sem);
 	while (n) {
@@ -118,6 +120,7 @@ __copy_to_user_memcpy(void __user *to, const void *from, unsigned long n)
 		if (tocopy > n)
 			tocopy = n;
 
+		set_domain(dacr);
 		memcpy((void *)to, from, tocopy);
 		to += tocopy;
 		from += tocopy;
@@ -153,11 +156,14 @@ arm_copy_to_user(void __user *to, const void *from, unsigned long n)
 static unsigned long noinline
 __clear_user_memset(void __user *addr, unsigned long n)
 {
+	unsigned long dacr;
+
 	if (unlikely(segment_eq(get_fs(), KERNEL_DS))) {
 		memset((void *)addr, 0, n);
 		return 0;
 	}
 
+	dacr = get_domain();
 	down_read(&current->mm->mmap_sem);
 	while (n) {
 		pte_t *pte;
@@ -175,6 +181,7 @@ __clear_user_memset(void __user *addr, unsigned long n)
 		if (tocopy > n)
 			tocopy = n;
 
+		set_domain(dacr);
 		memset((void *)addr, 0, tocopy);
 		addr += tocopy;
 		n -= tocopy;
