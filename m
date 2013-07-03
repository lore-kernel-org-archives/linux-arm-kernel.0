From: festevam@gmail.com (Fabio Estevam)
Date: Wed,  3 Jul 2013 12:40:06 -0300
Subject: [PATCH] ARM: mx6: Fix the number of reported cores
Message-ID: <1372866006-3892-1-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@freescale.com>

On a mx6 quad-core processor:

$ cat /proc/cpuinfo                                             
processor       : 0                                                             
model name      : ARMv7 Processor rev 10 (v7l)                                  
BogoMIPS        : 1581.05                                                       
Features        : swp half thumb fastmult vfp edsp neon vfpv3 tls               
CPU implementer : 0x41                                                          
CPU architecture: 7                                                             
CPU variant     : 0x2                                                           
CPU part        : 0xc09                                                         
CPU revision    : 10                                                            

,which incorrectly shows this is a single core device.

Commit a0ae0240 (ARM: kernel: add device tree init map function) introduced the 
following requirement according to Documentation/devicetree/bindings/arm/cpus.txt:
"For the ARM architecture every CPU node must contain the following properties:

- device_type:	must be "cpu" 

Pass the 'device_type' property for each cpu node, so that we can have all the 
four cores correctly reported again.

Cc: <stable@vger.kernel.org> #3.10
Reported-by: Mike Loebl <mloebl@gmail.com> 
Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 arch/arm/boot/dts/imx6dl.dtsi | 2 ++
 arch/arm/boot/dts/imx6q.dtsi  | 4 ++++
 2 files changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/imx6dl.dtsi b/arch/arm/boot/dts/imx6dl.dtsi
index 63fafe2..a4b3e1e 100644
--- a/arch/arm/boot/dts/imx6dl.dtsi
+++ b/arch/arm/boot/dts/imx6dl.dtsi
@@ -16,12 +16,14 @@
 
 		cpu at 0 {
 			compatible = "arm,cortex-a9";
+			device_type = "cpu"
 			reg = <0>;
 			next-level-cache = <&L2>;
 		};
 
 		cpu at 1 {
 			compatible = "arm,cortex-a9";
+			device_type = "cpu"
 			reg = <1>;
 			next-level-cache = <&L2>;
 		};
diff --git a/arch/arm/boot/dts/imx6q.dtsi b/arch/arm/boot/dts/imx6q.dtsi
index cba021e..f4e9ebf 100644
--- a/arch/arm/boot/dts/imx6q.dtsi
+++ b/arch/arm/boot/dts/imx6q.dtsi
@@ -17,6 +17,7 @@
 
 		cpu at 0 {
 			compatible = "arm,cortex-a9";
+			device_type = "cpu";
 			reg = <0>;
 			next-level-cache = <&L2>;
 			operating-points = <
@@ -38,18 +39,21 @@
 
 		cpu@1 {
 			compatible = "arm,cortex-a9";
+			device_type = "cpu";
 			reg = <1>;
 			next-level-cache = <&L2>;
 		};
 
 		cpu at 2 {
 			compatible = "arm,cortex-a9";
+			device_type = "cpu";
 			reg = <2>;
 			next-level-cache = <&L2>;
 		};
 
 		cpu at 3 {
 			compatible = "arm,cortex-a9";
+			device_type = "cpu";
 			reg = <3>;
 			next-level-cache = <&L2>;
 		};
-- 
1.8.1.2
