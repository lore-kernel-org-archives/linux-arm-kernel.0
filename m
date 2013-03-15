From: tony@atomide.com (Tony Lindgren)
Date: Fri, 15 Mar 2013 09:20:50 -0700
Subject: [PATCH 2/2] ARM: OMAP2+: clocks: Pass static parent pointers
 to common clock core
In-Reply-To: <514313B6.4050905@ti.com>
References: <1363264618-5071-1-git-send-email-rnayak@ti.com>
 <1363264618-5071-3-git-send-email-rnayak@ti.com>
 <20130314170601.GH26093@atomide.com> <514313B6.4050905@ti.com>
Message-ID: <20130315162049.GB9370@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Rajendra Nayak <rnayak@ti.com> [130315 05:31]:
> On Thursday 14 March 2013 10:36 PM, Tony Lindgren wrote:
> > * Rajendra Nayak <rnayak@ti.com> [130314 05:44]:
> >> OMAP clock inits happen quite early, even before the slab is available.
> >> As part of the clock init, the common clock core tries to cache parent
> >> pointers (if not passed by the caller registering the clock) which
> >> fails in case of OMAP since the slab isn't initied.
> >> Without CONFIG_DEBUG_SLAB enabled, this just results in the common clock core
> >> retrying the caching attempt at some point later.
> >> However with CONFIG_DEBUG_SLAB enabled this results in a BUG() as reported
> >> in the link below by Tony..
> >> http://www.mail-archive.com/linux-omap at vger.kernel.org/msg85932.html
> >>
> >> Fix this by passing static parent pointers to the common clock core
> >> while registering clocks.
> > 
> > I wonder if we could easily fix this by initializing only some of the
> > clocks that early?
> 
> We actually don't need any clocks that early (I mean even before slab init)
> We only need them before timer init.

Yes and only the timer clocks at that point. The others could be initialized
later on so we get console error messages without having to turn on DEBUG_LL
and earlyprintk.
 
> This isn't something specific to OMAP so I started looking at what others
> in drivers/clk seem to do.
> 
> I found imx, spear, mvebu all do their clk inits within .init_time callbacks.
> tegra seems to even do it within .init_irq callback.
> 
> Either one would work for us too :)

Well I suggest init_irq as that's when we need the first clocks for timer.

Regards,

Tony
