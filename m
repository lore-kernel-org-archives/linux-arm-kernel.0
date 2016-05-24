From: heiko@sntech.de (Heiko Stuebner)
Date: Tue, 24 May 2016 15:07:52 +0200
Subject: [PATCH 2/3] soc: rockchip: add driver handling grf setup
In-Reply-To: <6a6e87ee-688d-90a3-2407-22847bd80971@rock-chips.com>
References: <1464015539-19521-1-git-send-email-heiko@sntech.de>
 <1464015539-19521-3-git-send-email-heiko@sntech.de>
 <6a6e87ee-688d-90a3-2407-22847bd80971@rock-chips.com>
Message-ID: <7631878.OiMWPcBrqd@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Dienstag, 24. Mai 2016, 10:22:09 schrieb Shawn Lin:
> Hi Heiko,
> 
> On 2016/5/23 22:58, Heiko Stuebner wrote:
> > The General Register Files are an area of registers containing a lot
> > of single-bit settings for numerous components as well full components
> > like usbphy control. Therefore all used components are accessed
> > via the syscon provided by the grf nodes or from the sub-devices
> > created through the simple-mfd created from the grf node.
> > 
> > Some settings are not used by anything but will need to be set up
> > according to expectations on the kernel side.
> > 
> > Best example is the force_jtag setting, which defaults to on and
> > results in the soc switching the pin-outputs between jtag and sdmmc
> > automatically depending on the card-detect status. This conflicts
> > heavily with how the dw_mmc driver expects to do its work and also
> > with the clock-controller, which has most likely deactivated the
> > jtag clock due to it being unused.
> 
> I agree we should disable force_jtag for real product. But on my local
> branch we add a callback to parse a tag from cmdline. Sometime it's
> useful for debugging in case of we need to setup JTAG for reproducing
> and comfirming serious issue in which state the CPU cannot reponse to
> any console input or FIQ-debug triggering.
>
> Should we need it for upstream as you move all related code in this
> new driver?  I'm not sure.

This driver really _should not_ become a catchall for settings stuff.
I.e. the jtag/sdmmc switch handles the automatic switching done inside the 
soc based on the card-detect state. Which confuses the dw_mmc driver.

If I'm reading that correctly in the TRM, jtag on Rockchip SoCs is part of 
the coresight infrastructure - in the DAP block.
There are generic drivers + devicetree bindings for (I think most) coresight 
blocks existing now, but I haven't found anything related to the DAP itself.

In theory I'd think real handling of jtag pins/clocks should be done 
somewhere in that area and and if jtag is to be used,it could then be set up 
using in-kernel mechanics, like disabling sdmmc that claims the shared pins 
and enabling the jtag pinctrl and clocks.

This could even be doable at runtime via devicetree overlays.


Most likely way out of scope for now, but that is where I would imagine this 
stuff to be.

Heiko
