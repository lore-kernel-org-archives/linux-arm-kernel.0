From: heiko@sntech.de (Heiko Stuebner)
Date: Fri, 24 Jun 2016 21:39:32 +0200
Subject: [v3 PATCH 3/5] phy: Add USB Type-C PHY driver for rk3399
In-Reply-To: <576BDCD0.5060001@ti.com>
References: <1466686264-6744-1-git-send-email-zyw@rock-chips.com>
 <1466686264-6744-4-git-send-email-zyw@rock-chips.com>
 <576BDCD0.5060001@ti.com>
Message-ID: <1514992.DV7LTB70sc@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Donnerstag, 23. Juni 2016, 18:27:52 schrieb Kishon Vijay Abraham I:
> Hi,
> 
> On Thursday 23 June 2016 06:21 PM, Chris Zhong wrote:
> > Add a PHY provider driver for the rk3399 SoC Type-c PHY. The USB
> > Type-C PHY is designed to support the USB3 and DP applications. The
> > PHY basically has two main components: USB3 and DisplyPort. USB3
> > operates in SuperSpeed mode and the DP can operate at RBR, HBR and
> > HBR2 data rates.
> > 
> > Signed-off-by: Chris Zhong <zyw@rock-chips.com>
> > Signed-off-by: Kever Yang <kever.yang@rock-chips.com>
> > 
> > ---
> > 
> > Changes in v3:
> > - remove the phy framework(Kishon Vijay Abraham I)
> > - add parentheses around the macro
> > - use a single space between type and name
> > - add spaces after opening and before closing braces.
> > - use u16 for register value
> > - remove type-c phy header file
> > - CodingStyle optimization
> > - use some cable extcon to get type-c port information
> > - add a extcon to notify Display Port
> > 
> > Changes in v2:
> > - select RESET_CONTROLLER
> > - alphabetic order
> > - modify some spelling mistakes
> > - make mode cleaner
> > - use bool for enable/disable
> > - check all of the return value
> > - return a better err number
> > - use more readx_poll_timeout()
> > - clk_disable_unprepare(tcphy->clk_ref);
> > - remove unuse functions, rockchip_typec_phy_power_on/off
> > - remove unnecessary typecast from void *
> > - use dts node to distinguish between phys.
> > 
> > Changes in v1:
> > - update the licence note
> > - init core clock to 50MHz
> > - use extcon API
> > - remove unused global
> > - add some comments for magic num
> > - change usleep_range(1000, 2000) tousleep_range(1000, 1050)
> > - remove __func__ from dev_err
> > - return err number when get clk failed
> > - remove ADDR_ADJ define
> > - use devm_clk_get(&pdev->dev, "tcpdcore")
> > 
> >  drivers/phy/Kconfig              |    8 +
> >  drivers/phy/Makefile             |    1 +
> >  drivers/phy/phy-rockchip-typec.c | 1027
> >  ++++++++++++++++++++++++++++++++++++++ 3 files changed, 1036
> >  insertions(+)
> >  create mode 100644 drivers/phy/phy-rockchip-typec.c
> > 
> > diff --git a/drivers/phy/Kconfig b/drivers/phy/Kconfig
> > index 26566db..ec87b3a 100644
> > --- a/drivers/phy/Kconfig
> > +++ b/drivers/phy/Kconfig
> > @@ -351,6 +351,14 @@ config PHY_ROCKCHIP_DP
> > 
> >  	help
> >  	
> >  	  Enable this to support the Rockchip Display Port PHY.
> > 
> > +config PHY_ROCKCHIP_TYPEC
> > +	tristate "Rockchip TYPEC PHY Driver"
> > +	depends on ARCH_ROCKCHIP && OF
> > +	select GENERIC_PHY
> 
> Why? None of the generic PHY API's are used here. Why do you want select
> generic PHY?

I'm actually wondering, why there are no phy ops to start and stop the py. 
Right now the device seems to be on and handling all the extcon notifies all 
the time even if no-one is using the phy.

There are two users of this phy, the dp-controller as well as some usb 
component. The phy framework is nicely refcounted, so can handle any number 
of phy users and somehow I'd expect the phy to do nothing (and try to not 
consume power) if neither the dp-controller nor the usb-part is actually 
running.

It may very well be my ignorance, but Chris could you explain, if there is a 
reason for this?


Thanks
Heiko
