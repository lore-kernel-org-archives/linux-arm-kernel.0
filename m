From: xerofoify@gmail.com (Nicholas Krause)
Date: Sat, 19 Dec 2015 14:43:07 -0500
Subject: [PATCH] mpt3sas:Fix missing error checks for calls to
 _transport_phy_reset in mpt3sas_transport.c
Message-ID: <1450554187-14812-1-git-send-email-xerofoify@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds the missing error checks and paths for functions that
call _transport_phy_reset and do not correctly check that the
call to this particular function has succeeded by returning zero
in the file, mpt3sas_transport.c.

Signed-off-by: Nicholas Krause <xerofoify@gmail.com>
---
 drivers/scsi/mpt3sas/mpt3sas_transport.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/mpt3sas/mpt3sas_transport.c b/drivers/scsi/mpt3sas/mpt3sas_transport.c
index ca36d7e..bff5a11 100644
--- a/drivers/scsi/mpt3sas/mpt3sas_transport.c
+++ b/drivers/scsi/mpt3sas/mpt3sas_transport.c
@@ -1766,7 +1766,7 @@ _transport_phy_enable(struct sas_phy *phy, int enable)
 
 	/* link reset */
 	if (enable)
-		_transport_phy_reset(phy, 0);
+		rc = _transport_phy_reset(phy, 0);
 
  out:
 	kfree(sas_iounit_pg1);
@@ -1870,7 +1870,9 @@ _transport_phy_speed(struct sas_phy *phy, struct sas_phy_linkrates *rates)
 	}
 
 	/* link reset */
-	_transport_phy_reset(phy, 0);
+	rc = _transport_phy_reset(phy, 0);
+	if (rc)
+		goto out;
 
 	/* read phy page 0, then update the rates in the sas transport phy */
 	if (!mpt3sas_config_get_phy_pg0(ioc, &mpi_reply, &phy_pg0,
-- 
2.5.0
