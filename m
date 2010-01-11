From: dwalker@codeaurora.org (Daniel Walker)
Date: Mon, 11 Jan 2010 14:47:26 -0800
Subject: [RFC 07/18] arm: mm: retry on QSD icache parity errors
In-Reply-To: <1263250057-26692-1-git-send-email-dwalker@codeaurora.org>
References: <1263250057-26692-1-git-send-email-dwalker@codeaurora.org>
Message-ID: <1263250057-26692-8-git-send-email-dwalker@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Steve Muckle <smuckle@quicinc.com>

Parity errors in the icache on QSD can be worked around either by
retrying the access, or invalidating the icache. The whole icache
must be invalidated since the data abort is imprecise (the faulting
address is not known).

Signed-off-by: Steve Muckle <smuckle@quicinc.com>
Signed-off-by: Daniel Walker <dwalker@codeaurora.org>
---
 arch/arm/mm/fault.c |   36 +++++++++++++++++++++++++++++++++++-
 1 files changed, 35 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mm/fault.c b/arch/arm/mm/fault.c
index 10e0680..bea3e75 100644
--- a/arch/arm/mm/fault.c
+++ b/arch/arm/mm/fault.c
@@ -2,6 +2,7 @@
  *  linux/arch/arm/mm/fault.c
  *
  *  Copyright (C) 1995  Linus Torvalds
+ *  Copyright (c) 2009, Code Aurora Forum. All rights reserved.
  *  Modifications for ARM processor (c) 1995-2004 Russell King
  *
  * This program is free software; you can redistribute it and/or modify
@@ -442,6 +443,39 @@ do_bad(unsigned long addr, unsigned int fsr, struct pt_regs *regs)
 	return 1;
 }
 
+static int
+do_imprecise_ext(unsigned long addr, unsigned int fsr, struct pt_regs *regs)
+{
+#ifdef CONFIG_ARCH_MSM_SCORPION
+	unsigned int regval;
+	static unsigned char flush_toggle;
+
+	asm("mrc p15, 0, %0, c5, c1, 0\n" /* read adfsr for fault status */
+	    : "=r" (regval));
+	if (regval == 0x2) {
+		/* Fault was caused by icache parity error. Alternate
+		 * simply retrying the access and flushing the icache. */
+		flush_toggle ^= 1;
+		if (flush_toggle)
+			asm("mcr p15, 0, %0, c7, c5, 0\n"
+			    :
+			    : "r" (regval)); /* input value is ignored */
+		/* Clear fault in EFSR. */
+		asm("mcr p15, 7, %0, c15, c0, 1\n"
+		    :
+		    : "r" (regval));
+		/* Clear fault in ADFSR. */
+		regval = 0;
+		asm("mcr p15, 0, %0, c5, c1, 0\n"
+		    :
+		    : "r" (regval));
+		return 0;
+	}
+#endif
+
+	return 1;
+}
+
 static struct fsr_info {
 	int	(*fn)(unsigned long addr, unsigned int fsr, struct pt_regs *regs);
 	int	sig;
@@ -479,7 +513,7 @@ static struct fsr_info {
 	{ do_bad,		SIGBUS,  0,		"unknown 19"			   },
 	{ do_bad,		SIGBUS,  0,		"lock abort"			   }, /* xscale */
 	{ do_bad,		SIGBUS,  0,		"unknown 21"			   },
-	{ do_bad,		SIGBUS,  BUS_OBJERR,	"imprecise external abort"	   }, /* xscale */
+	{ do_imprecise_ext,	SIGBUS,  BUS_OBJERR,	"imprecise external abort"	   }, /* xscale */
 	{ do_bad,		SIGBUS,  0,		"unknown 23"			   },
 	{ do_bad,		SIGBUS,  0,		"dcache parity error"		   }, /* xscale */
 	{ do_bad,		SIGBUS,  0,		"unknown 25"			   },
-- 
1.6.3.3
