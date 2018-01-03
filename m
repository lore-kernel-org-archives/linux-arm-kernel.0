From: srinivas.kandagatla@linaro.org (Srinivas Kandagatla)
Date: Wed, 3 Jan 2018 16:26:47 +0000
Subject: [RESEND PATCH v2 06/15] ASoC: qcom: qdsp6: Add support to Q6ASM
In-Reply-To: <20180102044350.GO478@tuxbook>
References: <20171214173402.19074-1-srinivas.kandagatla@linaro.org>
 <20171214173402.19074-7-srinivas.kandagatla@linaro.org>
 <20180102044350.GO478@tuxbook>
Message-ID: <bb236217-7e0f-a6a3-afb1-121f47ff624b@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 02/01/18 04:43, Bjorn Andersson wrote:
> On Thu 14 Dec 09:33 PST 2017, srinivas.kandagatla at linaro.org wrote:
> 
>> From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>>
>> This patch adds basic support to Q6 ASM (Audio Stream Manager) module on
>> Q6DSP. ASM supports up to 8 concurrent streams. each stream can be setup
>> as playback/capture.
> 
> "...streams, each one setup as either playback or capture".
> 
> or "each" need to be capitalized.
> 
>> ASM provides top control functions like
>> Pause/flush/resume for playback and record. ASM can Create/destroy encoder,
> 
> lower case p and c
> 
>> decoder and also provides POPP dynamic services.
> 
> Please describe what POPP is.
Yep, will fix the commit log as suggested.

> 
> [..]
>> +struct audio_client {
>> +	int session;
>> +	app_cb cb;
>> +	int cmd_state;
>> +	void *priv;
>> +	uint32_t io_mode;
>> +	uint64_t time_stamp;
> 
> Unused.
> 
will remove this in next version.

>> +	struct apr_device *adev;
>> +	struct mutex cmd_lock;
>> +	wait_queue_head_t cmd_wait;
>> +	int perf_mode;
>> +	int stream_id;
>> +	struct device *dev;
>> +};
>> +
>> +struct q6asm {
>> +	struct apr_device *adev;
>> +	int mem_state;
>> +	struct device *dev;
>> +	wait_queue_head_t mem_wait;
>> +	struct mutex	session_lock;
>> +	struct platform_device *pcmdev;
>> +	struct audio_client *session[MAX_SESSIONS + 1];
>> +};
>> +
>> +static int q6asm_session_alloc(struct audio_client *ac, struct q6asm *a)
> 
> Move the allocation of ac into this function, and return the newly
> allocated ac - that way the name of this function makes more sense.
will try that, it should cleanup some code.

> 
>> +{
>> +	int n = -EINVAL;
> 
> You're returning MAX_SESSIONS if no free sessions are found, but are
> checking for <= 0 in the caller.

I will make sure that its checked correctly and i will also update the 
kernel doc to reflect this.

> 
>> +
>> +	mutex_lock(&a->session_lock);
>> +	for (n = 1; n <= MAX_SESSIONS; n++) {
> 
> Is there an external reason for session 0 not being considered?
> 
Yes, session 0 is reserved.

>> +		if (!a->session[n]) {
>> +			a->session[n] = ac;
>> +			break;
>> +		}
>> +	}
> 
> If you make session an idr this function would become idr_alloc(1,
> MAX_SESSIONS + 1).
will try idr and see how it looks.
> 
>> +	mutex_unlock(&a->session_lock);
>> +
>> +	return n;
>> +}
>> +
>> +static bool q6asm_is_valid_audio_client(struct audio_client *ac)
>> +{
>> +	struct q6asm *a = dev_get_drvdata(ac->dev->parent);
>> +	int n;
>> +
>> +	for (n = 1; n <= MAX_SESSIONS; n++) {
>> +		if (a->session[n] == ac)
>> +			return 1;
> 
> "true"
thanks, will fix these.
> 
>> +	}
>> +
>> +	return 0;
> 
> "false"
> 
>> +}
>> +
>> +static void q6asm_session_free(struct audio_client *ac)
>> +{
>> +	struct q6asm *a = dev_get_drvdata(ac->dev->parent);
>> +
>> +	if (!a)
>> +		return;
>> +
>> +	mutex_lock(&a->session_lock);
>> +	a->session[ac->session] = 0;
>> +	ac->session = 0;
>> +	ac->perf_mode = LEGACY_PCM_MODE;
> 
> No need to update ac->*, as you kfree ac as soon as you return from
> here.
yep.

> 
>> +	mutex_unlock(&a->session_lock);
>> +}
>> +
>> +/**
>> + * q6asm_audio_client_free() - Freee allocated audio client
>> + *
>> + * @ac: audio client to free
>> + */
>> +void q6asm_audio_client_free(struct audio_client *ac)
>> +{
>> +	q6asm_session_free(ac);
> 
> Inline q6asm_session_free() here.
makes sense here.

> 
>> +	kfree(ac);
>> +}
>> +EXPORT_SYMBOL_GPL(q6asm_audio_client_free);
>> +
>> +static struct audio_client *q6asm_get_audio_client(struct q6asm *a,
>> +						   int session_id)
>> +{
>> +	if ((session_id <= 0) || (session_id > MAX_SESSIONS)) {
>> +		dev_err(a->dev, "invalid session: %d\n", session_id);
>> +		goto err;
> 
> Just return NULL here instead.
yep.

> 
>> +	}
>> +
>> +	if (!a->session[session_id]) {
>> +		dev_err(a->dev, "session not active: %d\n", session_id);
>> +		goto err;
> 
> Dito
> 
>> +	}
> 
> But this is another place where an idr would be preferable, as both
> these cases would be covered with a call to idr_find()
> 
>> +	return a->session[session_id];
>> +err:
>> +	return NULL;
>> +}
>> +
>> +static int q6asm_srvc_callback(struct apr_device *adev, struct apr_client_data *data)
>> +{
>> +	struct q6asm *q6asm = dev_get_drvdata(&adev->dev);
>> +	struct audio_client *ac = NULL;
>> +	uint32_t sid = 0;
> 
> This is 4 bits, so just use int.
> 
makes sense.

>> +	uint32_t *payload;
> 
> payload is unused.

will remove this in next version.

> 
>> +
>> +	if (!data) {
>> +		dev_err(&adev->dev, "%s: Invalid CB\n", __func__);
>> +		return 0;
>> +	}
> 
> Again, define the apr to never invoke the callback with data = NULL
> 
yep.

>> +
>> +	payload = data->payload;
>> +	sid = (data->token >> 8) & 0x0F;
>> +	ac = q6asm_get_audio_client(q6asm, sid);
>> +	if (!ac) {
>> +		dev_err(&adev->dev, "Audio Client not active\n");
>> +		return 0;
>> +	}
>> +
>> +	if (ac->cb)
>> +		ac->cb(data->opcode, data->token, data->payload, ac->priv);
>> +	return 0;
>> +}
>> +

[...]


>> +/**
>> + * q6asm_audio_client_alloc() - Allocate a new audio client
>> + *
>> + * @dev: Pointer to asm child device.
>> + * @cb: event callback.
>> + * @priv: private data associated with this client.
>> + *
>> + * Return: Will be an error pointer on error or a valid audio client
>> + * on success.
>> + */
>> +struct audio_client *q6asm_audio_client_alloc(struct device *dev,
>> +					      app_cb cb, void *priv)
>> +{
>> +	struct q6asm *a = dev_get_drvdata(dev->parent);
>> +	struct audio_client *ac;
>> +	int n;
>> +
>> +	ac = kzalloc(sizeof(struct audio_client), GFP_KERNEL);
> 
> sizeof(*ac)

Yep.

> 
>> +	if (!ac)
>> +		return NULL;
>> +
>> +	n = q6asm_session_alloc(ac, a);
> 
> As stated above, moving the kzalloc into q6asm_session_alloc() would
> clean the code up here, as you only need to deal with one possible
> error case here.

Will give it a go and see.

> 
>> +	if (n <= 0) {
>> +		dev_err(dev, "ASM Session alloc fail n=%d\n", n);
>> +		kfree(ac);
>> +		return NULL;
> 
> Per the kerneldoc I expect an ERR_PTR(n) here.
> 
yep.

>> +	}
>> +
>> +	ac->session = n;
>> +	ac->cb = cb;
>> +	ac->dev = dev;
>> +	ac->priv = priv;
>> +	ac->io_mode = SYNC_IO_MODE;
>> +	ac->perf_mode = LEGACY_PCM_MODE;
>> +	/* DSP expects stream id from 1 */
>> +	ac->stream_id = 1;
>> +	ac->adev = a->adev;
>> +
>> +	init_waitqueue_head(&ac->cmd_wait);
>> +	mutex_init(&ac->cmd_lock);
>> +	ac->cmd_state = 0;
>> +
>> +	return ac;
>> +}
>> +EXPORT_SYMBOL_GPL(q6asm_audio_client_alloc);
>> +
>> +
> 
> Extra newline.
> 
yep, will fix it.

[...]
>> +
>> +static struct apr_driver qcom_q6asm_driver = {
>> +	.probe = q6asm_probe,
>> +	.remove = q6asm_remove,
>> +	.callback = q6asm_srvc_callback,
>> +	.id_table = q6asm_id,
>> +	.driver = {
>> +		   .name = "qcom-q6asm",
>> +		   },
> 
> Indentation

yep.

> 
>> +};
>> +
>> +module_apr_driver(qcom_q6asm_driver);
>> +MODULE_DESCRIPTION("Q6 Audio Stream Manager driver");
>> +MODULE_LICENSE("GPL v2");
>> diff --git a/sound/soc/qcom/qdsp6/q6asm.h b/sound/soc/qcom/qdsp6/q6asm.h
>> new file mode 100644
>> index 000000000000..7a8a9039fd89
>> --- /dev/null
>> +++ b/sound/soc/qcom/qdsp6/q6asm.h
>> @@ -0,0 +1,14 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +#ifndef __Q6_ASM_H__
>> +#define __Q6_ASM_H__
>> +
>> +#define MAX_SESSIONS	16
>> +
>> +typedef void (*app_cb) (uint32_t opcode, uint32_t token,
>> +			uint32_t *payload, void *priv);
> 
> This name of a type is too generic.
> 
> And make payload void *, unless the payload really really is an
> unstructured uint32_t array.
will do that as suggested.
> 
> Regards,
> Bjorn
> 
