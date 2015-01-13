From: horms+renesas@verge.net.au (Simon Horman)
Date: Tue, 13 Jan 2015 11:13:28 +0900
Subject: [PATCH 2/2] ARM: shmobile: sh73a0 legacy: Set .control_parent for all
 irqpin instances
In-Reply-To: <cover.1421113695.git.horms+renesas@verge.net.au>
References: <cover.1421113695.git.horms+renesas@verge.net.au>
Message-ID: <b0ddb319db3d7a1943445f0de0a45c07a7f3457a.1421113695.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

The sh73a0 INTC can't mask interrupts properly most likely due to a
hardware bug. Set the .control_parent flag to delegate masking to the
parent interrupt controller, like was already done for irqpin1.

Without this, accessing the three-axis digital accelerometer ADXL345
on kzm9g through /dev/input/event1 causes an interrupt storm, which
requires a power-cycle to recover from.

This was inspired by a patch for arch/arm/boot/dts/sh73a0.dtsi from
Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Fixes: 341eb5465f67437a ("ARM: shmobile: INTC External IRQ pin driver on sh73a0")
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/setup-sh73a0.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/mach-shmobile/setup-sh73a0.c b/arch/arm/mach-shmobile/setup-sh73a0.c
index fa7cab8..b5d0cf5 100644
--- a/arch/arm/mach-shmobile/setup-sh73a0.c
+++ b/arch/arm/mach-shmobile/setup-sh73a0.c
@@ -579,6 +579,7 @@ static struct platform_device ipmmu_device = {
 
 static struct renesas_intc_irqpin_config irqpin0_platform_data = {
 	.irq_base = irq_pin(0), /* IRQ0 -> IRQ7 */
+	.control_parent = true,
 };
 
 static struct resource irqpin0_resources[] = {
@@ -640,6 +641,7 @@ static struct platform_device irqpin1_device = {
 
 static struct renesas_intc_irqpin_config irqpin2_platform_data = {
 	.irq_base = irq_pin(16), /* IRQ16 -> IRQ23 */
+	.control_parent = true,
 };
 
 static struct resource irqpin2_resources[] = {
@@ -670,6 +672,7 @@ static struct platform_device irqpin2_device = {
 
 static struct renesas_intc_irqpin_config irqpin3_platform_data = {
 	.irq_base = irq_pin(24), /* IRQ24 -> IRQ31 */
+	.control_parent = true,
 };
 
 static struct resource irqpin3_resources[] = {
-- 
2.1.4
