From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 30 Jun 2011 14:33:48 +0200
Subject: [PATCH] ARM TCM sample code
Message-ID: <mailman.88.1313487316.20020.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is a simple sample snippet of ARM TCM code use, we create
arm/test to host the code.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 Documentation/arm/tcm.txt   |   60 +--------------------------
 arch/arm/Kconfig.debug      |    2 +
 arch/arm/Makefile           |    2 +
 arch/arm/test/Kconfig       |   20 +++++++++
 arch/arm/test/Makefile      |    2 +
 arch/arm/test/tcm-example.c |   94 +++++++++++++++++++++++++++++++++++++++++++
 samples/Kconfig             |    9 ++++
 samples/Makefile            |    2 +-
 8 files changed, 132 insertions(+), 59 deletions(-)
 create mode 100644 arch/arm/test/Kconfig
 create mode 100644 arch/arm/test/Makefile
 create mode 100644 arch/arm/test/tcm-example.c

diff --git a/Documentation/arm/tcm.txt b/Documentation/arm/tcm.txt
index 7c15871..f6ead49 100644
--- a/Documentation/arm/tcm.txt
+++ b/Documentation/arm/tcm.txt
@@ -95,61 +95,5 @@ To put assembler into TCM just use
 .section ".tcm.text" or .section ".tcm.data"
 respectively.

-Example code:
-
-#include <asm/tcm.h>
-
-/* Uninitialized data */
-static u32 __tcmdata tcmvar;
-/* Initialized data */
-static u32 __tcmdata tcmassigned = 0x2BADBABEU;
-/* Constant */
-static const u32 __tcmconst tcmconst = 0xCAFEBABEU;
-
-static void __tcmlocalfunc tcm_to_tcm(void)
-{
-	int i;
-	for (i = 0; i < 100; i++)
-		tcmvar ++;
-}
-
-static void __tcmfunc hello_tcm(void)
-{
-	/* Some abstract code that runs in ITCM */
-	int i;
-	for (i = 0; i < 100; i++) {
-		tcmvar ++;
-	}
-	tcm_to_tcm();
-}
-
-static void __init test_tcm(void)
-{
-	u32 *tcmem;
-	int i;
-
-	hello_tcm();
-	printk("Hello TCM executed from ITCM RAM\n");
-
-	printk("TCM variable from testrun: %u @ %p\n", tcmvar, &tcmvar);
-	tcmvar = 0xDEADBEEFU;
-	printk("TCM variable: 0x%x @ %p\n", tcmvar, &tcmvar);
-
-	printk("TCM assigned variable: 0x%x @ %p\n", tcmassigned, &tcmassigned);
-
-	printk("TCM constant: 0x%x @ %p\n", tcmconst, &tcmconst);
-
-	/* Allocate some TCM memory from the pool */
-	tcmem = tcm_alloc(20);
-	if (tcmem) {
-		printk("TCM Allocated 20 bytes of TCM @ %p\n", tcmem);
-		tcmem[0] = 0xDEADBEEFU;
-		tcmem[1] = 0x2BADBABEU;
-		tcmem[2] = 0xCAFEBABEU;
-		tcmem[3] = 0xDEADBEEFU;
-		tcmem[4] = 0x2BADBABEU;
-		for (i = 0; i < 5; i++)
-			printk("TCM tcmem[%d] = %08x\n", i, tcmem[i]);
-		tcm_free(tcmem, 20);
-	}
-}
+Example code can be found in the samples/arm_tcm directory of the kernel
+tree, and can be compiled in using menuconfig.
diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
index 81cbe40..82bf536 100644
--- a/arch/arm/Kconfig.debug
+++ b/arch/arm/Kconfig.debug
@@ -129,4 +129,6 @@ config DEBUG_S3C_UART
 	  The uncompressor code port configuration is now handled
 	  by CONFIG_S3C_LOWLEVEL_UART_PORT.

+source "arch/arm/test/Kconfig"
+
 endmenu
diff --git a/arch/arm/Makefile b/arch/arm/Makefile
index 70c424e..f2f370b 100644
--- a/arch/arm/Makefile
+++ b/arch/arm/Makefile
@@ -255,6 +255,8 @@ core-$(CONFIG_VFP)		+= arch/arm/vfp/
 core-y				+= arch/arm/kernel/ arch/arm/mm/ arch/arm/common/
 core-y				+= $(machdirs) $(platdirs)

+core-$(CONFIG_ARM_TEST)		+= arch/arm/test/
+
 drivers-$(CONFIG_OPROFILE)      += arch/arm/oprofile/

 libs-y				:= arch/arm/lib/ $(libs-y)
diff --git a/arch/arm/test/Kconfig b/arch/arm/test/Kconfig
new file mode 100644
index 0000000..13c38e1
--- /dev/null
+++ b/arch/arm/test/Kconfig
@@ -0,0 +1,20 @@
+config ARM_TEST
+       bool "Enable ARM kernel tests"
+
+if ARM_TEST
+
+menu "ARM Kernel tests"
+
+comment "test code to exercise the ARM kernel"
+
+config ARM_TCM_TEST
+	bool "ARM TCM test"
+	depends on HAVE_TCM
+	help
+		Enables some test code snippets to exercise the TCM memory
+		on platforms that have it. The code will not be executed
+		if no TCM memory is found.
+
+endmenu
+
+endif
diff --git a/arch/arm/test/Makefile b/arch/arm/test/Makefile
new file mode 100644
index 0000000..9161440
--- /dev/null
+++ b/arch/arm/test/Makefile
@@ -0,0 +1,2 @@
+obj-y :=
+obj-$(CONFIG_ARM_TCM_TEST) += tcm-example.o
diff --git a/arch/arm/test/tcm-example.c b/arch/arm/test/tcm-example.c
new file mode 100644
index 0000000..156d97e
--- /dev/null
+++ b/arch/arm/test/tcm-example.c
@@ -0,0 +1,94 @@
+/*
+ * Copyright (C) 2010 ST-Ericsson AB
+ * License terms: GNU General Public License (GPL) version 2
+ * TCM memory test
+ *
+ * Author: Linus Walleij <linus.walleij@stericsson.com>
+ */
+
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <asm/tcm.h>
+
+#define CANARY1 0xDEADBEEFU
+#define CANARY2 0x2BADBABEU
+#define CANARY3 0xCAFEBABEU
+
+/* Uninitialized data */
+static u32 __tcmdata tcmvar;
+/* Initialized data */
+static u32 __tcmdata tcmassigned = CANARY2;
+/* Constant */
+static const u32 __tcmconst tcmconst = CANARY3;
+
+static void __tcmlocalfunc tcm_to_tcm(void)
+{
+	int i;
+	for (i = 0; i < 100; i++)
+		tcmvar ++;
+}
+
+static void __tcmfunc hello_tcm(void)
+{
+	/* Some abstract code that runs in ITCM */
+	int i;
+	for (i = 0; i < 100; i++) {
+		tcmvar ++;
+	}
+	tcm_to_tcm();
+}
+
+static int __init test_tcm(void)
+{
+	u32 *tcmem;
+	int i;
+
+	if (!tcm_dtcm_present() && !tcm_itcm_present()) {
+		pr_info("CPU: no TCMs present, skipping tests\n");
+		return 0;
+	}
+
+	if (!tcm_itcm_present())
+		goto skip_itcm_tests;
+
+	hello_tcm();
+	pr_info("CPU: hello TCM executed from ITCM RAM\n");
+
+	pr_info("CPU: TCM variable from testrun: %u @ %p\n",
+		tcmvar, &tcmvar);
+	BUG_ON(tcmvar != 200);
+
+skip_itcm_tests:
+	tcmvar = CANARY1;
+	pr_info("CPU: TCM variable: 0x%x @ %p\n", tcmvar, &tcmvar);
+	BUG_ON(tcmvar != CANARY1);
+
+	pr_info("CPU: TCM assigned variable: 0x%x @ %p\n",
+		tcmassigned, &tcmassigned);
+	BUG_ON(tcmassigned != CANARY2);
+
+	pr_info("CPU: TCM constant: 0x%x @ %p\n", tcmconst, &tcmconst);
+	BUG_ON(tcmconst != CANARY3);
+
+	/* Allocate some TCM memory from the pool */
+	tcmem = tcm_alloc(20);
+	if (tcmem) {
+		pr_info("CPU: TCM Allocated 20 bytes of TCM @ %p\n", tcmem);
+		tcmem[0] = CANARY1;
+		tcmem[1] = CANARY2;
+		tcmem[2] = CANARY3;
+		tcmem[3] = CANARY1;
+		tcmem[4] = CANARY2;
+		for (i = 0; i < 5; i++)
+			pr_info("CPU: TCM tcmem[%d] = %08x\n", i, tcmem[i]);
+		BUG_ON(tcmem[0] != CANARY1);
+		BUG_ON(tcmem[1] != CANARY2);
+		BUG_ON(tcmem[2] != CANARY3);
+		BUG_ON(tcmem[3] != CANARY1);
+		BUG_ON(tcmem[4] != CANARY2);
+		tcm_free(tcmem, 20);
+	}
+	return 0;
+}
+
+late_initcall(test_tcm);
diff --git a/samples/Kconfig b/samples/Kconfig
index 96a7572..91260c6 100644
--- a/samples/Kconfig
+++ b/samples/Kconfig
@@ -67,4 +67,13 @@ config SAMPLE_HIDRAW
 	help
 	  Build an example of how to use hidraw from userspace.

+config SAMPLE_ARM_TCM
+	bool "TCM sample testing module"
+	depends on HAVE_TCM
+	help
+	  This enables a small testing module that execise the ARM TCM
+	  memory on the platform@startup to make sure it's working.
+	  If you're really using the TCM it is a scarce resource so
+	  this should only be selected for testing and education.
+
 endif # SAMPLES
diff --git a/samples/Makefile b/samples/Makefile
index 6280817..11a1d27 100644
--- a/samples/Makefile
+++ b/samples/Makefile
@@ -1,4 +1,4 @@
 # Makefile for Linux samples code

 obj-$(CONFIG_SAMPLES)	+= kobject/ kprobes/ tracepoints/ trace_events/ \
-			   hw_breakpoint/ kfifo/ kdb/ hidraw/
+			   hw_breakpoint/ kfifo/ kdb/ hidraw/ arm_tcm/
-- 
1.7.3.2


> Are they visible to userspace?

Nope, that's a much asked-for feature, but I don't quite
know how to deal with that.

Thanks,
Linus Walleij


>From bogus@does.not.exist.com  Mon Jun 27 16:47:34 2011
From: bogus@does.not.exist.com ()
Date: Mon, 27 Jun 2011 20:47:34 -0000
Subject: No subject
Message-ID: <mailman.98.1314119850.20020.linux-arm-kernel@lists.infradead.org>

don't have the ELF information at this point.

> =A02. The bootloader will select the first mode from the three listed
> =A0 =A0above which is supported by both the processor and the kernel to
> =A0 =A0be loaded, and transition the processor to that mode. =A0If this
> =A0 =A0involves dropping out of secure or hypervisor mode, it will put
> =A0 =A0those modes permanently beyond use.

I'm not considering this step because of my point above.

> =A03. The kernel will examine CPSR to determine which of the three
> =A0 =A0possibilities above has happened, and:
> =A0 (a) If started in monitor mode:
> =A0 =A0 =A0 * Grant access to everything to non-secure state
> =A0 =A0 =A0 * Set the non-secure copies of the various CP15 registers
> =A0 =A0 =A0 =A0 which don't have a sane value on cpu reset
> =A0 =A0 =A0 * Install a trivial monitor vector which unconditionally
> =A0 =A0 =A0 =A0 copies r0 to MVBAR and returns
> =A0 =A0 =A0 * Switch to non-secure Hyp mode (if available) and do (b),
> =A0 =A0 =A0 =A0 or non-secure Kernel mode (if Hyp mode not supported).
> =A0 (b) If started in Hyp mode:
> =A0 =A0 =A0 * Install a trivial hypervisor vector which unconditionally
> =A0 =A0 =A0 =A0 copies r0 to HVBAR and returns
> =A0 (c) Rest of startup.

Maybe we could allow (b) if SoC vendors don't provide a different API
to set the HVBAR. But it means that kernels not aware of this feature
would fail.

--=20
Catalin


>From bogus@does.not.exist.com  Mon Jun 27 16:47:34 2011
From: bogus@does.not.exist.com ()
Date: Mon, 27 Jun 2011 20:47:34 -0000
Subject: No subject
Message-ID: <mailman.100.1314193888.20020.linux-arm-kernel@lists.infradead.org>

and various bootloader people, it looks like we have two scenarios [this is
reiterating a lot of what you've said but I think it's important]:


  After the system has taken care of whatever secure initialisation was
  required, it moves into HYP mode. At this point there are two things that
  can happen:

  1.0: HYP mode boot loader (uboot, UEFI) runs and installs Linux at the
       same privilege level
  1.1: Raw Linux boots, and detects HYP mode
  1.2: Sets up basic init, with HVC trampoline for installing KVM/Xen later
  1.3: Switch to SVC mode
  1.4: Continue booting Linux as normal

  Or:

  2.0: HYP layer installed as part of system firmware
  2.1: Hypervisor system init, HVC handlers installed
  2.2: Switch to SVC mode
  2.3: SVC mode boot loader (uboot, UEFI) runs and installs Linux
  2.4: Linux boots as normal


Obviously, as kernel developers, we prefer the first approach because it
gives us control over the HYP interface. In practice, I expect to see
some platforms that take the second approach and I think that we have to
support it. The best we can hope for in this case is that the HVC layer
has an API for installing another hypervisor. If that API is standardised,
then even better.

Unlike the fragmented secure monitor API that currently exists across
different platforms, it's really in the interests of the vendor to
standardise on the HYP interface and provide calls to install code, otherwise
they run the risk of producing what is essentially a closed system.

Will


>From bogus@does.not.exist.com  Mon Jun 27 16:47:34 2011
From: bogus@does.not.exist.com ()
Date: Mon, 27 Jun 2011 20:47:34 -0000
Subject: No subject
Message-ID: <mailman.101.1314273235.20020.linux-arm-kernel@lists.infradead.org>

"config HIGHMEM
	bool "High Memory Support"
	depends on MMU
	help
	  The address space of ARM processors is only 4 Gigabytes large
	  and it has to accommodate user address space, kernel address
	  space as well as some memory mapped IO. That means that, if you
	  have a large amount of physical memory and/or IO, not all of the
	  memory can be "permanently mapped" by the kernel. The physical
	  memory that is not permanently mapped is called "high memory".

	  Depending on the selected kernel/user memory split, minimum
	  vmalloc space and actual amount of RAM, you may not need this
	  option which should result in a slightly faster kernel.

	  If unsure, say n."

So is it correct to say that CONFIG_VMSPLIT_2G is preferred over
CONFIG_HIGHMEM due to the "should result in a slightly faster kernel."
statement above?

Regards,

Fabio Estevam


>From bogus@does.not.exist.com  Mon Jun 27 16:47:34 2011
From: bogus@does.not.exist.com ()
Date: Mon, 27 Jun 2011 20:47:34 -0000
Subject: No subject
Message-ID: <mailman.102.1314607932.20020.linux-arm-kernel@lists.infradead.org>

As the SATA controller on "other SoC" so far, we don't know yet if they
show the same issue (which we have to use ahci_pmp_retry_srst_ops).

So Wolfram, how about we consider a generic one once more controllers
are being added?

>
> --
> Pengutronix e.K. =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | Wolfram Sang =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|
> Industrial Linux Solutions =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 | http://www.pengutronix.de/ =C2=A0|
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>
>


>From bogus@does.not.exist.com  Mon Jun 27 16:47:34 2011
From: bogus@does.not.exist.com ()
Date: Mon, 27 Jun 2011 20:47:34 -0000
Subject: No subject
Message-ID: <mailman.103.1314607971.20020.linux-arm-kernel@lists.infradead.org>

doesn't need to provide that level of ordering as its supposed to be
an inter-CPU barrier - which probably means we need to invent a new
barrier to deal with DMA memory ordering.  However, given the
difficulty of getting the existing barriers placed correctly, I don't
think inventing new barriers is a very good idea.

What we can do is view devices which perform DMA as being strongly
ordered with respect to their memory accesses - iow, they have an
implicit memory barrier before and after their accesses to memory.
This would make the CPUs use of mb() have a conceptual pairing with
the DMA agents.


>From bogus@does.not.exist.com  Mon Jun 27 16:47:34 2011
From: bogus@does.not.exist.com ()
Date: Mon, 27 Jun 2011 20:47:34 -0000
Subject: No subject
Message-ID: <mailman.104.1314631319.20020.linux-arm-kernel@lists.infradead.org>

after the qtd transaction is executed when new token is flushed into
memory. The delay
depends on how long the token will be flushed into memory.


>From bogus@does.not.exist.com  Mon Jun 27 16:47:34 2011
From: bogus@does.not.exist.com ()
Date: Mon, 27 Jun 2011 20:47:34 -0000
Subject: No subject
Message-ID: <mailman.105.1314631320.20020.linux-arm-kernel@lists.infradead.org>

delay
is more than 20ms, so caused the bad performance.

Also I am not sure if EHCI can read the old hw_token correctly in this kind=
 of
inconsistent memory state.

>
> Some EHCI implementations have a quirk, in which they perform the
> overlay even when ACTIVE is clear. =A0But even these implementations
> won't try to execute the qTD, because the old value of dummy->hw_token
> also has the HALT bit set.
>
>> It is not only a reasoning or guess, and I have traced this kind of
>> fact certainly.
>
> If your controller behaves as you suggest then it is buggy. =A0And in
> that case, adding another memory barrier won't fix it. =A0There is still
> the possibility that the HC will read dummy during the brief time after
> the existing wmb() and before the CPU has written dummy->hw_token.

No, the mb after 'dummy->hw_token=3Dtoken' does fix the problem. As
said above, IOC IRQ is surely delayed from view of CPU.


thanks,
--
Ming Lei


>From bogus@does.not.exist.com  Mon Jun 27 16:47:34 2011
From: bogus@does.not.exist.com ()
Date: Mon, 27 Jun 2011 20:47:34 -0000
Subject: No subject
Message-ID: <mailman.107.1314712886.20020.linux-arm-kernel@lists.infradead.org>

- Removed the read_sched_clock test from sched_clock() and move
  the jiffies code to its own function, as suggested by Nicolas Pitre.
  WARN_ON are added to ensure that setup_sched_clock() is not called
  in an unsafe context and that we only override the default once.


>From bogus@does.not.exist.com  Mon Jun 27 16:47:34 2011
From: bogus@does.not.exist.com ()
Date: Mon, 27 Jun 2011 20:47:34 -0000
Subject: No subject
Message-ID: <mailman.108.1314712887.20020.linux-arm-kernel@lists.infradead.org>

- Added 'notrace' to all _read_sched_lock() functions, fixing
  the ftrace problem reported by Jamie Iles
- Removed useless #include <linux/sched.h> from touched files
- Made omap_32k_read_sched_clock() static

 arch/arm/include/asm/sched_clock.h       |  108 +---------------------------
 arch/arm/kernel/sched_clock.c            |  115 +++++++++++++++++++++++++++---
 arch/arm/mach-ixp4xx/common.c            |   16 +----
 arch/arm/mach-mmp/time.c                 |   16 +----
 arch/arm/mach-omap1/time.c               |   58 +--------------
 arch/arm/mach-omap2/timer.c              |   20 +----
 arch/arm/mach-pxa/time.c                 |   15 +---
 arch/arm/mach-sa1100/time.c              |   28 +-------
 arch/arm/mach-tegra/timer.c              |   24 +------
 arch/arm/mach-u300/timer.c               |   15 +---
 arch/arm/plat-iop/time.c                 |   16 +----
 arch/arm/plat-mxc/time.c                 |   15 +---
 arch/arm/plat-nomadik/timer.c            |   18 +----
 arch/arm/plat-omap/counter_32k.c         |   40 +----------
 arch/arm/plat-omap/include/plat/common.h |    1 -
 arch/arm/plat-orion/time.c               |   21 +-----
 arch/arm/plat-s5p/s5p-time.c             |   19 +----
 arch/arm/plat-versatile/sched-clock.c    |   29 ++------
 18 files changed, 157 insertions(+), 417 deletions(-)

diff --git a/arch/arm/include/asm/sched_clock.h b/arch/arm/include/asm/sched_clock.h
index c8e6ddf..e3f7572 100644
--- a/arch/arm/include/asm/sched_clock.h
+++ b/arch/arm/include/asm/sched_clock.h
@@ -8,113 +8,7 @@
 #ifndef ASM_SCHED_CLOCK
 #define ASM_SCHED_CLOCK
 
-#include <linux/kernel.h>
-#include <linux/types.h>
-
-struct clock_data {
-	u64 epoch_ns;
-	u32 epoch_cyc;
-	u32 epoch_cyc_copy;
-	u32 mult;
-	u32 shift;
-};
-
-#define DEFINE_CLOCK_DATA(name)	struct clock_data name
-
-static inline u64 cyc_to_ns(u64 cyc, u32 mult, u32 shift)
-{
-	return (cyc * mult) >> shift;
-}
-
-/*
- * Atomically update the sched_clock epoch.  Your update callback will
- * be called from a timer before the counter wraps - read the current
- * counter value, and call this function to safely move the epochs
- * forward.  Only use this from the update callback.
- */
-static inline void update_sched_clock(struct clock_data *cd, u32 cyc, u32 mask)
-{
-	unsigned long flags;
-	u64 ns = cd->epoch_ns +
-		cyc_to_ns((cyc - cd->epoch_cyc) & mask, cd->mult, cd->shift);
-
-	/*
-	 * Write epoch_cyc and epoch_ns in a way that the update is
-	 * detectable in cyc_to_fixed_sched_clock().
-	 */
-	raw_local_irq_save(flags);
-	cd->epoch_cyc = cyc;
-	smp_wmb();
-	cd->epoch_ns = ns;
-	smp_wmb();
-	cd->epoch_cyc_copy = cyc;
-	raw_local_irq_restore(flags);
-}
-
-/*
- * If your clock rate is known at compile time, using this will allow
- * you to optimize the mult/shift loads away.  This is paired with
- * init_fixed_sched_clock() to ensure that your mult/shift are correct.
- */
-static inline unsigned long long cyc_to_fixed_sched_clock(struct clock_data *cd,
-	u32 cyc, u32 mask, u32 mult, u32 shift)
-{
-	u64 epoch_ns;
-	u32 epoch_cyc;
-
-	/*
-	 * Load the epoch_cyc and epoch_ns atomically.  We do this by
-	 * ensuring that we always write epoch_cyc, epoch_ns and
-	 * epoch_cyc_copy in strict order, and read them in strict order.
-	 * If epoch_cyc and epoch_cyc_copy are not equal, then we're in
-	 * the middle of an update, and we should repeat the load.
-	 */
-	do {
-		epoch_cyc = cd->epoch_cyc;
-		smp_rmb();
-		epoch_ns = cd->epoch_ns;
-		smp_rmb();
-	} while (epoch_cyc != cd->epoch_cyc_copy);
-
-	return epoch_ns + cyc_to_ns((cyc - epoch_cyc) & mask, mult, shift);
-}
-
-/*
- * Otherwise, you need to use this, which will obtain the mult/shift
- * from the clock_data structure.  Use init_sched_clock() with this.
- */
-static inline unsigned long long cyc_to_sched_clock(struct clock_data *cd,
-	u32 cyc, u32 mask)
-{
-	return cyc_to_fixed_sched_clock(cd, cyc, mask, cd->mult, cd->shift);
-}
-
-/*
- * Initialize the clock data - calculate the appropriate multiplier
- * and shift.  Also setup a timer to ensure that the epoch is refreshed
- * at the appropriate time interval, which will call your update
- * handler.
- */
-void init_sched_clock(struct clock_data *, void (*)(void),
-	unsigned int, unsigned long);
-
-/*
- * Use this initialization function rather than init_sched_clock() if
- * you're using cyc_to_fixed_sched_clock, which will warn if your
- * constants are incorrect.
- */
-static inline void init_fixed_sched_clock(struct clock_data *cd,
-	void (*update)(void), unsigned int bits, unsigned long rate,
-	u32 mult, u32 shift)
-{
-	init_sched_clock(cd, update, bits, rate);
-	if (cd->mult != mult || cd->shift != shift) {
-		pr_crit("sched_clock: wrong multiply/shift: %u>>%u vs calculated %u>>%u\n"
-			"sched_clock: fix multiply/shift to avoid scheduler hiccups\n",
-			mult, shift, cd->mult, cd->shift);
-	}
-}
-
 extern void sched_clock_postinit(void);
+extern void setup_sched_clock(u32 (*read)(void), int bits, unsigned long rate);
 
 #endif
diff --git a/arch/arm/kernel/sched_clock.c b/arch/arm/kernel/sched_clock.c
index 9a46370..e093289 100644
--- a/arch/arm/kernel/sched_clock.c
+++ b/arch/arm/kernel/sched_clock.c
@@ -14,25 +14,97 @@
 
 #include <asm/sched_clock.h>
 
+struct clock_data {
+	u64 epoch_ns;
+	u32 epoch_cyc;
+	u32 epoch_cyc_copy;
+	u32 mult;
+	u32 shift;
+};
+
 static void sched_clock_poll(unsigned long wrap_ticks);
 static DEFINE_TIMER(sched_clock_timer, sched_clock_poll, 0, 0);
-static void (*sched_clock_update_fn)(void);
+
+static struct clock_data cd = {
+	.mult	= NSEC_PER_SEC / HZ,
+};
+
+static u32 sched_clock_mask = 0xffffffff;
+
+static u32 notrace jiffy_sched_clock_read(void)
+{
+	return (u32)(jiffies - INITIAL_JIFFIES);
+}
+
+static u32 __read_mostly (*read_sched_clock)(void) = jiffy_sched_clock_read;
+
+static inline u64 cyc_to_ns(u64 cyc, u32 mult, u32 shift)
+{
+	return (cyc * mult) >> shift;
+}
+
+static unsigned long long cyc_to_sched_clock(struct clock_data *cd,
+					     u32 cyc, u32 mask)
+{
+	u64 epoch_ns;
+	u32 epoch_cyc;
+
+	/*
+	 * Load the epoch_cyc and epoch_ns atomically.  We do this by
+	 * ensuring that we always write epoch_cyc, epoch_ns and
+	 * epoch_cyc_copy in strict order, and read them in strict order.
+	 * If epoch_cyc and epoch_cyc_copy are not equal, then we're in
+	 * the middle of an update, and we should repeat the load.
+	 */
+	do {
+		epoch_cyc = cd->epoch_cyc;
+		smp_rmb();
+		epoch_ns = cd->epoch_ns;
+		smp_rmb();
+	} while (epoch_cyc != cd->epoch_cyc_copy);
+
+	return epoch_ns + cyc_to_ns((cyc - epoch_cyc) & mask, cd->mult, cd->shift);
+}
+
+/*
+ * Atomically update the sched_clock epoch.
+ */
+static void notrace update_sched_clock(void)
+{
+	unsigned long flags;
+	u32 cyc;
+	u64 ns;
+
+	cyc = read_sched_clock();
+	ns = cd.epoch_ns +
+		cyc_to_ns((cyc - cd.epoch_cyc) & sched_clock_mask,
+			  cd.mult, cd.shift);
+	/*
+	 * Write epoch_cyc and epoch_ns in a way that the update is
+	 * detectable in cyc_to_fixed_sched_clock().
+	 */
+	raw_local_irq_save(flags);
+	cd.epoch_cyc = cyc;
+	smp_wmb();
+	cd.epoch_ns = ns;
+	smp_wmb();
+	cd.epoch_cyc_copy = cyc;
+	raw_local_irq_restore(flags);
+}
 
 static void sched_clock_poll(unsigned long wrap_ticks)
 {
 	mod_timer(&sched_clock_timer, round_jiffies(jiffies + wrap_ticks));
-	sched_clock_update_fn();
+	update_sched_clock();
 }
 
-void __init init_sched_clock(struct clock_data *cd, void (*update)(void),
-	unsigned int clock_bits, unsigned long rate)
+static void __init init_sched_clock(struct clock_data *cd,
+				    unsigned int clock_bits, unsigned long rate)
 {
 	unsigned long r, w;
 	u64 res, wrap;
 	char r_unit;
 
-	sched_clock_update_fn = update;
-
 	/* calculate the mult/shift to convert counter ticks to ns. */
 	clocks_calc_mult_shift(&cd->mult, &cd->shift, rate, NSEC_PER_SEC, 0);
 
@@ -40,10 +112,11 @@ void __init init_sched_clock(struct clock_data *cd, void (*update)(void),
 	if (r >= 4000000) {
 		r /= 1000000;
 		r_unit = 'M';
-	} else {
+	} else if (r >= 1000) {
 		r /= 1000;
 		r_unit = 'k';
-	}
+	} else
+		r_unit = ' ';
 
 	/* calculate how many ns until we wrap */
 	wrap = cyc_to_ns((1ULL << clock_bits) - 1, cd->mult, cd->shift);
@@ -60,7 +133,7 @@ void __init init_sched_clock(struct clock_data *cd, void (*update)(void),
 	 * sets the initial epoch.
 	 */
 	sched_clock_timer.data = msecs_to_jiffies(w - (w / 10));
-	update();
+	update_sched_clock();
 
 	/*
 	 * Ensure that sched_clock() starts off at 0ns
@@ -68,7 +141,31 @@ void __init init_sched_clock(struct clock_data *cd, void (*update)(void),
 	cd->epoch_ns = 0;
 }
 
+unsigned long long notrace sched_clock(void)
+{
+	u32 cyc = read_sched_clock();
+	return cyc_to_sched_clock(&cd, cyc, sched_clock_mask);
+}
+
+void __init setup_sched_clock(u32 (*read)(void), int bits, unsigned long rate)
+{
+	BUG_ON(bits > 32);
+	WARN_ON(!irqs_disabled());
+	WARN_ON(read_sched_clock != jiffy_sched_clock_read);
+	read_sched_clock = read;
+	sched_clock_mask = (1 << bits) - 1;
+	init_sched_clock(&cd, bits, rate);
+	pr_debug("Registered %pF as sched_clock source\n", read);
+}
+
 void __init sched_clock_postinit(void)
 {
+	/*
+	 * If no sched_clock function has been provided@that point,
+	 * make it the final one one.
+	 */
+	if (read_sched_clock == jiffy_sched_clock_read)
+		setup_sched_clock(jiffy_sched_clock_read, 32, HZ);	
+
 	sched_clock_poll(sched_clock_timer.data);
 }
diff --git a/arch/arm/mach-ixp4xx/common.c b/arch/arm/mach-ixp4xx/common.c
index 0777257..d10d838 100644
--- a/arch/arm/mach-ixp4xx/common.c
+++ b/arch/arm/mach-ixp4xx/common.c
@@ -17,7 +17,6 @@
 #include <linux/mm.h>
 #include <linux/init.h>
 #include <linux/serial.h>
-#include <linux/sched.h>
 #include <linux/tty.h>
 #include <linux/platform_device.h>
 #include <linux/serial_core.h>
@@ -402,18 +401,9 @@ void __init ixp4xx_sys_init(void)
 /*
  * sched_clock()
  */
-static DEFINE_CLOCK_DATA(cd);
-
-unsigned long long notrace sched_clock(void)
+static u32 notrace ixp4xx_read_sched_clock(void)
 {
-	u32 cyc = *IXP4XX_OSTS;
-	return cyc_to_sched_clock(&cd, cyc, (u32)~0);
-}
-
-static void notrace ixp4xx_update_sched_clock(void)
-{
-	u32 cyc = *IXP4XX_OSTS;
-	update_sched_clock(&cd, cyc, (u32)~0);
+	return *IXP4XX_OSTS;
 }
 
 /*
@@ -429,7 +419,7 @@ unsigned long ixp4xx_timer_freq = IXP4XX_TIMER_FREQ;
 EXPORT_SYMBOL(ixp4xx_timer_freq);
 static void __init ixp4xx_clocksource_init(void)
 {
-	init_sched_clock(&cd, ixp4xx_update_sched_clock, 32, ixp4xx_timer_freq);
+	setup_sched_clock(ixp4xx_read_sched_clock, 32, ixp4xx_timer_freq);
 
 	clocksource_mmio_init(NULL, "OSTS", ixp4xx_timer_freq, 200, 32,
 			ixp4xx_clocksource_read);
diff --git a/arch/arm/mach-mmp/time.c b/arch/arm/mach-mmp/time.c
index 4e91ee6..71fc4ee 100644
--- a/arch/arm/mach-mmp/time.c
+++ b/arch/arm/mach-mmp/time.c
@@ -25,7 +25,6 @@
 
 #include <linux/io.h>
 #include <linux/irq.h>
-#include <linux/sched.h>
 
 #include <asm/sched_clock.h>
 #include <mach/addr-map.h>
@@ -42,8 +41,6 @@
 #define MAX_DELTA		(0xfffffffe)
 #define MIN_DELTA		(16)
 
-static DEFINE_CLOCK_DATA(cd);
-
 /*
  * FIXME: the timer needs some delay to stablize the counter capture
  */
@@ -59,16 +56,9 @@ static inline uint32_t timer_read(void)
 	return __raw_readl(TIMERS_VIRT_BASE + TMR_CVWR(1));
 }
 
-unsigned long long notrace sched_clock(void)
+static u32 notrace mmp_read_sched_clock(void)
 {
-	u32 cyc = timer_read();
-	return cyc_to_sched_clock(&cd, cyc, (u32)~0);
-}
-
-static void notrace mmp_update_sched_clock(void)
-{
-	u32 cyc = timer_read();
-	update_sched_clock(&cd, cyc, (u32)~0);
+	return timer_read();
 }
 
 static irqreturn_t timer_interrupt(int irq, void *dev_id)
@@ -201,7 +191,7 @@ void __init timer_init(int irq)
 {
 	timer_config();
 
-	init_sched_clock(&cd, mmp_update_sched_clock, 32, CLOCK_TICK_RATE);
+	setup_sched_clock(mmp_read_sched_clock, 32, CLOCK_TICK_RATE);
 
 	ckevt.mult = div_sc(CLOCK_TICK_RATE, NSEC_PER_SEC, ckevt.shift);
 	ckevt.max_delta_ns = clockevent_delta2ns(MAX_DELTA, &ckevt);
diff --git a/arch/arm/mach-omap1/time.c b/arch/arm/mach-omap1/time.c
index a183777..92b5847 100644
--- a/arch/arm/mach-omap1/time.c
+++ b/arch/arm/mach-omap1/time.c
@@ -37,7 +37,6 @@
 #include <linux/init.h>
 #include <linux/delay.h>
 #include <linux/interrupt.h>
-#include <linux/sched.h>
 #include <linux/spinlock.h>
 #include <linux/clk.h>
 #include <linux/err.h>
@@ -190,30 +189,9 @@ static __init void omap_init_mpu_timer(unsigned long rate)
  * ---------------------------------------------------------------------------
  */
 
-static DEFINE_CLOCK_DATA(cd);
-
-static inline unsigned long long notrace _omap_mpu_sched_clock(void)
-{
-	u32 cyc = ~omap_mpu_timer_read(1);
-	return cyc_to_sched_clock(&cd, cyc, (u32)~0);
-}
-
-#ifndef CONFIG_OMAP_32K_TIMER
-unsigned long long notrace sched_clock(void)
-{
-	return _omap_mpu_sched_clock();
-}
-#else
-static unsigned long long notrace omap_mpu_sched_clock(void)
-{
-	return _omap_mpu_sched_clock();
-}
-#endif
-
-static void notrace mpu_update_sched_clock(void)
+static u32 notrace omap_mpu_read_sched_clock(void)
 {
-	u32 cyc = ~omap_mpu_timer_read(1);
-	update_sched_clock(&cd, cyc, (u32)~0);
+	return ~omap_mpu_timer_read(1);
 }
 
 static void __init omap_init_clocksource(unsigned long rate)
@@ -223,7 +201,7 @@ static void __init omap_init_clocksource(unsigned long rate)
 			"%s: can't register clocksource!\n";
 
 	omap_mpu_timer_start(1, ~0, 1);
-	init_sched_clock(&cd, mpu_update_sched_clock, 32, rate);
+	setup_sched_clock(omap_mpu_read_sched_clock, 32, rate);
 
 	if (clocksource_mmio_init(&timer->read_tim, "mpu_timer2", rate,
 			300, 32, clocksource_mmio_readl_down))
@@ -254,30 +232,6 @@ static inline void omap_mpu_timer_init(void)
 }
 #endif	/* CONFIG_OMAP_MPU_TIMER */
 
-#if defined(CONFIG_OMAP_MPU_TIMER) && defined(CONFIG_OMAP_32K_TIMER)
-static unsigned long long (*preferred_sched_clock)(void);
-
-unsigned long long notrace sched_clock(void)
-{
-	if (!preferred_sched_clock)
-		return 0;
-
-	return preferred_sched_clock();
-}
-
-static inline void preferred_sched_clock_init(bool use_32k_sched_clock)
-{
-	if (use_32k_sched_clock)
-		preferred_sched_clock = omap_32k_sched_clock;
-	else
-		preferred_sched_clock = omap_mpu_sched_clock;
-}
-#else
-static inline void preferred_sched_clock_init(bool use_32k_sched_clcok)
-{
-}
-#endif
-
 static inline int omap_32k_timer_usable(void)
 {
 	int res = false;
@@ -299,12 +253,8 @@ static inline int omap_32k_timer_usable(void)
  */
 static void __init omap1_timer_init(void)
 {
-	if (omap_32k_timer_usable()) {
-		preferred_sched_clock_init(1);
-	} else {
+	if (!omap_32k_timer_usable())
 		omap_mpu_timer_init();
-		preferred_sched_clock_init(0);
-	}
 }
 
 struct sys_timer omap1_timer = {
diff --git a/arch/arm/mach-omap2/timer.c b/arch/arm/mach-omap2/timer.c
index cf1de7d..925bf86 100644
--- a/arch/arm/mach-omap2/timer.c
+++ b/arch/arm/mach-omap2/timer.c
@@ -248,7 +248,6 @@ static struct omap_dm_timer clksrc;
 /*
  * clocksource
  */
-static DEFINE_CLOCK_DATA(cd);
 static cycle_t clocksource_read_cycles(struct clocksource *cs)
 {
 	return (cycle_t)__omap_dm_timer_read_counter(clksrc.io_base, 1);
@@ -262,23 +261,12 @@ static struct clocksource clocksource_gpt = {
 	.flags		= CLOCK_SOURCE_IS_CONTINUOUS,
 };
 
-static void notrace dmtimer_update_sched_clock(void)
+static u32 notrace dmtimer_read_sched_clock(void)
 {
-	u32 cyc;
-
-	cyc = __omap_dm_timer_read_counter(clksrc.io_base, 1);
-
-	update_sched_clock(&cd, cyc, (u32)~0);
-}
-
-unsigned long long notrace sched_clock(void)
-{
-	u32 cyc = 0;
-
 	if (clksrc.reserved)
-		cyc = __omap_dm_timer_read_counter(clksrc.io_base, 1);
+		return __omap_dm_timer_read_counter(clksrc.io_base, 1);
 
-	return cyc_to_sched_clock(&cd, cyc, (u32)~0);
+	return 0;
 }
 
 /* Setup free-running counter for clocksource */
@@ -295,7 +283,7 @@ static void __init omap2_gp_clocksource_init(int gptimer_id,
 
 	__omap_dm_timer_load_start(clksrc.io_base,
 			OMAP_TIMER_CTRL_ST | OMAP_TIMER_CTRL_AR, 0, 1);
-	init_sched_clock(&cd, dmtimer_update_sched_clock, 32, clksrc.rate);
+	setup_sched_clock(dmtimer_read_sched_clock, 32, clksrc.rate);
 
 	if (clocksource_register_hz(&clocksource_gpt, clksrc.rate))
 		pr_err("Could not register clocksource %s\n",
diff --git a/arch/arm/mach-pxa/time.c b/arch/arm/mach-pxa/time.c
index de68470..b503049 100644
--- a/arch/arm/mach-pxa/time.c
+++ b/arch/arm/mach-pxa/time.c
@@ -16,7 +16,6 @@
 #include <linux/init.h>
 #include <linux/interrupt.h>
 #include <linux/clockchips.h>
-#include <linux/sched.h>
 
 #include <asm/div64.h>
 #include <asm/mach/irq.h>
@@ -32,18 +31,10 @@
  * long as there is always less than 582 seconds between successive
  * calls to sched_clock() which should always be the case in practice.
  */
-static DEFINE_CLOCK_DATA(cd);
 
-unsigned long long notrace sched_clock(void)
+static u32 notrace pxa_read_sched_clock(void)
 {
-	u32 cyc = OSCR;
-	return cyc_to_sched_clock(&cd, cyc, (u32)~0);
-}
-
-static void notrace pxa_update_sched_clock(void)
-{
-	u32 cyc = OSCR;
-	update_sched_clock(&cd, cyc, (u32)~0);
+	return OSCR;
 }
 
 
@@ -119,7 +110,7 @@ static void __init pxa_timer_init(void)
 	OIER = 0;
 	OSSR = OSSR_M0 | OSSR_M1 | OSSR_M2 | OSSR_M3;
 
-	init_sched_clock(&cd, pxa_update_sched_clock, 32, clock_tick_rate);
+	setup_sched_clock(pxa_read_sched_clock, 32, clock_tick_rate);
 
 	clockevents_calc_mult_shift(&ckevt_pxa_osmr0, clock_tick_rate, 4);
 	ckevt_pxa_osmr0.max_delta_ns =
diff --git a/arch/arm/mach-sa1100/time.c b/arch/arm/mach-sa1100/time.c
index fa66024..1ee6d4c 100644
--- a/arch/arm/mach-sa1100/time.c
+++ b/arch/arm/mach-sa1100/time.c
@@ -12,7 +12,6 @@
 #include <linux/errno.h>
 #include <linux/interrupt.h>
 #include <linux/irq.h>
-#include <linux/sched.h>	/* just for sched_clock() - funny that */
 #include <linux/timex.h>
 #include <linux/clockchips.h>
 
@@ -20,29 +19,9 @@
 #include <asm/sched_clock.h>
 #include <mach/hardware.h>
 
-/*
- * This is the SA11x0 sched_clock implementation.
- */
-static DEFINE_CLOCK_DATA(cd);
-
-/*
- * Constants generated by clocks_calc_mult_shift(m, s, 3.6864MHz,
- * NSEC_PER_SEC, 60).
- * This gives a resolution of about 271ns and a wrap period of about 19min.
- */
-#define SC_MULT		2275555556u
-#define SC_SHIFT	23
-
-unsigned long long notrace sched_clock(void)
-{
-	u32 cyc = OSCR;
-	return cyc_to_fixed_sched_clock(&cd, cyc, (u32)~0, SC_MULT, SC_SHIFT);
-}
-
-static void notrace sa1100_update_sched_clock(void)
+static u32 notrace sa100_read_sched_clock(void)
 {
-	u32 cyc = OSCR;
-	update_sched_clock(&cd, cyc, (u32)~0);
+	return OSCR;
 }
 
 #define MIN_OSCR_DELTA 2
@@ -109,8 +88,7 @@ static void __init sa1100_timer_init(void)
 	OIER = 0;
 	OSSR = OSSR_M0 | OSSR_M1 | OSSR_M2 | OSSR_M3;
 
-	init_fixed_sched_clock(&cd, sa1100_update_sched_clock, 32,
-			       3686400, SC_MULT, SC_SHIFT);
+	setup_sched_clock(sa1100_read_sched_clock, 32, 3686400);
 
 	clockevents_calc_mult_shift(&ckevt_sa1100_osmr0, 3686400, 4);
 	ckevt_sa1100_osmr0.max_delta_ns =
diff --git a/arch/arm/mach-tegra/timer.c b/arch/arm/mach-tegra/timer.c
index 9035042..b5dc8d2 100644
--- a/arch/arm/mach-tegra/timer.c
+++ b/arch/arm/mach-tegra/timer.c
@@ -19,7 +19,6 @@
 
 #include <linux/init.h>
 #include <linux/err.h>
-#include <linux/sched.h>
 #include <linux/time.h>
 #include <linux/interrupt.h>
 #include <linux/irq.h>
@@ -106,25 +105,9 @@ static struct clock_event_device tegra_clockevent = {
 	.set_mode	= tegra_timer_set_mode,
 };
 
-static DEFINE_CLOCK_DATA(cd);
-
-/*
- * Constants generated by clocks_calc_mult_shift(m, s, 1MHz, NSEC_PER_SEC, 60).
- * This gives a resolution of about 1us and a wrap period of about 1h11min.
- */
-#define SC_MULT		4194304000u
-#define SC_SHIFT	22
-
-unsigned long long notrace sched_clock(void)
-{
-	u32 cyc = timer_readl(TIMERUS_CNTR_1US);
-	return cyc_to_fixed_sched_clock(&cd, cyc, (u32)~0, SC_MULT, SC_SHIFT);
-}
-
-static void notrace tegra_update_sched_clock(void)
+static u32 notrace tegra_read_sched_clock(void)
 {
-	u32 cyc = timer_readl(TIMERUS_CNTR_1US);
-	update_sched_clock(&cd, cyc, (u32)~0);
+	return timer_readl(TIMERUS_CNTR_1US);
 }
 
 /*
@@ -218,8 +201,7 @@ static void __init tegra_init_timer(void)
 		WARN(1, "Unknown clock rate");
 	}
 
-	init_fixed_sched_clock(&cd, tegra_update_sched_clock, 32,
-			       1000000, SC_MULT, SC_SHIFT);
+	setup_sched_clock(tegra_read_sched_clock, 32, 1000000);
 
 	if (clocksource_mmio_init(timer_reg_base + TIMERUS_CNTR_1US,
 		"timer_us", 1000000, 300, 32, clocksource_mmio_readl_up)) {
diff --git a/arch/arm/mach-u300/timer.c b/arch/arm/mach-u300/timer.c
index 5f51bde..bc1c789 100644
--- a/arch/arm/mach-u300/timer.c
+++ b/arch/arm/mach-u300/timer.c
@@ -9,7 +9,6 @@
  * Author: Linus Walleij <linus.walleij@stericsson.com>
  */
 #include <linux/interrupt.h>
-#include <linux/sched.h>
 #include <linux/time.h>
 #include <linux/timex.h>
 #include <linux/clockchips.h>
@@ -337,18 +336,10 @@ static struct irqaction u300_timer_irq = {
  * this wraps around for now, since it is just a relative time
  * stamp. (Inspired by OMAP implementation.)
  */
-static DEFINE_CLOCK_DATA(cd);
 
-unsigned long long notrace sched_clock(void)
+static u32 notrace u300_read_sched_clock(void)
 {
-	u32 cyc = readl(U300_TIMER_APP_VBASE + U300_TIMER_APP_GPT2CC);
-	return cyc_to_sched_clock(&cd, cyc, (u32)~0);
-}
-
-static void notrace u300_update_sched_clock(void)
-{
-	u32 cyc = readl(U300_TIMER_APP_VBASE + U300_TIMER_APP_GPT2CC);
-	update_sched_clock(&cd, cyc, (u32)~0);
+	return readl(U300_TIMER_APP_VBASE + U300_TIMER_APP_GPT2CC);
 }
 
 
@@ -366,7 +357,7 @@ static void __init u300_timer_init(void)
 	clk_enable(clk);
 	rate = clk_get_rate(clk);
 
-	init_sched_clock(&cd, u300_update_sched_clock, 32, rate);
+	setup_sched_clock(u300_read_sched_clock, 32, rate);
 
 	/*
 	 * Disable the "OS" and "DD" timers - these are designed for Symbian!
diff --git a/arch/arm/plat-iop/time.c b/arch/arm/plat-iop/time.c
index 7cdc516..fd94c55 100644
--- a/arch/arm/plat-iop/time.c
+++ b/arch/arm/plat-iop/time.c
@@ -18,7 +18,6 @@
 #include <linux/time.h>
 #include <linux/init.h>
 #include <linux/timex.h>
-#include <linux/sched.h>
 #include <linux/io.h>
 #include <linux/clocksource.h>
 #include <linux/clockchips.h>
@@ -51,21 +50,12 @@ static struct clocksource iop_clocksource = {
 	.flags		= CLOCK_SOURCE_IS_CONTINUOUS,
 };
 
-static DEFINE_CLOCK_DATA(cd);
-
 /*
  * IOP sched_clock() implementation via its clocksource.
  */
-unsigned long long notrace sched_clock(void)
+static u32 notrace iop_read_sched_clock(void)
 {
-	u32 cyc = 0xffffffffu - read_tcr1();
-	return cyc_to_sched_clock(&cd, cyc, (u32)~0);
-}
-
-static void notrace iop_update_sched_clock(void)
-{
-	u32 cyc = 0xffffffffu - read_tcr1();
-	update_sched_clock(&cd, cyc, (u32)~0);
+	return 0xffffffffu - read_tcr1();
 }
 
 /*
@@ -151,7 +141,7 @@ void __init iop_init_time(unsigned long tick_rate)
 {
 	u32 timer_ctl;
 
-	init_sched_clock(&cd, iop_update_sched_clock, 32, tick_rate);
+	setup_sched_clock(iop_read_sched_clock, 32, tick_rate);
 
 	ticks_per_jiffy = DIV_ROUND_CLOSEST(tick_rate, HZ);
 	iop_tick_rate = tick_rate;
diff --git a/arch/arm/plat-mxc/time.c b/arch/arm/plat-mxc/time.c
index 4b0fe28..1c96cdb 100644
--- a/arch/arm/plat-mxc/time.c
+++ b/arch/arm/plat-mxc/time.c
@@ -108,18 +108,9 @@ static void gpt_irq_acknowledge(void)
 
 static void __iomem *sched_clock_reg;
 
-static DEFINE_CLOCK_DATA(cd);
-unsigned long long notrace sched_clock(void)
+static u32 notrace mxc_read_sched_clock(void)
 {
-	cycle_t cyc = sched_clock_reg ? __raw_readl(sched_clock_reg) : 0;
-
-	return cyc_to_sched_clock(&cd, cyc, (u32)~0);
-}
-
-static void notrace mxc_update_sched_clock(void)
-{
-	cycle_t cyc = sched_clock_reg ? __raw_readl(sched_clock_reg) : 0;
-	update_sched_clock(&cd, cyc, (u32)~0);
+	return sched_clock_reg ? __raw_readl(sched_clock_reg) : 0;
 }
 
 static int __init mxc_clocksource_init(struct clk *timer_clk)
@@ -129,7 +120,7 @@ static int __init mxc_clocksource_init(struct clk *timer_clk)
 
 	sched_clock_reg = reg;
 
-	init_sched_clock(&cd, mxc_update_sched_clock, 32, c);
+	setup_sched_clock(mxc_read_sched_clock, 32, c);
 	return clocksource_mmio_init(reg, "mxc_timer1", c, 200, 32,
 			clocksource_mmio_readl_up);
 }
diff --git a/arch/arm/plat-nomadik/timer.c b/arch/arm/plat-nomadik/timer.c
index ef74e15..7a0a9d7 100644
--- a/arch/arm/plat-nomadik/timer.c
+++ b/arch/arm/plat-nomadik/timer.c
@@ -17,7 +17,6 @@
 #include <linux/clk.h>
 #include <linux/jiffies.h>
 #include <linux/err.h>
-#include <linux/sched.h>
 #include <asm/mach/time.h>
 #include <asm/sched_clock.h>
 
@@ -30,23 +29,12 @@ void __iomem *mtu_base; /* Assigned by machine code */
  * local implementation which uses the clocksource to get some
  * better resolution when scheduling the kernel.
  */
-static DEFINE_CLOCK_DATA(cd);
-
-unsigned long long notrace sched_clock(void)
+static u32 notrace nomadik_read_sched_clock(void)
 {
-	u32 cyc;
-
 	if (unlikely(!mtu_base))
 		return 0;
 
-	cyc = -readl(mtu_base + MTU_VAL(0));
-	return cyc_to_sched_clock(&cd, cyc, (u32)~0);
-}
-
-static void notrace nomadik_update_sched_clock(void)
-{
-	u32 cyc = -readl(mtu_base + MTU_VAL(0));
-	update_sched_clock(&cd, cyc, (u32)~0);
+	return -readl(mtu_base + MTU_VAL(0));
 }
 
 /* Clockevent device: use one-shot mode */
@@ -154,7 +142,7 @@ void __init nmdk_timer_init(void)
 		pr_err("timer: failed to initialize clock source %s\n",
 		       "mtu_0");
 
-	init_sched_clock(&cd, nomadik_update_sched_clock, 32, rate);
+	setup_sched_clock(nomadik_setup_sched_clock, 32, rate);
 
 	/* Timer 1 is used for events */
 
diff --git a/arch/arm/plat-omap/counter_32k.c b/arch/arm/plat-omap/counter_32k.c
index a6cbb71..5f0f229 100644
--- a/arch/arm/plat-omap/counter_32k.c
+++ b/arch/arm/plat-omap/counter_32k.c
@@ -17,7 +17,6 @@
 #include <linux/clk.h>
 #include <linux/err.h>
 #include <linux/io.h>
-#include <linux/sched.h>
 #include <linux/clocksource.h>
 
 #include <asm/sched_clock.h>
@@ -37,41 +36,9 @@ static void __iomem *timer_32k_base;
 
 #define OMAP16XX_TIMER_32K_SYNCHRONIZED		0xfffbc410
 
-/*
- * Returns current time from boot in nsecs. It's OK for this to wrap
- * around for now, as it's just a relative time stamp.
- */
-static DEFINE_CLOCK_DATA(cd);
-
-/*
- * Constants generated by clocks_calc_mult_shift(m, s, 32768, NSEC_PER_SEC, 60).
- * This gives a resolution of about 30us and a wrap period of about 36hrs.
- */
-#define SC_MULT		4000000000u
-#define SC_SHIFT	17
-
-static inline unsigned long long notrace _omap_32k_sched_clock(void)
-{
-	u32 cyc = timer_32k_base ? __raw_readl(timer_32k_base) : 0;
-	return cyc_to_fixed_sched_clock(&cd, cyc, (u32)~0, SC_MULT, SC_SHIFT);
-}
-
-#if defined(CONFIG_OMAP_32K_TIMER) && !defined(CONFIG_OMAP_MPU_TIMER)
-unsigned long long notrace sched_clock(void)
-{
-	return _omap_32k_sched_clock();
-}
-#else
-unsigned long long notrace omap_32k_sched_clock(void)
-{
-	return _omap_32k_sched_clock();
-}
-#endif
-
-static void notrace omap_update_sched_clock(void)
+static u32 notrace omap_32k_read_sched_clock(void)
 {
-	u32 cyc = timer_32k_base ? __raw_readl(timer_32k_base) : 0;
-	update_sched_clock(&cd, cyc, (u32)~0);
+	return timer_32k_base ? __raw_readl(timer_32k_base) : 0;
 }
 
 /**
@@ -147,8 +114,7 @@ int __init omap_init_clocksource_32k(void)
 					  clocksource_mmio_readl_up))
 			printk(err, "32k_counter");
 
-		init_fixed_sched_clock(&cd, omap_update_sched_clock, 32,
-				       32768, SC_MULT, SC_SHIFT);
+		setup_sched_clock(omap_32k_read_sched_clock, 32, 32768);
 	}
 	return 0;
 }
diff --git a/arch/arm/plat-omap/include/plat/common.h b/arch/arm/plat-omap/include/plat/common.h
index 4564cc6..44e2e33 100644
--- a/arch/arm/plat-omap/include/plat/common.h
+++ b/arch/arm/plat-omap/include/plat/common.h
@@ -41,7 +41,6 @@ extern struct sys_timer omap3_secure_timer;
 extern struct sys_timer omap4_timer;
 extern bool omap_32k_timer_init(void);
 extern int __init omap_init_clocksource_32k(void);
-extern unsigned long long notrace omap_32k_sched_clock(void);
 
 extern void omap_reserve(void);
 
diff --git a/arch/arm/plat-orion/time.c b/arch/arm/plat-orion/time.c
index 69a6136..1ed8d13 100644
--- a/arch/arm/plat-orion/time.c
+++ b/arch/arm/plat-orion/time.c
@@ -12,7 +12,6 @@
  */
 
 #include <linux/kernel.h>
-#include <linux/sched.h>
 #include <linux/timer.h>
 #include <linux/clockchips.h>
 #include <linux/interrupt.h>
@@ -60,24 +59,10 @@ static u32 ticks_per_jiffy;
  * Orion's sched_clock implementation. It has a resolution of
  * at least 7.5ns (133MHz TCLK).
  */
-static DEFINE_CLOCK_DATA(cd);
 
-unsigned long long notrace sched_clock(void)
+static u32 notrace orion_read_sched_clock(void)
 {
-	u32 cyc = ~readl(timer_base + TIMER0_VAL_OFF);
-	return cyc_to_sched_clock(&cd, cyc, (u32)~0);
-}
-
-
-static void notrace orion_update_sched_clock(void)
-{
-	u32 cyc = ~readl(timer_base + TIMER0_VAL_OFF);
-	update_sched_clock(&cd, cyc, (u32)~0);
-}
-
-static void __init setup_sched_clock(unsigned long tclk)
-{
-	init_sched_clock(&cd, orion_update_sched_clock, 32, tclk);
+	return ~readl(timer_base + TIMER0_VAL_OFF);
 }
 
 /*
@@ -217,7 +202,7 @@ orion_time_init(u32 _bridge_base, u32 _bridge_timer1_clr_mask,
 	/*
 	 * Set scale and timer for sched_clock.
 	 */
-	setup_sched_clock(tclk);
+	setup_sched_clock(orion_read_sched_clock, 32, tclk);
 
 	/*
 	 * Setup free-running clocksource timer (interrupts
diff --git a/arch/arm/plat-s5p/s5p-time.c b/arch/arm/plat-s5p/s5p-time.c
index c833e7b..566341b 100644
--- a/arch/arm/plat-s5p/s5p-time.c
+++ b/arch/arm/plat-s5p/s5p-time.c
@@ -10,7 +10,6 @@
  * published by the Free Software Foundation.
 */
 
-#include <linux/sched.h>
 #include <linux/interrupt.h>
 #include <linux/irq.h>
 #include <linux/err.h>
@@ -321,26 +320,14 @@ static void __iomem *s5p_timer_reg(void)
  * this wraps around for now, since it is just a relative time
  * stamp. (Inspired by U300 implementation.)
  */
-static DEFINE_CLOCK_DATA(cd);
-
-unsigned long long notrace sched_clock(void)
-{
-	void __iomem *reg = s5p_timer_reg();
-
-	if (!reg)
-		return 0;
-
-	return cyc_to_sched_clock(&cd, ~__raw_readl(reg), (u32)~0);
-}
-
-static void notrace s5p_update_sched_clock(void)
+static u32 notrace s5p_read_sched_clock(void)
 {
 	void __iomem *reg = s5p_timer_reg();
 
 	if (!reg)
 		return;
 
-	update_sched_clock(&cd, ~__raw_readl(reg), (u32)~0);
+	return ~__raw_readl(reg);
 }
 
 static void __init s5p_clocksource_init(void)
@@ -358,7 +345,7 @@ static void __init s5p_clocksource_init(void)
 	s5p_time_setup(timer_source.source_id, TCNT_MAX);
 	s5p_time_start(timer_source.source_id, PERIODIC);
 
-	init_sched_clock(&cd, s5p_update_sched_clock, 32, clock_rate);
+	setup_sched_clock(s5p_read_sched_clock, 32, clock_rate);
 
 	if (clocksource_mmio_init(s5p_timer_reg(), "s5p_clocksource_timer",
 			clock_rate, 250, 32, clocksource_mmio_readl_down))
diff --git a/arch/arm/plat-versatile/sched-clock.c b/arch/arm/plat-versatile/sched-clock.c
index 3d6a4c2..b33b74c 100644
--- a/arch/arm/plat-versatile/sched-clock.c
+++ b/arch/arm/plat-versatile/sched-clock.c
@@ -18,41 +18,24 @@
  * along with this program; if not, write to the Free Software
  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
  */
+#include <linux/kernel.h>
 #include <linux/io.h>
-#include <linux/sched.h>
 
 #include <asm/sched_clock.h>
 #include <plat/sched_clock.h>
 
-static DEFINE_CLOCK_DATA(cd);
 static void __iomem *ctr;
 
-/*
- * Constants generated by clocks_calc_mult_shift(m, s, 24MHz, NSEC_PER_SEC, 60).
- * This gives a resolution of about 41ns and a wrap period of about 178s.
- */
-#define SC_MULT		2796202667u
-#define SC_SHIFT	26
-
-unsigned long long notrace sched_clock(void)
+static u32 notrace versatile_read_sched_clock(void)
 {
-	if (ctr) {
-		u32 cyc = readl(ctr);
-		return cyc_to_fixed_sched_clock(&cd, cyc, (u32)~0,
-						SC_MULT, SC_SHIFT);
-	} else
-		return 0;
-}
+	if (ctr)
+		return readl(ctr);
 
-static void notrace versatile_update_sched_clock(void)
-{
-	u32 cyc = readl(ctr);
-	update_sched_clock(&cd, cyc, (u32)~0);
+	return 0;
 }
 
 void __init versatile_sched_clock_init(void __iomem *reg, unsigned long rate)
 {
 	ctr = reg;
-	init_fixed_sched_clock(&cd, versatile_update_sched_clock,
-			       32, rate, SC_MULT, SC_SHIFT);
+	setup_sched_clock(versatile_read_sched_clock, 32, rate);
 }
-- 
1.7.0.4



>From bogus@does.not.exist.com  Mon Jun 27 16:47:34 2011
From: bogus@does.not.exist.com ()
Date: Mon, 27 Jun 2011 20:47:34 -0000
Subject: No subject
Message-ID: <mailman.119.1315398696.20020.linux-arm-kernel@lists.infradead.org>

voltdm->read is changed. Is this part of another patch from this set?

>
> =A0 =A0 =A0 =A0if (!voltdm->pmic || !voltdm->pmic->vsel_to_uv) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0pr_warning("%s: PMIC function to convert v=
sel to voltage"
> diff --git a/arch/arm/mach-omap2/vp.h b/arch/arm/mach-omap2/vp.h
> index 0d63267..f78752b 100644
> --- a/arch/arm/mach-omap2/vp.h
> +++ b/arch/arm/mach-omap2/vp.h
> @@ -63,6 +63,7 @@ struct omap_vp_ops {
> =A0* @vlimitto_vddmin_shift: VDDMIN field shift in PRM_VP*_VLIMITTO reg
> =A0* @vlimitto_vddmax_shift: VDDMAX field shift in PRM_VP*_VLIMITTO reg
> =A0* @vlimitto_timeout_shift: TIMEOUT field shift in PRM_VP*_VLIMITTO reg
> + * @vpvoltage_mask: VPVOLTAGE field mask in PRM_VP*_VOLTAGE reg
> =A0*/
> =A0struct omap_vp_common {
> =A0 =A0 =A0 =A0u32 vpconfig_erroroffset_mask;
> @@ -79,6 +80,7 @@ struct omap_vp_common {
> =A0 =A0 =A0 =A0u8 vlimitto_vddmin_shift;
> =A0 =A0 =A0 =A0u8 vlimitto_vddmax_shift;
> =A0 =A0 =A0 =A0u8 vlimitto_timeout_shift;
> + =A0 =A0 =A0 u8 vpvoltage_mask;
>
> =A0 =A0 =A0 =A0const struct omap_vp_ops *ops;
> =A0};
> diff --git a/arch/arm/mach-omap2/vp3xxx_data.c b/arch/arm/mach-omap2/vp3x=
xx_data.c
> index d429c44..260c554 100644
> --- a/arch/arm/mach-omap2/vp3xxx_data.c
> +++ b/arch/arm/mach-omap2/vp3xxx_data.c
> @@ -51,6 +51,8 @@ static const struct omap_vp_common omap3_vp_common =3D =
{
> =A0 =A0 =A0 =A0.vlimitto_vddmin_shift =3D OMAP3430_VDDMIN_SHIFT,
> =A0 =A0 =A0 =A0.vlimitto_vddmax_shift =3D OMAP3430_VDDMAX_SHIFT,
> =A0 =A0 =A0 =A0.vlimitto_timeout_shift =3D OMAP3430_TIMEOUT_SHIFT,
> + =A0 =A0 =A0 .vpvoltage_mask =3D OMAP3430_VPVOLTAGE_MASK,
> +
Stray empty line...

> =A0 =A0 =A0 =A0.ops =3D &omap3_vp_ops,
> =A0};
>
> diff --git a/arch/arm/mach-omap2/vp44xx_data.c b/arch/arm/mach-omap2/vp44=
xx_data.c
> index 0daf2a4..b4e7704 100644
> --- a/arch/arm/mach-omap2/vp44xx_data.c
> +++ b/arch/arm/mach-omap2/vp44xx_data.c
> @@ -51,6 +51,7 @@ static const struct omap_vp_common omap4_vp_common =3D =
{
> =A0 =A0 =A0 =A0.vlimitto_vddmin_shift =3D OMAP4430_VDDMIN_SHIFT,
> =A0 =A0 =A0 =A0.vlimitto_vddmax_shift =3D OMAP4430_VDDMAX_SHIFT,
> =A0 =A0 =A0 =A0.vlimitto_timeout_shift =3D OMAP4430_TIMEOUT_SHIFT,
> + =A0 =A0 =A0 .vpvoltage_mask =3D OMAP4430_VPVOLTAGE_MASK,
> =A0 =A0 =A0 =A0.ops =3D &omap4_vp_ops,
> =A0};
>
> --
> 1.7.6
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>

Regards,
Jean


>From bogus@does.not.exist.com  Mon Jun 27 16:47:34 2011
From: bogus@does.not.exist.com ()
Date: Mon, 27 Jun 2011 20:47:34 -0000
Subject: No subject
Message-ID: <mailman.120.1315400142.20020.linux-arm-kernel@lists.infradead.org>

This Patch series based on Kevin's tree is hosted at:
git://gitorious.org/runtime_3-0/runtime_3-0.git rc4_uart_od

Testing updates:
----------------
3430SDP:
retention, off_mode, system_wide suspend is tested.
(earlyprintk & no_console_suspend checked)

OMAP3630 - Zoom3:
pm-retention checked with quart/omap-uart3
[Also tested with uart3 as console uart and pm-ret checked]

OMAP4430-SDP: Boot tested.
OMAP2420/2430SDP: Boot tested.

Govindraj.R (10):
  OMAP2+: hwmod: Add API to enable IO ring wakeup.
  OMAP2+: hwmod: Add API to check IO PAD wakeup status
  OMAP2+: UART: cleanup + remove certain uart calls from pm code
  OMAP2+: UART: Remove uart clock handling code from serial.c
  OMAP2+: Serial: Add default mux for all uarts.
  Serial: OMAP: Store certain reg values to port structure
  Serial: OMAP: Add runtime pm support for omap-serial driver
  Serial: OMAP2+: Move erratum handling from serial.c
  OMAP2+: Serial: Use prepare and resume calls to gate uart clocks
  OMAP: Serial: Allow UART parameters to be configured from board file.

Jon Hunter (1):
  Serial: OMAP2+: Make the RX_TIMEOUT for DMA configurable for each
    UART

 arch/arm/mach-omap2/board-3430sdp.c           |  100 +---
 arch/arm/mach-omap2/board-4430sdp.c           |    8 +-
 arch/arm/mach-omap2/board-n8x0.c              |    6 +-
 arch/arm/mach-omap2/board-omap4panda.c        |    8 +-
 arch/arm/mach-omap2/mux.c                     |   30 +
 arch/arm/mach-omap2/mux.h                     |   13 +
 arch/arm/mach-omap2/omap_hwmod.c              |   66 ++
 arch/arm/mach-omap2/pm24xx.c                  |   11 +-
 arch/arm/mach-omap2/pm34xx.c                  |   22 +-
 arch/arm/mach-omap2/serial.c                  |  922 +++++++------------------
 arch/arm/plat-omap/include/plat/omap-serial.h |   34 +-
 arch/arm/plat-omap/include/plat/omap_hwmod.h  |    1 +
 arch/arm/plat-omap/include/plat/serial.h      |   13 +-
 drivers/tty/serial/omap-serial.c              |  349 ++++++++--
 14 files changed, 717 insertions(+), 866 deletions(-)

-- 
1.7.4.1
