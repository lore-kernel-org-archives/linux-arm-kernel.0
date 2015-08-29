From: stefan@agner.ch (Stefan Agner)
Date: Fri, 28 Aug 2015 18:08:19 -0700
Subject: [PATCH] remoteproc: report error if resource table doesn't exist
Message-ID: <1440810499-24327-1-git-send-email-stefan@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently, if the resource table is completely missing in the
firmware, powering up the remoteproc fails silently. Add a message
indicating that the resource table is missing in the firmware.

Signed-off-by: Stefan Agner <stefan@agner.ch>
---
Hi Ohad,

I am currently working on remoteproc support for Freescale Vybrid's
secondary Cortex-M4 core. I stumbled upon this rough spot since the
little test firmware I am using now does not have a resource table
yet.

This also opens up a more general question: Is it mandatory to have
a resource table in the firmware? Theoretically a remoteproc could
also work completely independent, all what would be used from the
remoteproc framework is the loading and starting capabilities...

--
Stefan

 drivers/remoteproc/remoteproc_core.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
index 8b3130f..29db8b3 100644
--- a/drivers/remoteproc/remoteproc_core.c
+++ b/drivers/remoteproc/remoteproc_core.c
@@ -823,8 +823,10 @@ static int rproc_fw_boot(struct rproc *rproc, const struct firmware *fw)
 
 	/* look for the resource table */
 	table = rproc_find_rsc_table(rproc, fw, &tablesz);
-	if (!table)
+	if (!table) {
+		dev_err(dev, "Failed to find resource table\n");
 		goto clean_up;
+	}
 
 	/* Verify that resource table in loaded fw is unchanged */
 	if (rproc->table_csum != crc32(0, table, tablesz)) {
-- 
2.5.0
