From: magnus.damm@gmail.com (Magnus Damm)
Date: Thu, 30 May 2013 17:52:40 +0900
Subject: [PATCH 05/05] ARM: shmobile: r8a73a4 CA7 setup arch timer
In-Reply-To: <20130530085152.24374.64208.sendpatchset@w520>
References: <20130530085152.24374.64208.sendpatchset@w520>
Message-ID: <20130530085240.24374.65991.sendpatchset@w520>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Setup the CA7 arch timer in r8a73a4 at boot up. Thanks to
Kevin Bracey at Renesas Mobile for initial implementation.

We need to discuss if some of this can be moved into the
common arch timer driver or not. It may also need to be
shared with R-Car H2. So this is not ready for merge.

Without this patch the interrupt count for the per-cpu arch
timers for CA7 are stuck at zero.

Not-yet-Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/arm/mach-shmobile/smp-r8a73a4.c |   37 +++++++++++++++++++++++++++++++++-
 1 file changed, 36 insertions(+), 1 deletion(-)

--- 0005/arch/arm/mach-shmobile/smp-r8a73a4.c
+++ work/arch/arm/mach-shmobile/smp-r8a73a4.c	2013-05-30 17:13:01.000000000 +0900
@@ -50,6 +50,8 @@
 #define CCI_SNOOP	0x0000
 #define CCI_STATUS	0x000c
 
+#define CNTFID0	0xe6080020
+
 static inline void r8a73a4_execute_wfe_as_nop(void)
 {
 	unsigned int v;
@@ -64,6 +66,32 @@ static inline void r8a73a4_execute_wfe_a
 	  : "cc");
 }
 
+static u32 r8a73a4_arch_freq;
+
+static inline void r8a73a4_reset_arch_timer(void)
+{
+	/* Program CNTFRQ from the frequency table */
+	asm volatile("mcr p15, 0, %0, c14, c0, 0" : : "r" (r8a73a4_arch_freq));
+
+	/* CNTVOFF has to be initialized either from non-secure Hypervisor
+	 * mode or secure Monitor mode with SCR.NS==1. If TrustZone is enabled
+	 * then it should be handled by the secure code
+	 */
+	asm volatile(
+	"cps	0x16				@ Monitor mode"
+	"mrc	p15, 0, r1, c1, c1, 0"
+	"orr	r0, r1, #1			@ Set SCR.NS (non-secure)"
+	"mcr	p15, 0, r0, c1, c1, 0"
+	"isb"
+	"mov	r0, #0"
+	"mcrr	p15, 4, r0, r0, c14		@ CNTVOFF"
+	"isb"
+	"mcr	p15, 0, r1, c1, c1, 0		@ Restore SCR"
+	"isb"
+	"cps	0x13				@ Back to SVC mode"
+	: : : "r0", "r1");
+}
+
 static void __init r8a73a4_smp_prepare_cpus(unsigned int max_cpus)
 {
 	u32 bar;
@@ -94,6 +122,11 @@ static void __init r8a73a4_smp_prepare_c
 		/* wait for pending bit low */;
 	iounmap(p);
 
+	/* Retrieve frequency to be able to later program CNTFRQ */
+	p = ioremap_nocache(CNTFID0, 16);
+	r8a73a4_arch_freq = __raw_readl(p);
+	iounmap(p);
+
 	r8a73a4_execute_wfe_as_nop();
 }
 
@@ -115,9 +148,11 @@ static int __cpuinit r8a73a4_boot_second
 
 static void __cpuinit r8a73a4_secondary_init(unsigned int cpu)
 {
-	/* CA15 need SW workaround */
+	/* CA15 and CA7 need SW workaround */
 	if (cpu_logical_map(cpu) < 4)
 		r8a73a4_execute_wfe_as_nop();
+	else
+		r8a73a4_reset_arch_timer();
 }
 
 #ifdef CONFIG_HOTPLUG_CPU
