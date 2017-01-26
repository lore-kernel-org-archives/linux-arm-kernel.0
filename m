From: fabrice.gasnier@st.com (Fabrice Gasnier)
Date: Thu, 26 Jan 2017 15:28:31 +0100
Subject: [PATCH v2 3/7] iio: adc: stm32: add trigger polarity extended
 attribute
In-Reply-To: <1485440915-30119-1-git-send-email-fabrice.gasnier@st.com>
References: <1485440915-30119-1-git-send-email-fabrice.gasnier@st.com>
Message-ID: <1485440915-30119-4-git-send-email-fabrice.gasnier@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Define extended attribute so that user may choose rising, falling or both
edges for external trigger sources.
Default to rising edge in case it isn't set.

Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
---
Changes in v2:
- Rename and document new trigger_polarity custom attribute
---
 Documentation/ABI/testing/sysfs-bus-iio-adc-stm32 | 18 +++++++++
 drivers/iio/adc/stm32-adc.c                       | 46 ++++++++++++++++++++++-
 2 files changed, 63 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-adc-stm32

diff --git a/Documentation/ABI/testing/sysfs-bus-iio-adc-stm32 b/Documentation/ABI/testing/sysfs-bus-iio-adc-stm32
new file mode 100644
index 0000000..efe4c85
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-bus-iio-adc-stm32
@@ -0,0 +1,18 @@
+What:		/sys/bus/iio/devices/triggerX/trigger_polarity
+KernelVersion:	4.11
+Contact:	fabrice.gasnier at st.com
+Description:
+		The STM32 ADC can be configured to use external trigger sources
+		(e.g. timers, pwm or exti gpio). Then, it can be tuned to start
+		conversions on external trigger by either:
+		- "rising-edge"
+		- "falling-edge"
+		- "both-edges".
+		Reading returns current trigger polarity.
+		Writing value before enabling conversions sets trigger polarity.
+
+What:		/sys/bus/iio/devices/triggerX/trigger_polarity_available
+KernelVersion:	4.11
+Contact:	fabrice.gasnier at st.com
+Description:
+		List all available trigger_polarity settings.
diff --git a/drivers/iio/adc/stm32-adc.c b/drivers/iio/adc/stm32-adc.c
index 87d984b..9a38f9a 100644
--- a/drivers/iio/adc/stm32-adc.c
+++ b/drivers/iio/adc/stm32-adc.c
@@ -135,6 +135,7 @@ struct stm32_adc_regs {
  * @lock:		spinlock
  * @bufi:		data buffer index
  * @num_conv:		expected number of scan conversions
+ * @trigger_polarity:	external trigger polarity (e.g. exten)
  */
 struct stm32_adc {
 	struct stm32_adc_common	*common;
@@ -146,6 +147,7 @@ struct stm32_adc {
 	spinlock_t		lock;		/* interrupt lock */
 	unsigned int		bufi;
 	unsigned int		num_conv;
+	u32			trigger_polarity;
 };
 
 /**
@@ -410,7 +412,7 @@ static int stm32_adc_set_trig(struct iio_dev *indio_dev,
 
 		/* set trigger source and polarity (default to rising edge) */
 		extsel = ret;
-		exten = STM32_EXTEN_HWTRIG_RISING_EDGE;
+		exten = adc->trigger_polarity + STM32_EXTEN_HWTRIG_RISING_EDGE;
 	}
 
 	spin_lock_irqsave(&adc->lock, flags);
@@ -424,6 +426,36 @@ static int stm32_adc_set_trig(struct iio_dev *indio_dev,
 	return 0;
 }
 
+static int stm32_adc_set_trig_pol(struct iio_dev *indio_dev,
+				  const struct iio_chan_spec *chan,
+				  unsigned int type)
+{
+	struct stm32_adc *adc = iio_priv(indio_dev);
+
+	adc->trigger_polarity = type;
+
+	return 0;
+}
+
+static int stm32_adc_get_trig_pol(struct iio_dev *indio_dev,
+				  const struct iio_chan_spec *chan)
+{
+	struct stm32_adc *adc = iio_priv(indio_dev);
+
+	return adc->trigger_polarity;
+}
+
+static const char * const stm32_trig_pol_items[] = {
+	"rising-edge", "falling-edge", "both-edges",
+};
+
+const struct iio_enum stm32_adc_trig_pol = {
+	.items = stm32_trig_pol_items,
+	.num_items = ARRAY_SIZE(stm32_trig_pol_items),
+	.get = stm32_adc_get_trig_pol,
+	.set = stm32_adc_set_trig_pol,
+};
+
 /**
  * stm32_adc_single_conv() - Performs a single conversion
  * @indio_dev: IIO device
@@ -682,6 +714,17 @@ static irqreturn_t stm32_adc_trigger_handler(int irq, void *p)
 	return IRQ_HANDLED;
 }
 
+static const struct iio_chan_spec_ext_info stm32_adc_ext_info[] = {
+	IIO_ENUM("trigger_polarity", IIO_SHARED_BY_ALL, &stm32_adc_trig_pol),
+	{
+		.name = "trigger_polarity_available",
+		.shared = IIO_SHARED_BY_ALL,
+		.read = iio_enum_available_read,
+		.private = (uintptr_t)&stm32_adc_trig_pol,
+	},
+	{},
+};
+
 static void stm32_adc_chan_init_one(struct iio_dev *indio_dev,
 				    struct iio_chan_spec *chan,
 				    const struct stm32_adc_chan_spec *channel,
@@ -697,6 +740,7 @@ static void stm32_adc_chan_init_one(struct iio_dev *indio_dev,
 	chan->scan_type.sign = 'u';
 	chan->scan_type.realbits = 12;
 	chan->scan_type.storagebits = 16;
+	chan->ext_info = stm32_adc_ext_info;
 }
 
 static int stm32_adc_chan_of_init(struct iio_dev *indio_dev)
-- 
1.9.1
