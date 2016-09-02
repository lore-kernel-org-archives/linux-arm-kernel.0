From: nsekhar@ti.com (Sekhar Nori)
Date: Fri, 2 Sep 2016 16:11:59 +0530
Subject: [PATCH 2/2] ARM: dts: am57xx-beagle-x15: Add support for rev B1
In-Reply-To: <20160902090600.27262-3-nm@ti.com>
References: <20160902090600.27262-1-nm@ti.com>
 <20160902090600.27262-3-nm@ti.com>
Message-ID: <dd74f5e1-304f-661e-7fd9-f5f81bcfc55e@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

+ Robert Nelson

On Friday 02 September 2016 02:36 PM, Nishanth Menon wrote:
> Latest update to the BeagleBoard-X15 platform (revision B1)[1] updates
> for allowing UHS SD cards to function with the split of supply to SD
> card from a dedicated LDO.
> 
> As a result of this, AM57xx BeagleBoard-X15 now uses gpio2_30 instead
> of gpio6_28 for HDMI because HDMI_LS_OE should now be switched from
> GPIO6_28(Y9) to GPIO2_30 (AG8) to avoid a 1.8V GPIO toggling a 3.3V
> SoC input when the SD card is in UHS 1.8V mode.
> 
> NOTE: For UHS mode to function, we need full fledged IODelay support
> in kernel to be functional. IODelay support is yet to be added.
> 
> Further, It does not make much sense to spin off a new board
> compatible flag since there is no real functional benefit for the
> same.
> 
> Note: Even though production version is supposed to be B1, there is
> over ~200 boards of previous version (A2)[2] out there which continue
> to get supported with the existing dts file and the production board
> is now supported as revb1
> 
> [1] https://github.com/beagleboard/beagleboard-x15/blob/master/BEAGLEBOARD_X15_REV_B1.pdf
> [2] http://marc.info/?l=linux-arm-kernel&m=147273929820708&w=2
> 
> Signed-off-by: Nishanth Menon <nm@ti.com>
> ---
> 
> NOTE: even though I have used -C -M option with git-format-patch, the
> diff for x15.dts might look a little weird. we could alternatively
> split the patch into two by creating a common dtsi and then
> introducing revb1 -> but, at least for the moment, I felt it to be an
> overkill.
> 
> Also, please note that even though revb1 is the production platform,
> there are sufficient quantities of x15 A2s (pre-prod) in the wild
> currently to leave existing dts in sync with A2 and introduce b1 as a
> seperate dts (instead of the other way around).
> 
>  arch/arm/boot/dts/Makefile                         |   1 +
>  ...eagle-x15.dts => am57xx-beagle-x15-common.dtsi} |   8 +-
>  arch/arm/boot/dts/am57xx-beagle-x15-revb1.dts      |  24 +
>  arch/arm/boot/dts/am57xx-beagle-x15.dts            | 592 +--------------------

I understand that there are existing users of A2 boards and so we simply
cannot remove support for those boards (at least yet).

But given the small numbers of A2 boards, its also quite likely that we
will not have enough test coverage for those boards. Especially as years
pass and there are fewer and fewer people with access to working A2 boards.

Given that, aren't we increasing the chance of A2 breakage by creating a
common file - this essentially necessitates that any change to
am57xx-beagle-x15-common.dtsi is also tested on A2.

Instead, it seems to be easier for maintenance and safer overall if the
older version has a file of its own which can be kept alone.

Also, how about renaming the existing dts to am57xx-beagle-x15-reva2.dts
and let the production version be called am57xx-beagle-x15.dts? Surely
this will cause some inconvenience to A2 users. But there are few users
of those and it might be more intuitive for the majority users if the
file for production version is without a specific version string
attached. Just a thought though, not sure about it myself either.

Regards,
Sekhar
