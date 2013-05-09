From: skannan@codeaurora.org (Saravana Kannan)
Date: Wed,  8 May 2013 22:18:46 -0700
Subject: [PATCH 3/3] regulator: core: Disable unused regulators after deferred
 probing is done
In-Reply-To: <1368076726-11492-1-git-send-email-skannan@codeaurora.org>
References: <1368076726-11492-1-git-send-email-skannan@codeaurora.org>
Message-ID: <1368076726-11492-4-git-send-email-skannan@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

With deferred probing, late_initcall() is too soon to declare a regulator
as unused. Wait for deferred probing to finish before declaring a regulator
as unused.

Signed-off-by: Saravana Kannan <skannan@codeaurora.org>
---
 drivers/regulator/core.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index e3661c2..11a0508 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -3812,6 +3812,8 @@ static int __init regulator_init_complete(void)
 	if (of_have_populated_dt())
 		has_full_constraints = true;
 
+	wait_for_init_deferred_probe_done();
+
 	mutex_lock(&regulator_list_mutex);
 
 	/* If we have a full configuration then disable any regulators
@@ -3864,4 +3866,4 @@ unlock:
 
 	return 0;
 }
-late_initcall(regulator_init_complete);
+late_initcall_sync(regulator_init_complete);
-- 
1.7.8.3

The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
