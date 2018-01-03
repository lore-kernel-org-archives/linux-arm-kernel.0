From: srinivas.kandagatla@linaro.org (Srinivas Kandagatla)
Date: Wed, 3 Jan 2018 16:26:35 +0000
Subject: [RESEND PATCH v2 04/15] ASoC: qcom: qdsp6: Add support to Q6AFE
In-Reply-To: <20180102004523.GM478@tuxbook>
References: <20171214173402.19074-1-srinivas.kandagatla@linaro.org>
 <20171214173402.19074-5-srinivas.kandagatla@linaro.org>
 <20180102004523.GM478@tuxbook>
Message-ID: <d4ac1306-c58f-abfd-bafe-5ae70a67d0eb@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thanks for the comments!

On 02/01/18 00:45, Bjorn Andersson wrote:
> On Thu 14 Dec 09:33 PST 2017, srinivas.kandagatla at linaro.org wrote:
> 
> [..]
>> +
>> +config SND_SOC_QDSP6_AFE
>> +	tristate
>> +	default n
> 
> Do you see a particular benefit of having one kernel module per
> function? Why not just compile them all into the same q6dsp.ko?
> 
No, I do not see any benefit in doing so, I can try to make it as single 
module in next version.

>> +
>> +config SND_SOC_QDSP6
>> +	tristate "SoC ALSA audio driver for QDSP6"
>> +	select SND_SOC_QDSP6_AFE
>> +	help
>> +	 To add support for MSM QDSP6 Soc Audio.
>> +	 This will enable sound soc platform specific
>> +	 audio drivers. This includes q6asm, q6adm,
>> +	 q6afe interfaces to DSP using apr.
> [..]
>> +struct q6afev2 {
>> +	void *apr;
> 
> apr has a type, even if it's definition is hidden you should use the
> proper type here.
>
I agree.

>> +	struct device *dev;
>> +	int state;
>> +	int status;
>> +	struct platform_device *daidev;
>> +
>> +	struct mutex afe_cmd_lock;
> 
> You shouldn't need to include afe_ in this name.
> 
make sense!
>> +	struct list_head port_list;
>> +	spinlock_t port_list_lock;
>> +	struct list_head node;
>> +};
>> +
> [..]
>> +/* Port map of index vs real hw port ids */
>> +static struct afe_port_map port_maps[AFE_PORT_MAX] = {
>> +		[AFE_PORT_HDMI_RX] = { AFE_PORT_ID_MULTICHAN_HDMI_RX,
> 
> Looks like you have an extra tab here, consider breaking the 80 char
> "rule" to not have to wrap these.
yep!
> 
>> +				       AFE_PORT_HDMI_RX, 1},
>> +};
>> +
>> +static struct q6afe_port *afe_find_port(struct q6afev2 *afe, int token)
>> +{
>> +	struct q6afe_port *p = NULL;
>> +
>> +	spin_lock(&afe->port_list_lock);
>> +	list_for_each_entry(p, &afe->port_list, node)
>> +		if (p->token == token)
>> +			break;
>> +
>> +	spin_unlock(&afe->port_list_lock);
>> +	return p;
>> +}
> 
> Make port_list an idr and you can just use idr_find() instead of rolling
> your own search function.
> 
Will give that a go.
>> +
>> +static int afe_callback(struct apr_device *adev, struct apr_client_data *data)
>> +{
>> +	struct q6afev2 *afe = dev_get_drvdata(&adev->dev);//priv;
> 
> This is perfectly fine, no need to extend the interface with a priv (so
> drop the comment).

I think it was a leftover, will clean such instances.
> 
>> +	struct q6afe_port *port;
>> +
>> +	if (!data) {
>> +		dev_err(afe->dev, "%s: Invalid param data\n", __func__);
>> +		return -EINVAL;
>> +	}
> 
> Just define on in the apr layer that data will never be NULL, that will
> save you 4 lines of code in every apr client.
> 
I agree!

>> +
>> +	if (data->payload_size) {
>> +		uint32_t *payload = data->payload;
> 
> So the payload is 2 ints, where the first is a command and the second is
> the status of it. This you can express in a simple struct to make the
> code even easier on the eye.
> 
Will do that, if it make code more readable.
>> +
>> +		if (data->opcode == APR_BASIC_RSP_RESULT) {
>> +			if (payload[1] != 0) {
>> +				afe->status = payload[1];
>> +				dev_err(afe->dev,
>> +					"cmd = 0x%x returned error = 0x%x\n",
>> +					payload[0], payload[1]);
>> +			}
>> +			switch (payload[0]) {
>> +			case AFE_PORT_CMD_SET_PARAM_V2:
>> +			case AFE_PORT_CMD_DEVICE_STOP:
>> +			case AFE_PORT_CMD_DEVICE_START:
>> +				afe->state = AFE_CMD_RESP_AVAIL;
>> +				port = afe_find_port(afe, data->token);
>> +				if (port)
>> +					wake_up(&port->wait);
>> +
>> +				break;
>> +			default:
>> +				dev_err(afe->dev, "Unknown cmd 0x%x\n",
>> +					payload[0]);
> 
> If you flip the check for payload_size to return early if there isn't a
> payload then you can reduce the indentation level one step and probably
> doesn't have to wrap this line.

yep make sense!

> 
>> +				break;
>> +			}
>> +		}
>> +	}
>> +	return 0;
>> +}
>> +/**
>> + * q6afe_get_port_id() - Get port id from a given port index
>> + *
>> + * @index: port index
>> + *
>> + * Return: Will be an negative on error or valid port_id on success
>> + */
>> +int q6afe_get_port_id(int index)
>> +{
>> +	if (index < 0 || index > AFE_PORT_MAX)
>> +		return -EINVAL;
>> +
>> +	return port_maps[index].port_id;
>> +}
>> +EXPORT_SYMBOL_GPL(q6afe_get_port_id);
>> +
>> +static int afe_apr_send_pkt(struct q6afev2 *afe, void *data,
>> +			    wait_queue_head_t *wait)
> 
> Rather than conditionally passing the wait, split this function in
> afe_send_sync(*afe, *data, wait) and afe_send_async(*afe, *data).
> 
Will do that across other modules too.
>> +{
>> +	int ret;
>> +
>> +	if (wait)
>> +		afe->state = AFE_CMD_RESP_NONE;
>> +
>> +	afe->status = 0;
>> +	ret = apr_send_pkt(afe->apr, data);
>> +	if (ret > 0) {
> 
> Check ret < 0 and return here, this saves you one indentation level in
> the following chunk.
> 
> If you then check !wait and return early you can reduce another level.
>
okay!


>> +		if (wait) {
>> +			ret = wait_event_timeout(*wait,
>> +						 (afe->state ==
>> +						 AFE_CMD_RESP_AVAIL),
>> +						 msecs_to_jiffies(TIMEOUT_MS));
>> +			if (!ret) {
>> +				ret = -ETIMEDOUT;
>> +			} else if (afe->status > 0) {
>> +				dev_err(afe->dev, "DSP returned error[%s]\n",
>> +				       adsp_err_get_err_str(afe->status));
>> +				ret = adsp_err_get_lnx_err_code(afe->status);
>> +			} else {
>> +				ret = 0;
>> +			}
>> +		} else {
>> +			ret = 0;
>> +		}
>> +	} else {
>> +		dev_err(afe->dev, "packet not transmitted\n");
>> +		ret = -EINVAL;
>> +	}
>> +
>> +	return ret;
>> +}
>> +
>> +static int afe_send_cmd_port_start(struct q6afe_port *port)
>> +{
>> +	u16 port_id = port->id;
>> +	struct afe_port_cmd_device_start start;
>> +	struct q6afev2 *afe = port->afe.v2;
>> +	int ret, index;
>> +
>> +	index = port->token;
>> +	start.hdr.hdr_field = APR_HDR_FIELD(APR_MSG_TYPE_SEQ_CMD,
>> +					    APR_HDR_LEN(APR_HDR_SIZE),
>> +					    APR_PKT_VER);
>> +	start.hdr.pkt_size = sizeof(start);
>> +	start.hdr.src_port = 0;
>> +	start.hdr.dest_port = 0;
>> +	start.hdr.token = index;
> 
> Just put port->token here, saves you a local variable.
> 
yep!

>> +	start.hdr.opcode = AFE_PORT_CMD_DEVICE_START;
>> +	start.port_id = port_id;
>> +
>> +	ret = afe_apr_send_pkt(afe, &start, &port->wait);
>> +	if (ret)
>> +		dev_err(afe->dev, "AFE enable for port 0x%x failed %d\n",
>> +		       port_id, ret);
>> +
>> +	return ret;
>> +}
>> +
>> +static int afe_port_start(struct q6afe_port *port,
>> +			  union afe_port_config *afe_config)
>> +{
>> +	struct afe_audioif_config_command config;
>> +	struct q6afev2 *afe = port->afe.v2;
>> +	int ret = 0;
>> +	int port_id = port->id;
>> +	int cfg_type;
>> +	int index = 0;
>> +
>> +	if (!afe_config) {
> 
> Looking at the one caller of this function, afe_config can't be NULL, so
> no need for this error handling.
> 
okay.

>> +		dev_err(afe->dev, "Error, no configuration data\n");
>> +		ret = -EINVAL;
>> +		return ret;
>> +	}
>> +
>> +	index = port->token;
>> +
>> +	mutex_lock(&afe->afe_cmd_lock);
>> +	/* Also send the topology id here: */
>> +	config.hdr.hdr_field = APR_HDR_FIELD(APR_MSG_TYPE_SEQ_CMD,
>> +					     APR_HDR_LEN(APR_HDR_SIZE),
>> +					     APR_PKT_VER);
>> +	config.hdr.pkt_size = sizeof(config);
>> +	config.hdr.src_port = 0;
>> +	config.hdr.dest_port = 0;
>> +	config.hdr.token = index;
>> +
>> +	cfg_type = port->cfg_type;
>> +	config.hdr.opcode = AFE_PORT_CMD_SET_PARAM_V2;
>> +	config.param.port_id = port_id;
>> +	config.param.payload_size = sizeof(config) - sizeof(struct apr_hdr) -
>> +	    sizeof(config.param);
>> +	config.param.payload_address_lsw = 0x00;
>> +	config.param.payload_address_msw = 0x00;
>> +	config.param.mem_map_handle = 0x00;
>> +	config.pdata.module_id = AFE_MODULE_AUDIO_DEV_INTERFACE;
>> +	config.pdata.param_id = cfg_type;
>> +	config.pdata.param_size = sizeof(config.port);
> 
> This looks like a good candidate for a afe_port_set_param() function.
> 
makes sense.

>> +
>> +	config.port = *afe_config;
>> +
>> +	ret = afe_apr_send_pkt(afe, &config, &port->wait);
>> +	if (ret) {
>> +		dev_err(afe->dev, "AFE enable for port 0x%x failed %d\n",
>> +			port_id, ret);
>> +		goto fail_cmd;
>> +	}
>> +
>> +	ret = afe_send_cmd_port_start(port);
>> +
>> +fail_cmd:
>> +	mutex_unlock(&afe->afe_cmd_lock);
>> +	return ret;
>> +}
> [..]
>> +/**
>> + * q6afe_port_get_from_id() - Get port instance from a port id
>> + *
>> + * @dev: Pointer to afe child device.
>> + * @id: port id
>> + *
>> + * Return: Will be an error pointer on error or a valid afe port
>> + * on success.
>> + */
>> +struct q6afe_port *q6afe_port_get_from_id(struct device *dev, int id)
> 
> Will there be any other getter? Otherwise you can just call this
> q6afe_port_get().

There is one more get, which is basically lookup from index to port number.

> 
>> +{
>> +	int port_id;
>> +	struct q6afev2 *afe = dev_get_drvdata(dev->parent);
>> +	struct q6afe_port *port;
>> +	int token;
>> +	int cfg_type;
>> +
>> +	if (!afe) {
>> +		dev_err(dev, "Unable to find instance of afe service\n");
>> +		return ERR_PTR(-ENOENT);
>> +	}
> 
> As this comes from the passed dev this check will catch bugs withing
> this driver, but if the client accidentally passes the wrong dev it's
> likely that you don't catch it here anyways. Consider dropping the
> check.

yes!

> 
>> +
>> +	token = id;
>> +	if (token < 0 || token > AFE_PORT_MAX) {
>> +		dev_err(dev, "AFE port token[%d] invalid!\n", token);
>> +		return ERR_PTR(-EINVAL);
>> +	}
>> +
>> +	port_id = port_maps[id].port_id;
>> +
>> +	port = devm_kzalloc(dev, sizeof(*port), GFP_KERNEL);
>> +	if (!port)
>> +		return ERR_PTR(-ENOMEM);
>> +
>> +	init_waitqueue_head(&port->wait);
>> +
>> +	port->token = token;
>> +	port->id = port_id;
>> +
>> +	port->afe.v2 = afe;
>> +	switch (port_id) {
> 
> How about moving this switch statement above the allocation?
> 

Yes, this can be done!
>> +	case AFE_PORT_ID_MULTICHAN_HDMI_RX:
>> +		cfg_type = AFE_PARAM_ID_HDMI_CONFIG;
>> +		break;
>> +	default:
>> +		dev_err(dev, "Invalid port id 0x%x\n", port_id);
>> +		return ERR_PTR(-EINVAL);
>> +	}
>> +
>> +	port->cfg_type = cfg_type;
>> +
>> +	spin_lock(&afe->port_list_lock);
>> +	list_add_tail(&port->node, &afe->port_list);
>> +	spin_unlock(&afe->port_list_lock);
>> +
>> +	return port;
>> +
>> +}
>> +EXPORT_SYMBOL_GPL(q6afe_port_get_from_id);
> 
> Regards,
> Bjorn
> 
