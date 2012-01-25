From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 25 Jan 2012 14:31:46 +0000
Subject: [PATCH 05/33] MFD: ucb1x00-core: fix missing restore of io output
 data on resume
In-Reply-To: <20120125143000.GF1068@n2100.arm.linux.org.uk>
References: <20120125143000.GF1068@n2100.arm.linux.org.uk>
Message-ID: <E1Rq3t4-0000Xv-MA@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We were not restoring the UCB1x00 gpio output data on resume, resulting
in incorrect GPIO output data after a resume.  Add the missing register
write.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/mfd/ucb1x00-core.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/mfd/ucb1x00-core.c b/drivers/mfd/ucb1x00-core.c
index b281217..8ebda97 100644
--- a/drivers/mfd/ucb1x00-core.c
+++ b/drivers/mfd/ucb1x00-core.c
@@ -687,6 +687,7 @@ static int ucb1x00_resume(struct mcp *mcp)
 	struct ucb1x00 *ucb = mcp_get_drvdata(mcp);
 	struct ucb1x00_dev *dev;
 
+	ucb1x00_reg_write(ucb, UCB_IO_DATA, ucb->io_out);
 	ucb1x00_reg_write(ucb, UCB_IO_DIR, ucb->io_dir);
 	mutex_lock(&ucb1x00_mutex);
 	list_for_each_entry(dev, &ucb->devs, dev_node) {
-- 
1.7.4.4
