From: laurentiu.tudor@nxp.com (laurentiu.tudor at nxp.com)
Date: Wed, 19 Jul 2017 14:42:29 +0300
Subject: [PATCH v3 5/8] staging: fsl-mc: fix formating of phys_addr_t on 32
 bits
In-Reply-To: <20170719114232.8347-1-laurentiu.tudor@nxp.com>
References: <20170719114232.8347-1-laurentiu.tudor@nxp.com>
Message-ID: <20170719114232.8347-6-laurentiu.tudor@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Laurentiu Tudor <laurentiu.tudor@nxp.com>

Use correct format specifier for phys_addr_t variables (%pa) instead
of %llx. This fixes these warnings on 32 bit targets:
 "format '%llx' expects argument of type 'long long unsigned int',
  but argument 4 has type 'phys_addr_t' [-Wformat=]"

Signed-off-by: Laurentiu Tudor <laurentiu.tudor@nxp.com>
Acked-by: Arnd Bergmann <arnd@arndb.de>
---
Notes:
    -v3
      -no changes
    -v2
      -no changes

 drivers/staging/fsl-mc/bus/mc-io.c  |  8 ++++----
 drivers/staging/fsl-mc/bus/mc-sys.c | 12 ++++++------
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/staging/fsl-mc/bus/mc-io.c b/drivers/staging/fsl-mc/bus/mc-io.c
index 35221a17..4e6f99a 100644
--- a/drivers/staging/fsl-mc/bus/mc-io.c
+++ b/drivers/staging/fsl-mc/bus/mc-io.c
@@ -129,8 +129,8 @@ int __must_check fsl_create_mc_io(struct device *dev,
 				      "mc_portal");
 	if (!res) {
 		dev_err(dev,
-			"devm_request_mem_region failed for MC portal %#llx\n",
-			mc_portal_phys_addr);
+			"devm_request_mem_region failed for MC portal %pa\n",
+			&mc_portal_phys_addr);
 		return -EBUSY;
 	}
 
@@ -139,8 +139,8 @@ int __must_check fsl_create_mc_io(struct device *dev,
 						   mc_portal_size);
 	if (!mc_portal_virt_addr) {
 		dev_err(dev,
-			"devm_ioremap_nocache failed for MC portal %#llx\n",
-			mc_portal_phys_addr);
+			"devm_ioremap_nocache failed for MC portal %pa\n",
+			&mc_portal_phys_addr);
 		return -ENXIO;
 	}
 
diff --git a/drivers/staging/fsl-mc/bus/mc-sys.c b/drivers/staging/fsl-mc/bus/mc-sys.c
index 012abd5..195d9f3 100644
--- a/drivers/staging/fsl-mc/bus/mc-sys.c
+++ b/drivers/staging/fsl-mc/bus/mc-sys.c
@@ -196,8 +196,8 @@ static int mc_polling_wait_preemptible(struct fsl_mc_io *mc_io,
 
 		if (time_after_eq(jiffies, jiffies_until_timeout)) {
 			dev_dbg(mc_io->dev,
-				"MC command timed out (portal: %#llx, dprc handle: %#x, command: %#x)\n",
-				 mc_io->portal_phys_addr,
+				"MC command timed out (portal: %pa, dprc handle: %#x, command: %#x)\n",
+				 &mc_io->portal_phys_addr,
 				 (unsigned int)mc_cmd_hdr_read_token(cmd),
 				 (unsigned int)mc_cmd_hdr_read_cmdid(cmd));
 
@@ -236,8 +236,8 @@ static int mc_polling_wait_atomic(struct fsl_mc_io *mc_io,
 		timeout_usecs -= MC_CMD_COMPLETION_POLLING_MAX_SLEEP_USECS;
 		if (timeout_usecs == 0) {
 			dev_dbg(mc_io->dev,
-				"MC command timed out (portal: %#llx, dprc handle: %#x, command: %#x)\n",
-				 mc_io->portal_phys_addr,
+				"MC command timed out (portal: %pa, dprc handle: %#x, command: %#x)\n",
+				 &mc_io->portal_phys_addr,
 				 (unsigned int)mc_cmd_hdr_read_token(cmd),
 				 (unsigned int)mc_cmd_hdr_read_cmdid(cmd));
 
@@ -290,8 +290,8 @@ int mc_send_command(struct fsl_mc_io *mc_io, struct mc_command *cmd)
 
 	if (status != MC_CMD_STATUS_OK) {
 		dev_dbg(mc_io->dev,
-			"MC command failed: portal: %#llx, dprc handle: %#x, command: %#x, status: %s (%#x)\n",
-			 mc_io->portal_phys_addr,
+			"MC command failed: portal: %pa, dprc handle: %#x, command: %#x, status: %s (%#x)\n",
+			 &mc_io->portal_phys_addr,
 			 (unsigned int)mc_cmd_hdr_read_token(cmd),
 			 (unsigned int)mc_cmd_hdr_read_cmdid(cmd),
 			 mc_status_to_string(status),
-- 
2.9.4
