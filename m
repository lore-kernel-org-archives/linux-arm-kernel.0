From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Wed, 28 Aug 2013 09:08:02 -0300
Subject: [PATCH 01/15] watchdog: orion: Remove unneeded BRIDGE_CAUSE clear
In-Reply-To: <20130827222532.GA1632@obsidianresearch.com>
References: <1377614079-10000-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <1377614079-10000-2-git-send-email-ezequiel.garcia@free-electrons.com>
 <20130827163939.24636d80@skate> <20130827151136.GA10084@localhost>
 <20130827152535.GG19598@titan.lakedaemon.net>
 <20130827191337.GA2339@localhost> <521D063F.4040404@gmail.com>
 <20130827210248.GA19625@obsidianresearch.com>
 <20130827221729.GA25413@localhost>
 <20130827222532.GA1632@obsidianresearch.com>
Message-ID: <20130828120801.GC2348@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 27, 2013 at 04:25:32PM -0600, Jason Gunthorpe wrote:
> On Tue, Aug 27, 2013 at 07:17:29PM -0300, Ezequiel Garcia wrote:
> 
> > The problem is: how do we handle the reset out enable in the watchdog
> > driver, while removing the hard-coded register (and hence the mach-header)
> > *at the same* time?
> > 
> > Should we return to the previously proposed idea of putting that
> > in the reg property? IOW:
> > 
> >   watchdog {
> >     reg = <timer control>, <rstout>;
> >   };
> > 
> > If we *must* access the rstout register from the watchdog driver,
> > and we *cannot* have any mach-xxx headers to find base addresses,
> > then the only valid solution is to pass this information from the DT.
> 
> Makes sense to me..
> 

Ok, good.

> I think the need for strong ordering between the timer control and the
> rstout registers trumps other considerations.
> 

Agreed.

> Ditto for the interrupt, specify the interrupt in the DT, and request
> it in the driver. Ensure that the irq driver clears the cause register
> bit for an interrupt before attaching an irq (this is fairly standard
> irq practice).
> 

Hm.. but in order to make this work, we need the bridge interrupt
controller introduced by Sebastian, but not available in the "older"
platforms (right?).

So, in order to add support to Armada 370/XP watchdog (which was the
initial goal of all of this) I think our sane option reduce to two:

* Drop watchdog support on non-DT platforms and add support for
  A370/XP in the orion-wdt driver.
  I don't quite like the idea of dropping support on anything,
  so I can't say I'm thrilled by this idea.

Or,

* Support A370/AXP in a different and new armada-wdt driver.
  The differences between the SoC might be small, but maybe
  enough to justify a separate driver and avoid more problems.

Ideas?
-- 
Ezequiel Garc?a, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com
