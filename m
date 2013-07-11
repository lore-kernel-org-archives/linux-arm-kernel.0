From: magnus.damm@gmail.com (Magnus Damm)
Date: Fri, 12 Jul 2013 01:22:29 +0900
Subject: [PATCH 02/02] ARM: shmobile: Setup r8a7790 arch timer based on MD pins
In-Reply-To: <20130711162209.933.47610.sendpatchset@w520>
References: <20130711162209.933.47610.sendpatchset@w520>
Message-ID: <20130711162229.933.53924.sendpatchset@w520>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Update the r8a7790 arch timer setup code to configure the
frequency dynamically at boot time. This means that the arch
timer driver will be able to detect a timer frequency that
has been calculated based on the MD pins instead of a fixed
and potentially incorrect 13 MHz.

With this patch applied the Linux kernel will correctly
support the r8a7790 Lager board that uses a 20 Mhz EXTAL.
The arch timer will operate on 10 MHz and the Linux arch
timer driver will be correctly configured to use 10 MHz.

Without this patch the 20 MHz EXTAL will be used to drive
the arch timer at 10 MHz, but the Linux arch timer driver
will believe it is counting at 13 Mhz.

Reported-by: Ulrich Hecht <ulrich.hecht@gmail.com>
Signed-off-by: Magnus Damm <damm@opensource.se>
Tested-by: Ulrich Hecht <ulrich.hecht@gmail.com>
---

 arch/arm/mach-shmobile/setup-r8a7790.c |   49 ++++++++++++++++++++++++++++----
 1 file changed, 44 insertions(+), 5 deletions(-)

--- 0006/arch/arm/mach-shmobile/setup-r8a7790.c
+++ work/arch/arm/mach-shmobile/setup-r8a7790.c	2013-07-09 21:29:18.000000000 +0900
@@ -215,14 +215,53 @@ u32 __init r8a7790_read_mode_pins(void)
 	return mode;
 }
 
+#define CNTCR 0
+#define CNTFID0 0x20
+
 void __init r8a7790_timer_init(void)
 {
-	void __iomem *cntcr;
+#ifdef CONFIG_ARM_ARCH_TIMER
+	u32 mode = r8a7790_read_mode_pins();
+	void __iomem *base;
+	int extal_mhz = 0;
+	u32 freq;
+
+	/* At Linux boot time the r8a7790 arch timer comes up
+	 * with the counter disabled. Moreover, it may also report
+	 * a potentially incorrect fixed 13 MHz frequency. To be
+	 * correct these registers need to be updated to use the
+	 * frequency EXTAL / 2 which can be determined by the MD pins.
+	 */
+
+	switch (mode & (MD(14) | MD(13))) {
+	case 0:
+		extal_mhz = 15;
+		break;
+	case MD(13):
+		extal_mhz = 20;
+		break;
+	case MD(14):
+		extal_mhz = 26;
+		break;
+	case MD(13) | MD(14):
+		extal_mhz = 30;
+		break;
+	}
+
+	/* The arch timer frequency equals EXTAL / 2 */
+	freq = extal_mhz * (1000000 / 2);
+
+	/* Remap "armgcnt address map" space */
+	base = ioremap(0xe6080000, PAGE_SIZE);
+
+	/* Update registers with correct frequency */
+	iowrite32(freq, base + CNTFID0);
+	asm volatile("mcr p15, 0, %0, c14, c0, 0" : : "r" (freq));
 
-	/* make sure arch timer is started by setting bit 0 of CNTCT */
-	cntcr = ioremap(0xe6080000, PAGE_SIZE);
-	iowrite32(1, cntcr);
-	iounmap(cntcr);
+	/* make sure arch timer is started by setting bit 0 of CNTCR */
+	iowrite32(1, base + CNTCR);
+	iounmap(base);
+#endif /* CONFIG_ARM_ARCH_TIMER */
 
 	shmobile_timer_init();
 }
