From: rohitkr@codeaurora.org (Rohit Kumar)
Date: Sat, 13 Jan 2018 14:12:33 +0530
Subject: [alsa-devel] [RESEND PATCH v2 08/15] ASoC: qcom: q6asm: add
 support to audio stream apis
In-Reply-To: <20171214173402.19074-9-srinivas.kandagatla@linaro.org>
References: <20171214173402.19074-1-srinivas.kandagatla@linaro.org>
 <20171214173402.19074-9-srinivas.kandagatla@linaro.org>
Message-ID: <8a895c84-cf2f-b192-ab66-14ea624edcdb@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 12/14/2017 11:03 PM, srinivas.kandagatla at linaro.org wrote:
> From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>
> This patch adds support to open, write and media format commands
> in the q6asm module.
[..]
> +static int32_t q6asm_callback(struct apr_device *adev,
> +			      struct apr_client_data *data, int session_id)
> +{
> +	struct audio_client *ac;// = (struct audio_client *)priv;
> +	uint32_t token;
> +	uint32_t *payload;
> +	uint32_t wakeup_flag = 1;
> +	uint32_t client_event = 0;
> +	struct q6asm *q6asm = dev_get_drvdata(&adev->dev);
> +
> +	if (data == NULL)
> +		return -EINVAL;
> +
> +	ac = q6asm_get_audio_client(q6asm, session_id);
> +	if (!q6asm_is_valid_audio_client(ac))
> +		return -EINVAL;
> +
ac could get freed by q6asm_audio_client_free during the execution of 
q6asm_callback as they are running in different thread.
Add synchronization.
> +	payload = data->payload;
> +
> +	if (data->opcode == APR_BASIC_RSP_RESULT) {
> +		token = data->token;
> +		switch (payload[0]) {
> +		case ASM_SESSION_CMD_PAUSE:
> +			client_event = ASM_CLIENT_EVENT_CMD_PAUSE_DONE;
> +			break;
> +		case ASM_SESSION_CMD_SUSPEND:
> +			client_event = ASM_CLIENT_EVENT_CMD_SUSPEND_DONE;
> +			break;
> +		case ASM_DATA_CMD_EOS:
> +			client_event = ASM_CLIENT_EVENT_CMD_EOS_DONE;
> +			break;
> +			break;
> +		case ASM_STREAM_CMD_FLUSH:
> +			client_event = ASM_CLIENT_EVENT_CMD_FLUSH_DONE;
> +			break;
> +		case ASM_SESSION_CMD_RUN_V2:
> +			client_event = ASM_CLIENT_EVENT_CMD_RUN_DONE;
> +			break;
> +
> +		case ASM_STREAM_CMD_FLUSH_READBUFS:
> +			if (token != ac->session) {
> +				dev_err(ac->dev, "session invalid\n");
> +				return -EINVAL;
> +			}
> +		case ASM_STREAM_CMD_CLOSE:
> +			client_event = ASM_CLIENT_EVENT_CMD_CLOSE_DONE;
> +			break;
> +		case ASM_STREAM_CMD_OPEN_WRITE_V3:
> +		case ASM_DATA_CMD_MEDIA_FMT_UPDATE_V2:
> +			if (payload[1] != 0) {
> +				dev_err(ac->dev,
> +					"cmd = 0x%x returned error = 0x%x\n",
> +					payload[0], payload[1]);
> +				if (wakeup_flag) {
> +					ac->cmd_state = payload[1];
> +					wake_up(&ac->cmd_wait);
> +				}
> +				return 0;
> +			}
> +			break;
> +		default:
> +			dev_err(ac->dev, "command[0x%x] not expecting rsp\n",
> +				payload[0]);
> +			break;
> +		}
> +
> +		if (ac->cmd_state && wakeup_flag) {
> +			ac->cmd_state = 0;
> +			wake_up(&ac->cmd_wait);
> +		}
> +		if (ac->cb)
> +			ac->cb(client_event, data->token,
> +			       data->payload, ac->priv);
> +
> +		return 0;
> +	}
> +
> +	switch (data->opcode) {
> +	case ASM_DATA_EVENT_WRITE_DONE_V2:{
> +			struct audio_port_data *port =
> +			    &ac->port[SNDRV_PCM_STREAM_PLAYBACK];
> +
> +			client_event = ASM_CLIENT_EVENT_DATA_WRITE_DONE;
> +
> +			if (ac->io_mode & SYNC_IO_MODE) {
> +				dma_addr_t phys = port->buf[data->token].phys;
> +
> +				if (lower_32_bits(phys) != payload[0] ||
> +				    upper_32_bits(phys) != payload[1]) {
> +					dev_err(ac->dev, "Expected addr %pa\n",
> +						&port->buf[data->token].phys);
> +					return -EINVAL;
> +				}
> +				token = data->token;
> +				port->buf[token].used = 1;
> +			}
> +			break;
> +		}
> +	}
> +	if (ac->cb)
> +		ac->cb(client_event, data->token, data->payload, ac->priv);
> +
> +	return 0;
> +}
> +
[..]
> +/**
> + * q6asm_media_format_block_multi_ch_pcm() - setup pcm configuration
> + *
> + * @ac: audio client pointer
> + * @rate: audio sample rate
> + * @channels: number of audio channels.
> + * @use_default_chmap: flag to use default ch map.
> + * @channel_map: channel map pointer
> + * @bits_per_sample: bits per sample
> + *
> + * Return: Will be an negative value on error or zero on success
> + */
> +int q6asm_media_format_block_multi_ch_pcm(struct audio_client *ac,
> +					  uint32_t rate, uint32_t channels,
> +					  bool use_default_chmap,
> +					  char *channel_map,
> +					  uint16_t bits_per_sample)
> +{
> +	struct asm_multi_channel_pcm_fmt_blk_v2 fmt;
asm_multi_channel_pcm_fmt_blk_v4 is now being used in latest adsp. 
Better to add adsp version based support to handle different struct
> +	u8 *channel_mapping;
> +	int rc = 0;
> +
> +	q6asm_add_hdr(ac, &fmt.hdr, sizeof(fmt), true, ac->stream_id);
> +	ac->cmd_state = -1;
> +
> +	fmt.hdr.opcode = ASM_DATA_CMD_MEDIA_FMT_UPDATE_V2;
> +	fmt.fmt_blk.fmt_blk_size = sizeof(fmt) - sizeof(fmt.hdr) -
> +	    sizeof(fmt.fmt_blk);
> +	fmt.num_channels = channels;
> +	fmt.bits_per_sample = bits_per_sample;
> +	fmt.sample_rate = rate;
> +	fmt.is_signed = 1;
> +
> +	channel_mapping = fmt.channel_mapping;
> +
> +	if (use_default_chmap) {
> +		if (q6dsp_map_channels(channel_mapping, channels)) {
> +			dev_err(ac->dev, " map channels failed %d\n", channels);
> +			return -EINVAL;
> +		}
> +	} else {
> +		memcpy(channel_mapping, channel_map,
> +		       PCM_FORMAT_MAX_NUM_CHANNEL);
> +	}
> +
> +	rc = apr_send_pkt(ac->adev, (uint32_t *) &fmt);
> +	if (rc < 0)
> +		goto fail_cmd;
> +
> +	rc = wait_event_timeout(ac->cmd_wait, (ac->cmd_state >= 0), 5 * HZ);
> +	if (!rc) {
> +		dev_err(ac->dev, "timeout on format update\n");
> +		return -ETIMEDOUT;
> +	}
> +	if (ac->cmd_state > 0)
> +		return adsp_err_get_lnx_err_code(ac->cmd_state);
> +
> +	return 0;
> +fail_cmd:
> +	return rc;
> +}
> +EXPORT_SYMBOL_GPL(q6asm_media_format_block_multi_ch_pcm);
> +
> +/**
> + * q6asm_write_nolock() - non blocking write
> + *
> + * @ac: audio client pointer
> + * @len: lenght in bytes
> + * @msw_ts: timestamp msw
> + * @lsw_ts: timestamp lsw
> + * @flags: flags associated with write
> + *
> + * Return: Will be an negative value on error or zero on success
> + */
> +int q6asm_write_nolock(struct audio_client *ac, uint32_t len, uint32_t msw_ts,
> +		       uint32_t lsw_ts, uint32_t flags)
> +{
> +	struct asm_data_cmd_write_v2 write;
> +	struct audio_port_data *port;
> +	struct audio_buffer *ab;
> +	int dsp_buf = 0;
> +	int rc = 0;
> +
> +	if (ac->io_mode & SYNC_IO_MODE) {
> +		port = &ac->port[SNDRV_PCM_STREAM_PLAYBACK];
> +		q6asm_add_hdr(ac, &write.hdr, sizeof(write), false,
> +			      ac->stream_id);
> +
> +		dsp_buf = port->dsp_buf;
> +		ab = &port->buf[dsp_buf];
> +
> +		write.hdr.token = port->dsp_buf;
> +		write.hdr.opcode = ASM_DATA_CMD_WRITE_V2;
> +		write.buf_addr_lsw = lower_32_bits(ab->phys);
> +		write.buf_addr_msw = upper_32_bits(ab->phys);
> +		write.buf_size = len;
> +		write.seq_id = port->dsp_buf;
> +		write.timestamp_lsw = lsw_ts;
> +		write.timestamp_msw = msw_ts;
> +		write.mem_map_handle =
> +		    ac->port[SNDRV_PCM_STREAM_PLAYBACK].mem_map_handle;
> +
> +		if (flags == NO_TIMESTAMP)
> +			write.flags = (flags & 0x800000FF);
> +		else
> +			write.flags = (0x80000000 | flags);
> +
> +		port->dsp_buf++;
> +
> +		if (port->dsp_buf >= port->max_buf_cnt)
> +			port->dsp_buf = 0;
> +
> +		rc = apr_send_pkt(ac->adev, (uint32_t *) &write);
> +		if (rc < 0)
> +			return rc;
> +	}
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(q6asm_write_nolock);
> +
> +static void q6asm_reset_buf_state(struct audio_client *ac)
> +{
> +	int cnt = 0;
> +	int loopcnt = 0;
> +	int used;
> +	struct audio_port_data *port = NULL;
> +
> +	if (ac->io_mode & SYNC_IO_MODE) {
> +		used = (ac->io_mode & TUN_WRITE_IO_MODE ? 1 : 0);
> +		mutex_lock(&ac->cmd_lock);
> +		for (loopcnt = 0; loopcnt <= SNDRV_PCM_STREAM_CAPTURE;
> +		     loopcnt++) {
> +			port = &ac->port[loopcnt];
> +			cnt = port->max_buf_cnt - 1;
> +			port->dsp_buf = 0;
> +			while (cnt >= 0) {
> +				if (!port->buf)
> +					continue;
> +				port->buf[cnt].used = used;
> +				cnt--;
> +			}
> +		}
> +		mutex_unlock(&ac->cmd_lock);
> +	}
> +}
> +
> +static int __q6asm_cmd(struct audio_client *ac, int cmd, bool wait)
> +{
> +	int stream_id = ac->stream_id;
> +	struct apr_hdr hdr;
> +	int rc;
> +
> +	q6asm_add_hdr(ac, &hdr, sizeof(hdr), true, stream_id);
> +	ac->cmd_state = -1;
> +	switch (cmd) {
> +	case CMD_PAUSE:
> +		hdr.opcode = ASM_SESSION_CMD_PAUSE;
> +		break;
> +	case CMD_SUSPEND:
> +		hdr.opcode = ASM_SESSION_CMD_SUSPEND;
> +		break;
> +	case CMD_FLUSH:
> +		hdr.opcode = ASM_STREAM_CMD_FLUSH;
> +		break;
> +	case CMD_OUT_FLUSH:
> +		hdr.opcode = ASM_STREAM_CMD_FLUSH_READBUFS;
> +		break;
> +	case CMD_EOS:
> +		hdr.opcode = ASM_DATA_CMD_EOS;
> +		ac->cmd_state = 0;
> +		break;
> +	case CMD_CLOSE:
> +		hdr.opcode = ASM_STREAM_CMD_CLOSE;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	rc = apr_send_pkt(ac->adev, (uint32_t *) &hdr);
> +	if (rc < 0)
> +		return rc;
> +
> +	if (!wait)
> +		return 0;
> +
> +	rc = wait_event_timeout(ac->cmd_wait, (ac->cmd_state >= 0), 5 * HZ);
> +	if (!rc) {
> +		dev_err(ac->dev, "timeout response for opcode[0x%x]\n",
> +			hdr.opcode);
> +		return -ETIMEDOUT;
> +	}
> +	if (ac->cmd_state > 0)
> +		return adsp_err_get_lnx_err_code(ac->cmd_state);
> +
> +	if (cmd == CMD_FLUSH)
> +		q6asm_reset_buf_state(ac);
> +
> +	return 0;
> +}
> +
> +/**
> + * q6asm_cmd() - run cmd on audio client
> + *
> + * @ac: audio client pointer
> + * @cmd: command to run on audio client.
> + *
> + * Return: Will be an negative value on error or zero on success
> + */
> +int q6asm_cmd(struct audio_client *ac, int cmd)
> +{
> +	return __q6asm_cmd(ac, cmd, true);
> +}
> +EXPORT_SYMBOL_GPL(q6asm_cmd);
> +
> +/**
> + * q6asm_cmd_nowait() - non blocking, run cmd on audio client
> + *
> + * @ac: audio client pointer
> + * @cmd: command to run on audio client.
> + *
> + * Return: Will be an negative value on error or zero on success
> + */
> +int q6asm_cmd_nowait(struct audio_client *ac, int cmd)
> +{
> +	return __q6asm_cmd(ac, cmd, false);
> +}
> +EXPORT_SYMBOL_GPL(q6asm_cmd_nowait);
>   
>   static int q6asm_probe(struct apr_device *adev)
>   {
> diff --git a/sound/soc/qcom/qdsp6/q6asm.h b/sound/soc/qcom/qdsp6/q6asm.h
> index e1409c368600..b4896059da79 100644
> --- a/sound/soc/qcom/qdsp6/q6asm.h
> +++ b/sound/soc/qcom/qdsp6/q6asm.h
> @@ -2,7 +2,34 @@
>   #ifndef __Q6_ASM_H__
>   #define __Q6_ASM_H__
>   
> +/* ASM client callback events */
> +#define CMD_PAUSE			0x0001
> +#define ASM_CLIENT_EVENT_CMD_PAUSE_DONE		0x1001
> +#define CMD_FLUSH				0x0002
> +#define ASM_CLIENT_EVENT_CMD_FLUSH_DONE		0x1002
> +#define CMD_EOS				0x0003
> +#define ASM_CLIENT_EVENT_CMD_EOS_DONE		0x1003
> +#define CMD_CLOSE				0x0004
> +#define ASM_CLIENT_EVENT_CMD_CLOSE_DONE		0x1004
> +#define CMD_OUT_FLUSH				0x0005
> +#define ASM_CLIENT_EVENT_CMD_OUT_FLUSH_DONE	0x1005
> +#define CMD_SUSPEND				0x0006
> +#define ASM_CLIENT_EVENT_CMD_SUSPEND_DONE	0x1006
> +#define ASM_CLIENT_EVENT_CMD_RUN_DONE		0x1008
> +#define ASM_CLIENT_EVENT_DATA_WRITE_DONE	0x1009
> +
> +#define MSM_FRONTEND_DAI_MULTIMEDIA1	0
> +#define MSM_FRONTEND_DAI_MULTIMEDIA2	1
> +#define	MSM_FRONTEND_DAI_MULTIMEDIA3	2
> +#define MSM_FRONTEND_DAI_MULTIMEDIA4	3
> +#define MSM_FRONTEND_DAI_MULTIMEDIA5	4
> +#define MSM_FRONTEND_DAI_MULTIMEDIA6	5
> +#define	MSM_FRONTEND_DAI_MULTIMEDIA7	6
> +#define	MSM_FRONTEND_DAI_MULTIMEDIA8	7
> +
>   #define MAX_SESSIONS	16
> +#define NO_TIMESTAMP    0xFF00
> +#define FORMAT_LINEAR_PCM   0x0000
>   
>   typedef void (*app_cb) (uint32_t opcode, uint32_t token,
>   			uint32_t *payload, void *priv);
> @@ -10,6 +37,21 @@ struct audio_client;
>   struct audio_client *q6asm_audio_client_alloc(struct device *dev,
>   					      app_cb cb, void *priv);
>   void q6asm_audio_client_free(struct audio_client *ac);
> +int q6asm_write_nolock(struct audio_client *ac, uint32_t len, uint32_t msw_ts,
> +		       uint32_t lsw_ts, uint32_t flags);
> +int q6asm_open_write(struct audio_client *ac, uint32_t format,
> +		     uint16_t bits_per_sample);
> +int q6asm_media_format_block_multi_ch_pcm(struct audio_client *ac,
> +					  uint32_t rate, uint32_t channels,
> +					  bool use_default_chmap,
> +					  char *channel_map,
> +					  uint16_t bits_per_sample);
> +int q6asm_run(struct audio_client *ac, uint32_t flags, uint32_t msw_ts,
> +	      uint32_t lsw_ts);
> +int q6asm_run_nowait(struct audio_client *ac, uint32_t flags, uint32_t msw_ts,
> +		     uint32_t lsw_ts);
> +int q6asm_cmd(struct audio_client *ac, int cmd);
> +int q6asm_cmd_nowait(struct audio_client *ac, int cmd);
>   int q6asm_get_session_id(struct audio_client *ac);
>   int q6asm_map_memory_regions(unsigned int dir,
>   			     struct audio_client *ac,
