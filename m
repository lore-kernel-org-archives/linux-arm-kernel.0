From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Thu, 01 May 2014 15:21:34 +0200
Subject: syscon or memory mappings (was: Re: [RFC/PATCH 0/8] pinctrl-rockchip:
 Change wrong initial assumptions)
In-Reply-To: <699502106.fEF2JGVO0i@typ>
References: <1414506.B4e2jZujVm@diego> <699502106.fEF2JGVO0i@typ>
Message-ID: <5737609.o5tyv6lkQG@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Max,

Am Donnerstag, 1. Mai 2014, 12:43:13 schrieb Max Schwarz:
> On Wednesday 30 April 2014 at 00:07:12, Heiko St?bner wrote:
> > While this wasn't a problem until now, the upcoming rk3288 introduces
> > additional changes to both the grf and pmu areas. On it even part of
> > the pinmux registers move into the pmu space.
> 
> Could you give us more information on that? I tried to find details on the
> RK3288 but came up with nothing. How are the pinmux registers divided?

Some days ago, Rockchip released kernel sources for the rk3288 [0]. They took 
a lot of our current mainline code as base for their kernel. AS you can see in 
the register map below, the pinmux registers for the gpio0 bank are residing 
in the pmu space, while gpio1-8 are residing in the regular "general register 
files"


> Would adding a third reg element for the pinmux register to the gpio
> subnodes suffice to fix your problem?

Rockchip designers do not seem to fear reordering both the GRF and PMU 
register spaces. So my biggest fear is what they'll come up with the next SoC 
;-). Thus I'd like to reduce soc-specific parts instead of adding more.


To elaborate a bit:

On rk3188 it is
GRF: 0x00 - 0x5c: pin suspend control
GRF: 0x60 - 0x9c: pinmux control (0x60 and 0x64 gpio-only)
GRF: 0xa0 - 0xac: soc-control/status
GRF: 0xb0 - 0xc8: dma-control
GRF: 0xcc - 0xe0: "cpu core configuration"
GRF: 0xec - 0xf0: ddr-controller config
GRF: 0xf4 - 0x104: pin drive-strength (what we currently do not support)
GRF: 0x108: soc_status1
GRF: 0x10c - 0x140: USB phy control
GRF: 0x144 - 0x160: "OS register"
GRF: 0x160 - 0x19c: pin pull settings
PMU: 0x00 - 0x38: power-domains and a lot of unknown stuff
PMU: 0x3c: something called GPIO0_CON, what Rockchip does not use at all
PMU: 0x40 - 0x60: "SYS_REGx"
PMU: 0x64 - 0x68: part of GPIO0 pull config

so we would/will in the end need 4 mappings for the rk3188-pinctrl
GRF: 0x00 - 0x9c, GRF: 0xf4 - 0x104, GRF: 0x160 - 0x19c, PMU: 0x64 - 0x68


On rk3288 it is

GRF: 0x00 - 0x84: gpio1-gpio8 iomux settings
GRF: 0x104 - 0x138: unknown GPIOxx_SR registers
GRF: 0x140 - 0x1b4: gpio1-gpio8 pull settings
GRF: 0x1c0 - 0x234: gpio1-gpio8 driver strength settings
GRF: 0x240: unknown/unused GPIO_SMT
GRF: 0x244 - 0x2d4: soc control/status registers
GRF: 0x2e0 - ...: a lot of stuff like dma, usb-phy etc.
PMU: 0x00 - 0x5c: powerdomains and a lot of other stuff
PMU: 0x60: GPIO_SR
PMU: 0x64 - 0x6c: gpio0 pull settings
PMU: 0x70 - 0x78: gpio0 drive-strength settings
PMU: 0x7c: GPIO_OP
PMU: 0x80: GPIO0_SEL18
PMU: 0x84 - 0x8c: gpio0 pinmux settings
PMU: 0x90 - 0xa0: more misc registers (powermode, sys_regX)

so we would essentially need only two mappings here
GRF: 0x00 - 0x240 and PMU: 0x60 - 0x8c


So we'd need additional if(is_rk3188()) conditionals to distinguish between 
these implementations [and possible future ones] to select the correct base 
address, and we don't know what the next SoC will bring and how the stuff will 
be ordered there.


Also leaving the driver behind, devicetree is meant to describe the hardware, 
not the implementation. And hw-wise both PMU and GRF are actual hardware 
blocks even with individual clock gates.

Citing the syscon-devicetree bindings:

	System controller node represents a register region containing a set
	of miscellaneous registers. The registers are not cohesive enough to
	represent as any specific type of device.

So to me both GRF and PMU regions scream "syscon".


> > For this my current gut-feeling is, that providing both the grf and pmu
> > as syscons to the pinctrl driver might be more future proof for the next
> > socs. But as I'm not sure on this, I'd like of course comments :-)
> 
> I don't see the problem with the current solution. In my mind it's cleaner
> to specify register mappings explicitly in the dt rather than map one large
> block and let the drivers figure out themselves where their registers are.

I've attached my current WIP patch to implement rk3288 support (untested, as I 
don't have any hardware), based on this series. As you can see in it, the 
rk3288 has even more peculiarities with gpio-only and 4bit wide iomuxes.

As the patch stands now, rk3288 doesn't even need special handling for its 
iomux registers, as it can be simply described now in the pin-bank declaration 
at the bottom - and even the rk3188-bank0 wouldn't be necessary anymore.


> There are some question marks for me on the syscon solution. Regmap uses
> locking internally, which means separate drivers can't access separate
> registers simultaneously. We have an SMP machine here, so that's not far-
> fetched. And that locking is completely unnecessary, as we *know* in most
> cases that the accessed areas do not overlap.

For locking vs. speed, I do not see this as a big problem. All registers in 
there mainly contain general settings that are not changed often during the 
operation of the device. So there is no high frequency access to them in any 
case.


> > The other option would be to leave the grf as it is and create separate
> > syscons for real small individual parts like the soc-conf and usb-phys.
> > But apart from creating these real small syscons that would
> > also make it necessary to introduce another register map for the
> > drive-strength settings of the pin-controller, which are sitting in the
> > middle of everything at least on rk3066 and rk3188.
> 
> Wy do we need a syscon for usb-phys? Is it shared by multiple drivers?
> My instinctive approach would be two usb-phys devices mapping the GRF_UOC0/1
> spaces directly via reg properties. Or did I miss something?

Of course if we're going to map each part of the GRF individually there is no 
need for a syscon.


> The only register space I see that is used from many drivers is the
> GRF_SOC_* space. So in my mind that should be the only syscon device.
> 
> > @Max: sorry to come up with this now, but I feel this should be resolved
> > (in whatever direction) before we introduce any grf syscon. Because due
> > to dt being an API we will be tied for a long time to it.
> 
> Yes, I agree. If we want to change something, we should change it now. All
> in all I would vote for the current solution. But it seems you have more
> information than me, so my vote is somewhat uneducated ;-)

I'm also hoping for more input so I've changed the title a bit, to maybe 
attract more people :-) .


Heiko


[0] https://github.com/rkchrome/kernel
-------------- next part --------------
A non-text attachment was scrubbed...
Name: 0001-pinctrl-rockchip-WIP-introduce-flexible-iomux-handli.patch
Type: text/x-patch
Size: 12112 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140501/76468eb8/attachment-0001.bin>
