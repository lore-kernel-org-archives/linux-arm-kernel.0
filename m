From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon,  7 Jan 2013 23:56:12 +0100
Subject: [PATCH 04/11] ARM: nomadik: move remaining PrimeCells to device tree
Message-ID: <1357599372-7458-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The two remaining PrimeCells, RNG and RTC, are migrated to the
device tree for device tree boot.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/boot/dts/ste-nomadik-stn8815.dtsi | 12 ++++++++++++
 arch/arm/mach-nomadik/cpu-8815.c           | 11 +++++++++--
 2 files changed, 21 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/ste-nomadik-stn8815.dtsi b/arch/arm/boot/dts/ste-nomadik-stn8815.dtsi
index 81284c5..29986ea 100644
--- a/arch/arm/boot/dts/ste-nomadik-stn8815.dtsi
+++ b/arch/arm/boot/dts/ste-nomadik-stn8815.dtsi
@@ -73,5 +73,17 @@
 			interrupts = <28>;
 			status = "disabled";
 		};
+
+		rng: rng at 101b0000 {
+			compatible = "arm,primecell";
+			reg = <0x101b0000 0x1000>;
+		};
+
+		rtc: rtc at 101e8000 {
+			compatible = "arm,pl031", "arm,primecell";
+			reg = <0x101e8000 0x1000>;
+			interrupt-parent = <&vica>;
+			interrupts = <10>;
+		};
 	};
 };
diff --git a/arch/arm/mach-nomadik/cpu-8815.c b/arch/arm/mach-nomadik/cpu-8815.c
index a983f47..10b9f20 100644
--- a/arch/arm/mach-nomadik/cpu-8815.c
+++ b/arch/arm/mach-nomadik/cpu-8815.c
@@ -39,6 +39,7 @@
 #include <asm/mach/map.h>
 #include <asm/mach/time.h>
 #include <asm/hardware/vic.h>
+#include <asm/mach-types.h>
 
 #include <asm/cacheflush.h>
 #include <asm/hardware/cache-l2x0.h>
@@ -154,8 +155,10 @@ static int __init cpu8815_init(void)
 	cpu8815_add_gpios(cpu8815_gpio_base, ARRAY_SIZE(cpu8815_gpio_base),
 			  IRQ_GPIO0, &pdata);
 	cpu8815_add_pinctrl(NULL, "pinctrl-stn8815");
-	amba_apb_device_add(NULL, "rng", NOMADIK_RNG_BASE, SZ_4K, 0, 0, NULL, 0);
-	amba_apb_device_add(NULL, "rtc-pl031", NOMADIK_RTC_BASE, SZ_4K, IRQ_RTC_RTT, 0, NULL, 0);
+	if (machine_is_nomadik()) {
+		amba_apb_device_add(NULL, "rng", NOMADIK_RNG_BASE, SZ_4K, 0, 0, NULL, 0);
+		amba_apb_device_add(NULL, "rtc-pl031", NOMADIK_RTC_BASE, SZ_4K, IRQ_RTC_RTT, 0, NULL, 0);
+	}
 	return 0;
 }
 arch_initcall(cpu8815_init);
@@ -265,6 +268,10 @@ static struct of_dev_auxdata cpu8815_auxdata_lookup[] __initdata = {
 		"uart0", NULL),
 	OF_DEV_AUXDATA("arm,primecell", NOMADIK_UART1_BASE,
 		"uart1", NULL),
+	OF_DEV_AUXDATA("arm,primecell", NOMADIK_RNG_BASE,
+		"rng", NULL),
+	OF_DEV_AUXDATA("arm,primecell", NOMADIK_RTC_BASE,
+		"rtc-pl031", NULL),
 	{ /* sentinel */ },
 };
 
-- 
1.7.11.7
