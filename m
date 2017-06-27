From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Tue, 27 Jun 2017 23:08:12 +0100
Subject: [RFC PATCH v2 2/2] ARM: signal: Fix unparseable iwmmxt_sigframe
 in uc_regspace[]
In-Reply-To: <1498583067-14178-3-git-send-email-Dave.Martin@arm.com>
References: <1498583067-14178-1-git-send-email-Dave.Martin@arm.com>
 <1498583067-14178-3-git-send-email-Dave.Martin@arm.com>
Message-ID: <20170627220812.GT4902@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 27, 2017 at 06:04:07PM +0100, Dave Martin wrote:
> In kernels with CONFIG_IWMMXT=y running on non-iWMMXt hardware, the
> signal frame can be left partially uninitialised in such a way
> that userspace cannot parse uc_regspace[] safely.  In particular,
> this means that the VFP registers cannot be located reliably in the
> signal frame when a multi_v7_defconfig kernel is run on the
> majority of platforms.
> 
> The cause is that the uc_regspace[] is laid out statically based on
> the kernel config, but the decision of whether to save/restore the
> iWMMXt registers must be a runtime decision.
> 
> To minimise breakage of software that may assume a fixed layout,
> this patch emits a dummy block of the same size as iwmmxt_sigframe,
> for non-iWMMXt threads.  However, the magic and size of this block
> are now filled in to help parsers skip over it.  A new DUMMY_MAGIC
> is defined for this purpose.
> 
> It is probably legitimate (if non-portable) for userspace to
> manufacture its own sigframe for sigreturn, and there is no obvious
> reason why userspace should be required to insert a DUMMY_MAGIC
> block when running on non-iWMMXt hardware, when omitting it has
> worked just fine forever in other configurations.  So in this case,
> sigreturn does not require this block to be present.
> 
> Reported-by: Edmund Grimley-Evans <Edmund.Grimley-Evans@arm.com>
> Signed-off-by: Dave Martin <Dave.Martin@arm.com>

This looks fine to me.  Please drop it in the patch system, thanks.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
