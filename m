From: fabrice.gasnier@st.com (Fabrice Gasnier)
Date: Thu, 6 Apr 2017 18:11:54 +0200
Subject: [PATCH v2 3/5] iio: trigger: add set_trigger callback to notify device
In-Reply-To: <1491495116-7209-1-git-send-email-fabrice.gasnier@st.com>
References: <1491495116-7209-1-git-send-email-fabrice.gasnier@st.com>
Message-ID: <1491495116-7209-4-git-send-email-fabrice.gasnier@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add 'set_trigger' callback to iio info structure. This allows device
to be notified when a trigger (or no trigger) has been assigned. This
maybe useful for instance in non buffered mode (e.g. event triggered).
This is called, after trigger and device side validate callbacks have
been called.

Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
---
Changes in v2:
- Added set_trigger callback used in remaining patches
---
 drivers/iio/industrialio-trigger.c | 6 ++++++
 include/linux/iio/iio.h            | 2 ++
 2 files changed, 8 insertions(+)

diff --git a/drivers/iio/industrialio-trigger.c b/drivers/iio/industrialio-trigger.c
index 978e1592..010bdf2 100644
--- a/drivers/iio/industrialio-trigger.c
+++ b/drivers/iio/industrialio-trigger.c
@@ -434,6 +434,12 @@ static ssize_t iio_trigger_write_current(struct device *dev,
 			goto out_trigger_put;
 	}
 
+	if (indio_dev->info->set_trigger) {
+		ret = indio_dev->info->set_trigger(indio_dev, trig);
+		if (ret)
+			goto out_trigger_put;
+	}
+
 	indio_dev->trig = trig;
 
 	if (oldtrig) {
diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
index 3f5ea2e..9f51065 100644
--- a/include/linux/iio/iio.h
+++ b/include/linux/iio/iio.h
@@ -399,6 +399,7 @@ static inline bool iio_channel_has_available(const struct iio_chan_spec *chan,
  * @write_event_value:	write a configuration value for the event.
  * @validate_trigger:	function to validate the trigger when the
  *			current trigger gets changed.
+ * @set_trigger:	function to notify current trigger gets changed.
  * @update_scan_mode:	function to configure device and scan buffer when
  *			channels have changed
  * @debugfs_reg_access:	function to read or write register value of device
@@ -478,6 +479,7 @@ struct iio_info {
 
 	int (*validate_trigger)(struct iio_dev *indio_dev,
 				struct iio_trigger *trig);
+	int (*set_trigger)(struct iio_dev *indio_dev, struct iio_trigger *trig);
 	int (*update_scan_mode)(struct iio_dev *indio_dev,
 				const unsigned long *scan_mask);
 	int (*debugfs_reg_access)(struct iio_dev *indio_dev,
-- 
1.9.1
