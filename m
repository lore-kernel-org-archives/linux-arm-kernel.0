From: jgunthorpe@obsidianresearch.com (Jason Gunthorpe)
Date: Thu, 10 Jan 2013 11:48:32 -0700
Subject: [PATCH 2/3] ARM: Orion: Bind the orion bridge interrupt
 controller through DT
In-Reply-To: <50EE8FC5.50105@gmail.com>
References: <1355188683-18208-1-git-send-email-jgunthorpe@obsidianresearch.com>
 <1355188683-18208-2-git-send-email-jgunthorpe@obsidianresearch.com>
 <20121211062430.GD25466@lunn.ch>
 <20121211065813.GA14843@obsidianresearch.com>
 <20121211071333.GR17242@lunn.ch>
 <20121211185535.GA14534@obsidianresearch.com>
 <20130110014734.GC5075@titan.lakedaemon.net>
 <20130110060710.GM24650@lunn.ch> <50EE8FC5.50105@gmail.com>
Message-ID: <20130110184832.GB28004@obsidianresearch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 10, 2013 at 10:54:13AM +0100, Sebastian Hesselbarth wrote:

> >>>Kirkwood is already OK WRT the 0 IRQ, it is handled internally to
> >>>get_irqnr_and_base.
> >>>
> >>>So, I will suggest to please test on dove as-is...
> >>
> >>Did you have a chance to test this on dove?
> >
> >Hi Jason
> >
> >We discussed this a little and I prefer Sebastians implementation.
> >
> >Sebastian, do you have time to work on your code and get it ready?
> 
> Jason, Andrew,
> 
> we chose to jump to irqchip instead of fixing old code. I thought
> Jason Gunthorpe volunteered to get it ready? Moving to irqchip also
> requires clksrc-orion or reimplementing orion into clksrc-mvebu.

I looked into it, but at the time there was so much churn going into
the merge window that it was too much to tackle, then there was/is
holidays for me :) Feburary would probably be the soonest I could
actually get my systems running the latest kernels and do any work on
this subject.

The drivers Sebastian posted looked close to what I posted, a few
things like edge interrupts should be copied over from my patches
though..

The irqchip can be done prior to the timer, if the bridge cause
decoding is left disabled in the DT then the existing timer should
still work..

There is a bunch of prep stuff that may still be pending:
 - Fixup remaining drivers (usb? ethernet?) to have DT bindings and
   get the IRQ number through DT
 - Fixup the GPIO driver to dynamically allocate IRQs rather than
   having a hardwired start (did the pinctl change fix this?)
 - Separate the non-DT and DT IRQ related stuff, the IRQ numbering
   changes with the irqchip driver's dynamic allocation. This solves
   the 0 IRQ problem..
 - Remove non-DT code? Andrew was talking about this..

Jason
