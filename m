From: afaerber@suse.de (=?UTF-8?q?Andreas=20F=C3=A4rber?=)
Date: Fri, 25 Jul 2014 01:00:17 +0200
Subject: [PATCH v2 08/11] ARM: dts: zynq: Add VDMA to Parallella
In-Reply-To: <1406242820-20140-1-git-send-email-afaerber@suse.de>
References: <1406242820-20140-1-git-send-email-afaerber@suse.de>
Message-ID: <1406242820-20140-9-git-send-email-afaerber@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Andreas F?rber <afaerber@suse.de>
---
 v2: New
 
 arch/arm/boot/dts/zynq-parallella.dts | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/arch/arm/boot/dts/zynq-parallella.dts b/arch/arm/boot/dts/zynq-parallella.dts
index e60a0a9..8beaacc 100644
--- a/arch/arm/boot/dts/zynq-parallella.dts
+++ b/arch/arm/boot/dts/zynq-parallella.dts
@@ -32,6 +32,31 @@
 		bootargs = "console=ttyPS0,115200 earlyprintk root=/dev/mmcblk0p2 rootfstype=ext4 rw rootwait";
 		linux,stdout-path = "/amba/serial at e0001000";
 	};
+
+	fpga {
+		compatible = "simple-bus";
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges;
+
+		axi_vdma: axi-vdma at 43000000 {
+			compatible = "xlnx,axi-vdma-1.00.a";
+			reg = <0x43000000 0x1000>;
+			#dma-cells = <1>;
+			xlnx,num-fstores = <3>;
+			xlnx,include-sg = <0>;
+			xlnx,flush-fsync = <2>;
+
+			dma-channel at 43000000 {
+				compatible = "xlnx,axi-vdma-mm2s-channel";
+				interrupt-parent = <&intc>;
+				interrupts = <0 59 4>;
+				xlnx,datawidth = <64>;
+				xlnx,include-dre = <0>;
+				xlnx,genlock-mode = <0>;
+			};
+		};
+	};
 };
 
 &dmac_s {
-- 
1.9.3
