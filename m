From: cw00.choi@samsung.com (Chanwoo Choi)
Date: Mon, 28 Mar 2016 08:37:54 +0900
Subject: [PATCH v6 05/21] PM / devfreq: Add governer type with unique number
In-Reply-To: <1459121890-4601-1-git-send-email-cw00.choi@samsung.com>
References: <1459121890-4601-1-git-send-email-cw00.choi@samsung.com>
Message-ID: <1459121890-4601-6-git-send-email-cw00.choi@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch just adds the governor type to identify them
by using the defined constant.

Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
---
 drivers/devfreq/governor.h                | 6 ++++++
 drivers/devfreq/governor_performance.c    | 1 +
 drivers/devfreq/governor_powersave.c      | 1 +
 drivers/devfreq/governor_simpleondemand.c | 1 +
 drivers/devfreq/governor_userspace.c      | 1 +
 include/linux/devfreq.h                   | 2 ++
 6 files changed, 12 insertions(+)

diff --git a/drivers/devfreq/governor.h b/drivers/devfreq/governor.h
index fad7d6321978..cf19b923c362 100644
--- a/drivers/devfreq/governor.h
+++ b/drivers/devfreq/governor.h
@@ -18,6 +18,12 @@
 
 #define to_devfreq(DEV)	container_of((DEV), struct devfreq, dev)
 
+/* Devfreq governor type */
+#define DEVFREQ_GOV_ONDEMAND			0x1
+#define DEVFREQ_GOV_PERFORMANCE			0x2
+#define DEVFREQ_GOV_POWERSAVE			0x3
+#define DEVFREQ_GOV_USERSPACE			0x4
+
 /* Devfreq events */
 #define DEVFREQ_GOV_START			0x1
 #define DEVFREQ_GOV_STOP			0x2
diff --git a/drivers/devfreq/governor_performance.c b/drivers/devfreq/governor_performance.c
index c72f942f30a8..594d8ecb13fb 100644
--- a/drivers/devfreq/governor_performance.c
+++ b/drivers/devfreq/governor_performance.c
@@ -43,6 +43,7 @@ static int devfreq_performance_handler(struct devfreq *devfreq,
 
 static struct devfreq_governor devfreq_performance = {
 	.name = "performance",
+	.type = DEVFREQ_GOV_PERFORMANCE,
 	.get_target_freq = devfreq_performance_func,
 	.event_handler = devfreq_performance_handler,
 };
diff --git a/drivers/devfreq/governor_powersave.c b/drivers/devfreq/governor_powersave.c
index 0c6bed567e6d..e2817e1f2a31 100644
--- a/drivers/devfreq/governor_powersave.c
+++ b/drivers/devfreq/governor_powersave.c
@@ -40,6 +40,7 @@ static int devfreq_powersave_handler(struct devfreq *devfreq,
 
 static struct devfreq_governor devfreq_powersave = {
 	.name = "powersave",
+	.type = DEVFREQ_GOV_POWERSAVE,
 	.get_target_freq = devfreq_powersave_func,
 	.event_handler = devfreq_powersave_handler,
 };
diff --git a/drivers/devfreq/governor_simpleondemand.c b/drivers/devfreq/governor_simpleondemand.c
index ae72ba5e78df..b905a535d486 100644
--- a/drivers/devfreq/governor_simpleondemand.c
+++ b/drivers/devfreq/governor_simpleondemand.c
@@ -126,6 +126,7 @@ static int devfreq_simple_ondemand_handler(struct devfreq *devfreq,
 
 static struct devfreq_governor devfreq_simple_ondemand = {
 	.name = "simple_ondemand",
+	.type = DEVFREQ_GOV_ONDEMAND,
 	.get_target_freq = devfreq_simple_ondemand_func,
 	.event_handler = devfreq_simple_ondemand_handler,
 };
diff --git a/drivers/devfreq/governor_userspace.c b/drivers/devfreq/governor_userspace.c
index 35de6e83c1fe..c78ab78a5220 100644
--- a/drivers/devfreq/governor_userspace.c
+++ b/drivers/devfreq/governor_userspace.c
@@ -138,6 +138,7 @@ static int devfreq_userspace_handler(struct devfreq *devfreq,
 
 static struct devfreq_governor devfreq_userspace = {
 	.name = "userspace",
+	.type = DEVFREQ_GOV_USERSPACE,
 	.get_target_freq = devfreq_userspace_func,
 	.event_handler = devfreq_userspace_handler,
 };
diff --git a/include/linux/devfreq.h b/include/linux/devfreq.h
index 152ea342529c..9baf45f661ad 100644
--- a/include/linux/devfreq.h
+++ b/include/linux/devfreq.h
@@ -104,6 +104,7 @@ struct devfreq_dev_profile {
  * struct devfreq_governor - Devfreq policy governor
  * @node:		list node - contains registered devfreq governors
  * @name:		Governor's name
+ * @type:		Governor's type
  * @get_target_freq:	Returns desired operating frequency for the device.
  *			Basically, get_target_freq will run
  *			devfreq_dev_profile.get_dev_status() to get the
@@ -121,6 +122,7 @@ struct devfreq_governor {
 	struct list_head node;
 
 	const char name[DEVFREQ_NAME_LEN];
+	const int type;
 	int (*get_target_freq)(struct devfreq *this, unsigned long *freq);
 	int (*event_handler)(struct devfreq *devfreq,
 				unsigned int event, void *data);
-- 
1.9.1
