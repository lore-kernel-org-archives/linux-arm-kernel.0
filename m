From: heiko@sntech.de (Heiko Stuebner)
Date: Thu, 17 Nov 2016 10:12:01 +0100
Subject: [PATCH v2 2/3] soc: rockchip: add driver handling grf setup
In-Reply-To: <a01a1a8c-b01b-4335-b69c-bb99dec9d6d6@rock-chips.com>
References: <20161115223900.30728-1-heiko@sntech.de> <5037506.GEHFh4fruS@phil>
 <a01a1a8c-b01b-4335-b69c-bb99dec9d6d6@rock-chips.com>
Message-ID: <3512052.5NJHIQHqMY@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Donnerstag, 17. November 2016, 09:38:11 CET schrieb Shawn Lin:
> Hi Heiko,
> 
> ? 2016/11/16 17:58, Heiko Stuebner ??:
> > Hi Shawn,
> > 
> > Am Mittwoch, 16. November 2016, 17:33:21 CET schrieb Shawn Lin:
> >> ? 2016/11/16 6:38, Heiko Stuebner ??:
> >>> The General Register Files are an area of registers containing a lot
> >>> of single-bit settings for numerous components as well full components
> >>> like usbphy control. Therefore all used components are accessed
> >>> via the syscon provided by the grf nodes or from the sub-devices
> >>> created through the simple-mfd created from the grf node.
> 
> ----8<----------------
> [...]
> 
> >>> +	for (i = 0; i < grf_info->num_values; i++) {
> >>> +		const struct rockchip_grf_value *val = &grf_info->values[i];
> >>> +
> >>> +		pr_debug("%s: adjusting %s in %#6x to %#10x\n", __func__,
> >>> +			val->desc, val->reg, val->val);
> >>> +		ret = regmap_write(grf, val->reg, val->val);
> >>> +		if (ret < 0)
> >>> +			pr_err("%s: write to %#6x failed with %d\n",
> >>> +			       __func__, val->reg, ret);
> >> 
> >> So, when failing to do one of the settings, should we still let it goes?
> >> Sometimes the log of postcore_initcall is easy to be neglected when
> >> people finally find problems later but the very earlier log was missing
> >> due to whatever reason like buffer limitation, etc.
> > 
> > I expect errors here to be very rare. I.e. Doug thought that regmap might
> > return errors if we write outside the mapped region, which would mean
> > someone really messed up in this core component or a core-element of the
> > dts. But in general the GRF is always a mmio-regmap, so there won't be
> > any i2c/spi/ whatever errors possible.
> 
> I was just thinking about the scalability that in the future some of the
> GRF settings may depend on genpd or clock even if they are only a
> mmio-regmap but they don't belong to the general pd/clock for GRF, for
> instance, some of the PHYs' or controller's cap(like emmc) settings.
> 
> But, IIRC, you suggested this driver shouldn't be a catchall, and we
> now ask the drivers of controllers and phys to take over this, so I
> guess we won't put those settings here ever. :)
> 
> Thanks for explaining this.

correct, it should never become a catchall as things like those phy-subdevices 
that need runtime handling should definitly be handled in their respective 
drivers.

So far we're also always starting with all clocks and power-domains being on, 
so settings should always succeed as we're only active during early boot here.
We'll simply have to reevaluate if some new soc begins to boot with some 
needed clocks/power-domains being off.


Heiko
