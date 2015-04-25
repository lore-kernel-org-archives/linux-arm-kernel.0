From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Sat, 25 Apr 2015 20:47:49 +0200
Subject: [PATCH v14 0/3] ARM: rk3288: Add PM Domain support
In-Reply-To: <1429862868-14218-1-git-send-email-wxt@rock-chips.com>
References: <1429862868-14218-1-git-send-email-wxt@rock-chips.com>
Message-ID: <3550912.kR0pejLP0h@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Caesar,


thanks for keeping this alive :-)

Am Freitag, 24. April 2015, 16:07:45 schrieb Caesar Wang:
>     Add power domain drivers based on generic power domain for
> Rockchip platform, and support RK3288.
> 
>     Verified on url =
>     https://chromium.googlesource.com/chromiumos/third_party/kernel.
> 
>     At the moment,there are mass of products are using the driver.
> I believe the driver can happy work for next kernel.

I've taken a look at the driver and here are some global remarks:

(1) You provide dt-bindings/power-domain/rk3288.h in patch 3. This breaks
bisectability, as the driver itself in patch 2 also includes the header and
would thus fail to compile if the later patch 3 is missing.
Ideally I think the header addition should be a separate patch itself, so that
we can possibly share it between driver and dts branches.
So 1: binding doc, 2: binding-header, 3: driver, 4: dts-changes.


(2) The dts-changes in patch 3 should also add any necessary power-domain
assignment on devices if they're still missing, so that we don't introduce
regressions. In my case my work-in-progress edp died because the powerdomain
was turned off automatically it seems.


(3) more like wondering @Kevin or so, is there some more generic place for a
power-domain driver nowadays?


(4) As Tomasz remarked previously the dts should represent the hardware and
the power-domains are part of the pmu. There is a recent addition from Linus
Walleij, called simple-mfd [a] that is supposed to get added real early for
kernel 4.2. So I'd think the power-domains should use that and the patchset
modified to include the changes shown below [b]?


(5) Keven Hilman and Tomasz had reservations about all the device clocks
being listed in the power-domains itself in the previous versions. I don't see
a comment from them yet changing that view.

Their wish was to get the clocks by reading the clocks from the device nodes,
though I see a problem on how to handle devices that do not have any bindings
at all yet.

Kevin, Tomasz any new thoughts?


Heiko


[a] https://git.kernel.org/cgit/linux/kernel/git/linusw/linux-integrator.git/commit/?h=simple-mfd&id=fcf294c020ff7ee4e3b1e96159e4dc7a17ad59d1

[b]
Subject: [PATCH] make power-domains a child of the pmu

This should of course be distributed across the original patches and not
be a separate patch.
---
 arch/arm/boot/dts/rk3288.dtsi       | 118 ++++++++++++++++++------------------
 arch/arm/mach-rockchip/pm_domains.c |  11 +++-
 2 files changed, 67 insertions(+), 62 deletions(-)

diff --git a/arch/arm/boot/dts/rk3288.dtsi b/arch/arm/boot/dts/rk3288.dtsi
index 9696f51..b9ba79013 100644
--- a/arch/arm/boot/dts/rk3288.dtsi
+++ b/arch/arm/boot/dts/rk3288.dtsi
@@ -549,8 +549,66 @@
 	};
 
 	pmu: power-management at ff730000 {
-		compatible = "rockchip,rk3288-pmu", "syscon";
+		compatible = "rockchip,rk3288-pmu", "syscon", "simple-mfd";
 		reg = <0xff730000 0x100>;
+
+		power: power-controller {
+			compatible = "rockchip,rk3288-power-controller";
+			#power-domain-cells = <1>;
+			rockchip,pmu = <&pmu>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			pd_gpu {
+				reg = <RK3288_PD_GPU>;
+				clocks = <&cru ACLK_GPU>;
+			};
+
+			pd_hevc {
+				reg = <RK3288_PD_HEVC>;
+				clocks = <&cru ACLK_HEVC>,
+					<&cru SCLK_HEVC_CABAC>,
+					<&cru SCLK_HEVC_CORE>,
+					<&cru HCLK_HEVC>;
+			};
+
+			pd_vio {
+				reg = <RK3288_PD_VIO>;
+				clocks = <&cru ACLK_IEP>,
+					<&cru ACLK_ISP>,
+					<&cru ACLK_RGA>,
+					<&cru ACLK_VIP>,
+					<&cru ACLK_VOP0>,
+					<&cru ACLK_VOP1>,
+					<&cru DCLK_VOP0>,
+					<&cru DCLK_VOP1>,
+					<&cru HCLK_IEP>,
+					<&cru HCLK_ISP>,
+					<&cru HCLK_RGA>,
+					<&cru HCLK_VIP>,
+					<&cru HCLK_VOP0>,
+					<&cru HCLK_VOP1>,
+					<&cru PCLK_EDP_CTRL>,
+					<&cru PCLK_HDMI_CTRL>,
+					<&cru PCLK_LVDS_PHY>,
+					<&cru PCLK_MIPI_CSI>,
+					<&cru PCLK_MIPI_DSI0>,
+					<&cru PCLK_MIPI_DSI1>,
+					<&cru SCLK_EDP_24M>,
+					<&cru SCLK_EDP>,
+					<&cru SCLK_HDMI_CEC>,
+					<&cru SCLK_HDMI_HDCP>,
+					<&cru SCLK_ISP_JPE>,
+					<&cru SCLK_ISP>,
+					<&cru SCLK_RGA>;
+			};
+
+			pd_video {
+				reg = <RK3288_PD_VIDEO>;
+				clocks = <&cru ACLK_VCODEC>,
+					<&cru HCLK_VCODEC>;
+			};
+		};
 	};
 
 	sgrf: syscon at ff740000 {
@@ -1316,62 +1374,4 @@
 			};
 		};
 	};
-
-	power: power-controller {
-		compatible = "rockchip,rk3288-power-controller";
-		#power-domain-cells = <1>;
-		rockchip,pmu = <&pmu>;
-		#address-cells = <1>;
-		#size-cells = <0>;
-
-		pd_gpu {
-			reg = <RK3288_PD_GPU>;
-			clocks = <&cru ACLK_GPU>;
-		};
-
-		pd_hevc {
-			reg = <RK3288_PD_HEVC>;
-			clocks = <&cru ACLK_HEVC>,
-				 <&cru SCLK_HEVC_CABAC>,
-				 <&cru SCLK_HEVC_CORE>,
-				 <&cru HCLK_HEVC>;
-		};
-
-		pd_vio {
-			reg = <RK3288_PD_VIO>;
-			clocks = <&cru ACLK_IEP>,
-				 <&cru ACLK_ISP>,
-				 <&cru ACLK_RGA>,
-				 <&cru ACLK_VIP>,
-				 <&cru ACLK_VOP0>,
-				 <&cru ACLK_VOP1>,
-				 <&cru DCLK_VOP0>,
-				 <&cru DCLK_VOP1>,
-				 <&cru HCLK_IEP>,
-				 <&cru HCLK_ISP>,
-				 <&cru HCLK_RGA>,
-				 <&cru HCLK_VIP>,
-				 <&cru HCLK_VOP0>,
-				 <&cru HCLK_VOP1>,
-				 <&cru PCLK_EDP_CTRL>,
-				 <&cru PCLK_HDMI_CTRL>,
-				 <&cru PCLK_LVDS_PHY>,
-				 <&cru PCLK_MIPI_CSI>,
-				 <&cru PCLK_MIPI_DSI0>,
-				 <&cru PCLK_MIPI_DSI1>,
-				 <&cru SCLK_EDP_24M>,
-				 <&cru SCLK_EDP>,
-				 <&cru SCLK_HDMI_CEC>,
-				 <&cru SCLK_HDMI_HDCP>,
-				 <&cru SCLK_ISP_JPE>,
-				 <&cru SCLK_ISP>,
-				 <&cru SCLK_RGA>;
-		};
-
-		pd_video {
-			reg = <RK3288_PD_VIDEO>;
-			clocks = <&cru ACLK_VCODEC>,
-				 <&cru HCLK_VCODEC>;
-		};
-	};
 };
diff --git a/arch/arm/mach-rockchip/pm_domains.c b/arch/arm/mach-rockchip/pm_domains.c
index 92d2569..f3d87c21 100644
--- a/arch/arm/mach-rockchip/pm_domains.c
+++ b/arch/arm/mach-rockchip/pm_domains.c
@@ -377,6 +377,7 @@ static int rockchip_pm_domain_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct device_node *np = dev->of_node;
 	struct device_node *node;
+	struct device *parent;
 	struct rockchip_pmu *pmu;
 	const struct of_device_id *match;
 	const struct rockchip_pmu_info *pmu_info;
@@ -410,9 +411,13 @@ static int rockchip_pm_domain_probe(struct platform_device *pdev)
 	pmu->genpd_data.domains = pmu->domains;
 	pmu->genpd_data.num_domains = pmu_info->num_domains;
 
-	node = of_parse_phandle(np, "rockchip,pmu", 0);
-	pmu->regmap = syscon_node_to_regmap(node);
-	of_node_put(node);
+	parent = dev->parent;
+	if (!parent) {
+		dev_err(dev, "no parent for syscon LED\n");
+		return -ENODEV;
+	}
+
+	pmu->regmap = syscon_node_to_regmap(parent->of_node);
 	if (IS_ERR(pmu->regmap)) {
 		error = PTR_ERR(pmu->regmap);
 		dev_err(dev, "failed to get PMU regmap: %d\n", error);
-- 
2.1.4
