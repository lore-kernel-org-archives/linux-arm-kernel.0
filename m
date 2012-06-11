From: nico@fluxnic.net (Nicolas Pitre)
Date: Mon, 11 Jun 2012 13:18:28 -0400 (EDT)
Subject: [PATCH] ARM: formalize an IPI for CPU wake-ups
In-Reply-To: <20120611165115.GB18267@n2100.arm.linux.org.uk>
References: <alpine.LFD.2.02.1206111152190.23555@xanadu.home>
 <20120611155716.GA18267@n2100.arm.linux.org.uk>
 <alpine.LFD.2.02.1206111241470.23555@xanadu.home>
 <20120611165115.GB18267@n2100.arm.linux.org.uk>
Message-ID: <alpine.LFD.2.02.1206111307550.23555@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 11 Jun 2012, Russell King - ARM Linux wrote:

> On Mon, Jun 11, 2012 at 12:44:34PM -0400, Nicolas Pitre wrote:
> > On Mon, 11 Jun 2012, Russell King - ARM Linux wrote:
> > 
> > > On Mon, Jun 11, 2012 at 11:54:03AM -0400, Nicolas Pitre wrote:
> > > > 
> > > > Many CPUs are implementing power saving states via the WFI mode.
> > > > In some cases, WFI must be entered in order to suspend, or even reset,
> > > > a CPU.
> > > > 
> > > > Whether a CPU needs to be awaken, brought out of WFI during secondary
> > > > boot, or to cancel a reset state before it is effective, the CPU must
> > > > receive an interrupt to exit its WFI state.
> > > > 
> > > > Let's formalize an IPI number for this purpose, and move over existing
> > > > users over to a convenience function for it.
> > > > 
> > > > This also has the side effect of removing the spurious "Unknown IPI
> > > > message 1" each time a CPU is awaken.
> > > 
> > > I want people to move over to using IPI 0 for wakeup.
> > > 
> > > The problem is, as ever, no one bloody well listens and they all continue
> > > on copying Realview.
> > 
> > No problem -- with this patch the actual IPI number is abstracted away 
> > and we can modify it as we see fit in a single location.
> 
> No.  The reason I haven't simply been through the code and done a forceful
> replace of '1' to '0' is because we don't know how the platforms themselves
> will react, and whether any have their boot protocol expecting SGI1.

I'm all in favor of having people find this out the hard way.  As you 
know I'm sure, pushing out such changes and see if anyone complains is 
often the only way to go.  And I'll be glad to have those complaints 
sent my way if I'm credited for this.

> I've explained all this before, whenever the whinge about the "Unknown IPI"
> message comes up.  Unfortunately, no one has yet listened to what I've said
> and done anything to test whether SGI0 works.

It certainly works for all the targets I'm looking at right now.  In 
those cases the boot protocol couldn't care less about the IPI number as 
the point is only to kick the target CPU out of WFI.

And that message certainly has to go as it may be triggered multiple 
times per second in some use cases here.


Nicolas
