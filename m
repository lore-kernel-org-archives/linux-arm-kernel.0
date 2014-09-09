From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 09 Sep 2014 10:50:46 +0200
Subject: [GIT PULL] Renesas ARM Based SoC Init Delay Updates For v3.18
In-Reply-To: <20140909020218.GA23233@verge.net.au>
References: <cover.1408927601.git.horms+renesas@verge.net.au>
 <201409051727.18845.arnd@arndb.de> <20140909020218.GA23233@verge.net.au>
Message-ID: <11409170.rfMyQrIgd0@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 09 September 2014 11:02:18 Simon Horman wrote:
> On Fri, Sep 05, 2014 at 05:27:18PM +0200, Arnd Bergmann wrote:
> > On Monday 25 August 2014, Simon Horman wrote:
> > > Hi Olof, Hi Kevin, Hi Arnd,
> > > 
> > > Please consider these Renesas ARM based SoC init delay updates for v3.18.
> > > 
> > 
> > While looking at your branches, I noticed that you go to great lengths
> > to compute the correct lpj value and avoid the calibration.
> > 
> > However, I believe the "modern" way to do this is to call
> > register_current_timer_delay() in order to base the delay loop
> > on the hardware timer instead of looping in the CPU. This is
> > more accurate and more robust against CPU frequency scaling.
> 
> I may be wrong but my understanding is that Renesas SoCs may be
> booted without a timer.

Do you mean some of them only have a clockevent driver but no clocksource,
and use the jiffies clocksource instead?

I've looked at the three drivers/clocksource/{sh,em}_*.c files, and it seems
sh_mtu2.c indeed has no clocksource support, although the binding description
mentions that it has multiple counters that could be used for this
purpose. This timer is only used on R7S72100, so if you add
'register_current_timer_delay' calls to the other drivers, you can
decide to either keep computing the lpj value for R7S72100 but not the
others, or try to add a clocksource implementation to mtu2 as well.

Note that the read_current_timer() function for the delay implementation
doesn't have to be based on the same timer as the clocksource, but in
practice it often is.

	Arnd
