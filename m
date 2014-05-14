From: tony@atomide.com (Tony Lindgren)
Date: Tue, 13 May 2014 18:34:04 -0700
Subject: [PATCH 1/7] mfd: twl4030-power: Fix hang on reboot if sleep
 configuration was loaded earlier
In-Reply-To: <1400031250-29542-1-git-send-email-tony@atomide.com>
References: <1400031250-29542-1-git-send-email-tony@atomide.com>
Message-ID: <1400031250-29542-2-git-send-email-tony@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Looks like we can still hit the issue of wrong load order of
twl4030 configuration. If we have a sleep configuration loaded,
and do a warm reset, the device can hang while initializing the
wakeup12 sequence. We do have a warning message about wrong order
of twl4030 configuration, but in this case it does not help as
the sleep configuration was loaded during the previous boot and
the state of twl4030 is maintained throughout the warm reset.

Fix the issue by clearing any existing sleep configuration
before we load the warm reset configuration.

Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/mfd/twl4030-power.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/mfd/twl4030-power.c b/drivers/mfd/twl4030-power.c
index 96162b6..1b30d8a 100644
--- a/drivers/mfd/twl4030-power.c
+++ b/drivers/mfd/twl4030-power.c
@@ -421,6 +421,12 @@ static int load_twl4030_script(struct twl4030_script *tscript,
 			goto out;
 	}
 	if (tscript->flags & TWL4030_WAKEUP12_SCRIPT) {
+		/* Reset any existing sleep script to avoid hangs on reboot */
+		err = twl_i2c_write_u8(TWL_MODULE_PM_MASTER, END_OF_SCRIPT,
+				       R_SEQ_ADD_A2S);
+		if (err)
+			goto out;
+
 		err = twl4030_config_wakeup12_sequence(address);
 		if (err)
 			goto out;
-- 
1.8.1.1
