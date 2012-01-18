From: B29396@freescale.com (Dong Aisheng-B29396)
Date: Wed, 18 Jan 2012 09:32:40 +0000
Subject: Pinmux bindings proposal
In-Reply-To: <74CDBE0F657A3D45AFBB94109FB122FF17801D22EB@HQMAIL01.nvidia.com>
References: <74CDBE0F657A3D45AFBB94109FB122FF17801D202F@HQMAIL01.nvidia.com>
 <7FE21149F4667147B645348EC6057885091DEA@039-SN2MPN1-013.039d.mgd.msft.net>
 <20120117082334.GA31295@S2101-09.ap.freescale.net>
 <74CDBE0F657A3D45AFBB94109FB122FF17801D22EB@HQMAIL01.nvidia.com>
Message-ID: <7FE21149F4667147B645348EC6057885094F47@039-SN2MPN1-013.039d.mgd.msft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: Stephen Warren [mailto:swarren at nvidia.com]
....

> > Considering the different pinctrl configurations for the same client
> > device usually share the same pinmux and only pinconf varies.  It may
> > worth introducing another level phandle reference.  Something like the
> > following:
> 
> I don't think there's a need for another level of indirection. The 1:n model I
> was talking about already handles this, I believe. See below.
> 
> > 	pinmux_sdhci: pinmux-sdhci {
> > 		mux =
> > 			<&tegra_pmx TEGRA_PMX_PG_DTA TEGRA_PMX_MUX_1>
> > 			<&tegra_pmx TEGRA_PMX_PG_DTD TEGRA_PMX_MUX_1>;
> > 	};
> >
> > 	pinconf_sdhci_active: pinconf-sdhci-active {
> > 		config =
> > 			<&tegra_pmx TEGRA_PMX_PG_DTA TEGRA_PMX_CONF_DRIVE_STRENGTH 5>
> > 			<&tegra_pmx TEGRA_PMX_PG_DTD TEGRA_PMX_CONF_DRIVE_STRENGTH 5>
> > 			<&tegra_pmx TEGRA_PMX_PG_DTA TEGRA_PMX_CONF_SLEW_RATE 4>
> > 			<&tegra_pmx TEGRA_PMX_PG_DTD TEGRA_PMX_CONF_SLEW_RATE 8>;
> > 	};
> >
> > 	pinconf_sdhci_suspend: pinconf-sdhci-suspend {
> > 		config =
> > 			<&tegra_pmx TEGRA_PMX_PG_DTA TEGRA_PMX_CONF_TRISTATE 1>
> > 			<&tegra_pmx TEGRA_PMX_PG_DTD TEGRA_PMX_CONF_TRISTATE 1>
> > 			<&tegra_pmx TEGRA_PMX_PG_DTA TEGRA_PMX_CONF_DRIVE_STRENGTH 5>
> > 			<&tegra_pmx TEGRA_PMX_PG_DTD TEGRA_PMX_CONF_DRIVE_STRENGTH 5>
> > 			<&tegra_pmx TEGRA_PMX_PG_DTA TEGRA_PMX_CONF_SLEW_RATE 4>
> > 			<&tegra_pmx TEGRA_PMX_PG_DTD TEGRA_PMX_CONF_SLEW_RATE 8>;
> > 	};
> 
> Those 3 nodes make sense to me.
> 
> > 	pinctrl_sdhci_active: pinctrl-sdhci-active {
> > 		pinmux = <&pinmux_sdhci>;
> > 		pinconf = <&pinconf_sdhci_active>;
> > 	};
> >
> > 	pinctrl_sdhci_suspend: pinctrl-sdhci-suspend {
> > 		pinmux = <&pinmux_sdhci>;
> > 		pinconf = <&pinconf_sdhci_suspend>;
> > 	};
> 
> I think we can avoid those 2 nodes.
> 
> > 	sdhci at c8000200 {
> > 		...
> > 		pinctrl = <&pinctrl_sdhci_active> <&pinctrl_sdhci_suspend>;
> > 		pinctrl-names = "active", "suspend";
> > 	};
> 
> And rewrite that node as:
> 
> sdhci at c8000200 {
>     ...
>     pinctrl = <&pinmux_sdhci> <&pinconf_sdhci_active>
>               <&pinmux_sdhci> <&pinconf_sdhci_suspend>;
>     pinctrl-names = "active", "active", "suspend", "suspend"; };
> 
> The only slight disadvantage here is that the person constructing the
> pinctrl/pinctrl-names properties needs to know to explicitly list both the
> separate mux/config phandles for each value in pinctrl-names. Still, this seems
> a reasonable compromise; the user is still picking from a bunch of pre-
> defined/canned nodes, they simply need to list 2 (or n in
> general) of them for each state.
> 
> > This will be pretty useful for imx6 usdhc case, which will have 3
> > pinctrl configuration for each usdhc device (imx6 has 4 usdhc
> > devices), pinctrl-50mhz, pinctrl-100mhz and pinctrl-200mhz.  All these
> > 3 states have the exactly same pinmux settings, and only varies on pinconf.
> 
> Yes, I definitely agree there's a need for this.
> 
> As an aside, I wonder if the following would be any better:
> 
> sdhci at c8000200 {
>     ...
>     pinctrl = <&pinmux_sdhci> <&pinconf_sdhci_active>
>               <&pinmux_sdhci> <&pinconf_sdhci_suspend>;
>     /* Number of entries in pinctrl for each in pinctrl-names */
>     pinctrl-entries = <2 2>;
>     pinctrl-names = "active", "suspend"; };
> 
> That seems more complex though.
> 
This makes sense to me.

Regards
Dong Aisheng
