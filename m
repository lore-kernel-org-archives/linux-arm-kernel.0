From: nathan_lynch@mentor.com (Nathan Lynch)
Date: Mon,  3 Feb 2014 13:48:52 -0600
Subject: [PATCH 2/2] arm64: vdso: update wtm fields for CLOCK_MONOTONIC_COARSE
In-Reply-To: <1391456932-17815-1-git-send-email-nathan_lynch@mentor.com>
References: <1391456932-17815-1-git-send-email-nathan_lynch@mentor.com>
Message-ID: <1391456932-17815-3-git-send-email-nathan_lynch@mentor.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Update wall-to-monotonic fields in the VDSO data page
unconditionally.  These are used to service CLOCK_MONOTONIC_COARSE,
which is not guarded by use_syscall.

Signed-off-by: Nathan Lynch <nathan_lynch@mentor.com>
---
 arch/arm64/kernel/vdso.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kernel/vdso.c b/arch/arm64/kernel/vdso.c
index 65d40cf6945a..a7149cae1615 100644
--- a/arch/arm64/kernel/vdso.c
+++ b/arch/arm64/kernel/vdso.c
@@ -238,6 +238,8 @@ void update_vsyscall(struct timekeeper *tk)
 	vdso_data->use_syscall			= use_syscall;
 	vdso_data->xtime_coarse_sec		= xtime_coarse.tv_sec;
 	vdso_data->xtime_coarse_nsec		= xtime_coarse.tv_nsec;
+	vdso_data->wtm_clock_sec		= tk->wall_to_monotonic.tv_sec;
+	vdso_data->wtm_clock_nsec		= tk->wall_to_monotonic.tv_nsec;
 
 	if (!use_syscall) {
 		vdso_data->cs_cycle_last	= tk->clock->cycle_last;
@@ -245,8 +247,6 @@ void update_vsyscall(struct timekeeper *tk)
 		vdso_data->xtime_clock_nsec	= tk->xtime_nsec;
 		vdso_data->cs_mult		= tk->mult;
 		vdso_data->cs_shift		= tk->shift;
-		vdso_data->wtm_clock_sec	= tk->wall_to_monotonic.tv_sec;
-		vdso_data->wtm_clock_nsec	= tk->wall_to_monotonic.tv_nsec;
 	}
 
 	smp_wmb();
-- 
1.8.3.1
