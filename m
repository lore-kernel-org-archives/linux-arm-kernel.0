From: malat@debian.org (Mathieu Malaterre)
Date: Fri, 15 Dec 2017 13:46:50 +0100
Subject: [PATCH 17/25] arm: rk3: dts: Remove leading 0x and 0s from bindings
 notation
Message-ID: <20171215124650.30742-1-malat@debian.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Improve the DTS files by removing all the leading "0x" and zeros to fix the
following dtc warnings:

Warning (unit_address_format): Node /XXX unit name should not have leading "0x"

and

Warning (unit_address_format): Node /XXX unit name should not have leading 0s

Converted using the following command:

find . -type f \( -iname *.dts -o -iname *.dtsi \) -exec sed -i -e "s/@\([0-9a-fA-FxX\.;:#]+\)\s*{/@\L\1 {/g" -e "s/@0x\(.*\) {/@\1 {/g" -e "s/@0+\(.*\) {/@\1 {/g" {} +^C

For simplicity, two sed expressions were used to solve each warnings separately.

To make the regex expression more robust a few other issues were resolved,
namely setting unit-address to lower case, and adding a whitespace before the
the opening curly brace:

https://elinux.org/Device_Tree_Linux#Linux_conventions

This will solve as a side effect warning:

Warning (simple_bus_reg): Node /XXX@<UPPER> simple-bus unit address format error, expected "<lower>"

This is a follow up to commit 4c9847b7375a ("dt-bindings: Remove leading 0x from bindings notation")

Reported-by: David Daney <ddaney@caviumnetworks.com>
Suggested-by: Rob Herring <robh@kernel.org>
Signed-off-by: Mathieu Malaterre <malat@debian.org>
---
 arch/arm/boot/dts/rk3288.dtsi | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/rk3288.dtsi b/arch/arm/boot/dts/rk3288.dtsi
index cd24894ee5c6..3d81281be280 100644
--- a/arch/arm/boot/dts/rk3288.dtsi
+++ b/arch/arm/boot/dts/rk3288.dtsi
@@ -744,7 +744,7 @@
 			 *	*_HDMI		HDMI
 			 *	*_MIPI_*	MIPI
 			 */
-			pd_vio at RK3288_PD_VIO {
+			pd_vio at rk3288_pd_vio {
 				reg = <RK3288_PD_VIO>;
 				clocks = <&cru ACLK_IEP>,
 					 <&cru ACLK_ISP>,
@@ -786,7 +786,7 @@
 			 * Note: The following 3 are HEVC(H.265) clocks,
 			 * and on the ACLK_HEVC_NIU (NOC).
 			 */
-			pd_hevc at RK3288_PD_HEVC {
+			pd_hevc at rk3288_pd_hevc {
 				reg = <RK3288_PD_HEVC>;
 				clocks = <&cru ACLK_HEVC>,
 					 <&cru SCLK_HEVC_CABAC>,
@@ -800,7 +800,7 @@
 			 * (video endecoder & decoder) clocks that on the
 			 * ACLK_VCODEC_NIU and HCLK_VCODEC_NIU (NOC).
 			 */
-			pd_video at RK3288_PD_VIDEO {
+			pd_video at rk3288_pd_video {
 				reg = <RK3288_PD_VIDEO>;
 				clocks = <&cru ACLK_VCODEC>,
 					 <&cru HCLK_VCODEC>;
@@ -811,7 +811,7 @@
 			 * Note: ACLK_GPU is the GPU clock,
 			 * and on the ACLK_GPU_NIU (NOC).
 			 */
-			pd_gpu at RK3288_PD_GPU {
+			pd_gpu at rk3288_pd_gpu {
 				reg = <RK3288_PD_GPU>;
 				clocks = <&cru ACLK_GPU>;
 				pm_qos = <&qos_gpu_r>,
-- 
2.11.0
