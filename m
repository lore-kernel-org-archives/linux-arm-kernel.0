From: sboyd@codeaurora.org (Stephen Boyd)
Date: Mon,  4 Aug 2014 18:31:44 -0700
Subject: [PATCH 2/8] msm: scm: Get cacheline size from CTR
In-Reply-To: <1407202310-3359-1-git-send-email-sboyd@codeaurora.org>
References: <1407202310-3359-1-git-send-email-sboyd@codeaurora.org>
Message-ID: <1407202310-3359-3-git-send-email-sboyd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Instead of hardcoding the cacheline size as 32, get the cacheline
size from the CTR register.

Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
---
 arch/arm/mach-qcom/scm.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-qcom/scm.c b/arch/arm/mach-qcom/scm.c
index 820c72165e19..c08786ebf116 100644
--- a/arch/arm/mach-qcom/scm.c
+++ b/arch/arm/mach-qcom/scm.c
@@ -27,9 +27,6 @@
 
 #include "scm.h"
 
-/* Cache line size for msm8x60 */
-#define CACHELINESIZE 32
-
 #define SCM_ENOMEM		-5
 #define SCM_EOPNOTSUPP		-4
 #define SCM_EINVAL_ADDR		-3
@@ -214,13 +211,18 @@ static int __scm_call(const struct scm_command *cmd)
 
 static void scm_inv_range(unsigned long start, unsigned long end)
 {
-	start = round_down(start, CACHELINESIZE);
-	end = round_up(end, CACHELINESIZE);
+	u32 cacheline_size, ctr;
+
+	asm volatile("mrc p15, 0, %0, c0, c0, 1" : "=r" (ctr));
+	cacheline_size = 4 << ((ctr >> 16) & 0xf);
+
+	start = round_down(start, cacheline_size);
+	end = round_up(end, cacheline_size);
 	outer_inv_range(start, end);
 	while (start < end) {
 		asm ("mcr p15, 0, %0, c7, c6, 1" : : "r" (start)
 		     : "memory");
-		start += CACHELINESIZE;
+		start += cacheline_size;
 	}
 	dsb();
 	isb();
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
