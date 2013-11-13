From: stefano.stabellini@eu.citrix.com (Stefano Stabellini)
Date: Wed, 13 Nov 2013 17:33:38 +0000
Subject: Physical memory start contraints in the Linux kernel (Was: Re:
 Xen osstest on Calxeda midway progress (Was: Re: [Xen-devel] [xen-unstable
 test] 21486: tolerable FAIL - PUSHED))
In-Reply-To: <1384339849.5406.52.camel@kazak.uk.xensource.com>
References: <osstest-21486-mainreport@xen.org>
 <201311121939.08971.arnd@arndb.de>
 <alpine.DEB.2.02.1311121843230.26077@kaball.uk.xensource.com>
 <201311122108.01331.arnd@arndb.de>
 <1384339849.5406.52.camel@kazak.uk.xensource.com>
Message-ID: <alpine.DEB.2.02.1311131417030.4714@kaball.uk.xensource.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 13 Nov 2013, Ian Campbell wrote:
> On Tue, 2013-11-12 at 21:08 +0100, Arnd Bergmann wrote:
> > On Tuesday 12 November 2013, Stefano Stabellini wrote:
> > > On Tue, 12 Nov 2013, Arnd Bergmann wrote:
> > > > On Tuesday 12 November 2013, Ian Campbell wrote:
> > > > > On Tue, 2013-11-12 at 14:35 +0000, Julien Grall wrote:
> > > > > > On 11/12/2013 01:37 PM, Arnd Bergmann wrote:
> > > > > > > BTW, does Dom0 require an LPAE-enabled kernel or can it be a regular
> > > > > > > non-LPAE ARMv6/v7 multiplatform build?
> > > > > > 
> > > > > > It can be both.
> > > > > 
> > > > > NB: v7 only, we don't do v6 at all. But yes either LPAE or regular is
> > > > > fine with us.
> > > > 
> > > > Why not combined v6/v7 kernels for non-LPAE? I can't see a technical reason
> > > > preventing you from running a Dom0 or DomU kernel that can also run on
> > > > some ARMv6 platform as long as both platforms and CPUs are enabled in
> > > > Kconfig.
> > > 
> > > Unfortunately today we can't support ARMv6.
> > > From f880b67dcbdedb49453f88d2ccb1a0937b046d82:
> > >    
> > >     * ARMv6 does not support cmpxchg on 16-bit words that are used in the
> > >       Xen grant table code, so we must ensure that Xen support is only
> > >       built on ARMv7-only kernels not combined ARMv6/v7 kernels.
> > 
> > Ah, I must have made a mistake there. It's not strictly a bug, but I think
> > it would be better to undo the dependency I added in that patch and instead
> > change the Makefile to build the grant table code with -march=armv7-a:
> > This is safe because we know that this code will only /run/ on v7 even
> > in a combined v6/v7 kernel, but it lets us get better build coverage because
> > then we will enable Xen support in an allmodconfig or allyesconfig kernel
> > that today enables both v6 and v7.
> > 
> 
> This seems reasonable to me if it can be made to work. e.g. the uses of
> such constructs would need to be in .c files not static inlines in .h
> for it not to get ugly fast. Hopefully that is the case.
> 
> Another thing to watch out for is the atomics in xchg_xen_ulong which is
> used by drivers/xen/events.c and uses atomic64_xchg expecting to get
> exclusive load/store instructions. it looks to me like atomic64_xchg is
> the same for v6 and v7 so that is ok.
> 
> The last thing to watch out for is sync_test_bit/_test_and_set etc.
> Again those look the same to me on v6 and v7.

It is more complicated than I expected as XEN depends on
!GENERIC_ATOMIC64 because we require proper atomic instructions to
read/write memory shared with the hypervisor in events.c (see
85323a991d40681023822e86ca95f38a75262026).
Unfortunately config ARM selects GENERIC_ATOMIC64 if CPU_V6.

In addition to modifying arch/arm/Kconfig and drivers/xen/Makefile I had
to remove the XEN dependency on !GENERIC_ATOMIC64 by reimplementing
atomic64_xchg.

Finally the cmpxchg code used by grant-table.c is in a static inline
protected by #ifndef CONFIG_CPU_V6 (see arch/arm/include/asm/cmpxchg.h).
Passing -march=armv7-a from the Makefile is not enough.


---


diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 01f7013..3a888e1 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1885,8 +1885,7 @@ config XEN_DOM0
 config XEN
 	bool "Xen guest support on ARM (EXPERIMENTAL)"
 	depends on ARM && AEABI && OF
-	depends on CPU_V7 && !CPU_V6
-	depends on !GENERIC_ATOMIC64
+	depends on CPU_V7
 	select ARM_PSCI
 	select SWIOTLB_XEN
 	help
diff --git a/arch/arm/include/asm/xen/events.h b/arch/arm/include/asm/xen/events.h
index 8b1f37b..2032ee6 100644
--- a/arch/arm/include/asm/xen/events.h
+++ b/arch/arm/include/asm/xen/events.h
@@ -16,7 +16,37 @@ static inline int xen_irqs_disabled(struct pt_regs *regs)
 	return raw_irqs_disabled_flags(regs->ARM_cpsr);
 }
 
-#define xchg_xen_ulong(ptr, val) atomic64_xchg(container_of((ptr),	\
+#ifdef CONFIG_GENERIC_ATOMIC64
+/* if CONFIG_GENERIC_ATOMIC64 is defined we cannot use the generic
+ * atomic64_xchg function because it is implemented using spin locks.
+ * Here we need proper atomic instructions to read and write memory
+ * shared with the hypervisor.
+ */
+static inline u64 xen_atomic64_xchg(atomic64_t *ptr, u64 new)
+{
+	u64 result;
+	unsigned long tmp;
+
+	smp_mb();
+
+	__asm__ __volatile__("@ xen_atomic64_xchg\n"
+"1:	ldrexd	%0, %H0, [%3]\n"
+"	strexd	%1, %4, %H4, [%3]\n"
+"	teq	%1, #0\n"
+"	bne	1b"
+	: "=&r" (result), "=&r" (tmp), "+Qo" (ptr->counter)
+	: "r" (&ptr->counter), "r" (new)
+	: "cc");
+
+	smp_mb();
+
+	return result;
+}
+#else
+#define xen_atomic64_xchg atomic64_xchg
+#endif
+
+#define xchg_xen_ulong(ptr, val) xen_atomic64_xchg(container_of((ptr),	\
 							    atomic64_t,	\
 							    counter), (val))
 
diff --git a/drivers/xen/grant-table.c b/drivers/xen/grant-table.c
index 62ccf54..d668c3c 100644
--- a/drivers/xen/grant-table.c
+++ b/drivers/xen/grant-table.c
@@ -33,6 +33,14 @@
 
 #define pr_fmt(fmt) "xen:" KBUILD_MODNAME ": " fmt
 
+/* This is required because cmpxchg only support 32-bits operands on
+ * ARMv6, so if CONFIG_CPU_V6 is defined the cmpxchg implemention will
+ * be limited to 32-bits operands.
+ * However we know for sure that if Linux is running on Xen, the
+ * platform is >= ARMv7, so here we can safely undef CONFIG_CPU_V6.
+ */
+#undef CONFIG_CPU_V6
+
 #include <linux/module.h>
 #include <linux/sched.h>
 #include <linux/mm.h>
