From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 28 Jan 2010 10:18:09 +0000
Subject: [PATCH] ARM: Correct the FPSCR bits setting when raising exceptions
Message-ID: <20100128101809.7752.76832.stgit@pc1117.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit c98929c07a removed the clearing of the FPSCR[31:28] bits from the
vfp_raise_exceptions() function and the new bits are or'ed with the old
FPSCR bits leading to unexpected results (the original commit was
referring to the cumulative bits - FPSCR[4:0]).

Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Reported-by: Tom Hameenanttila <tmhameen@marvell.com>
---
 arch/arm/vfp/vfpmodule.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/arch/arm/vfp/vfpmodule.c b/arch/arm/vfp/vfpmodule.c
index f60a540..a63c4be 100644
--- a/arch/arm/vfp/vfpmodule.c
+++ b/arch/arm/vfp/vfpmodule.c
@@ -197,10 +197,13 @@ static void vfp_raise_exceptions(u32 exceptions, u32 inst, u32 fpscr, struct pt_
 	}
 
 	/*
-	 * Update the FPSCR with the additional exception flags.
+	 * If any of the status flags are set, update the FPSCR.
 	 * Comparison instructions always return at least one of
 	 * these flags set.
 	 */
+	if (exceptions & (FPSCR_N|FPSCR_Z|FPSCR_C|FPSCR_V))
+		fpscr &= ~(FPSCR_N|FPSCR_Z|FPSCR_C|FPSCR_V);
+
 	fpscr |= exceptions;
 
 	fmxr(FPSCR, fpscr);
