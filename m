From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 22 Nov 2010 19:17:19 +0000
Subject: [PATCH v2 8/9] ARM: Thumb-2: Fix long-distance conditional
	branches in head.S for Thumb-2.
In-Reply-To: <alpine.LFD.2.00.1011221346170.9313@xanadu.home>
References: <1290449065-28843-1-git-send-email-dave.martin@linaro.org>
	<1290449065-28843-9-git-send-email-dave.martin@linaro.org>
	<alpine.LFD.2.00.1011221346170.9313@xanadu.home>
Message-ID: <20101122191719.GO31227@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 22, 2010 at 02:03:51PM -0500, Nicolas Pitre wrote:
> On Mon, 22 Nov 2010, Dave Martin wrote:
> 
> > The 32-bit conditional branches in Thumb-2 have a shorter range (+/-512K)
> > than their ARM counterparts (+/-32MB).  The linker does not currently
> > generate trampolines to extend the range of these Thumb-2 conditional
> > branches, resulting in link errors when vmlinux is sufficiently large, e.g.:
> > 
> > head.o:(.text+0x464): relocation truncated to fit: R_ARM_THM_JUMP19
> > 
> > This patch forces the longer-range, unconditional branch encoding by
> > use of an explicit IT instruction.  The resulting branches are triggered on
> > the same conditions as before.
> > 
> > Signed-off-by: Dave Martin <dave.martin@linaro.org>
> 
> I'm afraid this patch is only making an actual bug visible.  There is no 
> reason why __error_p or __error_a ought to be farther than 512K away 
> from their call sites as they are all supposed to live in the __init 
> section close together.  It looks like the refactoring done in commit 
> 75d90832d5 has dropped the __init attribute from those moved functions, 
> and adding it back would be the real fix.

No, you're not thinking right.  It was _intentional_ that __error_p
ended up in a different section to __init.  With CPU hotplug, as it
is called from the hotplug CPU initialization path, it needs to be
available for that path to call.

So it can't be thrown away with the init code when hotplug is enabled.

The sections which the code end up in is correct as-is.
