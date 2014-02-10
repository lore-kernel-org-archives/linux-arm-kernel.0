From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Mon, 10 Feb 2014 09:22:24 -0300
Subject: [PATCH v6 05/19] watchdog: orion: Make sure the watchdog is
 initially stopped
In-Reply-To: <20140207174314.GB16263@obsidianresearch.com>
References: <1391707226-18258-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <1391707226-18258-6-git-send-email-ezequiel.garcia@free-electrons.com>
 <52F43ED0.4050808@roeck-us.net> <20140207104044.GA11063@localhost>
 <20140207174314.GB16263@obsidianresearch.com>
Message-ID: <20140210122223.GF10872@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 07, 2014 at 10:43:14AM -0700, Jason Gunthorpe wrote:
> On Fri, Feb 07, 2014 at 07:40:45AM -0300, Ezequiel Garcia wrote:
> 
> > Well, this is related to the discussion about the bootloader not
> > reseting the watchdog properly, provoking spurious watchdog triggering.
> > 
> > Jason Gunthorpe explained [1] that we needed a particular sequence:
> > 
> >  1. Disable WDT
> >  2. Clear bridge
> >  3. Enable WDT
> > 
> > We added the irq handling to satisfy (2), and the watchdog stop for (1).
> 
> The issue here is the driver configures two 'machine kill' elements:
> the PANIC IRQ and the RstOut setup.
> 
> Before configuring either of those the driver needs to ensure that any
> old watchdog events are cleared out of the HW. We must not get a
> spurious event. 
> 
> I agree not disabling an already functional and properly configured
> counter from the bootloader is desirable.
> 
> So lets break it down a bit..
> 
> 1) The IRQ:
>   It looks like the cause bit latches high on watchdog timer
>   expiration but has no side effect unless it is unmasked.
> 
>   The new IRQ flow code ensures the bit is cleared during request_irq
>   so no old events can trigger the IRQ. Thus it is solved now.
> 

Agreed.

> 3) The timer itself:
>   The WDT is just a general timer with an optional hookup to the
>   rst control. If it is harmlessly counting but not resetting we need
>   to stop that before enabling rst out.
> 

Actually, the current flow is to:

1. Disable rst out and then disable the counter, in probe().

2. Enable the counter, and then enable rst out, in start().

> So, how about this for psuedo-code in probe:
> 
> if (readl(RSTOUTn) & WDRstOutEn)
> {
>     /* Watchdog is configured and may be down counting,
>        don't touch it */
>     request_irq(..);
> }
> else
> {
>     /* Watchdog is not configured, fully disable the timer
>        and configure for watchdog operation. */
>     disable_watchdog();
>     request_irq();
>     writel(RSTOUTn), .. WDRstOutEn);
> }
> 

Sounds good, although it seems to me it's actually simpler:

  /* Let's make sure the watchdog is fully stopped, unless
   * it's explicitly enabled and running
   */
  if ( !(wdt_rst_out_en && wdt_timer_enabled) ) {
    watchdog_stop();
  }

-- 
Ezequiel Garc?a, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com
