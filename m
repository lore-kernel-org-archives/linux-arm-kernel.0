From: nico@fluxnic.net (Nicolas Pitre)
Date: Mon, 22 Nov 2010 14:03:51 -0500 (EST)
Subject: [PATCH v2 8/9] ARM: Thumb-2: Fix long-distance conditional
	branches in head.S for Thumb-2.
In-Reply-To: <1290449065-28843-9-git-send-email-dave.martin@linaro.org>
References: <1290449065-28843-1-git-send-email-dave.martin@linaro.org>
	<1290449065-28843-9-git-send-email-dave.martin@linaro.org>
Message-ID: <alpine.LFD.2.00.1011221346170.9313@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 22 Nov 2010, Dave Martin wrote:

> The 32-bit conditional branches in Thumb-2 have a shorter range (+/-512K)
> than their ARM counterparts (+/-32MB).  The linker does not currently
> generate trampolines to extend the range of these Thumb-2 conditional
> branches, resulting in link errors when vmlinux is sufficiently large, e.g.:
> 
> head.o:(.text+0x464): relocation truncated to fit: R_ARM_THM_JUMP19
> 
> This patch forces the longer-range, unconditional branch encoding by
> use of an explicit IT instruction.  The resulting branches are triggered on
> the same conditions as before.
> 
> Signed-off-by: Dave Martin <dave.martin@linaro.org>

I'm afraid this patch is only making an actual bug visible.  There is no 
reason why __error_p or __error_a ought to be farther than 512K away 
from their call sites as they are all supposed to live in the __init 
section close together.  It looks like the refactoring done in commit 
75d90832d5 has dropped the __init attribute from those moved functions, 
and adding it back would be the real fix.


Nicolas
