From: srinivas.kandagatla@linaro.org (Srinivas Kandagatla)
Date: Wed, 3 Jan 2018 16:26:57 +0000
Subject: [RESEND PATCH v2 08/15] ASoC: qcom: q6asm: add support to audio
 stream apis
In-Reply-To: <20180102200813.GA8625@builder>
References: <20171214173402.19074-1-srinivas.kandagatla@linaro.org>
 <20171214173402.19074-9-srinivas.kandagatla@linaro.org>
 <20180102200813.GA8625@builder>
Message-ID: <4a4aff7e-84a9-95a7-c82c-d2eb0aa5d220@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thanks for your comments.


On 02/01/18 20:08, Bjorn Andersson wrote:
> On Thu 14 Dec 09:33 PST 2017, srinivas.kandagatla at linaro.org wrote:
> 
>> From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>>
>> This patch adds support to open, write and media format commands
>> in the q6asm module.
>>
>> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>> ---
>>   sound/soc/qcom/qdsp6/q6asm.c | 530 ++++++++++++++++++++++++++++++++++++++++++-
>>   sound/soc/qcom/qdsp6/q6asm.h |  42 ++++
>>   2 files changed, 571 insertions(+), 1 deletion(-)
>>
>> diff --git a/sound/soc/qcom/qdsp6/q6asm.c b/sound/soc/qcom/qdsp6/q6asm.c
>> index 4be92441f524..dabd6509ef99 100644
>> --- a/sound/soc/qcom/qdsp6/q6asm.c
>> +++ b/sound/soc/qcom/qdsp6/q6asm.c
>> @@ -8,16 +8,34 @@
>>   #include <linux/soc/qcom/apr.h>
>>   #include <linux/device.h>
>>   #include <linux/platform_device.h>
>> +#include <uapi/sound/asound.h>
>>   #include <linux/delay.h>
>>   #include <linux/slab.h>
>>   #include <linux/mm.h>
>>   #include "q6asm.h"
>>   #include "common.h"
>>   
>> +#define ASM_STREAM_CMD_CLOSE			0x00010BCD
>> +#define ASM_STREAM_CMD_FLUSH			0x00010BCE
>> +#define ASM_SESSION_CMD_PAUSE			0x00010BD3
>> +#define ASM_DATA_CMD_EOS			0x00010BDB
>> +#define DEFAULT_POPP_TOPOLOGY			0x00010BE4
>> +#define ASM_STREAM_CMD_FLUSH_READBUFS		0x00010C09
>>   #define ASM_CMD_SHARED_MEM_MAP_REGIONS		0x00010D92
>>   #define ASM_CMDRSP_SHARED_MEM_MAP_REGIONS	0x00010D93
>>   #define ASM_CMD_SHARED_MEM_UNMAP_REGIONS	0x00010D94
>> -
>> +#define ASM_DATA_CMD_MEDIA_FMT_UPDATE_V2	0x00010D98
>> +#define ASM_DATA_EVENT_WRITE_DONE_V2		0x00010D99
>> +#define ASM_SESSION_CMD_RUN_V2			0x00010DAA
>> +#define ASM_MEDIA_FMT_MULTI_CHANNEL_PCM_V2	0x00010DA5
>> +#define ASM_DATA_CMD_WRITE_V2			0x00010DAB
>> +#define ASM_SESSION_CMD_SUSPEND			0x00010DEC
>> +#define ASM_STREAM_CMD_OPEN_WRITE_V3		0x00010DB3
>> +
>> +#define ASM_LEGACY_STREAM_SESSION	0
>> +#define ASM_END_POINT_DEVICE_MATRIX	0
>> +#define DEFAULT_APP_TYPE		0
>> +#define TUN_WRITE_IO_MODE		0x0008	/* tunnel read write mode */
>>   #define TUN_READ_IO_MODE		0x0004	/* tunnel read write mode */
>>   #define SYNC_IO_MODE			0x0001
>>   #define ASYNC_IO_MODE			0x0002
> 
> Probably prettier to reorder these and make them Q6ASM_IO_MODE_xyz
Sure I will try that.

> 
> [..]
>>   
>> +static int32_t q6asm_callback(struct apr_device *adev,
> 
> This callback is an extracted part of q6asm_srvc_callback(), can it be
> given a more descriptive name?

May be q6asm_stream_callback/q6asm_session_callback() should be better.


> 
>> +			      struct apr_client_data *data, int session_id)
>> +{
>> +	struct audio_client *ac;// = (struct audio_client *)priv;
>> +	uint32_t token;
>> +	uint32_t *payload;
>> +	uint32_t wakeup_flag = 1;
>> +	uint32_t client_event = 0;
>> +	struct q6asm *q6asm = dev_get_drvdata(&adev->dev);
>> +
>> +	if (data == NULL)
>> +		return -EINVAL;
>> +
>> +	ac = q6asm_get_audio_client(q6asm, session_id);
>> +	if (!q6asm_is_valid_audio_client(ac))
>> +		return -EINVAL;
>> +
>> +	payload = data->payload;
>> +
>> +	if (data->opcode == APR_BASIC_RSP_RESULT) {
> 
> Move this into the switch.

Yep, will cleanup these instances.
> 
>> +		token = data->token;
>> +		switch (payload[0]) {
> 
> This is again that common response struct.
> 
yep!

[...]

>> +
>> +	return 0;
>> +}
>> +
>>   static int q6asm_srvc_callback(struct apr_device *adev, struct apr_client_data *data)
>>   {
>>   	struct q6asm *a, *q6asm = dev_get_drvdata(&adev->dev);
>> @@ -415,12 +581,16 @@ static int q6asm_srvc_callback(struct apr_device *adev, struct apr_client_data *
>>   	struct audio_port_data *port;
>>   	uint32_t dir = 0;
>>   	uint32_t sid = 0;
>> +	int dest_port;
>>   	uint32_t *payload;
>>   
>>   	if (!data) {
>>   		dev_err(&adev->dev, "%s: Invalid CB\n", __func__);
>>   		return 0;
>>   	}
>> +	dest_port = (data->dest_port >> 8) & 0xFF;
>> +	if (dest_port)
>> +		return q6asm_callback(adev, data, dest_port);
> 
> You call dest_port "session_id" above, this seems to be a better name
> for this variable.
> 
yes

>>   
>>   	payload = data->payload;
>>   	sid = (data->token >> 8) & 0x0F;
>> @@ -540,6 +710,364 @@ struct audio_client *q6asm_audio_client_alloc(struct device *dev,
>>   }
>>   EXPORT_SYMBOL_GPL(q6asm_audio_client_alloc);
>>   
>> +static int __q6asm_open_write(struct audio_client *ac, uint32_t format,
>> +			      uint16_t bits_per_sample, uint32_t stream_id,
>> +			      bool is_gapless_mode)
>> +{
>> +	struct asm_stream_cmd_open_write_v3 open;
>> +	int rc;
>> +
>> +	q6asm_add_hdr(ac, &open.hdr, sizeof(open), true, stream_id);
>> +	ac->cmd_state = -1;
>> +
>> +	open.hdr.opcode = ASM_STREAM_CMD_OPEN_WRITE_V3;
>> +	open.mode_flags = 0x00;
>> +	open.mode_flags |= ASM_LEGACY_STREAM_SESSION;
>> +	if (is_gapless_mode)
> 
> This is hard coded as false.
> 

Will clean this up.

>> +		open.mode_flags |= 1 << ASM_SHIFT_GAPLESS_MODE_FLAG;
>> +
>> +	/* source endpoint : matrix */
>> +	open.sink_endpointype = ASM_END_POINT_DEVICE_MATRIX;
>> +	open.bits_per_sample = bits_per_sample;
>> +	open.postprocopo_id = DEFAULT_POPP_TOPOLOGY;
>> +
>> +	switch (format) {
>> +	case FORMAT_LINEAR_PCM:
>> +		open.dec_fmt_id = ASM_MEDIA_FMT_MULTI_CHANNEL_PCM_V2;
>> +		break;
>> +	default:
>> +		dev_err(ac->dev, "Invalid format 0x%x\n", format);
>> +		return -EINVAL;
>> +	}
>> +	rc = apr_send_pkt(ac->adev, (uint32_t *) &open);
>> +	if (rc < 0)
>> +		return rc;
>> +
>> +	rc = wait_event_timeout(ac->cmd_wait, (ac->cmd_state >= 0), 5 * HZ);
>> +	if (!rc) {
>> +		dev_err(ac->dev, "timeout on open write\n");
>> +		return -ETIMEDOUT;
>> +	}
> 
> Almost every time you apr_send_pkt() you have this wait with timeout,
> can this send/wait/return be wrapped in a helper function to reduce the
> duplication?
> 
> Creating a q6asm_send_sync() and q6asm_send_async() pair with this logic
> should help quite a bit.
will do that with all the apr drivers.

> 
>> +
>> +	if (ac->cmd_state > 0)
>> +		return adsp_err_get_lnx_err_code(ac->cmd_state);
>> +
>> +	ac->io_mode |= TUN_WRITE_IO_MODE;
>> +
>> +	return 0;
>> +}
>> +
>> +/**
>> + * q6asm_open_write() - Open audio client for writing
>> + *
>> + * @ac: audio client pointer
>> + * @format: audio sample format
>> + * @bits_per_sample: bits per sample
>> + *
>> + * Return: Will be an negative value on error or zero on success
>> + */
>> +int q6asm_open_write(struct audio_client *ac, uint32_t format,
>> +		     uint16_t bits_per_sample)
>> +{
>> +	return __q6asm_open_write(ac, format, bits_per_sample,
> 
> I don't see a particular reason for not inlining this, is there one
> coming later in the series?

No, will clean it up.

> 
>> +				  ac->stream_id, false);
>> +}
>> +EXPORT_SYMBOL_GPL(q6asm_open_write);
>> +
>> +static int __q6asm_run(struct audio_client *ac, uint32_t flags,
>> +	      uint32_t msw_ts, uint32_t lsw_ts, bool wait)
>> +{
>> +	struct asm_session_cmd_run_v2 run;
>> +	int rc;
>> +
>> +	q6asm_add_hdr(ac, &run.hdr, sizeof(run), true, ac->stream_id);
>> +	ac->cmd_state = -1;
>> +
>> +	run.hdr.opcode = ASM_SESSION_CMD_RUN_V2;
>> +	run.flags = flags;
>> +	run.time_lsw = lsw_ts;
>> +	run.time_msw = msw_ts;
>> +
>> +	rc = apr_send_pkt(ac->adev, (uint32_t *) &run);
>> +	if (rc < 0)
>> +		return rc;
>> +
>> +	if (wait) {
> 
> Rather than having half of the function conditional I would recommend
> inlining this function in the two callers.
> 
> In particular if you can come up with a helper function for the
> send/wait/handle-error case.

sure.

> 
>> +		rc = wait_event_timeout(ac->cmd_wait, (ac->cmd_state >= 0),
>> +					5 * HZ);
>> +		if (!rc) {
>> +			dev_err(ac->dev, "timeout on run cmd\n");
>> +			return -ETIMEDOUT;
>> +		}
>> +		if (ac->cmd_state > 0)
>> +			return adsp_err_get_lnx_err_code(ac->cmd_state);
>> +	}
>> +
>> +	return 0;
>> +}
>>
>> +/**
>> + * q6asm_media_format_block_multi_ch_pcm() - setup pcm configuration
>> + *
>> + * @ac: audio client pointer
>> + * @rate: audio sample rate
>> + * @channels: number of audio channels.
>> + * @use_default_chmap: flag to use default ch map.
>> + * @channel_map: channel map pointer
>> + * @bits_per_sample: bits per sample
>> + *
>> + * Return: Will be an negative value on error or zero on success
>> + */
>> +int q6asm_media_format_block_multi_ch_pcm(struct audio_client *ac,
>> +					  uint32_t rate, uint32_t channels,
>> +					  bool use_default_chmap,
>> +					  char *channel_map,
> 
> This should be u8 channel_map[PCM_FORMAT_MAX_NUM_CHANNEL], possibly
> char. Unless you, as I suggest below, want to be able to represent
> use_default_chmap = false, by setting this to NULL.
> 
>> +					  uint16_t bits_per_sample)
>> +{
>> +	struct asm_multi_channel_pcm_fmt_blk_v2 fmt;
>> +	u8 *channel_mapping;
>> +	int rc = 0;
> 
> Unnecessary initialization.
yep.

> 
>> +
>> +	q6asm_add_hdr(ac, &fmt.hdr, sizeof(fmt), true, ac->stream_id);
>> +	ac->cmd_state = -1;
>> +
>> +	fmt.hdr.opcode = ASM_DATA_CMD_MEDIA_FMT_UPDATE_V2;
>> +	fmt.fmt_blk.fmt_blk_size = sizeof(fmt) - sizeof(fmt.hdr) -
>> +	    sizeof(fmt.fmt_blk);
>> +	fmt.num_channels = channels;
>> +	fmt.bits_per_sample = bits_per_sample;
>> +	fmt.sample_rate = rate;
>> +	fmt.is_signed = 1;
>> +
>> +	channel_mapping = fmt.channel_mapping;
>> +
>> +	if (use_default_chmap) {
> 
> Passing NULL as channel_map would probably be a nicer way to say this,
> instead of having a separate bool.
I will give it a go and see.
> 
>> +		if (q6dsp_map_channels(channel_mapping, channels)) {
>> +			dev_err(ac->dev, " map channels failed %d\n", channels);
>> +			return -EINVAL;
>> +		}
>> +	} else {
>> +		memcpy(channel_mapping, channel_map,
>> +		       PCM_FORMAT_MAX_NUM_CHANNEL);
>> +	}
>> +
>> +	rc = apr_send_pkt(ac->adev, (uint32_t *) &fmt);
>> +	if (rc < 0)
>> +		goto fail_cmd;
>> +
>> +	rc = wait_event_timeout(ac->cmd_wait, (ac->cmd_state >= 0), 5 * HZ);
>> +	if (!rc) {
>> +		dev_err(ac->dev, "timeout on format update\n");
>> +		return -ETIMEDOUT;
>> +	}
>> +	if (ac->cmd_state > 0)
>> +		return adsp_err_get_lnx_err_code(ac->cmd_state);
>> +
>> +	return 0;
>> +fail_cmd:
>> +	return rc;
>> +}
>> +EXPORT_SYMBOL_GPL(q6asm_media_format_block_multi_ch_pcm);
>> +
>> +/**
>> + * q6asm_write_nolock() - non blocking write
>> + *
>> + * @ac: audio client pointer
>> + * @len: lenght in bytes
>> + * @msw_ts: timestamp msw
>> + * @lsw_ts: timestamp lsw
>> + * @flags: flags associated with write
>> + *
>> + * Return: Will be an negative value on error or zero on success
>> + */
>> +int q6asm_write_nolock(struct audio_client *ac, uint32_t len, uint32_t msw_ts,
>> +		       uint32_t lsw_ts, uint32_t flags)
> 
> q6asm_write_async() is probably a better name, nolock indicates some
> relationship to mutual exclusions...
> 
yep.

>> +{
>> +	struct asm_data_cmd_write_v2 write;
>> +	struct audio_port_data *port;
>> +	struct audio_buffer *ab;
>> +	int dsp_buf = 0;
>> +	int rc = 0;
>> +
>> +	if (ac->io_mode & SYNC_IO_MODE) {
> 
> Bail early if this isn't true, to save you the indentation level.
> 
yep.

>> +		port = &ac->port[SNDRV_PCM_STREAM_PLAYBACK];
>> +		q6asm_add_hdr(ac, &write.hdr, sizeof(write), false,
>> +			      ac->stream_id);
>> +
>> +		dsp_buf = port->dsp_buf;
>> +		ab = &port->buf[dsp_buf];
> 
> So we're just unconditionally telling the remote side about the next buf
> in our ring buffer. Do we need to ensure that this is available/ready?
> 

This is already synchronized at the top layer in q6asm_dai driver.

>> +
>> +		write.hdr.token = port->dsp_buf;
>> +		write.hdr.opcode = ASM_DATA_CMD_WRITE_V2;
>> +		write.buf_addr_lsw = lower_32_bits(ab->phys);
>> +		write.buf_addr_msw = upper_32_bits(ab->phys);
>> +		write.buf_size = len;
>> +		write.seq_id = port->dsp_buf;
>> +		write.timestamp_lsw = lsw_ts;
>> +		write.timestamp_msw = msw_ts;
>> +		write.mem_map_handle =
>> +		    ac->port[SNDRV_PCM_STREAM_PLAYBACK].mem_map_handle;
>> +
>> +		if (flags == NO_TIMESTAMP)
>> +			write.flags = (flags & 0x800000FF);
> 
> Fill in the constant and this becomes
> 
> 	if flags == 0xff00:
> 		write.flags = 0xff00 & 0x800000ff;
> 
> Or in other words:
> 	if flags == 0xff00:
> 		write.flags = 0;
> 
>> +		else
>> +			write.flags = (0x80000000 | flags);
> 
> Drop the parenthesis and flip the |. It would be nice to have a define
> or a comment indicating what BIT(31) is...

sure, I will make add more information here on the flag and also cleanup 
as suggested.
> 
>> +
>> +		port->dsp_buf++;
>> +
>> +		if (port->dsp_buf >= port->max_buf_cnt)
>> +			port->dsp_buf = 0;
>> +
>> +		rc = apr_send_pkt(ac->adev, (uint32_t *) &write);
>> +		if (rc < 0)
>> +			return rc;
>> +	}
>> +
>> +	return 0;
>> +}
>> +EXPORT_SYMBOL_GPL(q6asm_write_nolock);
>>

[...]

>> +
>> +static int __q6asm_cmd(struct audio_client *ac, int cmd, bool wait)
>> +{
>> +	int stream_id = ac->stream_id;
>> +	struct apr_hdr hdr;
>> +	int rc;
>> +
>> +	q6asm_add_hdr(ac, &hdr, sizeof(hdr), true, stream_id);
>> +	ac->cmd_state = -1;
> 
> Resetting cmd_state relates to the send, don't mix it with building the
> packet.
> 
Sure.

>> +	switch (cmd) {
>> +	case CMD_PAUSE:
>> +		hdr.opcode = ASM_SESSION_CMD_PAUSE;
>> +		break;
>> +	case CMD_SUSPEND:
>> +		hdr.opcode = ASM_SESSION_CMD_SUSPEND;
>> +		break;
>> +	case CMD_FLUSH:
>> +		hdr.opcode = ASM_STREAM_CMD_FLUSH;
>> +		break;
>> +	case CMD_OUT_FLUSH:
>> +		hdr.opcode = ASM_STREAM_CMD_FLUSH_READBUFS;
>> +		break;
>> +	case CMD_EOS:
>> +		hdr.opcode = ASM_DATA_CMD_EOS;
>> +		ac->cmd_state = 0;
>> +		break;
>> +	case CMD_CLOSE:
>> +		hdr.opcode = ASM_STREAM_CMD_CLOSE;
>> +		break;
>> +	default:
>> +		return -EINVAL;
>> +	}
>> +
>> +	rc = apr_send_pkt(ac->adev, (uint32_t *) &hdr);
>> +	if (rc < 0)
>> +		return rc;
>> +
>> +	if (!wait)
>> +		return 0;
> 
> I've asked you to split the others into _sync() vs _async() operations.
> 
> One particular concern I have is that I don't see any mutual exclusion
> protecting the cmd_state and a call with !wait will overwrite the
> existing value, which might be unexpected.
yes, this will be issue, we could move setting cmd_state to here.

Also I will revisit _sync() function to make sure that these are 
sequenced correctly and async are not touching the cmd_state.

> 
>> +
>> +	rc = wait_event_timeout(ac->cmd_wait, (ac->cmd_state >= 0), 5 * HZ);
>> +	if (!rc) {
>> +		dev_err(ac->dev, "timeout response for opcode[0x%x]\n",
>> +			hdr.opcode);
>> +		return -ETIMEDOUT;
>> +	}
>> +	if (ac->cmd_state > 0)
>> +		return adsp_err_get_lnx_err_code(ac->cmd_state);
>> +
>> +	if (cmd == CMD_FLUSH)
>> +		q6asm_reset_buf_state(ac);
>> +
>> +	return 0;
>> +}
> [..]
>> diff --git a/sound/soc/qcom/qdsp6/q6asm.h b/sound/soc/qcom/qdsp6/q6asm.h
>> index e1409c368600..b4896059da79 100644
>> --- a/sound/soc/qcom/qdsp6/q6asm.h
>> +++ b/sound/soc/qcom/qdsp6/q6asm.h
>> @@ -2,7 +2,34 @@
>>   #ifndef __Q6_ASM_H__
>>   #define __Q6_ASM_H__
>>   
>> +/* ASM client callback events */
>> +#define CMD_PAUSE			0x0001
> 
> These defines has rather generic names...

I can prefix them with Q6ASM to make it much more specific to Q6ASM service.

> 
> [..]
>> +
>> +#define MSM_FRONTEND_DAI_MULTIMEDIA1	0
>> +#define MSM_FRONTEND_DAI_MULTIMEDIA2	1
>> +#define	MSM_FRONTEND_DAI_MULTIMEDIA3	2
>> +#define MSM_FRONTEND_DAI_MULTIMEDIA4	3
>> +#define MSM_FRONTEND_DAI_MULTIMEDIA5	4
>> +#define MSM_FRONTEND_DAI_MULTIMEDIA6	5
>> +#define	MSM_FRONTEND_DAI_MULTIMEDIA7	6
>> +#define	MSM_FRONTEND_DAI_MULTIMEDIA8	7
>> +
>>   #define MAX_SESSIONS	16
>> +#define NO_TIMESTAMP    0xFF00
>> +#define FORMAT_LINEAR_PCM   0x0000
> 
> Ditto.
> 
> Regards,
> Bjorn
> 
