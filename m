From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Fri, 2 Mar 2018 15:32:22 +0000
Subject: [PATCH] i2c: s3c2410: Properly handle interrupts of number 0
In-Reply-To: <20180302140901.lrjqiaa2k4nxkqco@mwanda>
References: <1519936484-23132-1-git-send-email-krzk@kernel.org>
 <20180302111931.GX9418@n2100.armlinux.org.uk>
 <20180302124647.sfhnto77wgdh5sv6@katana>
 <20180302125907.GA9418@n2100.armlinux.org.uk>
 <20180302135854.76ue5jzsg7lvxjxw@katana>
 <20180302140901.lrjqiaa2k4nxkqco@mwanda>
Message-ID: <20180302153221.GB9418@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 02, 2018 at 05:09:01PM +0300, Dan Carpenter wrote:
> On Fri, Mar 02, 2018 at 02:58:54PM +0100, Wolfram Sang wrote:
> > 
> > > It needs platform maintainers to be motivated to fix it, and one way to
> > > provide that motivation is for subsystem maintainers to say no to patches
> > > like this.  If patches like this get accepted, then the "problem" gets
> > > solved, and there is very little motivation to fix the platform itself.
> > 
> > Yes, I can see this. I will drop / revert the patch.
> > 
> 
> TBH, I can't find the threads from November so I feel a bit lost and
> there is no documentation for platform_get_irq().

Start from here:

http://archive.armlinux.org.uk/lurker/search/20380101.000000.00000000 at ml:linux-arm-kernel,sb:platform%5Fget%5Firq.en.html

With the right list archiving software with a built-in search facility,
it becomes much easier to find stuff!  There's quite a number of messages
there though, as there were multiple patch series posted.

Some specific messages:

http://archive.armlinux.org.uk/lurker/message/20171204.182556.775e16ab.en.html
http://archive.armlinux.org.uk/lurker/message/20171120.164840.87002f9c.en.html
http://archive.armlinux.org.uk/lurker/message/20171118.182704.3e1a5553.en.html

The reason it hasn't be trivially done (just by changing
platform_get_irq() now) is that doing so will cause a bunch of
regressions, precisely because people _are_ using IRQ 0 with some
platform drivers.

The patch series above has died a death, so yet again the IRQ0/NO_IRQ
issue has disappeared off people's radars and there's no reason to
fix the situation.  So, we're yet again back to the status quo of
almost nothing happening.

How do we break this status quo and finally solve the IRQ 0 and
NO_IRQ issue?

I believe that we have to bite the bullet and start by saying no to
these trivial patches which try to preserve the current situation.
That at least provides some motivation for things to get fixed in
the right way.

Another possibility would be to change platform_get_irq() and
suffer the regressions that will cause, telling people that fixing
their platform IRQ numbering is the only solution (but this
requires breaking our ideals about regressions.)

The alternative is everyone (including Linus) stops whinging about
NO_IRQ and IRQ0 and put up with the fact that some platforms treat
IRQ0 as a valid interrupt - which, I think we can all agree, isn't
going to happen.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 8.8Mbps down 630kbps up
According to speedtest.net: 8.21Mbps down 510kbps up
