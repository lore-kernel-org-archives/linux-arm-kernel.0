From: tony@atomide.com (Tony Lindgren)
Date: Thu, 5 May 2016 12:27:32 -0700
Subject: [PATCH] ARM: dts: omap5-board-common: Describe the voltage
 supply mapping accurately
In-Reply-To: <572B984D.10203@ti.com>
References: <1462389618-28860-1-git-send-email-nm@ti.com>
 <572A528C.4090302@ti.com> <20160505183611.GA5995@atomide.com>
 <572B984D.10203@ti.com>
Message-ID: <20160505192732.GC5995@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Nishanth Menon <nm@ti.com> [160505 12:02]:
> On 05/05/2016 01:36 PM, Tony Lindgren wrote:
> > Now I'm wondering if the x15 related vin-supply changes are actually all
> > ignored? It seems that "vin" is only automatically configured for the
> > fixed-regulator? Maybe regulator-palmas should be updated to use the
> 
> ok /me goes duh!!!! ofcourse! Sorry about not catching it..
> hmm.. maybe we messed up am572x-idk as well.. I can quickly fix that
> up as well

OK yeah sounds like they won't do anything currently.

> ldoln is vsys_cobra as well.. I missed that.
> 
> Others look good. we should probably get this merged to fix the
> regression.

OK I'll apply the following updated version of your patch later today.
I left out the links from the description and the timestamps too.

Regards,

Tony

8< -------------------------
From: Nishanth Menon <nm@ti.com>
Date: Thu, 5 May 2016 11:12:28 -0700
Subject: [PATCH] ARM: dts: omap5-board-common: Describe the voltage supply
 mapping accurately
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

OMAP5uEVM based platforms share a similar voltage rail map. This
should be properly described in device tree, without this regulator core
will be unable to determine the source voltage of LDOs such as LDO9 and
SMPS10 which could be configured for bypass depending on the voltage
requested of them. This results in conditions such as:

ldo9: bypassed regulator has no supply!
ldo9: failed to get the current voltage(-517)
palmas-pmic 48070000.i2c:palmas at 48:palmas_pmic: failed to register
48070000.i2c:palmas at 48:palmas_pmic regulator

Cc: Agust? Fontquerni <af@iseebcn.com>
Cc: Eduard Gavin <egavin@iseebcn.com>
Cc: Enric Balletbo i Serra <eballetbo@iseebcn.com>
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>
Signed-off-by: Nishanth Menon <nm@ti.com>
[tony at atomide.com: fixed to use palmas style in-supply]
Signed-off-by: Tony Lindgren <tony@atomide.com>

--- a/arch/arm/boot/dts/omap5-board-common.dtsi
+++ b/arch/arm/boot/dts/omap5-board-common.dtsi
@@ -14,6 +14,29 @@
 		display0 = &hdmi0;
 	};
 
+	vmain: fixedregulator-vmain {
+		compatible = "regulator-fixed";
+		regulator-name = "vmain";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+	};
+
+	vsys_cobra: fixedregulator-vsys_cobra {
+		compatible = "regulator-fixed";
+		regulator-name = "vsys_cobra";
+		vin-supply = <&vmain>;
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+	};
+
+	vdds_1v8_main: fixedregulator-vdds_1v8_main {
+		compatible = "regulator-fixed";
+		regulator-name = "vdds_1v8_main";
+		vin-supply = <&smps7_reg>;
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+	};
+
 	vmmcsd_fixed: fixedregulator-mmcsd {
 		compatible = "regulator-fixed";
 		regulator-name = "vmmcsd_fixed";
@@ -409,6 +432,26 @@
 
 			ti,ldo6-vibrator;
 
+			smps123-in-supply = <&vsys_cobra>;
+			smps45-in-supply = <&vsys_cobra>;
+			smps6-in-supply = <&vsys_cobra>;
+			smps7-in-supply = <&vsys_cobra>;
+			smps8-in-supply = <&vsys_cobra>;
+			smps9-in-supply = <&vsys_cobra>;
+			smps10_out2-in-supply = <&vsys_cobra>;
+			smps10_out1-in-supply = <&vsys_cobra>;
+			ldo1-in-supply = <&vsys_cobra>;
+			ldo2-in-supply = <&vsys_cobra>;
+			ldo3-in-supply = <&vdds_1v8_main>;
+			ldo4-in-supply = <&vdds_1v8_main>;
+			ldo5-in-supply = <&vsys_cobra>;
+			ldo6-in-supply = <&vdds_1v8_main>;
+			ldo7-in-supply = <&vsys_cobra>;
+			ldo8-in-supply = <&vsys_cobra>;
+			ldo9-in-supply = <&vmmcsd_fixed>;
+			ldoln-in-supply = <&vsys_cobra>;
+			ldousb-in-supply = <&vsys_cobra>;
+
 			regulators {
 				smps123_reg: smps123 {
 					/* VDD_OPP_MPU */
