From: jonathan.austin@arm.com (Jonathan Austin)
Date: Wed, 14 Aug 2013 18:23:06 +0100
Subject: [PATCH Resend 2/3] clocksource: Add missing dependency on CONFIG_OF
 for ARM_ARCH_TIMER
In-Reply-To: <1376500987-12797-1-git-send-email-jonathan.austin@arm.com>
References: <1376500987-12797-1-git-send-email-jonathan.austin@arm.com>
Message-ID: <1376500987-12797-3-git-send-email-jonathan.austin@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Initialisation of the ARM Arch timer requires data from the DT. There is no
fallback initialisation method and hence selecting ARM_ARCH_TIMER without OF
makes little sense.

Furthermore, doing so causes a build error because the of_* stubs for
!CONFIG_OF do not extend to all of the functions being used by this driver,
and will not be extended unless there are valid use-cases for them to be
(this is not a valid case).

Signed-off-by: Jonathan Austin <jonathan.austin@arm.com>
---
 drivers/clocksource/Kconfig |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
index b7b9b04..4348902 100644
--- a/drivers/clocksource/Kconfig
+++ b/drivers/clocksource/Kconfig
@@ -72,7 +72,8 @@ config CLKSRC_DBX500_PRCMU_SCHED_CLOCK
 
 config ARM_ARCH_TIMER
 	bool
-	select CLKSRC_OF if OF
+	depends on OF
+	select CLKSRC_OF
 
 config ARM_GLOBAL_TIMER
 	bool
-- 
1.7.9.5
