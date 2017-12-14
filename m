From: srinivas.kandagatla@linaro.org (srinivas.kandagatla at linaro.org)
Date: Thu, 14 Dec 2017 17:33:53 +0000
Subject: [RESEND PATCH v2 06/15] ASoC: qcom: qdsp6: Add support to Q6ASM
In-Reply-To: <20171214173402.19074-1-srinivas.kandagatla@linaro.org>
References: <20171214173402.19074-1-srinivas.kandagatla@linaro.org>
Message-ID: <20171214173402.19074-7-srinivas.kandagatla@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

This patch adds basic support to Q6 ASM (Audio Stream Manager) module on
Q6DSP. ASM supports up to 8 concurrent streams. each stream can be setup
as playback/capture. ASM provides top control functions like
Pause/flush/resume for playback and record. ASM can Create/destroy encoder,
decoder and also provides POPP dynamic services.

This patch adds support to basic features to allow hdmi playback.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 sound/soc/qcom/Kconfig        |   5 +
 sound/soc/qcom/qdsp6/Makefile |   1 +
 sound/soc/qcom/qdsp6/q6asm.c  | 250 ++++++++++++++++++++++++++++++++++++++++++
 sound/soc/qcom/qdsp6/q6asm.h  |  14 +++
 4 files changed, 270 insertions(+)
 create mode 100644 sound/soc/qcom/qdsp6/q6asm.c
 create mode 100644 sound/soc/qcom/qdsp6/q6asm.h

diff --git a/sound/soc/qcom/Kconfig b/sound/soc/qcom/Kconfig
index a307880dc992..7ebdb879a8a3 100644
--- a/sound/soc/qcom/Kconfig
+++ b/sound/soc/qcom/Kconfig
@@ -52,10 +52,15 @@ config SND_SOC_QDSP6_ADM
 	tristate
 	default n
 
+config SND_SOC_QDSP6_ASM
+	tristate
+	default n
+
 config SND_SOC_QDSP6
 	tristate "SoC ALSA audio driver for QDSP6"
 	select SND_SOC_QDSP6_AFE
 	select SND_SOC_QDSP6_ADM
+	select SND_SOC_QDSP6_ASM
 	help
 	 To add support for MSM QDSP6 Soc Audio.
 	 This will enable sound soc platform specific
diff --git a/sound/soc/qcom/qdsp6/Makefile b/sound/soc/qcom/qdsp6/Makefile
index 052813ea7062..49dd3ccab27b 100644
--- a/sound/soc/qcom/qdsp6/Makefile
+++ b/sound/soc/qcom/qdsp6/Makefile
@@ -1,2 +1,3 @@
 obj-$(CONFIG_SND_SOC_QDSP6_AFE) += q6afe.o
 obj-$(CONFIG_SND_SOC_QDSP6_ADM) += q6adm.o
+obj-$(CONFIG_SND_SOC_QDSP6_ASM) += q6asm.o
diff --git a/sound/soc/qcom/qdsp6/q6asm.c b/sound/soc/qcom/qdsp6/q6asm.c
new file mode 100644
index 000000000000..9cc583afef4d
--- /dev/null
+++ b/sound/soc/qcom/qdsp6/q6asm.c
@@ -0,0 +1,250 @@
+/* SPDX-License-Identifier: GPL-2.0
+* Copyright (c) 2011-2016, The Linux Foundation
+* Copyright (c) 2017, Linaro Limited
+*/
+#include <linux/mutex.h>
+#include <linux/wait.h>
+#include <linux/module.h>
+#include <linux/soc/qcom/apr.h>
+#include <linux/device.h>
+#include <linux/platform_device.h>
+#include <linux/delay.h>
+#include <linux/slab.h>
+#include <linux/mm.h>
+#include "q6asm.h"
+#include "common.h"
+
+#define TUN_READ_IO_MODE		0x0004	/* tunnel read write mode */
+#define SYNC_IO_MODE			0x0001
+#define ASYNC_IO_MODE			0x0002
+
+struct audio_client {
+	int session;
+	app_cb cb;
+	int cmd_state;
+	void *priv;
+	uint32_t io_mode;
+	uint64_t time_stamp;
+	struct apr_device *adev;
+	struct mutex cmd_lock;
+	wait_queue_head_t cmd_wait;
+	int perf_mode;
+	int stream_id;
+	struct device *dev;
+};
+
+struct q6asm {
+	struct apr_device *adev;
+	int mem_state;
+	struct device *dev;
+	wait_queue_head_t mem_wait;
+	struct mutex	session_lock;
+	struct platform_device *pcmdev;
+	struct audio_client *session[MAX_SESSIONS + 1];
+};
+
+static int q6asm_session_alloc(struct audio_client *ac, struct q6asm *a)
+{
+	int n = -EINVAL;
+
+	mutex_lock(&a->session_lock);
+	for (n = 1; n <= MAX_SESSIONS; n++) {
+		if (!a->session[n]) {
+			a->session[n] = ac;
+			break;
+		}
+	}
+	mutex_unlock(&a->session_lock);
+
+	return n;
+}
+
+static bool q6asm_is_valid_audio_client(struct audio_client *ac)
+{
+	struct q6asm *a = dev_get_drvdata(ac->dev->parent);
+	int n;
+
+	for (n = 1; n <= MAX_SESSIONS; n++) {
+		if (a->session[n] == ac)
+			return 1;
+	}
+
+	return 0;
+}
+
+static void q6asm_session_free(struct audio_client *ac)
+{
+	struct q6asm *a = dev_get_drvdata(ac->dev->parent);
+
+	if (!a)
+		return;
+
+	mutex_lock(&a->session_lock);
+	a->session[ac->session] = 0;
+	ac->session = 0;
+	ac->perf_mode = LEGACY_PCM_MODE;
+	mutex_unlock(&a->session_lock);
+}
+
+/**
+ * q6asm_audio_client_free() - Freee allocated audio client
+ *
+ * @ac: audio client to free
+ */
+void q6asm_audio_client_free(struct audio_client *ac)
+{
+	q6asm_session_free(ac);
+	kfree(ac);
+}
+EXPORT_SYMBOL_GPL(q6asm_audio_client_free);
+
+static struct audio_client *q6asm_get_audio_client(struct q6asm *a,
+						   int session_id)
+{
+	if ((session_id <= 0) || (session_id > MAX_SESSIONS)) {
+		dev_err(a->dev, "invalid session: %d\n", session_id);
+		goto err;
+	}
+
+	if (!a->session[session_id]) {
+		dev_err(a->dev, "session not active: %d\n", session_id);
+		goto err;
+	}
+	return a->session[session_id];
+err:
+	return NULL;
+}
+
+static int q6asm_srvc_callback(struct apr_device *adev, struct apr_client_data *data)
+{
+	struct q6asm *q6asm = dev_get_drvdata(&adev->dev);
+	struct audio_client *ac = NULL;
+	uint32_t sid = 0;
+	uint32_t *payload;
+
+	if (!data) {
+		dev_err(&adev->dev, "%s: Invalid CB\n", __func__);
+		return 0;
+	}
+
+	payload = data->payload;
+	sid = (data->token >> 8) & 0x0F;
+	ac = q6asm_get_audio_client(q6asm, sid);
+	if (!ac) {
+		dev_err(&adev->dev, "Audio Client not active\n");
+		return 0;
+	}
+
+	if (ac->cb)
+		ac->cb(data->opcode, data->token, data->payload, ac->priv);
+	return 0;
+}
+
+/**
+ * q6asm_get_session_id() - get session id for audio client
+ *
+ * @ac: audio client pointer
+ *
+ * Return: Will be an session id of the audio client.
+ */
+int q6asm_get_session_id(struct audio_client *c)
+{
+	return c->session;
+}
+EXPORT_SYMBOL_GPL(q6asm_get_session_id);
+
+/**
+ * q6asm_audio_client_alloc() - Allocate a new audio client
+ *
+ * @dev: Pointer to asm child device.
+ * @cb: event callback.
+ * @priv: private data associated with this client.
+ *
+ * Return: Will be an error pointer on error or a valid audio client
+ * on success.
+ */
+struct audio_client *q6asm_audio_client_alloc(struct device *dev,
+					      app_cb cb, void *priv)
+{
+	struct q6asm *a = dev_get_drvdata(dev->parent);
+	struct audio_client *ac;
+	int n;
+
+	ac = kzalloc(sizeof(struct audio_client), GFP_KERNEL);
+	if (!ac)
+		return NULL;
+
+	n = q6asm_session_alloc(ac, a);
+	if (n <= 0) {
+		dev_err(dev, "ASM Session alloc fail n=%d\n", n);
+		kfree(ac);
+		return NULL;
+	}
+
+	ac->session = n;
+	ac->cb = cb;
+	ac->dev = dev;
+	ac->priv = priv;
+	ac->io_mode = SYNC_IO_MODE;
+	ac->perf_mode = LEGACY_PCM_MODE;
+	/* DSP expects stream id from 1 */
+	ac->stream_id = 1;
+	ac->adev = a->adev;
+
+	init_waitqueue_head(&ac->cmd_wait);
+	mutex_init(&ac->cmd_lock);
+	ac->cmd_state = 0;
+
+	return ac;
+}
+EXPORT_SYMBOL_GPL(q6asm_audio_client_alloc);
+
+
+static int q6asm_probe(struct apr_device *adev)
+{
+	struct q6asm *q6asm;
+
+	q6asm = devm_kzalloc(&adev->dev, sizeof(*q6asm), GFP_KERNEL);
+	if (!q6asm)
+		return -ENOMEM;
+
+	q6asm->dev = &adev->dev;
+	q6asm->adev = adev;
+	q6asm->mem_state = 0;
+	init_waitqueue_head(&q6asm->mem_wait);
+	mutex_init(&q6asm->session_lock);
+	dev_set_drvdata(&adev->dev, q6asm);
+
+	q6asm->pcmdev = platform_device_register_data(&adev->dev,
+						      "q6asm_dai", -1, NULL, 0);
+
+	return 0;
+}
+
+static int q6asm_remove(struct apr_device *adev)
+{
+	struct q6asm *q6asm = dev_get_drvdata(&adev->dev);
+
+	platform_device_unregister(q6asm->pcmdev);
+
+	return 0;
+}
+
+static const struct apr_device_id q6asm_id[] = {
+	{"Q6ASM", APR_DOMAIN_ADSP, APR_SVC_ASM, APR_CLIENT_AUDIO},
+	{}
+};
+
+static struct apr_driver qcom_q6asm_driver = {
+	.probe = q6asm_probe,
+	.remove = q6asm_remove,
+	.callback = q6asm_srvc_callback,
+	.id_table = q6asm_id,
+	.driver = {
+		   .name = "qcom-q6asm",
+		   },
+};
+
+module_apr_driver(qcom_q6asm_driver);
+MODULE_DESCRIPTION("Q6 Audio Stream Manager driver");
+MODULE_LICENSE("GPL v2");
diff --git a/sound/soc/qcom/qdsp6/q6asm.h b/sound/soc/qcom/qdsp6/q6asm.h
new file mode 100644
index 000000000000..7a8a9039fd89
--- /dev/null
+++ b/sound/soc/qcom/qdsp6/q6asm.h
@@ -0,0 +1,14 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __Q6_ASM_H__
+#define __Q6_ASM_H__
+
+#define MAX_SESSIONS	16
+
+typedef void (*app_cb) (uint32_t opcode, uint32_t token,
+			uint32_t *payload, void *priv);
+struct audio_client;
+struct audio_client *q6asm_audio_client_alloc(struct device *dev,
+					      app_cb cb, void *priv);
+void q6asm_audio_client_free(struct audio_client *ac);
+int q6asm_get_session_id(struct audio_client *ac);
+#endif /* __Q6_ASM_H__ */
-- 
2.15.0
