From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 24 May 2013 11:16:58 +0200
Subject: [PATCH 0/9] Switch internal registers address to 0xF1 on Armada
 370/XP
In-Reply-To: <20130524094313.669ab838@skate>
References: <1369132414-18959-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <201305240915.27847.arnd@arndb.de> <20130524094313.669ab838@skate>
Message-ID: <201305241116.59116.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 24 May 2013, Thomas Petazzoni wrote:
> On Fri, 24 May 2013 09:15:27 +0200, Arnd Bergmann wrote:
> 
> > But there is no problem on those boards /yet/. So far, the two boards
> > always come with the known 0xd0 configuration that match the DTs
> > we have, independent of where they come from.
> > 
> > Thomas wants to be prepared for them to do something stupid, and he
> > anticipates that they are going to do it in a particular way, but
> > he says that he has no control over them, so it's all speculation
> > at this point,
> 
> Speculation? The new bootloaders that change the address to 0xf1000000
> are already shipping on all new Marvell evaluation platforms, they are
> the ones currently available to Marvell customers for their
> developments, and I'm running such a new bootloader on an evaluation
> board.
> 
> I wouldn't call speculation something that I have in front of my eyes
> today. But maybe we don't have the same definition of speculation.

You said earlier yourself that you think the evaluation platforms are
under control because there are only small quantities of them and they
will eventually all move to the new address. I understand that Marvell
screwed up here (actually repeatedly it seems)

> > unless we do something stupid and change the dts
> > files in the kernel to no longer match the current hardware.
> 
> You are again making the same mistake again. You make the association
> between a given hardware platform and the location of the internal
> registers, but this is completely false. Current OpenBlocks are shipped
> with a old bootloader, but new OpenBlocks will most likely be shipped
> with a new bootloader, or existing users of OpenBlocks may upgrade
> their bootloader. So you can't make the assumption that OpenBlocks ==
> old register address.

That is what I meant with speculation: You don't actually know if
OpenBlocks are going to change their boot loader incompatibly, or
in case they do, whether they do it in the same way that Marvell
did or in a different way.

I think it's rather unlikely that a company that has shipped a ton
of machines would force an update on their users that breaks every
single kernel they have running today.

> Again, we do *NOT* want to make this address configurable. All boards
> should use 0xf1000000, and the kernel should assume that this a fixed
> location for the internal registers.

You also said that it didn't matter what you *want* because you have
no control over the boot loaders.

> All what we're trying to achieve here is to provide some temporary
> workaround to help people using old bootloaders move smoothly to newer
> bootloaders version without having a completely silent kernel at boot
> time in the mean time.

I understand that you are trying to do what's best here, but I fear
your workaround is going to make it much worse than it already is.

> So, while we are seeking for a workaround for a mistake of the past,
> you are trying to force us to generalize the mechanism of customizing
> the internal register address, which we do not want to do.

But your approach forces OpenBlocks and others to make the same mistake
that Marvell did by changing their boot loaders in a way that is not
backwards compatible and not detectable in a reliable way (see below).

> If all you're willing to accept is a very complex generalization of the
> internal register base address handling, then I believe what we're
> going to do is just move all Device Tree sources to use 0xf1, and we'll
> tell users to upgrade their bootloader.

Those are two options that would both be better than your current proposal,
but you can probably come up with others. The one thing you must not do
is override the address passed in the boot protocol for all boards based
on an arbitrary non-architecture register setting.

We know that boot loaders are broken all the time. Being able to describe
the breakage correctly in the device tree so the kernel can work around
it is our last line of defence, we have to trust that data.

In your patch, you are effectively encoding the policy that whatever we
find as the internal register address in the DT is meaningless and that
we instead use one of two hardcoded values depending on a bit that
Marvell (who are the ones that screwed this up before) tells you to use
as the interface. You also assume that by some magic you can introduce
the interface now and get everybody to do what you think they should in
the future (i.e. set the internal register to 0xf1 and enable that bit)
so you can remove that hack. I would call that rather optimistic.

What I would expect to see instead is:

* As the interface is now there, some board developers randomly mix
  boot loaders with 0xd0 and 0xf1 and rely on the kernel to use that
  bit for all eternity.

* some other board developers will get the updated u-boot from Marvell
  that sets the bit, but they revert the address back to 0xd0 because
  they want to keep running their old in-house kernels.

* some (slightly crazy) board developers will use their own boot loader
  with the 0xf1 address since Marvell is telling them to use that as
  the new default, but will not set the bit because their in-house kernel
  does not require it.

* at least one (rather crazy) board developers decides that neither 0xd0
  nor 0xf1 is the best base address for their uses and pick something
  completely different. They put the address into their DT following
  the binding and expect the kernel to handle that.

If any of the above happen, your hack will fail and you will have to
build additional hacks on top, instead of getting rid of it.

	Arnd
