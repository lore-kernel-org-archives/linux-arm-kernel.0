From: Dave.Martin@arm.com (Dave Martin)
Date: Wed, 28 Jun 2017 14:09:18 +0100
Subject: [RFC PATCH v2 2/2] ARM: signal: Fix unparseable iwmmxt_sigframe
 in uc_regspace[]
In-Reply-To: <20170627220812.GT4902@n2100.armlinux.org.uk>
References: <1498583067-14178-1-git-send-email-Dave.Martin@arm.com>
 <1498583067-14178-3-git-send-email-Dave.Martin@arm.com>
 <20170627220812.GT4902@n2100.armlinux.org.uk>
Message-ID: <20170628130916.GM8543@e103592.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 27, 2017 at 11:08:12PM +0100, Russell King - ARM Linux wrote:
> On Tue, Jun 27, 2017 at 06:04:07PM +0100, Dave Martin wrote:
> > In kernels with CONFIG_IWMMXT=y running on non-iWMMXt hardware, the
> > signal frame can be left partially uninitialised in such a way
> > that userspace cannot parse uc_regspace[] safely.  In particular,
> > this means that the VFP registers cannot be located reliably in the
> > signal frame when a multi_v7_defconfig kernel is run on the
> > majority of platforms.
> > 
> > The cause is that the uc_regspace[] is laid out statically based on
> > the kernel config, but the decision of whether to save/restore the
> > iWMMXt registers must be a runtime decision.
> > 
> > To minimise breakage of software that may assume a fixed layout,
> > this patch emits a dummy block of the same size as iwmmxt_sigframe,
> > for non-iWMMXt threads.  However, the magic and size of this block
> > are now filled in to help parsers skip over it.  A new DUMMY_MAGIC
> > is defined for this purpose.
> > 
> > It is probably legitimate (if non-portable) for userspace to
> > manufacture its own sigframe for sigreturn, and there is no obvious
> > reason why userspace should be required to insert a DUMMY_MAGIC
> > block when running on non-iWMMXt hardware, when omitting it has
> > worked just fine forever in other configurations.  So in this case,
> > sigreturn does not require this block to be present.
> > 
> > Reported-by: Edmund Grimley-Evans <Edmund.Grimley-Evans@arm.com>
> > Signed-off-by: Dave Martin <Dave.Martin@arm.com>
> 
> This looks fine to me.  Please drop it in the patch system, thanks.

Do you have a view on whether I should Cc-stable on this?

The patches seem to apply cleanly back to v3.4, but I'm not in a
position to test that far back easily.

As a reference point, Debian stretch seems to use v4.9.x for its
multiplatform distro kernel, so it may be worth going at least that
far back.  (jessie uses v3.16.x.)

Cheers
---Dave
