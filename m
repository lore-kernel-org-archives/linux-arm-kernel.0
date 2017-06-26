From: Dave.Martin@arm.com (Dave Martin)
Date: Mon, 26 Jun 2017 14:32:56 +0100
Subject: [RFC PATCH 0/2] ARM: Fix unparseable signal frame with
 CONFIG_IWMMXT
In-Reply-To: <20170626101304.GG4902@n2100.armlinux.org.uk>
References: <1498059983-13438-1-git-send-email-Dave.Martin@arm.com>
 <20170626101304.GG4902@n2100.armlinux.org.uk>
Message-ID: <20170626133255.GH8543@e103592.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 26, 2017 at 11:13:04AM +0100, Russell King - ARM Linux wrote:
> On Wed, Jun 21, 2017 at 04:46:01PM +0100, Dave Martin wrote:
> > In kernels with CONFIG_IWMMXT=y running on non-iWMMXt hardware, the
> > signal frame can be left partially uninitialised in such a way
> > that userspace cannot parse uc_regspace[] safely.  In particular,
> > this means that the VFP registers cannot be located reliably in the
> > signal frame when a multi_v7_defconfig kernel is run on the
> > majority of platforms.
> > 
> > I don't know whether any userspace has implemented any sort of
> > workaround for this, but the ABI by itself is insufficient anyway.
> > 
> > This series attempts to omit the spurious iWMMXt record when
> > appropriate.
> > 
> > Not extensively tested, and the ABI impact is unknown for now.
> 
> Hmm, I would actually suggest that we poke in a correct size for the
> missing iWMMXt record, and an invalid magic number as the "simple"
> solution for this - that doesn't make any layout changes to the
> data structures, and is probably the safest solution for backporting.

This avoids altering the sigframe layout at all in this case, which
feels less dirsuptive, but overall I'm not sure it's lower-risk.

I'm concerned that there are a some userspace sigframe parsers out there
that work only by accident, especially given that the kernel sigreturn
implementation is the primary example and that doesn't need to be fully
robust (since the kernel lays out the sigframe itself during signal
delivery).

> Going forward, I think something along the lines of your proposal is
> okay.

I'm happy to do either, or propose one approach for stable and the other
for mainline, but it's hard to know which is least likely to break
userspace, or exactly what the ABI is.

Cheers
---Dave
