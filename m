From: max.schwarz@online.de (Max Schwarz)
Date: Fri, 02 May 2014 15:59:05 +0200
Subject: syscon or memory mappings (was: Re: [RFC/PATCH 0/8]
 pinctrl-rockchip: Change wrong initial assumptions)
In-Reply-To: <5737609.o5tyv6lkQG@diego>
References: <1414506.B4e2jZujVm@diego> <699502106.fEF2JGVO0i@typ>
 <5737609.o5tyv6lkQG@diego>
Message-ID: <1721270.d6hHid1rhj@typ>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Heiko,

On Thursday 01 May 2014 at 15:21:34, Heiko St?bner wrote:
> Hi Max,
> 
> Am Donnerstag, 1. Mai 2014, 12:43:13 schrieb Max Schwarz:
> > On Wednesday 30 April 2014 at 00:07:12, Heiko St?bner wrote:
> > > While this wasn't a problem until now, the upcoming rk3288 introduces
> > > additional changes to both the grf and pmu areas. On it even part of
> > > the pinmux registers move into the pmu space.
> > 
> > Could you give us more information on that? I tried to find details on the
> > RK3288 but came up with nothing. How are the pinmux registers divided?
> 
> Some days ago, Rockchip released kernel sources for the rk3288 [0]. They
> took a lot of our current mainline code as base for their kernel. AS you
> can see in the register map below, the pinmux registers for the gpio0 bank
> are residing in the pmu space, while gpio1-8 are residing in the regular
> "general register files"

Wow, that's interesting. Seems they invested some real effort to catch up 
instead of simply modifying their old patches. Which is a compliment to your 
contributions!

Maybe we should try to get one of the Rockchip developers on board. They must 
have thought about this kind of thing as well.

> To elaborate a bit:
> 
> On rk3188 it is
> GRF: 0x00 - 0x5c: pin suspend control
> GRF: 0x60 - 0x9c: pinmux control (0x60 and 0x64 gpio-only)
> GRF: 0xa0 - 0xac: soc-control/status
> GRF: 0xb0 - 0xc8: dma-control
> GRF: 0xcc - 0xe0: "cpu core configuration"
> GRF: 0xec - 0xf0: ddr-controller config
> GRF: 0xf4 - 0x104: pin drive-strength (what we currently do not support)
> GRF: 0x108: soc_status1
> GRF: 0x10c - 0x140: USB phy control
> GRF: 0x144 - 0x160: "OS register"
> GRF: 0x160 - 0x19c: pin pull settings
> PMU: 0x00 - 0x38: power-domains and a lot of unknown stuff
> PMU: 0x3c: something called GPIO0_CON, what Rockchip does not use at all
> PMU: 0x40 - 0x60: "SYS_REGx"
> PMU: 0x64 - 0x68: part of GPIO0 pull config
> 
> so we would/will in the end need 4 mappings for the rk3188-pinctrl
> GRF: 0x00 - 0x9c, GRF: 0xf4 - 0x104, GRF: 0x160 - 0x19c, PMU: 0x64 - 0x68
> 
> 
> On rk3288 it is
> 
> GRF: 0x00 - 0x84: gpio1-gpio8 iomux settings
> GRF: 0x104 - 0x138: unknown GPIOxx_SR registers
> GRF: 0x140 - 0x1b4: gpio1-gpio8 pull settings
> GRF: 0x1c0 - 0x234: gpio1-gpio8 driver strength settings
> GRF: 0x240: unknown/unused GPIO_SMT
> GRF: 0x244 - 0x2d4: soc control/status registers
> GRF: 0x2e0 - ...: a lot of stuff like dma, usb-phy etc.
> PMU: 0x00 - 0x5c: powerdomains and a lot of other stuff
> PMU: 0x60: GPIO_SR
> PMU: 0x64 - 0x6c: gpio0 pull settings
> PMU: 0x70 - 0x78: gpio0 drive-strength settings
> PMU: 0x7c: GPIO_OP
> PMU: 0x80: GPIO0_SEL18
> PMU: 0x84 - 0x8c: gpio0 pinmux settings
> PMU: 0x90 - 0xa0: more misc registers (powermode, sys_regX)
> 
> so we would essentially need only two mappings here
> GRF: 0x00 - 0x240 and PMU: 0x60 - 0x8c
>
> So we'd need additional if(is_rk3188()) conditionals to distinguish between
> these implementations [and possible future ones] to select the correct base
> address, and we don't know what the next SoC will bring and how the stuff
> will be ordered there.

Thanks for providing the register mappings.

Yes, if you do specify the mappings as you proposed it would be a nightmare.

However, this sheds light on an underlying issue: Rockchip is not treating the 
whole GPIO block as one cohesive device as we do currently. Instead, it seems 
to me, one GPIO bank is one device. Each has its cohesive mux, bank and pull 
registers - apart from rk3188-bank-0, maybe. But that one is special anyway 
with regards to register ordering (s.b.).

The issues you had with RK3188 and now have with RK3288 seem to stem from 
trying to group all banks together into one pinctrl driver.

So maybe we should promote the GPIO banks to full devices in the dt and make 
smaller mappings for each GPIO bank, i.e. three mappings for each GPIO bank 
(mux, bank, pull). I know we have to stay backwards compatible dt-wise, but 
that should be doable.

Then we are fully flexible and don't need any conditionals or address 
calculation logic. And should a future SoC bring another layout inside the 
banks, we can react with a new "compatible"-name (and maybe a completely 
separate driver, if the change is big enough).

> Also leaving the driver behind, devicetree is meant to describe the
> hardware, not the implementation. And hw-wise both PMU and GRF are actual
> hardware blocks even with individual clock gates.

Whatever a "hardware block" is. n:m mappings between devices and clocks are no 
problems in the dt. So why not describe things a bit more precisely?

> Citing the syscon-devicetree bindings:
> 
> 	System controller node represents a register region containing a set
> 	of miscellaneous registers. The registers are not cohesive enough to
> 	represent as any specific type of device.
> 
> So to me both GRF and PMU regions scream "syscon".

Yes, that sounds a bit like the mess we are dealing with ;-)
I still feel that declaring everything as syscon is somehow circumventing the 
dt. And I feel more comfortable declaring GRF_SOC_* as "miscellaneous 
registers" rather than e.g. the iomux space of GPIO0.

Don't get me wrong please, I'm not completely against the syscon idea. I'm 
just trying to have a full discussion on the issue.

> I've attached my current WIP patch to implement rk3288 support (untested, as
> I don't have any hardware), based on this series. As you can see in it, the
> rk3288 has even more peculiarities with gpio-only and 4bit wide iomuxes.

Nice, but you needed to introduce flags like "SOURCE_PMU/GRF" which would not 
be necessary with the fine-grained mapping. GPIO-Only could be handled by a 
mask specified in the dt.

> As the patch stands now, rk3288 doesn't even need special handling for its
> iomux registers, as it can be simply described now in the pin-bank
> declaration at the bottom - and even the rk3188-bank0 wouldn't be necessary
> anymore.

       /*
		 * The bits in these registers have an inverse ordering
		 * with the lowest pin being in bits 15:14 and the highest
		 * pin in bits 1:0
		 */
		*bit = 7 - (pin_num % RK3188_PULL_PINS_PER_REG);

(from rk3188_calc_pull_reg_and_bit)

That's probably still a peculiarity of rk3188-bank0, isn't it? So we'd still 
need a conditional on rk3188-bank0. That could enable a fourth mapping for the 
split up mux space of bank0 as well.

Compared to your RK3288 patch we'd be moving the information from the table in 
your driver (which is just describing the hw layout & capabilities) into the 
dt.

> > There are some question marks for me on the syscon solution. Regmap uses
> > locking internally, which means separate drivers can't access separate
> > registers simultaneously. We have an SMP machine here, so that's not far-
> > fetched. And that locking is completely unnecessary, as we *know* in most
> > cases that the accessed areas do not overlap.
> 
> For locking vs. speed, I do not see this as a big problem. All registers in
> there mainly contain general settings that are not changed often during the
> operation of the device. So there is no high frequency access to them in any
> case.

Agreed, that's probably not an issue (if no one wants to do high-speed 
concurrent bitbang I/O :D).

> > > The other option would be to leave the grf as it is and create separate
> > > syscons for real small individual parts like the soc-conf and usb-phys.
> > > But apart from creating these real small syscons that would
> > > also make it necessary to introduce another register map for the
> > > drive-strength settings of the pin-controller, which are sitting in the
> > > middle of everything at least on rk3066 and rk3188.
> > 
> > Wy do we need a syscon for usb-phys? Is it shared by multiple drivers?
> > My instinctive approach would be two usb-phys devices mapping the
> > GRF_UOC0/1 spaces directly via reg properties. Or did I miss something?
> 
> Of course if we're going to map each part of the GRF individually there is
> no need for a syscon.

Okay, sorry for misunderstanding.

> I'm also hoping for more input so I've changed the title a bit, to maybe 
> attract more people :-).

Yes, let's hope someone else speaks up. Maybe there has already been a 
precedent in another mach-*? I'll try to find something similar.
In the end you as the maintainer have to make the decision though. And as I 
said I don't have real problems with the syscon solution, it just doesn't feel 
nice.

Cheers,
  Max
