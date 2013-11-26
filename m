From: Hong-Xing.Zhu@freescale.com (Richard Zhu)
Date: Tue, 26 Nov 2013 02:20:15 +0000
Subject: [PATCH v6 3/3] PCI: imx6: Add support for i.MX6 PCIe controller
In-Reply-To: <CAB5oZtAKmgeAYCgbVAUyjFF+=P4n728M3qD16-FG7mz_9WJooA@mail.gmail.com>
References: <1379319655-20210-1-git-send-email-xobs@kosagi.com>
 <1379319655-20210-4-git-send-email-xobs@kosagi.com>
 <CAJ+vNU36neHP77dVnqSP=+oMxaU=-6PxWQ8Afni-tTRjNTkM_A@mail.gmail.com>
 <0E83723C55F66F43A6041464FE31119D40FC99@039-SN2MPN1-011.039d.mgd.msft.net>
 <CAJ+vNU13FA5s7tt-yEnBYNSBV+FHmHqZNoykFq8aF=O=TvqTnA@mail.gmail.com>
 <0E83723C55F66F43A6041464FE31119D40FD55@039-SN2MPN1-011.039d.mgd.msft.net>
 <CAJ+vNU2ifxfprYsgcQs+Kkgu37+diXHJS6DEqs4d51+U3F4sLQ@mail.gmail.com>
 <52792C5E.6030008@writeme.com>
 <CAErSpo7c1KiOKqpM1+v6GM09Mspge=Yq9orwXVYjZZjsQssCHA@mail.gmail.com>
 <CAB5oZtAKmgeAYCgbVAUyjFF+=P4n728M3qD16-FG7mz_9WJooA@mail.gmail.com>
Message-ID: <0E83723C55F66F43A6041464FE31119D45B7C1@039-SN2MPN1-011.039d.mgd.msft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Harro:

> -----Original Message-----
> From: Harro Haan [mailto:hrhaan at gmail.com]
> Sent: Sunday, November 24, 2013 1:28 AM
> To: linux-arm-kernel at lists.infradead.org
> Cc: Sinan Akman; Zhu Richard-R65037; Marek Va?ut; Pratyush Anand; Tim Harvey;
> Jingoo Han; Troy Kisky; Sean Cross; Shawn Guo; Sascha Hauer; Bjorn Helgaas
> Subject: Re: [PATCH v6 3/3] PCI: imx6: Add support for i.MX6 PCIe controller
> 
> On 5 November 2013 21:28, Bjorn Helgaas <bhelgaas@google.com> wrote:
> > On Tue, Nov 5, 2013 at 10:35 AM, Sinan Akman <sinan@writeme.com> wrote:
> >>   Tim, Sean what is the status of this patch ? Is it part of any tree
> >> already ? I'd like to test few things.
> >
> > This patch is in my "next" branch and will be merged into Linus' tree
> > during the v3.13 merge window (probably next week).  It's also in the
> > linux-next tree.
> >
> > http://git.kernel.org/cgit/linux/kernel/git/helgaas/pci.git/commit/?h=
> > next&id=bb38919ec56e0758c3ae56dfc091dcde1391353e
> 
> Does anybody know how to test this on a SabreSD board?
> 
> I have added the following to imx6qdl-sabresd.dtsi:
> ---------------------
> @@ -166,10 +166,21 @@
> 
>  &iomuxc {
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&pinctrl_hog>;
> 
> +	pcie {
> +		pinctrl_pcie: pciegrp {
> +			fsl,pins = <
> +				MX6QDL_PAD_GPIO_17__GPIO7_IO12      0x80000000
> +				MX6QDL_PAD_EIM_D19__GPIO3_IO19      0x80000000
> +				MX6QDL_PAD_CSI0_DATA_EN__GPIO5_IO20 0x80000000
> +				MX6QDL_PAD_KEY_COL4__GPIO4_IO14     0x80000000
> +			>;
> +		};
> +	};
> +
>  	hog {
>  		pinctrl_hog: hoggrp {
>  			fsl,pins = <
>  				MX6QDL_PAD_GPIO_4__GPIO1_IO04   0x80000000
>  				MX6QDL_PAD_GPIO_5__GPIO1_IO05   0x80000000
> @@ -185,10 +196,20 @@
>  			>;
>  		};
>  	};
>  };
> 
> +&pcie {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_pcie>;
> +	reset-gpio = <&gpio7 12 0>;
> +	power-on-gpio = <&gpio3 19 0>;
> +	wake-up-gpio = <&gpio5 20 0>;
> +	disable-gpio = <&gpio4 14 0>;
> +	status = "okay";
> +};
> +
>  &ldb {
>  	status = "okay";
> 
>  	lvds-channel at 1 {
>  		fsl,data-mapping = "spwg";
> ---------------------
> 
> But during booting it says:
> imx6q-pcie 1ffc000.pcie: phy link never came up
> 
> Thanks in advance,
> 
> Harro

[Richard] Regarding to my experience, based on Shawn's(http://git.linaro.org/git-ro/people/shawnguo/linux-2.6.git)
 for-next branch, cherry-pick the imx6-pcie patch set merged on host-imx6 branch on PCIe git-repos.
Re-setup the clock configurations refer to your kernel baseline.
Here is one example at my local git-repos site, hope it is helpful.
-------------------------------------------------
pcie: switch to upstreamed pcie driver

Based on community patch-set, re-setup pcie driver on
imx6 platforms.
* re-fine the pcie clks.
* add the pcie support in dts files.

Signed-off-by: Richard Zhu <r65037@freescale.com>
---
 .../devicetree/bindings/clock/imx6q-clock.txt      |    6 +++---
 arch/arm/boot/dts/imx6qdl-sabreauto.dtsi           |    4 ++++
 arch/arm/boot/dts/imx6qdl-sabresd.dtsi             |    7 +++++++
 arch/arm/boot/dts/imx6qdl.dtsi                     |    4 ++--
 arch/arm/mach-imx/Kconfig                          |    2 ++
 arch/arm/mach-imx/clk-imx6q.c                      |   17 ++++++++++++++++-
 6 files changed, 34 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/clock/imx6q-clock.txt b/Documentation/devicetree/bindings/clock/imx6q-clock.txt
index 02ad157..b289100 100644
--- a/Documentation/devicetree/bindings/clock/imx6q-clock.txt
+++ b/Documentation/devicetree/bindings/clock/imx6q-clock.txt
@@ -220,9 +220,9 @@ clocks and IDs.
 	ldb_di0_div_sel		207
 	ldb_di1_div_sel		208
 	pll4_audio_div		209
-	pcie_dummy1   		210
-	pcie_dummy2   		211
-	pcie_dummy3   		212
+	lvds1_sel      		210
+	lvds1_in      		211
+	lvds1_out		212
 	caam_mem		213
 	caam_aclk		214
 	caam_ipg		215
diff --git a/arch/arm/boot/dts/imx6qdl-sabreauto.dtsi b/arch/arm/boot/dts/imx6qdl-sabreauto.dtsi
index bbd4bfb..e011ba7 100644
--- a/arch/arm/boot/dts/imx6qdl-sabreauto.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-sabreauto.dtsi
@@ -590,6 +590,10 @@
 	status = "okay";
 };
 
+&pcie {
+	status = "okay";
+};
+
 &pwm3 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_pwm3_1>;
diff --git a/arch/arm/boot/dts/imx6qdl-sabresd.dtsi b/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
index 4de08aa..5236ff6 100644
--- a/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
@@ -611,6 +611,13 @@
 	status = "okay";
 };
 
+&pcie {
+	power-on-gpio = <&gpio3 19 0>;
+	reset-gpio = <&gpio7 12 0>;
+	status = "okay";
+};
+
+
 &pwm1 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_pwm1_1>;
diff --git a/arch/arm/boot/dts/imx6qdl.dtsi b/arch/arm/boot/dts/imx6qdl.dtsi
index c2f7fd5..1e40164 100644
--- a/arch/arm/boot/dts/imx6qdl.dtsi
+++ b/arch/arm/boot/dts/imx6qdl.dtsi
@@ -128,8 +128,8 @@
 				  0x82000000 0 0x01000000 0x01000000 0 0x00f00000>; /* non-prefetchable memory */
 			num-lanes = <1>;
 			interrupts = <0 123 0x04>;
-			clocks = <&clks 189>, <&clks 187>, <&clks 206>, <&clks 144>;
-			clock-names = "pcie_ref_125m", "sata_ref_100m", "lvds_gate", "pcie_axi";
+			clocks = <&clks 189>, <&clks 187>, <&clks 144>, <&clks 212>;
+			clock-names = "pcie_ref_125m", "sata_ref_100m", "pcie_axi", "lvds_gate";
 			status = "disabled";
 		};
 
diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
index 0633cf9..c26aac0 100644
--- a/arch/arm/mach-imx/Kconfig
+++ b/arch/arm/mach-imx/Kconfig
@@ -809,6 +809,8 @@ config SOC_IMX6Q
 	select HAVE_IMX_SRC
 	select HAVE_SMP
 	select MFD_SYSCON
+	select MIGHT_HAVE_PCI
+	select PCI_DOMAINS if PCI
 	select PINCTRL
 	select PINCTRL_IMX6Q
 	select PL310_ERRATA_588369 if CACHE_PL310
diff --git a/arch/arm/mach-imx/clk-imx6q.c b/arch/arm/mach-imx/clk-imx6q.c
index 0923ff8..96e3198 100644
--- a/arch/arm/mach-imx/clk-imx6q.c
+++ b/arch/arm/mach-imx/clk-imx6q.c
@@ -71,6 +71,8 @@ static const char *cko2_sels[] = {
 	"uart_serial", "spdif", "asrc", "hsi_tx",
 };
 static const char *cko_sels[] = { "cko1", "cko2", };
+static const char *lvds_sels[]	= { "arm", "pll1_sys", "dummy", "dummy", "dummy", "dummy", "dummy", "pll5_video_div",
+				    "dummy", "dummy", "pcie_ref", "sata_ref", "usbphy1", "usbphy2", };
 
 enum mx6q_clks {
 	dummy, ckil, ckih, osc, pll2_pfd0_352m, pll2_pfd1_594m, pll2_pfd2_396m,
@@ -107,7 +109,7 @@ enum mx6q_clks {
 	usbphy2_gate, pll4_post_div, pll5_post_div, pll5_video_div, eim_slow,
 	spdif, cko2_sel, cko2_podf, cko2, cko, vdoa, gpt_3m, video_27m,
 	ldb_di0_div_7, ldb_di1_div_7, ldb_di0_div_sel, ldb_di1_div_sel,
-	pll4_audio_div, pcie_dummy1, pcie_dummy2, pcie_dummy3, caam_mem, caam_aclk,
+	pll4_audio_div, lvds1_sel, lvds1_in, lvds1_out, caam_mem, caam_aclk,
 	caam_ipg, epit1, epit2, tzasc2, clk_max
 };
 
@@ -173,6 +175,9 @@ static void __init imx6q_clocks_init(struct device_node *ccm_node)
 	clk[pll6_enet]     = imx_clk_pllv3(IMX_PLLV3_ENET,	"pll6_enet",	"osc", base + 0xe0, 0x3, false);
 	clk[pll7_usb_host] = imx_clk_pllv3(IMX_PLLV3_USB,	"pll7_usb_host",	"osc", base + 0x20, 0x3, false);
 
+	/*                              name            reg       shift width parent_names     num_parents */
+	clk[lvds1_sel]    = imx_clk_mux("lvds1_sel",    base + 0x160, 0,  5,  lvds_sels,       ARRAY_SIZE(lvds_sels));
+
 	/*
 	 * Bit 20 is the reserved and read-only bit, we do this only for:
 	 * - Do nothing for usbphy clk_enable/disable
@@ -191,6 +196,9 @@ static void __init imx6q_clocks_init(struct device_node *ccm_node)
 
 	clk[sata_ref] = imx_clk_fixed_factor("sata_ref", "pll6_enet", 1, 5);
 	clk[pcie_ref] = imx_clk_fixed_factor("pcie_ref", "pll6_enet", 1, 4);
+	/* NOTICE: The gate of the lvds1 in/out is used to select the clk direction */
+	clk[lvds1_in] = imx_clk_gate("lvds1_in", NULL, base + 0x160, 12);
+	clk[lvds1_out] = imx_clk_gate("lvds1_out", "lvds1_sel", base + 0x160, 10);
 
 	clk[sata_ref_100m] = imx_clk_gate("sata_ref_100m", "sata_ref", base + 0xe0, 20);
 	clk[pcie_ref_125m] = imx_clk_gate("pcie_ref_125m", "pcie_ref", base + 0xe0, 19);
@@ -482,6 +490,13 @@ static void __init imx6q_clocks_init(struct device_node *ccm_node)
 	 */
 	clk_set_parent(clk[enfc_sel], clk[pll2_pfd2_396m]);
 
+	/* Set the parent clks of PCIe lvds1 and pcie_axi to be sata ref, axi */
+	if (clk_set_parent(clk[lvds1_sel], clk[sata_ref]))
+		pr_err("Failed to set PCIe bus parent clk.\n");
+	if (clk_set_parent(clk[pcie_axi_sel], clk[axi]))
+		pr_err("Failed to set PCIe parent clk.\n");
+
+
 	/* gpu clock initilazation */
 	clk_set_parent(clk[gpu3d_shader_sel], clk[pll2_pfd1_594m]);
 	clk_set_rate(clk[gpu3d_shader], 594000000);


> 
> Note: the e1000e network card does work with the FSL imx_3.0.35 kernel

Best Regards
Richard Zhu
