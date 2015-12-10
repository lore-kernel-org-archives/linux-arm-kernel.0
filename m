From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 10 Dec 2015 00:22:13 +0000
Subject: Domain faults when CONFIG_CPU_SW_DOMAIN_PAN is enabled
In-Reply-To: <45b615420548463ebd1d582bc5da2eff@EMAIL.axentia.se>
References: <1267b061b66c4d1fa8af1955825bc97a@EMAIL.axentia.se>
 <20151203110041.GK8644@n2100.arm.linux.org.uk>
 <f7774151e4a849e682ae5a607a98140b@EMAIL.axentia.se>
 <20151203115143.GM8644@n2100.arm.linux.org.uk>
 <533b0f1f264e42e78b94bbff9570fb50@EMAIL.axentia.se>
 <20151203133727.GN8644@n2100.arm.linux.org.uk>
 <94580382ca344ae2b64f66fb778c6ff7@EMAIL.axentia.se>
 <20151203164118.GR8644@n2100.arm.linux.org.uk>
 <20151203172708.GT8644@n2100.arm.linux.org.uk>
 <45b615420548463ebd1d582bc5da2eff@EMAIL.axentia.se>
Message-ID: <20151210002213.GL8644@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 03, 2015 at 09:37:51PM +0000, Peter Rosin wrote:
> I took both patches for a quick spin (a dozen boots and one hour uptime
> after that for each patch) and no incidents. I have not gathered data,
> but the crash on boot feels like it's quite a bit above 50% when there
> is a problem so this feels good (I used 5 clean reboots when I bisected
> and that worked).
> 
> Reported-by: Peter Rosin <peda@axentia.se>
> Tested-by: Peter Rosin <peda@axentia.se>
> 
> (and please don't forget to cc stable)

I've decided to do a more in-depth fix, so that we also solve the issue
that when we schedule in these down_read()s, we don't leak the permissive
domain register setting into the switched-to context.

Can you test this patch please?  Thanks.

8<====
Subject: [PATCH] ARM: fix uaccess_with_memcpy() with SW_DOMAIN_PAN

The uaccess_with_memcpy() code is currently incompatible with the SW
PAN code: it takes locks within the region that we've changed the DACR,
potentially sleeping as a result.  As we do not save and restore the
DACR across co-operative sleep events, can lead to an incorrect DACR
value later in this code path.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/include/asm/uaccess.h     |  4 ++++
 arch/arm/lib/uaccess_with_memcpy.c | 29 +++++++++++++++++++++++------
 2 files changed, 27 insertions(+), 6 deletions(-)

diff --git a/arch/arm/include/asm/uaccess.h b/arch/arm/include/asm/uaccess.h
index 8cc85a4ebec2..35c9db857ebe 100644
--- a/arch/arm/include/asm/uaccess.h
+++ b/arch/arm/include/asm/uaccess.h
@@ -510,10 +510,14 @@ __copy_to_user_std(void __user *to, const void *from, unsigned long n);
 static inline unsigned long __must_check
 __copy_to_user(void __user *to, const void *from, unsigned long n)
 {
+#ifndef CONFIG_UACCESS_WITH_MEMCPY
 	unsigned int __ua_flags = uaccess_save_and_enable();
 	n = arm_copy_to_user(to, from, n);
 	uaccess_restore(__ua_flags);
 	return n;
+#else
+	return arm_copy_to_user(to, from, n);
+#endif
 }
 
 extern unsigned long __must_check
diff --git a/arch/arm/lib/uaccess_with_memcpy.c b/arch/arm/lib/uaccess_with_memcpy.c
index d72b90905132..588bbc288396 100644
--- a/arch/arm/lib/uaccess_with_memcpy.c
+++ b/arch/arm/lib/uaccess_with_memcpy.c
@@ -88,6 +88,7 @@ pin_page_for_write(const void __user *_addr, pte_t **ptep, spinlock_t **ptlp)
 static unsigned long noinline
 __copy_to_user_memcpy(void __user *to, const void *from, unsigned long n)
 {
+	unsigned long ua_flags;
 	int atomic;
 
 	if (unlikely(segment_eq(get_fs(), KERNEL_DS))) {
@@ -118,7 +119,9 @@ __copy_to_user_memcpy(void __user *to, const void *from, unsigned long n)
 		if (tocopy > n)
 			tocopy = n;
 
+		ua_flags = uaccess_save_and_enable();
 		memcpy((void *)to, from, tocopy);
+		uaccess_restore(ua_flags);
 		to += tocopy;
 		from += tocopy;
 		n -= tocopy;
@@ -145,14 +148,21 @@ arm_copy_to_user(void __user *to, const void *from, unsigned long n)
 	 * With frame pointer disabled, tail call optimization kicks in
 	 * as well making this test almost invisible.
 	 */
-	if (n < 64)
-		return __copy_to_user_std(to, from, n);
-	return __copy_to_user_memcpy(to, from, n);
+	if (n < 64) {
+		unsigned long ua_flags = uaccess_save_and_enable();
+		n = __copy_to_user_std(to, from, n);
+		uaccess_restore(ua_flags);
+	} else {
+		n = __copy_to_user_memcpy(to, from, n);
+	}
+	return n;
 }
 	
 static unsigned long noinline
 __clear_user_memset(void __user *addr, unsigned long n)
 {
+	unsigned long ua_flags;
+
 	if (unlikely(segment_eq(get_fs(), KERNEL_DS))) {
 		memset((void *)addr, 0, n);
 		return 0;
@@ -175,7 +185,9 @@ __clear_user_memset(void __user *addr, unsigned long n)
 		if (tocopy > n)
 			tocopy = n;
 
+		ua_flags = uaccess_save_and_enable();
 		memset((void *)addr, 0, tocopy);
+		uaccess_restore(ua_flags);
 		addr += tocopy;
 		n -= tocopy;
 
@@ -193,9 +205,14 @@ __clear_user_memset(void __user *addr, unsigned long n)
 unsigned long arm_clear_user(void __user *addr, unsigned long n)
 {
 	/* See rational for this in __copy_to_user() above. */
-	if (n < 64)
-		return __clear_user_std(addr, n);
-	return __clear_user_memset(addr, n);
+	if (n < 64) {
+		unsigned long ua_flags = uaccess_save_and_enable();
+		n = __clear_user_std(addr, n);
+		uaccess_restore(ua_flags);
+	} else {
+		n = __clear_user_memset(addr, n);
+	}
+	return n;
 }
 
 #if 0
-- 
2.1.0

-- 
RMK's Patch system: http://www.arm.linux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently@9.6Mbps down 400kbps up
according to speedtest.net.
