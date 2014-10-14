From: sboyd@codeaurora.org (Stephen Boyd)
Date: Tue, 14 Oct 2014 06:48:57 -0700
Subject: [PATCH v2 1/3] ARM: vfp: Workaround bad MVFR1 register on some Kraits
In-Reply-To: <1413294539-22069-1-git-send-email-sboyd@codeaurora.org>
References: <1413294539-22069-1-git-send-email-sboyd@codeaurora.org>
Message-ID: <1413294539-22069-2-git-send-email-sboyd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Certain versions of the Krait processor don't report that they
support the fused multiply accumulate instruction via the MVFR1
register despite the fact that they actually do. Unfortunately we
use this register to identify support for VFPv4. Override the
hwcap on all Krait processors to indicate support for VFPv4 to
workaround this.

Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
---
 arch/arm/mm/proc-v7.S | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mm/proc-v7.S b/arch/arm/mm/proc-v7.S
index b5d67db20897..2e78b4b2538f 100644
--- a/arch/arm/mm/proc-v7.S
+++ b/arch/arm/mm/proc-v7.S
@@ -593,9 +593,10 @@ __krait_proc_info:
 	/*
 	 * Some Krait processors don't indicate support for SDIV and UDIV
 	 * instructions in the ARM instruction set, even though they actually
-	 * do support them.
+	 * do support them. They also don't indicate support for fused multiply
+	 * instructions even though they actually do support them.
 	 */
-	__v7_proc __v7_setup, hwcaps = HWCAP_IDIV
+	__v7_proc __v7_setup, hwcaps = HWCAP_IDIV | HWCAP_VFPv4
 	.size	__krait_proc_info, . - __krait_proc_info
 
 	/*
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
