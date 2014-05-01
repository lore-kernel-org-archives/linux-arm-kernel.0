From: max.schwarz@online.de (Max Schwarz)
Date: Thu, 01 May 2014 12:43:13 +0200
Subject: [RFC/PATCH 0/8] pinctrl-rockchip: Change wrong initial assumptions
In-Reply-To: <1414506.B4e2jZujVm@diego>
References: <1414506.B4e2jZujVm@diego>
Message-ID: <699502106.fEF2JGVO0i@typ>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 30 April 2014 at 00:07:12, Heiko St?bner wrote:
> While this wasn't a problem until now, the upcoming rk3288 introduces
> additional changes to both the grf and pmu areas. On it even part of
> the pinmux registers move into the pmu space.

Could you give us more information on that? I tried to find details on the 
RK3288 but came up with nothing. How are the pinmux registers divided?

Would adding a third reg element for the pinmux register to the gpio subnodes 
suffice to fix your problem?

> For this my current gut-feeling is, that providing both the grf and pmu
> as syscons to the pinctrl driver might be more future proof for the next
> socs. But as I'm not sure on this, I'd like of course comments :-)

I don't see the problem with the current solution. In my mind it's cleaner to 
specify register mappings explicitly in the dt rather than map one large block 
and let the drivers figure out themselves where their registers are.

There are some question marks for me on the syscon solution. Regmap uses 
locking internally, which means separate drivers can't access separate 
registers simultaneously. We have an SMP machine here, so that's not far-
fetched. And that locking is completely unnecessary, as we *know* in most 
cases that the accessed areas do not overlap.

> The other option would be to leave the grf as it is and create separate
> syscons for real small individual parts like the soc-conf and usb-phys.
> But apart from creating these real small syscons that would
> also make it necessary to introduce another register map for the
> drive-strength settings of the pin-controller, which are sitting in the
> middle of everything at least on rk3066 and rk3188.

Wy do we need a syscon for usb-phys? Is it shared by multiple drivers?
My instinctive approach would be two usb-phys devices mapping the GRF_UOC0/1 
spaces directly via reg properties. Or did I miss something?

The only register space I see that is used from many drivers is the GRF_SOC_* 
space. So in my mind that should be the only syscon device.

> @Max: sorry to come up with this now, but I feel this should be resolved
> (in whatever direction) before we introduce any grf syscon. Because due
> to dt being an API we will be tied for a long time to it.

Yes, I agree. If we want to change something, we should change it now. All in 
all I would vote for the current solution. But it seems you have more 
information than me, so my vote is somewhat uneducated ;-)

Cheers,
  Max
