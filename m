From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon,  7 Nov 2016 09:44:43 +0100
Subject: [PATCH 2/3 v4] ARM: dts: reference PM8058 as IRQ parent
In-Reply-To: <1478508284-10847-1-git-send-email-linus.walleij@linaro.org>
References: <1478508284-10847-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <1478508284-10847-2-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some nodes are referencing the pm8058_gpio as IRQ parent, but
the HW IRQ offset they are supplying is actually that for the
parent to that controller: the PM8058 itself. Since that is the
proper parent, reference it directly.

We can switch this to the pm8058_gpio and the proper offset
once we have fixed the SSBI GPIO driver to properly deal with
the hierarchical IRQ domain and get proper local offset
translation.

Acked-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog v1->v2:
- Add Bjorn's ACK.
- Follow version numbering of the primary patch.
---
 arch/arm/boot/dts/qcom-apq8060-dragonboard.dts | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/qcom-apq8060-dragonboard.dts b/arch/arm/boot/dts/qcom-apq8060-dragonboard.dts
index 4a532ddab53a..ea660ffa03ea 100644
--- a/arch/arm/boot/dts/qcom-apq8060-dragonboard.dts
+++ b/arch/arm/boot/dts/qcom-apq8060-dragonboard.dts
@@ -369,8 +369,8 @@
 				ak8975 at 0c {
 					compatible = "asahi-kasei,ak8975";
 					reg = <0x0c>;
-					/* GPIO33 has interrupt 224 on the PM8058 */
-					interrupt-parent = <&pm8058_gpio>;
+					/* FIXME: GPIO33 has interrupt 224 on the PM8058 */
+					interrupt-parent = <&pm8058>;
 					interrupts = <224 IRQ_TYPE_EDGE_RISING>;
 					pinctrl-names = "default";
 					pinctrl-0 = <&dragon_ak8975_gpios>;
@@ -380,8 +380,8 @@
 				bmp085 at 77 {
 					compatible = "bosch,bmp085";
 					reg = <0x77>;
-					/* GPIO16 has interrupt 207 on the PM8058 */
-					interrupt-parent = <&pm8058_gpio>;
+					/* FIXME: GPIO16 has interrupt 207 on the PM8058 */
+					interrupt-parent = <&pm8058>;
 					interrupts = <207 IRQ_TYPE_EDGE_RISING>;
 					reset-gpios = <&tlmm 86 GPIO_ACTIVE_LOW>;
 					pinctrl-names = "default";
-- 
2.7.4
