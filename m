From: gmbnomis@gmail.com (Simon Baatz)
Date: Sun, 24 Jun 2012 17:17:00 +0200
Subject: Dove clock support
In-Reply-To: <20120620055139.GD28139@lunn.ch>
References: <20120618074258.GI4799@lunn.ch> <4FDEDEAE.30502@blackshift.org>
 <20120618080449.GK4799@lunn.ch> <4FDEE6C6.2060101@blackshift.org>
 <20120618084300.GL4799@lunn.ch>
 <20120618214143.GA20040@schnuecks.de>
 <4FDFA748.10905@googlemail.com> <20120619193251.GR26034@lunn.ch>
 <20120619204210.GA18128@schnuecks.de>
 <20120620055139.GD28139@lunn.ch>
Message-ID: <20120624151425.GA8381@schnuecks.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andrew,

On Wed, Jun 20, 2012 at 07:51:39AM +0200, Andrew Lunn wrote:
> > > When moving from kirkwoods old clock management to the generic clock
> > > framework, i kept the functionality the same. The old code would turn
> > > the PHYs off, but have no way to turn them back on again. The new code
> > > is the same.
> > 
> > No, not exactly the same. In the old code, it was sufficient to call
> > the respective kirkwood_..._init function to keep the clock and the
> > PHY alive. Now, the respective driver needs to enable the clock in
> > order to prevent that the clock and the PHY are shut down. 
> 
> Ah yes, you are right.
> 
> I must admit, i never thought much about systems using kernel modules.
> My experience so far, is that systems using kirkwood tend to have
> nearly all drivers built in. The exception seems to be wifi, IPv6, and
> all plug+play drivers for USB.
> 
> However, now i start thinking about it, with the move to one kernel
> per ARM architectures, we are probably going to have more and more
> systems using modules, since for example it makes little sense to have
> the sata_mv driver built in, when run on an AT91 system...

Interesting, my experience is just the other way around. 
Distribution kernels typically are highly modularized.  For example,
the Debian kirkwood kernel uses most of the drivers as modules
(sata_mv, mv_cesa, mv643xx_eth).  This is where my current kernel
configuration originally came from.

After the patch to fix gate_fn, the Ethernet driver works as a
module, since its clocks and thus its PHY is not turned off. 
However, the SATA driver does not work and reports (not surprisingly)
all SATA links as down.

I think we cannot leave this that way. I still like the idea of
adding an "enable PHY" mechanism when the clock is enabled.  Of
course, it is not nice to fiddle around with registers which rather
belong to the driver.  However, we need to do this anyway for the
disable case. But if so, we can also do it symmetrically
(irrespective of adding PM code to drivers).


- Simon
