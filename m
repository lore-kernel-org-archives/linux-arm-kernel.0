From: haiyue.wang@linux.intel.com (Haiyue Wang)
Date: Sat, 31 Mar 2018 15:46:38 +0800
Subject: [PATCH dts/arm/aspeed-g5 v1] ARM: dts: aspeed-g5: Add IPMI KCS nodes
 for SMS and SMM mode
Message-ID: <1522482398-6248-1-git-send-email-haiyue.wang@linux.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The IPMI KCS device part of the LPC interface and is used for
communication with the host processor.

Keyboard Controller Style Interfaces:
The KCS channel number is assigned by AST_usrGuide_KCS.pdf
Name          | Use          | Address       | KCS Channel |
SMS Interface | SMS          | 0CA2h ? 0CA3h | kcs3        |
SMM Interface | SMI handling | 0CA4h ? 0CA5h | kcs4        |

Signed-off-by: Haiyue Wang <haiyue.wang@linux.intel.com>
---
The kcs_bmc_aspeed driver is in linux-next now:
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/drivers/char/ipmi/kcs_bmc_aspeed.c?h=next-20180329
---
 arch/arm/boot/dts/aspeed-g5.dtsi | 25 ++++++++++++++++++++++++-
 1 file changed, 24 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/aspeed-g5.dtsi b/arch/arm/boot/dts/aspeed-g5.dtsi
index 17ee0fa3..8d6c4af 100644
--- a/arch/arm/boot/dts/aspeed-g5.dtsi
+++ b/arch/arm/boot/dts/aspeed-g5.dtsi
@@ -268,8 +268,22 @@
 				ranges = <0x0 0x1e789000 0x1000>;
 
 				lpc_bmc: lpc-bmc at 0 {
-					compatible = "aspeed,ast2500-lpc-bmc";
+					compatible = "aspeed,ast2500-lpc-bmc", "simple-mfd", "syscon";
 					reg = <0x0 0x80>;
+					reg-io-width = <4>;
+
+					#address-cells = <1>;
+					#size-cells = <1>;
+					ranges = <0x0 0x0 0x80>;
+
+					kcs3: kcs3 at 0 {
+						compatible = "aspeed,ast2500-kcs-bmc";
+						reg = <0x0 0x80>;
+						interrupts = <8>;
+						kcs_chan = <3>;
+						kcs_addr = <0xca2>;
+						status = "disabled";
+					};
 				};
 
 				lpc_host: lpc-host at 80 {
@@ -281,6 +295,15 @@
 					#size-cells = <1>;
 					ranges = <0x0 0x80 0x1e0>;
 
+					kcs4: kcs4 at 0 {
+						compatible = "aspeed,ast2500-kcs-bmc";
+						reg = <0x0 0xa0>;
+						interrupts = <8>;
+						kcs_chan = <4>;
+						kcs_addr = <0xca4>;
+						status = "disabled";
+					};
+
 					lpc_ctrl: lpc-ctrl at 0 {
 						compatible = "aspeed,ast2500-lpc-ctrl";
 						reg = <0x0 0x80>;
-- 
2.7.4
