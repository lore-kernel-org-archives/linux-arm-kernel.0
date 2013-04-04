From: tony@atomide.com (Tony Lindgren)
Date: Thu, 4 Apr 2013 09:33:46 -0700
Subject: [RFC][PATCH 1/2] ARM: OMAP4: clock: Add device tree support
 for AUXCLKs
In-Reply-To: <515D0D8A.7030500@ti.com>
References: <1363703220-4777-1-git-send-email-rogerq@ti.com>
 <1363703220-4777-2-git-send-email-rogerq@ti.com>
 <20130403234242.GE10155@atomide.com> <515D0D8A.7030500@ti.com>
Message-ID: <20130404163346.GG10155@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Rajendra Nayak <rnayak@ti.com> [130403 22:25]:
> On Thursday 04 April 2013 05:12 AM, Tony Lindgren wrote:
> > 
> > How about just add a minimal drivers/clk/omap/clk-xyz.c that takes
> > the configuration from DT and is based on the binding we already have in
> > Documentation/devicetree/bindings/clock/clock-bindings.txt?
> > 
> > Then as we add new bindings there we can drop them from current
> > cclock44xx_data.c, no? That is after omap4 is DT only..
> 
> The patch just provides an alternative for clkdev mapping in case of DT.
> Are you suggesting we move all *clock data* related to auxclks (and eventually
> all clocks) into DT?

Well I think we should have a driver that can take any defined clock binding
from DT at least for boottime clocks. We need at least the timer clocks
early during the boot, and probably the root device like MMC or possibly
Ethernet depending on the board.

The rest of the huge amount of clocks we can just load from /lib/firmware
after mounting intramfs or root on MMC. As long as we can define any
boottime clock in DT also, loading the rest of the clock data from
/lib/firmware should not cause issues with booting.

And as we get the clocks moved, we can drop them from cclock44xx_data.c.
AFAIK the new driver can just clk_get the parent clocks so those can
stay in cclock44xx_data.c for now?

So basically we can do the same as we are already doing with pinctrl-single.c,
but with addition of loading large amounts of data from /lib/firmware.
And eventually we can do the same with hwmod too.

Regarding the readability issue, we now have preprocessing support for
.dts files merged AFAIK, so they can be as readable as data structures :)

> We have discussed this multiple times in the past, and moving 250 clock nodes
> with each needing multiple register offsets, masks, shifts etc into DT makes it
> completely un-readable. For me, having a way for devices to reference a clock that they
> use for a device using DT makes sense, but not moving all clock data into dts files.

Yes that's why we should also support loading clocks from /lib/firmware.
Naturally the parent clocks can be allocated by the clock driver(s) at
least initially.

But the main reason I think we should do this is so we get out of the
flame path with these huge data files for every new SoC.

Regards,

Tony
