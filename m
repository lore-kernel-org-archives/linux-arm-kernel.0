From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 30 Aug 2012 17:45:51 +0100
Subject: [PATCH 1/6] ARM: move ARCH config definitions into mach dirs
In-Reply-To: <503F845C.10406@gmail.com>
References: <1346280600-29395-1-git-send-email-robherring2@gmail.com>
 <1346280600-29395-2-git-send-email-robherring2@gmail.com>
 <20120829233159.GS18957@n2100.arm.linux.org.uk> <503F845C.10406@gmail.com>
Message-ID: <20120830164551.GY18957@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 30, 2012 at 10:18:52AM -0500, Rob Herring wrote:
> Then what do you suggest? I can think of a few alternatives.
> 
> Leave the current name and make the hidden option a new name like
> ARCH_xx_OPTIONS. This would require renaming ARCH_xxx for each platform
> all over the tree. I don't care to sign up for that task...

Well, requiring everyone to spend hours redoing their configuration also
isn't practical either.

> Move platforms one by one out of the choice as they are converted. I
> can't think of a reason for a platform to be in both places except we
> would have to figure out something for getting DEBUG_LL to work.

No you don't.  We've already decided how we're going to deal with
DEBUG_LL, and we are _not_ going to make that multi-platform.  You
select one of the output options, and that is it.  We've already
been moving in that direction, albiet slowly.  Again, anyone who wants
to be part of a multiplatform kernel better use the provided choice
or they will get no DEBUG_LL facility - simples.

That also means we can start to think about moving the mach/debug-macros.S
header elsewhere, remembering that this facility is shared between the
decompressor for debugging and the kernel.

Remember that DEBUG_LL is the low-level *debug* facility.  It is not
the early console, even if it ended up being used as such (which is
not something I really care for.)  Read the previous discussions on
this subject if you disagree, but I'm not changing my position over
DEBUG_LL because that will just require me to re-invent the facility
yet again (which is what DEBUG_LL is there to stop.)  It was _never_
intended to be an early console facility.
