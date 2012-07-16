From: ccross@android.com (Colin Cross)
Date: Mon, 16 Jul 2012 11:18:00 -0700
Subject: [PATCH] ARM: vfp: only clear vfp state for current cpu in
 vfp_pm_suspend
Message-ID: <1342462680-18548-1-git-send-email-ccross@android.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

vfp_pm_suspend runs on each cpu, only clear the hardware state
pointer for the current cpu.  Prevents a possible crash if one
cpu clears the hw state pointer when another cpu has already
checked if it is valid.

Signed-off-by: Colin Cross <ccross@android.com>
---
 arch/arm/vfp/vfpmodule.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/vfp/vfpmodule.c b/arch/arm/vfp/vfpmodule.c
index ce55f05..fb849d0 100644
--- a/arch/arm/vfp/vfpmodule.c
+++ b/arch/arm/vfp/vfpmodule.c
@@ -466,7 +466,7 @@ static int vfp_pm_suspend(void)
 	}
 
 	/* clear any information we had about last context state */
-	memset(vfp_current_hw_state, 0, sizeof(vfp_current_hw_state));
+	vfp_current_hw_state[ti->cpu] = NULL;
 
 	return 0;
 }
-- 
1.7.7.3
