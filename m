From: linus.walleij@stericsson.com (Linus Walleij)
Date: Fri, 31 May 2013 11:18:52 +0200
Subject: [PATCH 17/39] ARM: u300: add the COH 901 318 DMAC to device tree
In-Reply-To: <1369991954-17406-1-git-send-email-linus.walleij@stericsson.com>
References: <1369991954-17406-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <1369991954-17406-18-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Linus Walleij <linus.walleij@linaro.org>

This adds the COH 901 318 DMA controller to the U300
device tree. All devices now converted to device tree
so far will start to find their DMA channels.

Note that the U300 is not yet using the device tree
to obtain DMA channels, but this is a first step.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/boot/dts/ste-u300.dts | 9 +++++++++
 arch/arm/mach-u300/core.c      | 2 ++
 2 files changed, 11 insertions(+)

diff --git a/arch/arm/boot/dts/ste-u300.dts b/arch/arm/boot/dts/ste-u300.dts
index 6be932b..4dc9f26 100644
--- a/arch/arm/boot/dts/ste-u300.dts
+++ b/arch/arm/boot/dts/ste-u300.dts
@@ -68,6 +68,15 @@
 		interrupts = <10>;
 	};
 
+	dmac: dma-controller at c00020000 {
+		compatible = "stericsson,coh901318";
+		reg = <0xc0020000 0x1000>;
+		interrupt-parent = <&vica>;
+		interrupts = <2>;
+		#dma-cells = <1>;
+		dma-channels = <40>;
+	};
+
 	i2c0: i2c at c0004000 {
 		compatible = "st,ddci2c";
 		reg = <0xc0004000 0x1000>;
diff --git a/arch/arm/mach-u300/core.c b/arch/arm/mach-u300/core.c
index 637034b..7866f54 100644
--- a/arch/arm/mach-u300/core.c
+++ b/arch/arm/mach-u300/core.c
@@ -714,6 +714,8 @@ static struct of_dev_auxdata u300_auxdata_lookup[] __initdata = {
 		"coh901327_wdog", NULL),
 	OF_DEV_AUXDATA("stericsson,coh901331", U300_RTC_BASE,
 		"rtc-coh901331", NULL),
+	OF_DEV_AUXDATA("stericsson,coh901318", U300_DMAC_BASE,
+		"coh901318", NULL),
 	OF_DEV_AUXDATA("arm,primecell", U300_UART0_BASE,
 		"uart0", &uart0_plat_data),
 	OF_DEV_AUXDATA("arm,primecell", U300_UART1_BASE,
-- 
1.7.11.3
