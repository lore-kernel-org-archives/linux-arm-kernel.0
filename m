From: zhang.chunyan@linaro.org (Chunyan Zhang)
Date: Mon,  1 Feb 2016 15:58:44 +0800
Subject: [PATCH 1/6] stm class: Add ioctl get_options interface
In-Reply-To: <1454313529-8860-1-git-send-email-zhang.chunyan@linaro.org>
References: <1454313529-8860-1-git-send-email-zhang.chunyan@linaro.org>
Message-ID: <1454313529-8860-2-git-send-email-zhang.chunyan@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There is already an interface of set_options, but no get_options yet.
Before setting any options, one would may want to see the current
status of that option by means of get_options interface. This
interface has been used in CoreSight STM driver.

Signed-off-by: Chunyan Zhang <zhang.chunyan@linaro.org>
---
 drivers/hwtracing/stm/core.c | 11 +++++++++++
 include/linux/stm.h          |  3 +++
 include/uapi/linux/stm.h     |  1 +
 3 files changed, 15 insertions(+)

diff --git a/drivers/hwtracing/stm/core.c b/drivers/hwtracing/stm/core.c
index b6445d9..86bb4e3 100644
--- a/drivers/hwtracing/stm/core.c
+++ b/drivers/hwtracing/stm/core.c
@@ -571,6 +571,17 @@ stm_char_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 						    options);
 
 		break;
+
+	case STP_GET_OPTIONS:
+		if (stm_data->get_options)
+			err = stm_data->get_options(stm_data,
+						    stmf->output.master,
+						    stmf->output.channel,
+						    stmf->output.nr_chans,
+						    &options);
+
+		return copy_to_user((void __user *)arg, &options, sizeof(u64));
+
 	default:
 		break;
 	}
diff --git a/include/linux/stm.h b/include/linux/stm.h
index 9d0083d..f351d62 100644
--- a/include/linux/stm.h
+++ b/include/linux/stm.h
@@ -88,6 +88,9 @@ struct stm_data {
 	long			(*set_options)(struct stm_data *, unsigned int,
 					       unsigned int, unsigned int,
 					       unsigned long);
+	long			(*get_options)(struct stm_data *, unsigned int,
+					       unsigned int, unsigned int,
+					       u64 *);
 };
 
 int stm_register_device(struct device *parent, struct stm_data *stm_data,
diff --git a/include/uapi/linux/stm.h b/include/uapi/linux/stm.h
index 626a8d3..0dab16e 100644
--- a/include/uapi/linux/stm.h
+++ b/include/uapi/linux/stm.h
@@ -46,5 +46,6 @@ struct stp_policy_id {
 #define STP_POLICY_ID_SET	_IOWR('%', 0, struct stp_policy_id)
 #define STP_POLICY_ID_GET	_IOR('%', 1, struct stp_policy_id)
 #define STP_SET_OPTIONS		_IOW('%', 2, __u64)
+#define STP_GET_OPTIONS		_IOR('%', 3, __u64)
 
 #endif /* _UAPI_LINUX_STM_H */
-- 
1.9.1
