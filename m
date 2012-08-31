From: horms@verge.net.au (Simon Horman)
Date: Fri, 31 Aug 2012 09:34:40 +0900
Subject: [PATCH 05/10] ARM: shmobile: r8a7779: add USB common phy initializer
In-Reply-To: <1346373285-19588-1-git-send-email-horms@verge.net.au>
References: <1346373285-19588-1-git-send-email-horms@verge.net.au>
Message-ID: <1346373285-19588-6-git-send-email-horms@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

This patch adds common USB phy ports initializer for r8a7779.

The note is that each USB IP have own MSTP clock bit,
and common USB phy port doesn't have MSTP clock,
but this USB phy needs USB clock.
Each USB driver / platform should keep USB MSTP clock somehow.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Simon Horman <horms@verge.net.au>
---
 arch/arm/mach-shmobile/include/mach/common.h |  1 +
 arch/arm/mach-shmobile/setup-r8a7779.c       | 93 ++++++++++++++++++++++++++++
 2 files changed, 94 insertions(+)

diff --git a/arch/arm/mach-shmobile/include/mach/common.h b/arch/arm/mach-shmobile/include/mach/common.h
index 45e61da..00b2eb5 100644
--- a/arch/arm/mach-shmobile/include/mach/common.h
+++ b/arch/arm/mach-shmobile/include/mach/common.h
@@ -78,6 +78,7 @@ extern void r8a7779_clock_init(void);
 extern void r8a7779_pinmux_init(void);
 extern void r8a7779_pm_init(void);
 extern void r8a7740_meram_workaround(void);
+extern int r8a7779_usb_phy_init(u32 usbpctrl0);
 
 extern unsigned int r8a7779_get_core_count(void);
 extern int r8a7779_platform_cpu_kill(unsigned int cpu);
diff --git a/arch/arm/mach-shmobile/setup-r8a7779.c b/arch/arm/mach-shmobile/setup-r8a7779.c
index e98e46f..17fdd1f 100644
--- a/arch/arm/mach-shmobile/setup-r8a7779.c
+++ b/arch/arm/mach-shmobile/setup-r8a7779.c
@@ -25,6 +25,7 @@
 #include <linux/delay.h>
 #include <linux/input.h>
 #include <linux/io.h>
+#include <linux/pm_runtime.h>
 #include <linux/serial_sci.h>
 #include <linux/sh_intc.h>
 #include <linux/sh_timer.h>
@@ -243,6 +244,98 @@ static struct platform_device *r8a7779_early_devices[] __initdata = {
 static struct platform_device *r8a7779_late_devices[] __initdata = {
 };
 
+/* USBH common register */
+#define USBPCTRL0	0x0800
+#define USBPCTRL1	0x0804
+#define USBST		0x0808
+#define USBEH0		0x080C
+#define USBOH0		0x081C
+#define USBCTL0		0x0858
+#define EIIBC1		0x0094
+#define EIIBC2		0x009C
+
+#ifdef CONFIG_ARCH_SUPPORTS_BIG_ENDIAN
+# define xHCI_ENDIAN "BIG"
+# define xHCI_NO_SWAP 0x00000003
+#else
+# define xHCI_ENDIAN "LITTLE"
+# define xHCI_NO_SWAP 0x00000000
+#endif
+
+/*
+ * USB initial/install operation.
+ *
+ * This function setup USB phy.
+ * The used value and setting order came from
+ * [USB :: Initial setting] on datasheet.
+ */
+int __init r8a7779_usb_phy_init(u32 usbpctrl0)
+{
+	void __iomem *reg0, *reg1;
+	int i;
+	u32 val;
+
+	reg0 = ioremap_nocache(0xffe70000, 0x900);
+	reg1 = ioremap_nocache(0xfff70000, 0x900);
+
+	/*----------------------------------------*
+	 * USB phy start-up
+	 *----------------------------------------*/
+
+	/* (1) USB-PHY standby release */
+	iowrite32(0x00000001, (reg0 + USBPCTRL1));
+
+	/* (2) start USB-PHY internal PLL */
+	iowrite32(0x00000003, (reg0 + USBPCTRL1));
+
+	/* (3) USB module status check */
+	for (i = 0; i < 1024; i++) {
+		udelay(10);
+		val = ioread32(reg0 + USBST);
+		if (0xc0000000 == val)
+			goto usb_module_is_working;
+	}
+	pr_err("USB module not ready\n");
+	return -EIO;
+
+usb_module_is_working:
+	/* (4) USB-PHY reset clear */
+	iowrite32(0x00000007, (reg0 + USBPCTRL1));
+
+	/* set platform specific port settings */
+	iowrite32(usbpctrl0, (reg0 + USBPCTRL0));
+
+	/*----------------------------------------*
+	 * EHCI IP Internal Buffer Setting
+	 *----------------------------------------*/
+
+	/* (1) EHCI IP internal buffer setting */
+	iowrite32(0x00ff0040, (reg0 + EIIBC1));
+	iowrite32(0x00ff0040, (reg1 + EIIBC1));
+
+	/* (2) EHCI IP internal buffer enable */
+	iowrite32(0x00000001, (reg0 + EIIBC2));
+	iowrite32(0x00000001, (reg1 + EIIBC2));
+
+	/*----------------------------------------*
+	 * Bus alignment settings
+	 *----------------------------------------*/
+
+	/* (1) EHCI bus alignment */
+	iowrite32(xHCI_NO_SWAP, (reg0 + USBEH0));
+
+	/* (1) OHCI bus alignment */
+	iowrite32(xHCI_NO_SWAP, (reg0 + USBOH0));
+
+	pr_info("USB xHCI alignment was initialized as %s endian no swap\n",
+		xHCI_ENDIAN);
+
+	iounmap(reg0);
+	iounmap(reg1);
+
+	return 0;
+}
+
 void __init r8a7779_add_standard_devices(void)
 {
 #ifdef CONFIG_CACHE_L2X0
-- 
1.7.10.2.484.gcd07cc5
