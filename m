From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Fri, 25 Nov 2016 14:56:35 +0000
Subject: Tearing down DMA transfer setup after DMA client has finished
In-Reply-To: <yw1x1sxz8vxm.fsf@unicorn.mansr.com>
References: <58356EA8.2010806@free.fr> <20161125045549.GC2698@localhost>
 <20161125124528.GJ14217@n2100.armlinux.org.uk>
 <yw1xtwav9092.fsf@unicorn.mansr.com>
 <20161125133436.GK14217@n2100.armlinux.org.uk>
 <yw1xlgw78y8k.fsf@unicorn.mansr.com>
 <20161125135830.GL14217@n2100.armlinux.org.uk>
 <yw1xh96v8xnb.fsf@unicorn.mansr.com>
 <20161125141708.GM14217@n2100.armlinux.org.uk>
 <yw1x1sxz8vxm.fsf@unicorn.mansr.com>
Message-ID: <20161125145635.GN14217@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 25, 2016 at 02:40:21PM +0000, M?ns Rullg?rd wrote:
> Russell King - ARM Linux <linux@armlinux.org.uk> writes:
> 
> > On Fri, Nov 25, 2016 at 02:03:20PM +0000, M?ns Rullg?rd wrote:
> >> Russell King - ARM Linux <linux@armlinux.org.uk> writes:
> >> 
> >> > On Fri, Nov 25, 2016 at 01:50:35PM +0000, M?ns Rullg?rd wrote:
> >> >> Russell King - ARM Linux <linux@armlinux.org.uk> writes:
> >> >> > It would be unfair to augment the API and add the burden on everyone
> >> >> > for the new API when 99.999% of the world doesn't require it.
> >> >> 
> >> >> I don't think making this particular dma driver wait for the descriptor
> >> >> callback to return before reusing a channel quite amounts to a horrid
> >> >> hack.  It certainly wouldn't burden anyone other than the poor drivers
> >> >> for devices connected to it, all of which are specific to Sigma AFAIK.
> >> >
> >> > Except when you stop to think that delaying in a tasklet is exactly
> >> > the same as randomly delaying in an interrupt handler - the tasklet
> >> > runs on the return path back to the parent context of an interrupt
> >> > handler.  Even if you sleep in the tasklet, you're sleeping on behalf
> >> > of the currently executing thread - if it's a RT thread, you effectively
> >> > destroy the RT-ness of the thread.  Let's hope no one cares about RT
> >> > performance on that hardware...
> >> 
> >> That's why I suggested to do this only if the needed delay is known to
> >> be no more than a few bus cycles.  The completion callback is currently
> >> the only post-transfer interaction we have between the dma and device
> >> drivers.  To handle an arbitrarily long delay, some new interface will
> >> be required.
> >
> > And now we're back at the point I made a few emails ago about undue
> > burden which is just about quoted above...
> 
> So what do you suggest?  Stick our heads in the sand and pretend
> everything is perfect?

Look, if you're going to be arsey, don't be surprised if I start getting
the urge to repeat previous comments.

Let's try and keep this on a technical basis for once, rather than
decending into insults.

So, wind back to my original email where I started talking about PL08x
already doing something along these lines.  Before a DMA user can make
use of a DMA channel, it has to be requested.  Once a DMA user has
finished, it can free up the channel.

What this means is that there's already a solution here - but it depends
how many DMA channels and how many active DMA users there are.  It's
entirely possible to set the mapping up when a DMA user requests a
DMA channel, leave it setup, and only tear it down when the channel
is eventually freed.

At that point, there's no need to spin-wait or sleep to delay the
tear-down of the channel - and I'd suggest that approach _until_
such time that there are more users than there are DMA channels.  This
has minimal overhead, it doesn't screw up RT threads (which include
IRQ threads), and it doesn't spread the maintanence burden across
drivers with a new custom API just for one SoC.

If (or when) the number of active users exceeds the number of hardware
DMA channels, then there's a decision to be made:

1) either limit the number of peripherals that we support DMA on for
   the SoC.
2) add the delay or API as necessary and switch to dynamic channel
   allocation to incoming requests.

Until that point is reached, there's no point inventing new APIs for
something that isn't actually a problem yet.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
