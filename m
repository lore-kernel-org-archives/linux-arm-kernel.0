From: spjoshi@codeaurora.org (Sarangdhar Joshi)
Date: Mon, 23 Jan 2017 17:53:18 -0800
Subject: [PATCH v2 1/2] remoteproc: Add RPROC_DELETED state
Message-ID: <1485222799-20769-1-git-send-email-spjoshi@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add new state RPROC_DELETED to handle synchronization
between rproc_del() and other operations on rproc. This
state represents the rproc device that has been "deleted".

CC: Loic Pallardy <loic.pallardy@st.com>
CC: Bjorn Andersson <bjorn.andersson@linaro.org>
Signed-off-by: Sarangdhar Joshi <spjoshi@codeaurora.org>
---

The current patch series is a v2 version of original patch listed at
https://lkml.org/lkml/2016/12/16/534

Changes from v1:

* Add new RPROC_DELETED state
* Use the new state RPROC_DELETED to handle race between rproc_del()
  and rproc_boot()

 drivers/remoteproc/remoteproc_sysfs.c | 1 +
 include/linux/remoteproc.h            | 4 +++-
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/remoteproc/remoteproc_sysfs.c b/drivers/remoteproc/remoteproc_sysfs.c
index bc5b0e0..47be411 100644
--- a/drivers/remoteproc/remoteproc_sysfs.c
+++ b/drivers/remoteproc/remoteproc_sysfs.c
@@ -73,6 +73,7 @@ static ssize_t firmware_store(struct device *dev,
 	[RPROC_SUSPENDED]	= "suspended",
 	[RPROC_RUNNING]		= "running",
 	[RPROC_CRASHED]		= "crashed",
+	[RPROC_DELETED]		= "deleted",
 	[RPROC_LAST]		= "invalid",
 };
 
diff --git a/include/linux/remoteproc.h b/include/linux/remoteproc.h
index e2f3a32..25a8c37 100644
--- a/include/linux/remoteproc.h
+++ b/include/linux/remoteproc.h
@@ -346,6 +346,7 @@ struct rproc_ops {
  *			a message.
  * @RPROC_RUNNING:	device is up and running
  * @RPROC_CRASHED:	device has crashed; need to start recovery
+ * @RPROC_DELETED:	device is deleted
  * @RPROC_LAST:		just keep this one at the end
  *
  * Please note that the values of these states are used as indices
@@ -359,7 +360,8 @@ enum rproc_state {
 	RPROC_SUSPENDED	= 1,
 	RPROC_RUNNING	= 2,
 	RPROC_CRASHED	= 3,
-	RPROC_LAST	= 4,
+	RPROC_DELETED	= 4,
+	RPROC_LAST	= 5,
 };
 
 /**
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
