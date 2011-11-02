From: davidb@codeaurora.org (David Brown)
Date: Wed,  2 Nov 2011 11:36:04 -0700
Subject: [RFC PATCH 07/34] msm: clock-debug: Use clk_enable()/clk_disable()
	directly
In-Reply-To: <1320258991-22325-1-git-send-email-davidb@codeaurora.org>
References: <1320258991-22325-1-git-send-email-davidb@codeaurora.org>
Message-ID: <1320258991-22325-8-git-send-email-davidb@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Stephen Boyd <sboyd@codeaurora.org>

The debugfs operations currently sidestep the top level
enable/disable code and directly call the ops->enable/disable
functions. This won't work well when we generically enable parent
clocks in the toplevel clock code. Therefore call enable/disable
directly from the debugfs code to get proper parent enabling.

Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
Signed-off-by: David Brown <davidb@codeaurora.org>
---
 arch/arm/mach-msm/clock-debug.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-msm/clock-debug.c b/arch/arm/mach-msm/clock-debug.c
index bddcbc9..a8db06d 100644
--- a/arch/arm/mach-msm/clock-debug.c
+++ b/arch/arm/mach-msm/clock-debug.c
@@ -55,9 +55,9 @@ static int clock_debug_enable_set(void *data, u64 val)
 	int rc = 0;
 
 	if (val)
-		rc = clock->ops->enable(clock);
+		rc = clk_enable(clock);
 	else
-		clock->ops->disable(clock);
+		clk_disable(clock);
 
 	return rc;
 }
-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
