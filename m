From: bjorn.andersson@linaro.org (Bjorn Andersson)
Date: Mon, 1 Jan 2018 20:43:50 -0800
Subject: [RESEND PATCH v2 06/15] ASoC: qcom: qdsp6: Add support to Q6ASM
In-Reply-To: <20171214173402.19074-7-srinivas.kandagatla@linaro.org>
References: <20171214173402.19074-1-srinivas.kandagatla@linaro.org>
 <20171214173402.19074-7-srinivas.kandagatla@linaro.org>
Message-ID: <20180102044350.GO478@tuxbook>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu 14 Dec 09:33 PST 2017, srinivas.kandagatla at linaro.org wrote:

> From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> 
> This patch adds basic support to Q6 ASM (Audio Stream Manager) module on
> Q6DSP. ASM supports up to 8 concurrent streams. each stream can be setup
> as playback/capture.

"...streams, each one setup as either playback or capture".

or "each" need to be capitalized.

> ASM provides top control functions like
> Pause/flush/resume for playback and record. ASM can Create/destroy encoder,

lower case p and c

> decoder and also provides POPP dynamic services.

Please describe what POPP is.

[..]
> +struct audio_client {
> +	int session;
> +	app_cb cb;
> +	int cmd_state;
> +	void *priv;
> +	uint32_t io_mode;
> +	uint64_t time_stamp;

Unused.

> +	struct apr_device *adev;
> +	struct mutex cmd_lock;
> +	wait_queue_head_t cmd_wait;
> +	int perf_mode;
> +	int stream_id;
> +	struct device *dev;
> +};
> +
> +struct q6asm {
> +	struct apr_device *adev;
> +	int mem_state;
> +	struct device *dev;
> +	wait_queue_head_t mem_wait;
> +	struct mutex	session_lock;
> +	struct platform_device *pcmdev;
> +	struct audio_client *session[MAX_SESSIONS + 1];
> +};
> +
> +static int q6asm_session_alloc(struct audio_client *ac, struct q6asm *a)

Move the allocation of ac into this function, and return the newly
allocated ac - that way the name of this function makes more sense.

> +{
> +	int n = -EINVAL;

You're returning MAX_SESSIONS if no free sessions are found, but are
checking for <= 0 in the caller.

> +
> +	mutex_lock(&a->session_lock);
> +	for (n = 1; n <= MAX_SESSIONS; n++) {

Is there an external reason for session 0 not being considered?

> +		if (!a->session[n]) {
> +			a->session[n] = ac;
> +			break;
> +		}
> +	}

If you make session an idr this function would become idr_alloc(1,
MAX_SESSIONS + 1).

> +	mutex_unlock(&a->session_lock);
> +
> +	return n;
> +}
> +
> +static bool q6asm_is_valid_audio_client(struct audio_client *ac)
> +{
> +	struct q6asm *a = dev_get_drvdata(ac->dev->parent);
> +	int n;
> +
> +	for (n = 1; n <= MAX_SESSIONS; n++) {
> +		if (a->session[n] == ac)
> +			return 1;

"true"

> +	}
> +
> +	return 0;

"false"

> +}
> +
> +static void q6asm_session_free(struct audio_client *ac)
> +{
> +	struct q6asm *a = dev_get_drvdata(ac->dev->parent);
> +
> +	if (!a)
> +		return;
> +
> +	mutex_lock(&a->session_lock);
> +	a->session[ac->session] = 0;
> +	ac->session = 0;
> +	ac->perf_mode = LEGACY_PCM_MODE;

No need to update ac->*, as you kfree ac as soon as you return from
here.

> +	mutex_unlock(&a->session_lock);
> +}
> +
> +/**
> + * q6asm_audio_client_free() - Freee allocated audio client
> + *
> + * @ac: audio client to free
> + */
> +void q6asm_audio_client_free(struct audio_client *ac)
> +{
> +	q6asm_session_free(ac);

Inline q6asm_session_free() here.

> +	kfree(ac);
> +}
> +EXPORT_SYMBOL_GPL(q6asm_audio_client_free);
> +
> +static struct audio_client *q6asm_get_audio_client(struct q6asm *a,
> +						   int session_id)
> +{
> +	if ((session_id <= 0) || (session_id > MAX_SESSIONS)) {
> +		dev_err(a->dev, "invalid session: %d\n", session_id);
> +		goto err;

Just return NULL here instead.

> +	}
> +
> +	if (!a->session[session_id]) {
> +		dev_err(a->dev, "session not active: %d\n", session_id);
> +		goto err;

Dito

> +	}

But this is another place where an idr would be preferable, as both
these cases would be covered with a call to idr_find()

> +	return a->session[session_id];
> +err:
> +	return NULL;
> +}
> +
> +static int q6asm_srvc_callback(struct apr_device *adev, struct apr_client_data *data)
> +{
> +	struct q6asm *q6asm = dev_get_drvdata(&adev->dev);
> +	struct audio_client *ac = NULL;
> +	uint32_t sid = 0;

This is 4 bits, so just use int.

> +	uint32_t *payload;

payload is unused.

> +
> +	if (!data) {
> +		dev_err(&adev->dev, "%s: Invalid CB\n", __func__);
> +		return 0;
> +	}

Again, define the apr to never invoke the callback with data = NULL

> +
> +	payload = data->payload;
> +	sid = (data->token >> 8) & 0x0F;
> +	ac = q6asm_get_audio_client(q6asm, sid);
> +	if (!ac) {
> +		dev_err(&adev->dev, "Audio Client not active\n");
> +		return 0;
> +	}
> +
> +	if (ac->cb)
> +		ac->cb(data->opcode, data->token, data->payload, ac->priv);
> +	return 0;
> +}
> +
> +/**
> + * q6asm_get_session_id() - get session id for audio client
> + *
> + * @ac: audio client pointer
> + *
> + * Return: Will be an session id of the audio client.
> + */
> +int q6asm_get_session_id(struct audio_client *c)
> +{
> +	return c->session;
> +}
> +EXPORT_SYMBOL_GPL(q6asm_get_session_id);
> +
> +/**
> + * q6asm_audio_client_alloc() - Allocate a new audio client
> + *
> + * @dev: Pointer to asm child device.
> + * @cb: event callback.
> + * @priv: private data associated with this client.
> + *
> + * Return: Will be an error pointer on error or a valid audio client
> + * on success.
> + */
> +struct audio_client *q6asm_audio_client_alloc(struct device *dev,
> +					      app_cb cb, void *priv)
> +{
> +	struct q6asm *a = dev_get_drvdata(dev->parent);
> +	struct audio_client *ac;
> +	int n;
> +
> +	ac = kzalloc(sizeof(struct audio_client), GFP_KERNEL);

sizeof(*ac)

> +	if (!ac)
> +		return NULL;
> +
> +	n = q6asm_session_alloc(ac, a);

As stated above, moving the kzalloc into q6asm_session_alloc() would
clean the code up here, as you only need to deal with one possible
error case here.

> +	if (n <= 0) {
> +		dev_err(dev, "ASM Session alloc fail n=%d\n", n);
> +		kfree(ac);
> +		return NULL;

Per the kerneldoc I expect an ERR_PTR(n) here.

> +	}
> +
> +	ac->session = n;
> +	ac->cb = cb;
> +	ac->dev = dev;
> +	ac->priv = priv;
> +	ac->io_mode = SYNC_IO_MODE;
> +	ac->perf_mode = LEGACY_PCM_MODE;
> +	/* DSP expects stream id from 1 */
> +	ac->stream_id = 1;
> +	ac->adev = a->adev;
> +
> +	init_waitqueue_head(&ac->cmd_wait);
> +	mutex_init(&ac->cmd_lock);
> +	ac->cmd_state = 0;
> +
> +	return ac;
> +}
> +EXPORT_SYMBOL_GPL(q6asm_audio_client_alloc);
> +
> +

Extra newline.

> +static int q6asm_probe(struct apr_device *adev)
> +{
> +	struct q6asm *q6asm;
> +
> +	q6asm = devm_kzalloc(&adev->dev, sizeof(*q6asm), GFP_KERNEL);
> +	if (!q6asm)
> +		return -ENOMEM;
> +
> +	q6asm->dev = &adev->dev;
> +	q6asm->adev = adev;
> +	q6asm->mem_state = 0;
> +	init_waitqueue_head(&q6asm->mem_wait);
> +	mutex_init(&q6asm->session_lock);
> +	dev_set_drvdata(&adev->dev, q6asm);
> +
> +	q6asm->pcmdev = platform_device_register_data(&adev->dev,
> +						      "q6asm_dai", -1, NULL, 0);
> +
> +	return 0;
> +}
> +
> +static int q6asm_remove(struct apr_device *adev)
> +{
> +	struct q6asm *q6asm = dev_get_drvdata(&adev->dev);
> +
> +	platform_device_unregister(q6asm->pcmdev);
> +
> +	return 0;
> +}
> +
> +static const struct apr_device_id q6asm_id[] = {
> +	{"Q6ASM", APR_DOMAIN_ADSP, APR_SVC_ASM, APR_CLIENT_AUDIO},
> +	{}
> +};
> +
> +static struct apr_driver qcom_q6asm_driver = {
> +	.probe = q6asm_probe,
> +	.remove = q6asm_remove,
> +	.callback = q6asm_srvc_callback,
> +	.id_table = q6asm_id,
> +	.driver = {
> +		   .name = "qcom-q6asm",
> +		   },

Indentation

> +};
> +
> +module_apr_driver(qcom_q6asm_driver);
> +MODULE_DESCRIPTION("Q6 Audio Stream Manager driver");
> +MODULE_LICENSE("GPL v2");
> diff --git a/sound/soc/qcom/qdsp6/q6asm.h b/sound/soc/qcom/qdsp6/q6asm.h
> new file mode 100644
> index 000000000000..7a8a9039fd89
> --- /dev/null
> +++ b/sound/soc/qcom/qdsp6/q6asm.h
> @@ -0,0 +1,14 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef __Q6_ASM_H__
> +#define __Q6_ASM_H__
> +
> +#define MAX_SESSIONS	16
> +
> +typedef void (*app_cb) (uint32_t opcode, uint32_t token,
> +			uint32_t *payload, void *priv);

This name of a type is too generic.

And make payload void *, unless the payload really really is an
unstructured uint32_t array.

Regards,
Bjorn
