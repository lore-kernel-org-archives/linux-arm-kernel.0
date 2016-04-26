From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 26 Apr 2016 02:16:17 +0200
Subject: [PATCH] drivers: firmware: psci: make two helper functions inline
Message-ID: <1461629793-3856390-1-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The previous patch marked these two as 'static' which showed that they
are sometimes unused:

drivers/firmware/psci.c:103:13: error: 'psci_power_state_is_valid' defined but not used [-Werror=unused-function]
 static bool psci_power_state_is_valid(u32 state)
drivers/firmware/psci.c:94:13: error: 'psci_power_state_loses_context' defined but not used [-Werror=unused-function]
 static bool psci_power_state_loses_context(u32 state)

This also marks the functions 'inline', which has the main effect of
silently ignoring them when they are unused. The compiler will typically
inline small static functions anyway, so this seems more appropriate
than using __maybe_unused, which would have the same result otherwise.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Fixes: 21e8868 ("drivers: firmware: psci: make two helper functions static")
---
 drivers/firmware/psci.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/firmware/psci.c b/drivers/firmware/psci.c
index 04f2ac5..89fcbdd 100644
--- a/drivers/firmware/psci.c
+++ b/drivers/firmware/psci.c
@@ -91,7 +91,7 @@ static inline bool psci_has_ext_power_state(void)
 				PSCI_1_0_FEATURES_CPU_SUSPEND_PF_MASK;
 }
 
-static bool psci_power_state_loses_context(u32 state)
+static inline bool psci_power_state_loses_context(u32 state)
 {
 	const u32 mask = psci_has_ext_power_state() ?
 					PSCI_1_0_EXT_POWER_STATE_TYPE_MASK :
@@ -100,7 +100,7 @@ static bool psci_power_state_loses_context(u32 state)
 	return state & mask;
 }
 
-static bool psci_power_state_is_valid(u32 state)
+static inline bool psci_power_state_is_valid(u32 state)
 {
 	const u32 valid_mask = psci_has_ext_power_state() ?
 			       PSCI_1_0_EXT_POWER_STATE_MASK :
-- 
2.7.0
