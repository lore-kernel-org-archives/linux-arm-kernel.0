From: swarren@wwwdotorg.org (Stephen Warren)
Date: Thu, 27 Feb 2014 13:51:21 -0700
Subject: [PATCH V2 3/3] ARM: tegra: fix Dalmore PMIC IRQ polarity
In-Reply-To: <1393534281-30759-1-git-send-email-swarren@wwwdotorg.org>
References: <1393534281-30759-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <1393534281-30759-3-git-send-email-swarren@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Stephen Warren <swarren@nvidia.com>

The Tegra PMC's resume-from-sleep logic wants an active-low IRQ input
from the PMIC. However, the PMIC IRQ is also routed to the GIC, which
only supports active high IRQs (or rising edge). Hence, the signal must
be inverted in the PMC before being routed to the GIC. This implies that
the PMC DT property nvidia,invert-interrupt must be set, and it is.

The PMIC's DT interrupts property must represent the IRQ level at the
GIC, since that is the PMIC's parent IRQ controller. Fix the PMIC's
interrupts property to correctly describe the GIC input polarity.

However, the PMIC IRQ output's polarity is programmable in HW, and by
default follows the parent IRQ controller's input polarity. We need to
have an active-low output due to the inversion inside the Tegra PMC.
Hence, add the ti,irq-externally-inverted property to the PMIC.

Reported-by: Stefan Agner <stefan@agner.ch>
Signed-off-by: Stephen Warren <swarren@nvidia.com>
Acked-by: Laxman Dewangan <ldewangan@nvidia.com>
---
v2: No change.
---
 arch/arm/boot/dts/tegra114-dalmore.dts | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/tegra114-dalmore.dts b/arch/arm/boot/dts/tegra114-dalmore.dts
index 8de543777882..2977206cafc9 100644
--- a/arch/arm/boot/dts/tegra114-dalmore.dts
+++ b/arch/arm/boot/dts/tegra114-dalmore.dts
@@ -893,7 +893,8 @@
 		palmas: tps65913 at 58 {
 			compatible = "ti,palmas";
 			reg = <0x58>;
-			interrupts = <0 86 IRQ_TYPE_LEVEL_LOW>;
+			interrupts = <0 86 IRQ_TYPE_LEVEL_HIGH>;
+			ti,irq-externally-inverted;
 
 			#interrupt-cells = <2>;
 			interrupt-controller;
-- 
1.8.1.5
