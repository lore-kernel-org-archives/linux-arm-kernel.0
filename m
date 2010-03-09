From: saeed@marvell.com (Saeed Bishara)
Date: Tue,  9 Mar 2010 16:07:02 +0200
Subject: [PATCH 1/2] arm: disable L2 cache in the v7 finish function
In-Reply-To: <1268143623-22361-1-git-send-email-saeed@marvell.com>
References: <1268143623-22361-1-git-send-email-saeed@marvell.com>
Message-ID: <1268143623-22361-2-git-send-email-saeed@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Saeed Bishara <saeed@marvell.com>
---
 arch/arm/mm/proc-v7.S |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mm/proc-v7.S b/arch/arm/mm/proc-v7.S
index 7aaf88a..06cc36c 100644
--- a/arch/arm/mm/proc-v7.S
+++ b/arch/arm/mm/proc-v7.S
@@ -52,6 +52,11 @@ ENTRY(cpu_v7_proc_fin)
 	bic	r0, r0, #0x1000			@ ...i............
 	bic	r0, r0, #0x0006			@ .............ca.
 	mcr	p15, 0, r0, c1, c0, 0		@ disable caches
+#ifdef CONFIG_OUTER_CACHE
+	mrc	p15, 0, r0, c1, c0, 1
+	bic	r0, r0, #0x2
+	mcr	p15, 0, r0, c1, c0, 1		@ disable L2 cache
+#endif
 	ldmfd	sp!, {pc}
 ENDPROC(cpu_v7_proc_fin)
 
-- 
1.6.0.4
