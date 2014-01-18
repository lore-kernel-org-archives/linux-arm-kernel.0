From: hdegoede@redhat.com (Hans de Goede)
Date: Sun, 19 Jan 2014 00:48:46 +0100
Subject: [RFC v3 04/13] ahci-platform: Undo pdata->resume on resume failure
In-Reply-To: <1390088935-7193-1-git-send-email-hdegoede@redhat.com>
References: <1390088935-7193-1-git-send-email-hdegoede@redhat.com>
Message-ID: <1390088935-7193-5-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When the ahci_resume fails the error handling code tries to undo all changes
made, but it was not undoing the results of pdata->resume.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/ata/ahci_platform.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/ata/ahci_platform.c b/drivers/ata/ahci_platform.c
index dc1ef73..41720cb 100644
--- a/drivers/ata/ahci_platform.c
+++ b/drivers/ata/ahci_platform.c
@@ -307,7 +307,7 @@ static int ahci_resume(struct device *dev)
 	if (dev->power.power_state.event == PM_EVENT_SUSPEND) {
 		rc = ahci_reset_controller(host);
 		if (rc)
-			goto disable_unprepare_clk;
+			goto pdata_suspend;
 
 		ahci_init_controller(host);
 	}
@@ -316,6 +316,9 @@ static int ahci_resume(struct device *dev)
 
 	return 0;
 
+pdata_suspend:
+	if (pdata && pdata->suspend)
+		pdata->suspend(dev);
 disable_unprepare_clk:
 	if (!IS_ERR(hpriv->clk))
 		clk_disable_unprepare(hpriv->clk);
-- 
1.8.4.2
