From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 3 Mar 2011 13:48:54 +0000
Subject: [PATCH] ARM: Thumb-2: Add local symbols to work around gas
	behaviour
In-Reply-To: <1299155946-3641-1-git-send-email-dave.martin@linaro.org>
References: <1299155946-3641-1-git-send-email-dave.martin@linaro.org>
Message-ID: <20110303134854.GD25891@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 03, 2011 at 12:39:06PM +0000, Dave Martin wrote:
> All current versions of gas at the time of writing have issues
> fixing up pc-relative instructions which reference global symbols,
> due to the potential need to support symbol preemption.
> Even though symbol preemption is not relevant to the Linux kernel,
> there is no way to inform the tools of this, so we get the problem.
> 
> Most pc-relative forms in ARM, and all pc-relative forms in
> Thumb, will cause the assembler to fail with various fixup error
> messages when used to reference global symbols.
> 
> The legacy behaviour is for ADR and plain LDR instructions in ARM
> which reference global symbols to be fixed up silently with no
> relocation emitted.  This means that building the kernel in ARM
> currently works without problems, but it may be a bug, and the
> behaviour could change in the future.
> 
> After discussion with Richard Earnshaw, it seems that there is
> no single obvious remedy for this inconsistent behaviour,
> so there is not likely to be a comprehensive upstream fix for
> a while.
> 
> A workaround which should be valid for all past and all
> foreseeable future versions of gas is to express the need for
> a local fixup explicitly, by declaring a shadow local symbol
> for any global symbol which needs to be addressed using ADR
> or any pc-relative LDR variant.
> 
> This patch implements this workaround for the one part of the
> main kernel currently known to be affected.  The resulting code
> builds and works correctly in ARM and Thumb.
> 
> Similar fixes may be needed in mach-specific assembler.

This all sounds like dumbness on the part of the assembler, and to say
that this kind of behaviour may change in the future is completely brain
dead.

I am *FAR* from happy with this, and as far as I'm concerned, the
assembler must work as one expects irrespective of whether symbols are
local or global.  I've no idea what binutils people are playing at here
but it sounds utterly idiotic and broken.  I want no part in it.  If
that means developing our own assembler, so be it.
