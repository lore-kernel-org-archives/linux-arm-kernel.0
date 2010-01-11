From: dwalker@codeaurora.org (Daniel Walker)
Date: Mon, 11 Jan 2010 14:47:27 -0800
Subject: [RFC 08/18] arm: msm: set L2CR1 to enable prefetch and burst on
	Scorpion.
In-Reply-To: <1263250057-26692-1-git-send-email-dwalker@codeaurora.org>
References: <1263250057-26692-1-git-send-email-dwalker@codeaurora.org>
Message-ID: <1263250057-26692-9-git-send-email-dwalker@codeaurora.org>
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
Signed-off-by: Larry Bassel <lbassel@quicinc.com>
Signed-off-by: Daniel Walker <dwalker@codeaurora.org>
---
 arch/arm/mm/proc-v7.S |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mm/proc-v7.S b/arch/arm/mm/proc-v7.S
index 3a28521..b331f23 100644
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
@@ -237,6 +238,10 @@ __v7_setup:
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
