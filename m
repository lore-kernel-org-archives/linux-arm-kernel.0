From: Dave.Martin@arm.com (Dave Martin)
Date: Tue, 7 Jan 2014 16:36:29 +0000
Subject: [PATCH 19/19] [INCOMPLETE] ARM: make return_address available
 for ARM_UNWIND
In-Reply-To: <4325142.7drL5ndxN9@wuerfel>
References: <1359123276-15833-1-git-send-email-arnd@arndb.de>
 <201401071533.35309.arnd@arndb.de>
 <20140107144130.GJ27432@n2100.arm.linux.org.uk>
 <4325142.7drL5ndxN9@wuerfel>
Message-ID: <20140107163629.GC3350@e103592.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 07, 2014 at 03:48:25PM +0000, Arnd Bergmann wrote:
> On Tuesday 07 January 2014 14:41:30 Russell King - ARM Linux wrote:
> > On Tue, Jan 07, 2014 at 03:33:34PM +0100, Arnd Bergmann wrote:
> > > 
> > > 
> > > It's been almost a year since we last discussed the patches that were
> > > posted by Dave and sahara, but nothing has changed in the mainline kernel.
> > > 
> > > Any chance that someone could be motivated to pick this work up again
> > > and finally fix return_address().
> > 
> > I thought that we had _actively_ decided that we would not use the
> > unwinder for these paths - that it was too expensive for these paths,
> > and you had to use frame pointers instead.
> 
> I don't remember that discussion, but it may well be. What does
> that mean for the #warning in return_address.c then? Can we
> just use the frame pointer version based on CONFIG_FRAME_POINTER
> and ignore whether CONFIG_ARM_UNWIND is set as the patch below,
> or did I misunderstand?

For an ARM kernel this may work, but I thought that for THUMB2_KERNEL
there just isn't usable a framepointer at all.

If so, the only choices are to use the unwinder and accept the cost, or
to decide that return_address() will never work without
CONFIG_FRAMEPOINTER and remove the build-time warning.


My other concern was that we might end up in a recursive trace due to
the use of non-notrace core functions in the unwinder.  But I seem to
remember Steve Rostedt saying the the tracer guards against recursive
invocation nowadays -- if so, that shouldn't be a problem.

Cheers
---Dave
