From: linux@roeck-us.net (Guenter Roeck)
Date: Mon,  6 Oct 2014 22:28:36 -0700
Subject: [PATCH 34/44] ia64: Register with kernel poweroff handler
In-Reply-To: <1412659726-29957-1-git-send-email-linux@roeck-us.net>
References: <1412659726-29957-1-git-send-email-linux@roeck-us.net>
Message-ID: <1412659726-29957-35-git-send-email-linux@roeck-us.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Register with kernel poweroff handler instead of setting pm_power_off
directly. Register with lower priority of 64 to reflect that the call
is expected to be replaced at some point.

Cc: Tony Luck <tony.luck@intel.com>
Cc: Fenghua Yu <fenghua.yu@intel.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 arch/ia64/sn/kernel/setup.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/ia64/sn/kernel/setup.c b/arch/ia64/sn/kernel/setup.c
index 36182c8..6c83425 100644
--- a/arch/ia64/sn/kernel/setup.c
+++ b/arch/ia64/sn/kernel/setup.c
@@ -488,12 +488,12 @@ void __init sn_setup(char **cmdline_p)
 	sn_timer_init();
 
 	/*
-	 * set pm_power_off to a SAL call to allow
+	 * set poweroff handler to a SAL call to allow
 	 * sn machines to power off. The SAL call can be replaced
 	 * by an ACPI interface call when ACPI is fully implemented
 	 * for sn.
 	 */
-	pm_power_off = ia64_sn_power_down;
+	register_poweroff_handler_simple(ia64_sn_power_down, 64);
 	current->thread.flags |= IA64_THREAD_MIGRATION;
 }
 
-- 
1.9.1
