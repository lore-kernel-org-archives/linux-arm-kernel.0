From: dwalker@codeaurora.org (Daniel Walker)
Date: Thu, 28 Jan 2010 14:59:31 -0800
Subject: [RFC PATCH 06/12] arm: msm: set L2CR1 to enable prefetch and burst on
	Scorpion.
Message-ID: <1264719577-5436-7-git-send-email-dwalker@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Larry Bassel <lbassel@quicinc.com>

This change improves the following LMBench benchmarks
by over 15%:

System Call Latency
Signal Handling Latency
Fault Latency
Inter-process Communication Latency
Inter-process Communication Bandwidth
Random Number Generation Latency

Acked-by: Steve Muckle <smuckle@quicinc.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Shilimkar, Santosh <santosh.shilimkar@ti.com>
Cc: Nicolas Pitre <nico@fluxnic.net>
Cc: Bohan, Michael <mbohan@quicinc.com>
Signed-off-by: Larry Bassel <lbassel@quicinc.com>
Signed-off-by: Daniel Walker <dwalker@codeaurora.org>
---
 arch/arm/mm/proc-v7.S |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mm/proc-v7.S b/arch/arm/mm/proc-v7.S
index 7aaf88a..3ca5d29 100644
--- a/arch/arm/mm/proc-v7.S
+++ b/arch/arm/mm/proc-v7.S
@@ -2,6 +2,7 @@
  *  linux/arch/arm/mm/proc-v7.S
  *
  *  Copyright (C) 2001 Deep Blue Solutions Ltd.
+ *  Copyright (c) 2009, Code Aurora Forum. All rights reserved.
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
@@ -242,6 +243,10 @@ __v7_setup:
 	mcr	p15, 0, r4, c2, c0, 1		@ load TTB1
 	mov	r10, #0x1f			@ domains 0, 1 = manager
 	mcr	p15, 0, r10, c3, c0, 0		@ load domain access register
+#ifdef CONFIG_ARCH_MSM_SCORPION
+	mov     r0, #0x77
+	mcr     p15, 3, r0, c15, c0, 3          @ set L2CR1
+#endif
 	/*
 	 * Memory region attributes with SCTLR.TRE=1
 	 *
-- 
1.6.3.3
