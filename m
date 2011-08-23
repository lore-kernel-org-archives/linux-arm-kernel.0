From: will.deacon@arm.com (Will Deacon)
Date: Tue, 23 Aug 2011 22:46:45 +0100
Subject: [PATCH v4 1/8] ARM: proc-v7: disable SCTLR.TE when disabling MMU
In-Reply-To: <1314136012-20533-1-git-send-email-will.deacon@arm.com>
References: <1314136012-20533-1-git-send-email-will.deacon@arm.com>
Message-ID: <1314136012-20533-2-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

cpu_v7_reset disables the MMU and then branches to the provided address.
On Thumb-2 kernels, we should take care to clear the Thumb Exception
enable bit in the System Control Register, otherwise this may wreak
havok in the code to which we are branching (for example, an ARM kernel
image via kexec).

Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/mm/proc-v7.S |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mm/proc-v7.S b/arch/arm/mm/proc-v7.S
index a30e785..96b872c 100644
--- a/arch/arm/mm/proc-v7.S
+++ b/arch/arm/mm/proc-v7.S
@@ -66,6 +66,7 @@ ENDPROC(cpu_v7_proc_fin)
 ENTRY(cpu_v7_reset)
 	mrc	p15, 0, r1, c1, c0, 0		@ ctrl register
 	bic	r1, r1, #0x1			@ ...............m
+ THUMB(	bic	r1, r1, #1 << 30 )		@ Thumb exceptions
 	mcr	p15, 0, r1, c1, c0, 0		@ disable MMU
 	isb
 	mov	pc, r0
-- 
1.7.0.4
