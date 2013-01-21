From: lee.jones@linaro.org (Lee Jones)
Date: Mon, 21 Jan 2013 12:03:42 +0000
Subject: [PATCH 06/24] ab8500-chargalg: Update battery health on safety timer
 exp
In-Reply-To: <1358769840-4763-1-git-send-email-lee.jones@linaro.org>
References: <1358769840-4763-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1358769840-4763-7-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When the charging safety timer elapses, the battery health is
shown as "Good". This is misleading and also makes it difficult
to distinguish issues relating to discharging despite the fact
that the charger is still connected.

When in actual fact a safety timer elapse is an indication of a
fault in the battery. Here we make this clearer by reporting
POWER_SUPPLY_HEALTH_UNSPEC_FAILURE instead.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/power/abx500_chargalg.c |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/power/abx500_chargalg.c b/drivers/power/abx500_chargalg.c
index 830b2dd..2463fa0 100644
--- a/drivers/power/abx500_chargalg.c
+++ b/drivers/power/abx500_chargalg.c
@@ -1628,6 +1628,9 @@ static int abx500_chargalg_get_property(struct power_supply *psy,
 				val->intval = POWER_SUPPLY_HEALTH_COLD;
 			else
 				val->intval = POWER_SUPPLY_HEALTH_OVERHEAT;
+		} else if (di->charge_state == STATE_SAFETY_TIMER_EXPIRED ||
+			   di->charge_state == STATE_SAFETY_TIMER_EXPIRED_INIT) {
+			val->intval = POWER_SUPPLY_HEALTH_UNSPEC_FAILURE;
 		} else {
 			val->intval = POWER_SUPPLY_HEALTH_GOOD;
 		}
-- 
1.7.9.5
