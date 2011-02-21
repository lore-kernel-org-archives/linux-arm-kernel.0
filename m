From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Mon, 21 Feb 2011 18:49:24 +0530
Subject: [PATCH 5/6] omap3: pm: Clear the SCTLR C bit in asm code to prevent
	data cache allocation
In-Reply-To: <1298294365-30770-1-git-send-email-santosh.shilimkar@ti.com>
References: <1298294365-30770-1-git-send-email-santosh.shilimkar@ti.com>
Message-ID: <1298294365-30770-6-git-send-email-santosh.shilimkar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On the newer ARM processors like CortexA8, CortexA9, the caches can be
speculatively loaded while they are getting flushed.

Clear the SCTLR C bit to prevent further data cache allocation as
part of cache clean routine

Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: Kevin Hilman <khilman@ti.com>
---
 arch/arm/mach-omap2/sleep34xx.S |   12 ++++++++++++
 1 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/sleep34xx.S b/arch/arm/mach-omap2/sleep34xx.S
index 28baeb2..1e723bb 100644
--- a/arch/arm/mach-omap2/sleep34xx.S
+++ b/arch/arm/mach-omap2/sleep34xx.S
@@ -224,6 +224,12 @@ l1_logic_lost:
 	mrc	p15, 0, r4, c1, c0, 0	@ save control register
 	stmia	r8!, {r4}
 
+	/* Clear the SCTLR C bit to prevent further data cache allocation */
+	mrc	p15, 0, r0, c1, c0, 0
+	bic	r0, r0, #(1 << 2)	@ Disable the C bit
+	mcr	p15, 0, r0, c1, c0, 0
+	isb
+
 clean_caches:
 	/*
 	 * jump out to kernel flush routine
@@ -270,6 +276,12 @@ omap3_do_wfi:
 	nop
 	bl wait_sdrc_ok
 
+	mrc	p15, 0, r0, c1, c0, 0
+	tst	r0, #(1 << 2)		@ Check C bit enabled?
+	orreq	r0, r0, #(1 << 2)	@ Enable the C bit if cleared
+	mcreq	p15, 0, r0, c1, c0, 0
+	isb
+
 /*
  * ===================================
  * == Exit point from non-OFF modes ==
-- 
1.6.0.4
