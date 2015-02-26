From: rjw@rjwysocki.net (Rafael J. Wysocki)
Date: Thu, 26 Feb 2015 22:55:50 +0100
Subject: [RFC PATCH 0/3] genirq: mixing IRQF_NO_SUSPEND and wakeup sources
 on shared IRQs
In-Reply-To: <20150226191724.0ae4ca4e@bbrezillon>
References: <1424771762-16343-1-git-send-email-boris.brezillon@free-electrons.com>
 <8151717.nkhnGBri9h@vostro.rjw.lan> <20150226191724.0ae4ca4e@bbrezillon>
Message-ID: <4291864.PMm4sVoz77@vostro.rjw.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday, February 26, 2015 07:17:24 PM Boris Brezillon wrote:
> On Thu, 26 Feb 2015 19:17:03 +0100
> "Rafael J. Wysocki" <rjw@rjwysocki.net> wrote:
> 
> > On Thursday, February 26, 2015 04:47:24 PM Boris Brezillon wrote:
> > > On Thu, 26 Feb 2015 16:44:16 +0100
> > > "Rafael J. Wysocki" <rjw@rjwysocki.net> wrote:
> 
> [...]
> 
> > > > 
> > > > But it is still a bit risky.  Namely, if the driver in question is sufficiently
> > > > broken (eg. it may not suspend the device and rely on the fact that its interrupt
> > > > handler will be run just because it is sharing a "no suspend" IRQ), we may get
> > > > an interrupt storm.
> > > > 
> > > > Isn't that a problem?
> > > 
> > > For me no (I'll fix all the drivers to handle wakeup, and they are all
> > > already masking interrupts coming from their side in the suspend
> > > callback).
> > > I can't talk for other people though.
> > > The only problem I see here is that you're not informing people that
> > > they are erroneously mixing IRQF_NO_SUSPEND and !IRQF_NO_SUSPEND anymore
> > > (you removed the warning backtrace).
> > > Moreover, you are replacing their handler by a stub when entering
> > > suspend, so they might end-up receiving spurious interrupts when
> > > suspended without knowing why ?
> > > 
> > > How about checking if the number of actions registered with
> > > IRQF_NO_SUSPEND + those registered with IRQF_COND_SUSPEND (or another
> > > flag stating that the handler can safely be called in suspended state
> > > even if it didn't ask for NO_SUSPEND) are equal to the total number of
> > > registered actions, and complain if it's not the case.
> > 
> > The same idea I had while talking to Peter over IRC.  So the patch below
> > implements that.
> 
> Yep, that's what I had in mind.

OK, thanks.

I'll submit it formally, then.


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
