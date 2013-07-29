From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 29 Jul 2013 19:16:07 +0100
Subject: DT bindings as ABI [was: Do we have people interested in
 device tree janitoring / cleanup?]
In-Reply-To: <20130729175400.GB15861@obsidianresearch.com>
References: <CAOesGMhJ+je8FZqeFxhAcYwU0CHYer+aGP6DA_8x3azrzfA2sw@mail.gmail.com>
 <20130725175702.GC22291@e106331-lin.cambridge.arm.com>
 <51F168FC.9070906@wwwdotorg.org>
 <20130725182920.GA24955@e106331-lin.cambridge.arm.com>
 <20130725184834.GA8296@netboy> <20130725213753.GC17616@obsidianresearch.com>
 <20130726045433.GB4100@netboy> <20130726171524.GB28895@obsidianresearch.com>
 <20130727084825.GA4707@netboy> <20130729175400.GB15861@obsidianresearch.com>
Message-ID: <20130729181607.GM24642@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 29, 2013 at 11:54:00AM -0600, Jason Gunthorpe wrote:
> There is no way I can possibly ship a product with a DT that is
> finished. I can't tie my company's product release cycles to the whims
> of the kernel community.
> 
> So embedded people are going to ship with unfinished DT and upgrade
> later. They have to. There is no choice. Stable DT doesn't change
> anything unless you can create perfect stable bindings for a new SOC
> instantaneously.
> 
> This is where I see the whole disconnect in this
> discussion. General-purpose and embedded are *DIFFERENT* users, and
> they have different use-cases and different needs.

We have had for the last 20 odd years a stable kernel syscall ABI, in
that syscalls which were around 20 years ago are still around today,
and still function according to how they're meant to.

However, some syscalls were found to be insufficient for todays needs,
so they got augmented.  For example, the uid/gid IDs used to be 16-bit.
We now have 32-bit versions, but the 16-bit versions are still there.
(Since ARM started out from early 1.0 times, it too has the 16-bit
syscalls, and _still_ does.)

So, "stable" is possible.

What has to be realised to achieve that it requires nothing more than
a "keep existing stuff working" attitude towards it.  When you need to
change the interface, you supplement it, leaving the old version to
work in the same manner that it used to (yes, you should choose to
implement the old interfaces using the new stuff, just like we support
the 16-bit UID calls but internally deal with 32-bit UIDs.)

What does it take?  Good practice, care, thought and planning.  All
the qualities which should already be present for kernel _engineers_.
Not an "lets create something for me, I don't care about anyone else"
attitude.

We can draw the line at an interface becoming stable in exactly the
same way that we do every other "stable" interface like syscalls - if
it's in a -final kernel, then it has been released at that point as a
stable interface to the world.  That's how syscalls are dealt with -
if a syscall is supported by a -final kernel, then that interface
immediately becomes part of the userland ABI and can't be changed or
deleted without some really serious thought, a migration path, and
sufficient (which means many years) warning to users that it's obsolete.

If that is followed, then there is absolutely no reason why a "Stable
DT" is not possible - one which it's possible to write a DT file today,
and it should still work in 20 years time with updated kernels.  That's
what a stable interface _should_ allow, and this is what DT _should_ be.

It should be possible to say "I have a XYZ ethernet device, it is
hooked up like this, uses this interrupt" etc and that same way work
in 20 years time to describe exactly the same connections.

Sure, we can create a "staging" directory for stuff which we want to
merge but is not deemed to be properly fit for the kernel, and deem
_that_ stuff to be unstable - just like drivers/stable.  Maybe some
of it can live in drivers/stable too...
