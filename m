From: paul@pwsan.com (Paul Walmsley)
Date: Mon, 8 Apr 2013 17:09:41 +0000 (UTC)
Subject: [PATCH] ARM: OMAP4: PM: fix PM regression introduced by recent
 clock cleanup
In-Reply-To: <alpine.DEB.2.00.1304081617470.32105@utopia.booyaka.com>
References: <alpine.DEB.2.00.1302122026530.29149@utopia.booyaka.com>
 <5162B019.6050407@ti.com>
 <alpine.DEB.2.00.1304081617470.32105@utopia.booyaka.com>
Message-ID: <alpine.DEB.2.00.1304081704380.32105@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 8 Apr 2013, Paul Walmsley wrote:

> On Mon, 8 Apr 2013, Kishon Vijay Abraham I wrote:
> 
> > On Wednesday 13 February 2013 01:58 AM, Paul Walmsley wrote:
> > > 
> > > Commit 17b7e7d33530e2bbd3bdc90f4db09b91cfdde2bb ("ARM: OMAP4:
> > > clock/hwmod data: start to remove some IP block control "clocks"")
> > > introduced a regression preventing the L3INIT clockdomain of OMAP4
> > > systems from entering idle.  This in turn prevented these systems from
> > > entering full chip clock-stop.
> > > integration hwmod data.
> > 
> > This patch breaks MUSB in OMAP4 panda. The 48M clock is modeled as main clk
> > [1] for ocp2scp so after doing get_sync, this optional clock gets enabled. But
> > after this patch, the optional clock seems to be not enabled after get_sync.
> > 
> > http://lists.infradead.org/pipermail/linux-arm-kernel/2012-September/118285.html
> > (this patch is not directly merged but I guess the discussion here is taken
> > care of)
> 
> The OMAP integration for the MUSB driver needs to clk_enable() and 
> clk_disable() its optional clock.  It's not correct to work around a 
> driver problem by changing the hardware description data - that data is 
> intended to be driver-neutral.

Ugh, took a closer look at this one.  Now I recall what's going on here.  
This is a case where a bit that's clearly marked as an "optional clock" in 
the hardware is really the main functional clock for the IP block.

So I'm open to solving this problem in the integration data as we did 
before, by making ocp2scp_usb_phy_phy_48m the main clock of the 
ocp2scp_usb_phy.  But we need to have a big comment in the hwmod data to 
indicate what's going on here so it doesn't get missed again, since it's 
an inconsistency.  


- Paul
