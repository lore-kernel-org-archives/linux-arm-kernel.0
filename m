From: tony@atomide.com (Tony Lindgren)
Date: Fri, 9 Dec 2011 10:00:40 -0800
Subject: [RFC 1/3] pinctrl: add a driver for NVIDIA Tegra
In-Reply-To: <74CDBE0F657A3D45AFBB94109FB122FF17518604D7@HQMAIL01.nvidia.com>
References: <1323382390-14892-1-git-send-email-swarren@nvidia.com>
 <1323382390-14892-2-git-send-email-swarren@nvidia.com>
 <CACRpkdYDn0V7SeQuFiFDMxGkybvg6PGf7jxid8ECGB7Azkj3zw@mail.gmail.com>
 <74CDBE0F657A3D45AFBB94109FB122FF17518604D7@HQMAIL01.nvidia.com>
Message-ID: <20111209180039.GR31337@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Stephen Warren <swarren@nvidia.com> [111209 08:56]:
> Linus Walleij wrote at Friday, December 09, 2011 7:01 AM:
> > 
> > What we could worry about is the amount of hard-coded chip data
> > which sort of correlates with the discussion with Tony on how to
> > provide DT info for pin control drivers.
> 
> My thinking here is that irrespective of whether the data in future chips
> is the same or different to the current chips, it's better in the driver.
> 
> For a given SoC, the data is static; it can never ever change.
> 
> Hence, there's no point parsing it from device tree; we end up with exactly
> the same data in the driver, yet have spent a bunch of time parsing it out
> from device tree instead of just embedding it into the kernel binary.
> 
> If parts of Tegra X and Tegra Y are similar, it should be possible to have
> them co-ordinate together and share the common data, and do whatever it
> takes to create the appropriate completed view before passing it back from
> tegraX_pinctrl_init() to the core. You could perhaps do it using /include/
> in the .dtsi file too, but I think allowing the SoC init code to unify the
> tables gives more flexibility; in your example below of the same data with
> different pin names, that'd be implementable with code without too much
> difficulty, but probably impossible with dtc since it has no macro/define
> support at present.
> 
> Also, the representation of the data in a .c file will likely be far
> smaller than in the .dtsi file, so this way saves space. Admittedly with
> a multi-SoC binary, you end up with all the large per-SoC data in the
> binary initially, so the space-savings aren't exactly seen, but it's
> all init data, so does get dumped soon after boot.
> 
> Another point here: I don't have to maintain a DT binding for the Tegra
> pinctrl driver this way, so if the next Tegra's pinmux HW is different,
> all I need to do is edit the driver, not be shackled by a need to keep
> the DT binding for it backwards-compatible. Although that said, I
> /think/ even an obvious DT binding derived from struct
> tegra_pinctrl_soc_data would be flexible enough for most things, perhaps
> with the addition of allowing config param field definitions for pins
> as well as groups.

What you're describing should be supported for sure.

IMHO the key issue here from pinctrl fwk point of view is: We want to
allow multiple data sources for describing the pinmux functions.

The data sources supported should be any combination of static platform_data,
DT data, loadable modules, and /lib/firmware. Then it's just a question of
using the most suitable method for each SoC.

Regards,

Tony
