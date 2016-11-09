From: cw00.choi@samsung.com (Chanwoo Choi)
Date: Wed, 09 Nov 2016 17:40:11 +0900
Subject: [PATCH v4 2/2] pinctrl: samsung: Add GPF support for Exynos5433
In-Reply-To: <1478680811-24835-1-git-send-email-cw00.choi@samsung.com>
References: <1478680811-24835-1-git-send-email-cw00.choi@samsung.com>
Message-ID: <1478680811-24835-3-git-send-email-cw00.choi@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch add the support of GPF[1-5] pin of Exynos5433 SoC. The GPFx need
to support the multiple memory map because the registers of GPFx are located
in the different domain.

Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Tomasz Figa <tomasz.figa@gmail.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Sylwester Nawrocki <s.nawrocki@samsung.com>
Cc: Kukjin Kim <kgene@kernel.org>
Cc: linux-gpio at vger.kernel.org
Signed-off-by: Joonyoung Shim <jy0922.shim@samsung.com>
Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
---
 .../devicetree/bindings/pinctrl/samsung-pinctrl.txt   | 19 +++++++++++++++++++
 drivers/pinctrl/samsung/pinctrl-exynos.c              |  6 ++++++
 2 files changed, 25 insertions(+)

diff --git a/Documentation/devicetree/bindings/pinctrl/samsung-pinctrl.txt b/Documentation/devicetree/bindings/pinctrl/samsung-pinctrl.txt
index d49e22d2a8b5..1baf19eecabf 100644
--- a/Documentation/devicetree/bindings/pinctrl/samsung-pinctrl.txt
+++ b/Documentation/devicetree/bindings/pinctrl/samsung-pinctrl.txt
@@ -19,11 +19,30 @@ Required Properties:
   - "samsung,exynos5260-pinctrl": for Exynos5260 compatible pin-controller.
   - "samsung,exynos5410-pinctrl": for Exynos5410 compatible pin-controller.
   - "samsung,exynos5420-pinctrl": for Exynos5420 compatible pin-controller.
+  - "samsung,exynos5433-pinctrl": for Exynos5433 compatible pin-controller.
   - "samsung,exynos7-pinctrl": for Exynos7 compatible pin-controller.
 
 - reg: Base address of the pin controller hardware module and length of
   the address space it occupies.
 
+  - reg: Second base address of the pin controller if the specific registers
+  of the pin controller are separated into the different base address.
+
+	Eg: GPF[1-5] of Exynos5433 are separated into the two base address.
+	- First base address is for GPAx and GPF[1-5] external interrupt
+	  registers.
+	- Second base address is for GPF[1-5] pinctrl registers.
+
+	pinctrl_0: pinctrl at 10580000 {
+		compatible = "samsung,exynos5433-pinctrl";
+		reg = <0x10580000 0x1a20>, <0x11090000 0x100>;
+
+		wakeup-interrupt-controller {
+			compatible = "samsung,exynos7-wakeup-eint";
+			interrupts = <0 16 0>;
+		};
+	};
+
 - Pin banks as child nodes: Pin banks of the controller are represented by child
   nodes of the controller node. Bank name is taken from name of the node. Each
   bank node must contain following properties:
diff --git a/drivers/pinctrl/samsung/pinctrl-exynos.c b/drivers/pinctrl/samsung/pinctrl-exynos.c
index d657b52dfdb5..12f7d1eb65bc 100644
--- a/drivers/pinctrl/samsung/pinctrl-exynos.c
+++ b/drivers/pinctrl/samsung/pinctrl-exynos.c
@@ -1339,6 +1339,11 @@ static void exynos_pinctrl_resume(struct samsung_pinctrl_drv_data *drvdata)
 	EXYNOS_PIN_BANK_EINTW(8, 0x020, "gpa1", 0x04),
 	EXYNOS_PIN_BANK_EINTW(8, 0x040, "gpa2", 0x08),
 	EXYNOS_PIN_BANK_EINTW(8, 0x060, "gpa3", 0x0c),
+	EXYNOS_PIN_BANK_EINTW_EXT(8, 0x020, "gpf1", 0x1004, 1),
+	EXYNOS_PIN_BANK_EINTW_EXT(4, 0x040, "gpf2", 0x1008, 1),
+	EXYNOS_PIN_BANK_EINTW_EXT(4, 0x060, "gpf3", 0x100c, 1),
+	EXYNOS_PIN_BANK_EINTW_EXT(8, 0x080, "gpf4", 0x1010, 1),
+	EXYNOS_PIN_BANK_EINTW_EXT(8, 0x0a0, "gpf5", 0x1014, 1),
 };
 
 /* pin banks of exynos5433 pin-controller - AUD */
@@ -1420,6 +1425,7 @@ static void exynos_pinctrl_resume(struct samsung_pinctrl_drv_data *drvdata)
 		.eint_wkup_init = exynos_eint_wkup_init,
 		.suspend	= exynos_pinctrl_suspend,
 		.resume		= exynos_pinctrl_resume,
+		.nr_ext_resources = 1,
 	}, {
 		/* pin-controller instance 1 data */
 		.pin_banks	= exynos5433_pin_banks1,
-- 
1.9.1
