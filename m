From: tony@atomide.com (Tony Lindgren)
Date: Fri, 18 Dec 2009 19:46:06 -0800
Subject: [PATCH 2/5] arm: Fix cpu_proc_fin() for proc-v7.S and make kexec work
In-Reply-To: <20091219034151.26198.26570.stgit@localhost>
References: <20091219034151.26198.26570.stgit@localhost>
Message-ID: <20091219034606.26198.9336.stgit@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The comments in arm_machine_restart() suggest that cpu_proc_fin()
will clean and disable cache and turn off interrupts. This does
not seem to be implemented for proc-v7.S, implement it the same
way as for proc-v6.S.

This also makes kexec work for v7. Note that a related TLB and
branch traget flush patch is also needed to avoid kexec
"crc error".

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mm/proc-v7.S |    9 ++++++++-
 1 files changed, 8 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mm/proc-v7.S b/arch/arm/mm/proc-v7.S
index 3a28521..d2a8074 100644
--- a/arch/arm/mm/proc-v7.S
+++ b/arch/arm/mm/proc-v7.S
@@ -45,7 +45,14 @@ ENTRY(cpu_v7_proc_init)
 ENDPROC(cpu_v7_proc_init)
 
 ENTRY(cpu_v7_proc_fin)
-	mov	pc, lr
+	stmfd	sp!, {lr}
+	cpsid	if				@ disable interrupts
+	bl	v7_flush_kern_cache_all
+	mrc	p15, 0, r0, c1, c0, 0		@ ctrl register
+	bic	r0, r0, #0x1000			@ ...i............
+	bic	r0, r0, #0x0006			@ .............ca.
+	mcr	p15, 0, r0, c1, c0, 0		@ disable caches
+	ldmfd	sp!, {pc}
 ENDPROC(cpu_v7_proc_fin)
 
 /*
