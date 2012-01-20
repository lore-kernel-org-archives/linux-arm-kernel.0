From: swarren@nvidia.com (Stephen Warren)
Date: Fri, 20 Jan 2012 12:28:55 -0800
Subject: Pinmux bindings proposal
In-Reply-To: <7FE21149F4667147B645348EC6057885095125@039-SN2MPN1-013.039d.mgd.msft.net>
References: <74CDBE0F657A3D45AFBB94109FB122FF17801D202F@HQMAIL01.nvidia.com>
 <7FE21149F4667147B645348EC6057885091DEA@039-SN2MPN1-013.039d.mgd.msft.net>
 <20120117082334.GA31295@S2101-09.ap.freescale.net>
 <7FE21149F4667147B645348EC6057885092D56@039-SN2MPN1-013.039d.mgd.msft.net>
 <74CDBE0F657A3D45AFBB94109FB122FF17801D22F5@HQMAIL01.nvidia.com>
 <7FE21149F4667147B645348EC6057885095125@039-SN2MPN1-013.039d.mgd.msft.net>
Message-ID: <74CDBE0F657A3D45AFBB94109FB122FF1780DAB445@HQMAIL01.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dong Aisheng wrote at Wednesday, January 18, 2012 4:06 AM:
> Stephen Warren wrote at Wednesday, January 18, 2012 3:29 AM:
> > Dong Aisheng wrote at Tuesday, January 17, 2012 2:47 AM:
> > > Shawn Guo wrote at Tuesday, January 17, 2012 4:24 PM:
> > > > On Mon, Jan 16, 2012 at 12:50:02PM +0000, Dong Aisheng-B29396 wrote:
> > > > > Stephen Warren wrote:
...
> Now i'm still thinking if the mux way we discussed here fits IMX.
> For example:
>
> > 	pinmux_sdhci: pinmux-sdhci {
> > 		mux =
> > 			<&tegra_pmx TEGRA_PMX_PG_DTA TEGRA_PMX_MUX_1>
> > 			<&tegra_pmx TEGRA_PMX_PG_DTD TEGRA_PMX_MUX_1>;
> > 	};
>
> It may work well for Tegra.
> When pinctrl core parsing the mux proterty, it will creat each maps
> For each entry in the list.
> But for IMX like:
>
> > > 	pinmux_usdhc1: pinmux-usdhc1 {
> > > 		mux = <IMX6Q_PAD_SD1_DAT1 0>
> > > 		      <IMX6Q_PAD_SD1_DAT2 0>
> > > 		      ...
> > > 	};
>
> Each entry in the list is PIN rather than group.
> So we cannot create each map for each entry in the list except we treat the PIN as
> A group(this will cause a huge maps and predefined groups and functions).

Linusw has NAKd the idea that we should not use these "virtual groups",
i.e. he believes they're fine to use if you wish.

Given that, I think what you should do is:

* Your pinctrl driver should enumerate whatever kind of groups it wishes.

* Use the same sets of groups for both board-based and DT-based systems
  (well, that's true irrespective of anything else)

* The mux properties above would not refer to pins, but whatever muxable
  entities your pinctrl driver exposes.

  For Tegra20, I'll use the raw HW pin groups.

  For Tegra30, I'll use raw HW pins here, since each pin is individually
  muxable. In the pinctrl driver, pin IDs and these mux group IDs will
  be equivalent, since there will be 1 group per pin.

  For IMX, you can use "virtual group" IDs in the DT properties.

> A little different way I'm thinking now is cover the mux difference(pin or group)
> between Tegra and IMX in Pinctrl driver, then we may not need the second mux value
> (e.g: TEGRA_PMX_MUX_1)in the standard mux property:
> The mux property can become:
>
> pinmux_sdhci: pinmux-sdhci {
> 	mux =
> 		<&tegra_pmx TEGRA_PMX_PG_DTA_X>
> 		<&tegra_pmx TEGRA_PMX_PG_DTD_Y>;
> };

I definitely don't like putting the group ID and mux function into a
single value; this seems redundant.

However, since I'm leaning towards it being up to the individual pinctrl
driver to convert the DT property values into the group/function values
that the pinctrl core uses, you are free to define your binding however
you wish.

-- 
nvpublic
