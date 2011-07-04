From: ben-linux@fluff.org (Ben Dooks)
Date: Mon, 4 Jul 2011 22:39:22 +0100
Subject: Future of S3C6410 platform
In-Reply-To: <201107042239.41833.arnd@arndb.de>
References: <2635745.FvrjgPkNLz@flatron> <201107042239.41833.arnd@arndb.de>
Message-ID: <20110704213921.GL21138@trinity.fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 04, 2011 at 10:39:41PM +0200, Arnd Bergmann wrote:
> On Monday 04 July 2011 21:14:19 Tomasz Figa wrote:
> > I am writing to ask what is the planned future for the (now obsolete?) S3C6410 
> > platform. Is there any ongoing work on bringing more feature-complete support 
> > for it?
> 
> I guess you should ask the maintainer directly, now on Cc. I wouldn't call
> s3c6410 obsolete, we have much much older platforms that are still supported
> well. Of course, many people are overworked and need to set priorities,
> so it's understandable if there are fewer patches to improve the less
> current platforms.

We've still got shipping products with these chips, they're actively used
and still being manufactured.
 
> > The platform is really far behind its newer friends and here is what bothers 
> > me most:
> > - missing basic features as NOHZ support

hardly a basic feature.

> > - buggy drivers (in mainline!, s3c-fb requesting irq before fully initializing 
> > driver data, same goes for the adc driver)

never seen any bug reports for these items.

> > - totally broken usb gadget driver - I could not get it to work on my platform 
> > in any way (Samsung GT-i5700 phone; I am getting a Tiny6410 soon, so I will 
> > check whether it is not a board specific issue) without rewriting control 
> > endpoint handling code, not even mentioning about DMA support, which I still 
> > cannot get to work
> > - poor OneNAND support (mostly in terms of performance)

I've not seen any s3c6410 systems with OnenNAND on.

The UDC driver actually works most of the time for me, there are a few
corner cases that require work on for cases where it does not handle
unexpected events from the hardware. Newer SoCs do not tend to produce
these cases due to different synthesis options, and thus not all are
dealt with.

> > - no power domain support

runtime pm should make this easier.

> > - no support for advanced features of the chip (ie. functionality provided by 
> > old, and really _bad_, s3c modules)

old? some of these IP blocks have not changed much since their original
s3c2400 incarnations. The blocks that have changed have been re-written
to deal with this.

You're really endearing yourself to me by calling s3c modules "really _bad_".
 
> > I have already added NOHZ support, fixed fb and adc bugs, refactored control 
> > endpoint handling in udc driver (no DMA yet), done some improvement to OneNAND 
> > driver (still a big work in progress though, this is a topic for another 
> > message) and implemented power domain management + other minor changes/fixes. 

the usb gadget driver already has some of the DMA support code in it,
but the s3c6410 compilation of that hardware does not do unaligned
buffers making it difficult to use for most of the current gadget
drivers.  My view is that bounce-buffers are probably not going to
help much, so it was never a priority.

Unfortunately there's not a lot I can do with this driver as I am at the
limit of the documenation I can currently get my hands on.

Some of this will probably be obsoleted soon anyway due to the massive
restructuring in arch/arm land.
 
> In general, patches that fix bugs are always welcome, and so are patches
> that add functionality and device drivers. Even device drivers that are
> not good enough for inclusion can often get merged into the drivers/staging
> directory, if there is hope that the quality of the code is improving
> over time.

drivers/staging is not in any 
 
> > All of this is available in my tree at 
> > git://github.com/tom3q/spica-2.6.38.git, but I am going to prepare patches 
> > containing all the changes a bit later, after I rebase all my work to latest 
> > Linux sources, as I worked mostly on Android 2.6.38 sources.

Is there a browsable list of changes that you've got?
 
> Yes, that is a necessary step for getting your code contributions into
> the mainline kernel. You should also read Documentation/SubmittingPatches
> carefully, to avoid a frustrating experience from the first submission of
> a large patch set.
> 
> I would recommend that you have your patches reviewed in private by a person
> you know first, and then post them on the mailing list for a broader review.
> 
> 	Arnd

-- 
Ben Dooks, ben at fluff.org, http://www.fluff.org/ben/

Large Hadron Colada: A large Pina Colada that makes the universe disappear.
