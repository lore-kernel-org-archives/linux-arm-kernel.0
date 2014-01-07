From: hdegoede@redhat.com (Hans de Goede)
Date: Tue,  7 Jan 2014 18:57:32 +0100
Subject: [PATCH v2 2/2] phy-core: Don't propagate -ENOSUPP from
 phy_pm_runtime_get_sync to caller
In-Reply-To: <1389117452-3272-1-git-send-email-hdegoede@redhat.com>
References: <1389117452-3272-1-git-send-email-hdegoede@redhat.com>
Message-ID: <1389117452-3272-3-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The phy-core allows phy_init and phy_power_on to be called multiple times,
but before this patch -ENOSUPP from phy_pm_runtime_get_sync would be
propagated to the caller for the 2nd and later calls.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/phy/phy-core.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/phy/phy-core.c b/drivers/phy/phy-core.c
index 86a248b..4ea2987 100644
--- a/drivers/phy/phy-core.c
+++ b/drivers/phy/phy-core.c
@@ -161,6 +161,8 @@ int phy_init(struct phy *phy)
 			dev_err(&phy->dev, "phy init failed --> %d\n", ret);
 			goto out;
 		}
+	} else {
+		ret = 0; /* Override possible ret == -ENOTSUPP */
 	}
 
 out:
@@ -209,6 +211,8 @@ int phy_power_on(struct phy *phy)
 			dev_err(&phy->dev, "phy poweron failed --> %d\n", ret);
 			goto out;
 		}
+	} else {
+		ret = 0; /* Override possible ret == -ENOTSUPP */
 	}
 
 out:
-- 
1.8.4.2
