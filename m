From: linux@roeck-us.net (Guenter Roeck)
Date: Mon, 20 Oct 2014 21:12:52 -0700
Subject: [PATCH v2 36/47] arm64: psci: Register with kernel poweroff handler
In-Reply-To: <1413864783-3271-1-git-send-email-linux@roeck-us.net>
References: <1413864783-3271-1-git-send-email-linux@roeck-us.net>
Message-ID: <1413864783-3271-37-git-send-email-linux@roeck-us.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Register with kernel poweroff handler instead of setting pm_power_off
directly.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
- Use define to specify poweroff handler priority

 arch/arm64/kernel/psci.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/psci.c b/arch/arm64/kernel/psci.c
index 866c1c8..150ac1c 100644
--- a/arch/arm64/kernel/psci.c
+++ b/arch/arm64/kernel/psci.c
@@ -359,7 +359,8 @@ static int __init psci_0_2_init(struct device_node *np)
 
 	arm_pm_restart = psci_sys_reset;
 
-	pm_power_off = psci_sys_poweroff;
+	register_power_off_handler_simple(psci_sys_poweroff,
+					  POWEROFF_PRIORITY_DEFAULT);
 
 out_put_node:
 	of_node_put(np);
-- 
1.9.1
