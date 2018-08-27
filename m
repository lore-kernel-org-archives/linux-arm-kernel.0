From: horms@verge.net.au (Simon Horman)
Date: Mon, 27 Aug 2018 14:52:39 +0200
Subject: [PATCH/RFT] arm64: dts: renesas: r8a77965: Add OPPs table for
 cpu devices
In-Reply-To: <20180824082327.5my3j4zujckqbe65@verge.net.au>
References: <1534255961-23326-1-git-send-email-ykaneko0929@gmail.com>
 <20180822144113.s7prdezkj5c3xjqm@verge.net.au>
 <20180824082327.5my3j4zujckqbe65@verge.net.au>
Message-ID: <20180827125238.ayaw7z3odnkzid4d@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 24, 2018 at 10:23:28AM +0200, Simon Horman wrote:
> On Wed, Aug 22, 2018 at 04:41:18PM +0200, Simon Horman wrote:
> > On Tue, Aug 14, 2018 at 11:12:41PM +0900, Yoshihiro Kaneko wrote:
> > > From: Dien Pham <dien.pham.ry@renesas.com>
> > > 
> > > This patch adds OPPs table for CA57{0,1} cpu devices
> > > 
> > > Signed-off-by: Dien Pham <dien.pham.ry@renesas.com>
> > > Signed-off-by: Takeshi Kihara <takeshi.kihara.df@renesas.com>
> > > Signed-off-by: Yoshihiro Kaneko <ykaneko0929@gmail.com>
> > 
> > Tested on r8a77965/Salvator-XS
> > 
> > I see that CPUFreq is activated, that sysfs reports 3 possible
> > CPU speeds; 1.5, 1.0 and 0.50GHz. That current CPU frequency can be manipulated
> > by setting the maximum CPU frequency in sysfs. And that the frequency
> > of Z clock changes accordingly.
> > 
> > Tested-by: Simon Horman <horms+renesas@verge.net.au>
> 
> I have applied this for v4.20.

I noticed that this patch included unit numbers for the opps nodes.
This is not correct as there is no bus that the nodes live on.
I fixed this using s/@/-/.
The result is below:

>From cd889b86ce3fba300ce82b0ec22bf310cd2f361d Mon Sep 17 00:00:00 2001
From: Dien Pham <dien.pham.ry@renesas.com>
Date: Tue, 14 Aug 2018 23:12:41 +0900
Subject: [PATCH] arm64: dts: renesas: r8a77965: Add OPPs table for cpu devices

This patch adds OPPs table for CA57{0,1} cpu devices

Signed-off-by: Dien Pham <dien.pham.ry@renesas.com>
Signed-off-by: Takeshi Kihara <takeshi.kihara.df@renesas.com>
Signed-off-by: Yoshihiro Kaneko <ykaneko0929@gmail.com>
Tested-by: Simon Horman <horms+renesas@verge.net.au>
[simon: do not give nodes unit names as they have no bus addresses]
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm64/boot/dts/renesas/r8a77965.dtsi | 44 +++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a77965.dtsi b/arch/arm64/boot/dts/renesas/r8a77965.dtsi
index e7128fb65e33..5ce978502ee9 100644
--- a/arch/arm64/boot/dts/renesas/r8a77965.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a77965.dtsi
@@ -60,6 +60,46 @@
 		clock-frequency = <0>;
 	};
 
+	cluster0_opp: opp_table0 {
+		compatible = "operating-points-v2";
+		opp-shared;
+
+		opp-500000000 {
+			opp-hz = /bits/ 64 <500000000>;
+			opp-microvolt = <830000>;
+			clock-latency-ns = <300000>;
+		};
+		opp-1000000000 {
+			opp-hz = /bits/ 64 <1000000000>;
+			opp-microvolt = <830000>;
+			clock-latency-ns = <300000>;
+		};
+		opp-1500000000 {
+			opp-hz = /bits/ 64 <1500000000>;
+			opp-microvolt = <830000>;
+			clock-latency-ns = <300000>;
+			opp-suspend;
+		};
+		opp-1600000000 {
+			opp-hz = /bits/ 64 <1600000000>;
+			opp-microvolt = <900000>;
+			clock-latency-ns = <300000>;
+			turbo-mode;
+		};
+		opp-1700000000 {
+			opp-hz = /bits/ 64 <1700000000>;
+			opp-microvolt = <900000>;
+			clock-latency-ns = <300000>;
+			turbo-mode;
+		};
+		opp-1800000000 {
+			opp-hz = /bits/ 64 <1800000000>;
+			opp-microvolt = <960000>;
+			clock-latency-ns = <300000>;
+			turbo-mode;
+		};
+	};
+
 	cpus {
 		#address-cells = <1>;
 		#size-cells = <0>;
@@ -71,6 +111,8 @@
 			power-domains = <&sysc R8A77965_PD_CA57_CPU0>;
 			next-level-cache = <&L2_CA57>;
 			enable-method = "psci";
+			clocks =<&cpg CPG_CORE R8A77965_CLK_Z>;
+			operating-points-v2 = <&cluster0_opp>;
 		};
 
 		a57_1: cpu at 1 {
@@ -80,6 +122,8 @@
 			power-domains = <&sysc R8A77965_PD_CA57_CPU1>;
 			next-level-cache = <&L2_CA57>;
 			enable-method = "psci";
+			clocks =<&cpg CPG_CORE R8A77965_CLK_Z>;
+			operating-points-v2 = <&cluster0_opp>;
 		};
 
 		L2_CA57: cache-controller-0 {
-- 
2.11.0
