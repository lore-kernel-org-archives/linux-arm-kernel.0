From: wangkefeng.wang@huawei.com (Kefeng Wang)
Date: Fri, 8 Apr 2016 15:31:51 +0800
Subject: [PATCH v2 2/2] arm64: dts: hip05: Add nor flash support
In-Reply-To: <1460100711-54144-1-git-send-email-wangkefeng.wang@huawei.com>
References: <1460100711-54144-1-git-send-email-wangkefeng.wang@huawei.com>
Message-ID: <1460100711-54144-3-git-send-email-wangkefeng.wang@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch is to add support nor-flash. Notice, the pre-defined
partitions may not be used.

Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 arch/arm64/boot/dts/hisilicon/hip05-d02.dts | 34 +++++++++++++++++++++++++++++
 arch/arm64/boot/dts/hisilicon/hip05.dtsi    |  6 +++++
 2 files changed, 40 insertions(+)

diff --git a/arch/arm64/boot/dts/hisilicon/hip05-d02.dts b/arch/arm64/boot/dts/hisilicon/hip05-d02.dts
index e9436c0..abba750 100644
--- a/arch/arm64/boot/dts/hisilicon/hip05-d02.dts
+++ b/arch/arm64/boot/dts/hisilicon/hip05-d02.dts
@@ -52,3 +52,37 @@
 &peri_gpio0 {
 	status = "ok";
 };
+
+&lbc {
+	status = "ok";
+	#address-cells = <2>;
+	#size-cells = <1>;
+	ranges = <0 0 0x0 0x90000000 0x08000000>,
+		 <1 0 0x0 0x98000000 0x08000000>;
+
+	nor-flash at 0,0 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "numonyx,js28f00a", "cfi-flash";
+		reg = <0 0x0 0x08000000>;
+		bank-width = <2>;
+		/* The three parts may not used */
+		partition at 0 {
+			label = "BIOS";
+			reg = <0x0 0x300000>;
+		};
+		partition at 300000 {
+			label = "Linux";
+			reg = <0x300000 0xa00000>;
+		};
+		partition at 1000000 {
+			label = "Rootfs";
+			reg = <0x01000000 0x02000000>;
+		};
+	};
+
+	cpld at 1,0 {
+		compatible = "hisilicon,hip05-cpld";
+		reg = <1 0x0 0x100>;
+	};
+};
diff --git a/arch/arm64/boot/dts/hisilicon/hip05.dtsi b/arch/arm64/boot/dts/hisilicon/hip05.dtsi
index 52d06ab..bf322ed 100644
--- a/arch/arm64/boot/dts/hisilicon/hip05.dtsi
+++ b/arch/arm64/boot/dts/hisilicon/hip05.dtsi
@@ -327,6 +327,12 @@
 			status = "disabled";
 		};
 
+		lbc: localbus at 80380000 {
+			compatible = "hisilicon,hisi-localbus", "simple-bus";
+			reg = <0x0 0x80380000 0x0 0x10000>;
+			status = "disabled";
+		};
+
 		peri_gpio0: gpio at 802e0000 {
 			#address-cells = <1>;
 			#size-cells = <0>;
-- 
1.7.12.4
