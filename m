From: will.deacon@arm.com (Will Deacon)
Date: Wed, 8 Jul 2015 15:09:24 +0100
Subject: [RFC PATCH] arm64: force CONFIG_SMP=y and remove redundant #ifdefs
In-Reply-To: <20150708105847.GB6944@e104818-lin.cambridge.arm.com>
References: <1436293575-5101-1-git-send-email-will.deacon@arm.com>
 <20150708105847.GB6944@e104818-lin.cambridge.arm.com>
Message-ID: <20150708140923.GF9283@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 08, 2015 at 11:58:47AM +0100, Catalin Marinas wrote:
> On Tue, Jul 07, 2015 at 07:26:15PM +0100, Will Deacon wrote:
> > Nobody seems to be producing !SMP systems anymore, so this is just
> > becoming a source of kernel bugs, particularly if people want to use
> > coherent DMA with non-shared pages.
> > 
> > This patch forces CONFIG_SMP=y for arm64, removing a modest amount of
> > code in the process.
> > 
> > Signed-off-by: Will Deacon <will.deacon@arm.com>
> > ---
> > 
> > I'd appreciate any comments on this. Anybody got a good reason for
> > CONFIG_SMP=n on arm64?
> 
> A good reason would be testing/validating some hardware configurations
> or even KVM/Xen (to see how they cope with UP OS'es). Of course, this
> still requires that someone tests UP builds regularly but at least under
> KVM this shouldn't be hard.

>From a hypervisor perspective, this "validation" is basically just checking
that memory is overridden to be shareable and TLB/cache maintenance is
forced to be broadcast, right?

However, I think a UP kernel should be doing that *anyway* in order to
support cache-coherent DMA (potentially behind an SMMU using CPU page
tables), so by the time you fix !SMP kernels to do all that, they're
basically indistinguishable imo.

> An alternative, which does not remove any code:

Bah, removing the code is what made it fun :)

Will
