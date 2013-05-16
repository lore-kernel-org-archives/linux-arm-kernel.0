From: tony@atomide.com (Tony Lindgren)
Date: Thu, 16 May 2013 14:44:31 -0700
Subject: [BISECTED] 3.10-rc1 OMAP1 GPIO IRQ regression
In-Reply-To: <20130516210006.GA31836@blackmetal.musicnaut.iki.fi>
References: <20130513205302.GA3157@blackmetal.musicnaut.iki.fi>
 <20130516180933.GG5600@atomide.com>
 <20130516210006.GA31836@blackmetal.musicnaut.iki.fi>
Message-ID: <20130516214430.GN5600@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Aaro Koskinen <aaro.koskinen@iki.fi> [130516 14:05]:
> On Thu, May 16, 2013 at 11:09:34AM -0700, Tony Lindgren wrote:
> > * Aaro Koskinen <aaro.koskinen@iki.fi> [130513 13:58]:
> > > I tested 3.10-rc1 on OMAP1 / Nokia 770, and Retu MFD probe is broken:
> > > 
> > > [    2.264221] retu-mfd 2-0001: Retu v3.2 found
> > > [    2.281951] retu-mfd 2-0001: Failed to allocate IRQs: -12
> > > [    2.300140] retu-mfd: probe of 2-0001 failed with error -12
> > > 
> > > The error is coming from regmap code. According to git bisect, it is
> > > caused by:
> > > 
> > > 	commit ede4d7a5b9835510fd1f724367f68d2fa4128453
> > > 	Author: Jon Hunter <jon-hunter@ti.com>
> > > 	Date:   Fri Mar 1 11:22:47 2013 -0600
> > > 
> > > 	    gpio/omap: convert gpio irq domain to linear mapping
> > > 
> > > The commit does not anymore revert cleanly, and I haven't yet tried
> > > crafting a manual revert, so any fix proposals/ideas are welcome...
> > 
> > Hmm this might be a bit trickier to fix. Obviously the real solution
> > is to convert omap1 to SPARSE_IRQ like we did for omap2+.
> > 
> > For the -rc cycle, it might be possible to fix this by adding a
> > different irq_to_gpio() and gpio_to_irq() functions for omap1.
> 
> The commit reverts cleanly if we also revert
> 3513cdeccc647d41c4a9ff923af17deaaac04a66 (gpio/omap: optimise interrupt
> service routine), which seems to be just some minor optimization. The
> result is below, and with it 770 works again.

Hmm in this case it seems that we should just fix it rather than go back
to the old code, so let's take a look at that first.

Regards,

Tony
