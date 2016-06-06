From: sudeep.holla@arm.com (Sudeep Holla)
Date: Mon,  6 Jun 2016 16:36:04 +0100
Subject: [PATCH 1/3] firmware: arm_scpi: remove dvfs_get packed structure
Message-ID: <1465227366-12192-1-git-send-email-sudeep.holla@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

dvfs_get packed structure is used to read the DVFS/OPP index from the
firmware. It just contains a single byte that needs no packing making
the whole structure defination unnecessary.

This patch replaces the unnecessary dvfs_get packed structure with an
unsigned byte.

Cc: linux-arm-kernel at lists.infradead.org
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/firmware/arm_scpi.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/firmware/arm_scpi.c b/drivers/firmware/arm_scpi.c
index 7e3e595c9f30..279fb84f69e1 100644
--- a/drivers/firmware/arm_scpi.c
+++ b/drivers/firmware/arm_scpi.c
@@ -210,10 +210,6 @@ struct dvfs_info {
 	} opps[MAX_DVFS_OPPS];
 } __packed;

-struct dvfs_get {
-	u8 index;
-} __packed;
-
 struct dvfs_set {
 	u8 domain;
 	u8 index;
@@ -431,11 +427,11 @@ static int scpi_clk_set_val(u16 clk_id, unsigned long rate)
 static int scpi_dvfs_get_idx(u8 domain)
 {
 	int ret;
-	struct dvfs_get dvfs;
+	u8 dvfs_idx;

 	ret = scpi_send_message(SCPI_CMD_GET_DVFS, &domain, sizeof(domain),
-				&dvfs, sizeof(dvfs));
-	return ret ? ret : dvfs.index;
+				&dvfs_idx, sizeof(dvfs_idx));
+	return ret ? ret : dvfs_idx;
 }

 static int scpi_dvfs_set_idx(u8 domain, u8 index)
--
2.7.4
