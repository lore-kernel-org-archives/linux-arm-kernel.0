From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Thu, 16 Oct 2014 14:59:57 +0100
Subject: [PATCH 3/3] drivers: cpuidle: remove cpuidle-arm64 duplicate error
 messages
In-Reply-To: <1413467997-32131-1-git-send-email-lorenzo.pieralisi@arm.com>
References: <1413467997-32131-1-git-send-email-lorenzo.pieralisi@arm.com>
Message-ID: <1413467997-32131-3-git-send-email-lorenzo.pieralisi@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Current CPUidle driver for arm64 machines spits errors upon idle
state initialization and cpuidle driver registration failures.
These error messages are already printed in core code so there is
no need to print them again.

This patch removes the duplicate print messages from the cpuidle-arm64
driver.

Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
---
 drivers/cpuidle/cpuidle-arm64.c | 13 ++-----------
 1 file changed, 2 insertions(+), 11 deletions(-)

diff --git a/drivers/cpuidle/cpuidle-arm64.c b/drivers/cpuidle/cpuidle-arm64.c
index 50997ea..1b10f92e 100644
--- a/drivers/cpuidle/cpuidle-arm64.c
+++ b/drivers/cpuidle/cpuidle-arm64.c
@@ -104,11 +104,8 @@ static int __init arm64_idle_init(void)
 	 * reason to initialize the idle driver if only wfi is supported.
 	 */
 	ret = dt_init_idle_driver(drv, arm64_idle_state_match, 1);
-	if (ret <= 0) {
-		if (ret)
-			pr_err("failed to initialize idle states\n");
+	if (ret <= 0)
 		return ret ? : -ENODEV;
-	}
 
 	/*
 	 * Call arch CPU operations in order to initialize
@@ -122,12 +119,6 @@ static int __init arm64_idle_init(void)
 		}
 	}
 
-	ret = cpuidle_register(drv, NULL);
-	if (ret) {
-		pr_err("failed to register cpuidle driver\n");
-		return ret;
-	}
-
-	return 0;
+	return cpuidle_register(drv, NULL);
 }
 device_initcall(arm64_idle_init);
-- 
2.1.2
