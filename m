From: srinivas.kandagatla@linaro.org (Srinivas Kandagatla)
Date: Wed, 3 Jan 2018 16:26:40 +0000
Subject: [RESEND PATCH v2 05/15] ASoC: qcom: qdsp6: Add support to Q6ADM
In-Reply-To: <20180102015019.GN478@tuxbook>
References: <20171214173402.19074-1-srinivas.kandagatla@linaro.org>
 <20171214173402.19074-6-srinivas.kandagatla@linaro.org>
 <20180102015019.GN478@tuxbook>
Message-ID: <ed2cf2b8-0dff-ce83-72f6-57e52db94c6b@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thanks for your review comments.

On 02/01/18 01:50, Bjorn Andersson wrote:
> On Thu 14 Dec 09:33 PST 2017, srinivas.kandagatla at linaro.org wrote:
> 
>> From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>>
>> This patch adds support to q6 ADM (Audio Device Manager) module in
>> q6dsp. ADM performs routing between audio streams and AFE ports.
>> It does Rate matching for streams going to devices driven by
> 
> lower case "Rate"
> 
>> different clocks, it handles volume ramping, Mixing with channel
> 
> and "Mixing"
> 
>> and bit-width. ADM creates and destroys dynamic COPP services
>> for device-related audio processing as needed.
> 
> What's a "copp"?
Common post processing.


> 
>>
>> This patch adds basic support to ADM.
> 
> Wouldn't s/to/for/ be better?

Yes!

> 
> [..]
>> +struct copp {
>> +	int afe_port;
>> +	int copp_idx;
>> +	int id;
>> +	int cnt;
> 
> Please rename this "refcnt" to match other kernel code.
> 
yep.

>> +	int topology;
>> +	int mode;

[...]
>> +};
>
[...]

>> +static int adm_callback(struct apr_device *adev, struct apr_client_data *data)
>> +{
>> +	uint32_t *payload;
>> +	int port_idx, copp_idx;
>> +	struct copp *copp;
>> +	struct q6adm *adm = dev_get_drvdata(&adev->dev);
>> +
>> +	payload = data->payload;
>> +
>> +	if (data->payload_size) {
> 
> Bail if you don't have a payload and save yourself one indentation
> level.

yep!

> 
>> +		copp_idx = (data->token) & 0XFF;
>> +		port_idx = ((data->token) >> 16) & 0xFF;
>> +		if (port_idx < 0 || port_idx >= AFE_MAX_PORTS) {
>> +			dev_err(&adev->dev, "Invalid port idx %d token %d\n",
>> +			       port_idx, data->token);
>> +			return 0;
>> +		}
>> +		if (copp_idx < 0 || copp_idx >= MAX_COPPS_PER_PORT) {
>> +			dev_err(&adev->dev, "Invalid copp idx %d token %d\n",
>> +				copp_idx, data->token);
>> +			return 0;
>> +		}
>> +
>> +		if (data->opcode == APR_BASIC_RSP_RESULT) {
> 
> This is a case in the following switch statement.
> 
>> +			if (payload[1] != 0) {
>> +				dev_err(&adev->dev, "cmd = 0x%x returned error = 0x%x\n",
>> +					payload[0], payload[1]);
> 
> This would again benefit from a small struct...
> 
>> +			}
>> +			switch (payload[0]) {
>> +			case ADM_CMD_DEVICE_OPEN_V5:
>> +			case ADM_CMD_DEVICE_CLOSE_V5:
>> +				copp = adm_find_copp(adm, port_idx, copp_idx);
>> +				if (IS_ERR_OR_NULL(copp))
>> +					return 0;
>> +
>> +				copp->stat = payload[1];
>> +				wake_up(&copp->wait);
>> +				break;
>> +			case ADM_CMD_MATRIX_MAP_ROUTINGS_V5:
>> +				adm->matrix_map_stat = payload[1];
>> +				wake_up(&adm->matrix_map_wait);
>> +				break;
>> +
>> +			default:
>> +				dev_err(&adev->dev, "Unknown Cmd: 0x%x\n",
>> +					payload[0]);
>> +				break;
>> +			}
>> +			return 0;
>> +		}
>> +
>> +		switch (data->opcode) {
>> +		case ADM_CMDRSP_DEVICE_OPEN_V5:{
> 
> Perhaps it would be cleaner to break these out in separate functions?

will do!
> 
>> +				struct adm_cmd_rsp_device_open_v5 {
>> +					u32 status;
>> +					u16 copp_id;
>> +					u16 reserved;
>> +				} __packed * open = data->payload;
>> +
>> +				open = data->payload;
>> +				copp = adm_find_copp(adm, port_idx, copp_idx);
>> +				if (IS_ERR_OR_NULL(copp))
>> +					return 0;
>> +
>> +				if (open->copp_id == INVALID_COPP_ID) {
>> +					dev_err(&adev->dev, "Invalid coppid rxed %d\n",
>> +						open->copp_id);
>> +					copp->stat = ADSP_EBADPARAM;
>> +					wake_up(&copp->wait);
>> +					break;
>> +				}
>> +				copp->stat = payload[0];
>> +				copp->id = open->copp_id;
>> +				pr_debug("%s: coppid rxed=%d\n", __func__,
> 
> You have a dev, use dev_dbg()

I think this was a leftover from previous versions, I will fix such 
occurrences.
> 
>> +					 open->copp_id);
>> +				wake_up(&copp->wait);
>> +
>> +			}
>> +			break;
>> +		default:
>> +			dev_err(&adev->dev, "Unknown cmd:0x%x\n",
>> +			       data->opcode);
>> +			break;
>> +		}
>> +	}
>> +	return 0;
>> +}
>> +
>> +static struct copp *adm_alloc_copp(struct q6adm *adm, int port_idx)
>> +{
>> +	struct copp *c;
>> +	int idx;
>> +
>> +	idx = find_first_zero_bit(&adm->copp_bitmap[port_idx],
>> +				  MAX_COPPS_PER_PORT);
>> +
>> +	if (idx > MAX_COPPS_PER_PORT)
>> +		return ERR_PTR(-EBUSY);
>> +
>> +	set_bit(idx, &adm->copp_bitmap[port_idx]);
>> +
>> +	c = devm_kzalloc(adm->dev, sizeof(*c), GFP_KERNEL);
>> +	if (!c)
> 
> Set the bit after doing the allocation and you don't need to clear it
> here.
> 
Makes sense.

>> +		return ERR_PTR(-ENOMEM);
>> +	c->copp_idx = idx;
>> +	c->afe_port = port_idx;
>> +	c->adm = adm;
>> +
>> +	init_waitqueue_head(&c->wait);
>> +
>> +	spin_lock(&adm->copps_list_lock);
>> +	list_add_tail(&c->node, &adm->copps_list);
>> +	spin_unlock(&adm->copps_list_lock);
>> +
>> +	return c;
>> +}
>> +
>> +static void adm_free_copp(struct q6adm *adm, struct copp *c, int port_idx)
>> +{
>> +	clear_bit(c->copp_idx, &adm->copp_bitmap[port_idx]);
>> +	spin_lock(&adm->copps_list_lock);
>> +	list_del(&c->node);
>> +	spin_unlock(&adm->copps_list_lock);
> 
> This function clear the copp_bitmap, so after recycling this once
> c->copp_idx will be "dangling".
> 
> This seems to put the copp in a state where it is invalid and as the
> copp is "reset" i don't think adm_find_matching_copp() will actually
> find this again, ever...
> 
> So shouldn't you free the copp here too - rather than relying on devm
> doing that at some later point in time?

Yes I agree.
> 
>> +}
>> +/**
>> + * q6adm_open() - open adm to get hold of free copp
> 
> "open adm and grab a free copp"?
> 
yep.

>> + *
>> + * @dev: Pointer to adm child device.
>> + * @port_id: port id
>> + * @path: playback or capture path.
>> + * @rate: rate at which copp is required.
>> + * @channel_mode: channel mode
>> + * @topology: adm topology id
>> + * @perf_mode: performace mode.
>> + * @bit_width: audio sample bit width
>> + * @app_type: Application type.
>> + * @acdb_id: ACDB id
>> + *
>> + * Return: Will be an negative on error or a valid copp index on success.
>> + */
>> +int q6adm_open(struct device *dev, int port_id, int path, int rate,
>> +	       int channel_mode, int topology, int perf_mode,
>> +	       uint16_t bit_width, int app_type, int acdb_id)
>> +{
>> +	struct adm_cmd_device_open_v5 {
>> +		struct apr_hdr hdr;
>> +		u16 flags;
>> +		u16 mode_of_operation;
>> +		u16 endpoint_id_1;
>> +		u16 endpoint_id_2;
>> +		u32 topology_id;
>> +		u16 dev_num_channel;
>> +		u16 bit_width;
>> +		u32 sample_rate;
>> +		u8 dev_channel_mapping[8];
>> +	} __packed open;
>> +	int ret = 0;
>> +	int port_idx, flags;
>> +	int tmp_port = q6afe_get_port_id(port_id);
>> +	struct copp *copp;
>> +	struct q6adm *adm = dev_get_drvdata(dev->parent);
>> +
>> +	port_idx = port_id;
> 
> I'm not seeing the reason for having two different variables with the
> same value.
>
not sure why it ended up like this, will fix it.

>> +	if (port_idx < 0) {
>> +		dev_err(dev, "Invalid port_id 0x%x\n", port_id);
>> +		return -EINVAL;
>> +	}
>> +
>> +	flags = ADM_LEGACY_DEVICE_SESSION;
> 
> Just put ADM_LEGACY_DEVICE_SESSION in the assignment below.
> 
yep!

>> +	copp = adm_find_matching_copp(adm, port_idx, topology, perf_mode,
>> +				      rate, bit_width, app_type);
>> +
>> +	if (!copp) {
>> +		copp = adm_alloc_copp(adm, port_idx);
>> +		if (IS_ERR_OR_NULL(copp))
>> +			return PTR_ERR(copp);
>> +
>> +		copp->cnt = 0;
>> +		copp->topology = topology;
>> +		copp->mode = perf_mode;
>> +		copp->rate = rate;
>> +		copp->channels = channel_mode;
>> +		copp->bit_width = bit_width;
>> +		copp->app_type = app_type;
>> +	}
> 
> I would suggest that you make adm_find_matching_copp() allocate the new
> copp if none is found.
> 
will have a go and see!

>> +
>> +	/* Create a COPP if port id are not enabled */
>> +	if (copp->cnt == 0) {
> 
> Doesn't this scheme require some locking? What about concurrent close()?
> 

yes, it will be issue if we do concurrent closes(), will revisit locking 
on this.

>> +
>> +		open.hdr.hdr_field = APR_HDR_FIELD(APR_MSG_TYPE_SEQ_CMD,
>> +						   APR_HDR_LEN(APR_HDR_SIZE),
>> +						   APR_PKT_VER);
>> +		open.hdr.pkt_size = sizeof(open);
>> +		open.hdr.src_svc = APR_SVC_ADM;
>> +		open.hdr.src_domain = APR_DOMAIN_APPS;
>> +		open.hdr.src_port = tmp_port;
>> +		open.hdr.dest_svc = APR_SVC_ADM;
>> +		open.hdr.dest_domain = APR_DOMAIN_ADSP;
>> +		open.hdr.dest_port = tmp_port;
>> +		open.hdr.token = port_idx << 16 | copp->copp_idx;
>> +		open.hdr.opcode = ADM_CMD_DEVICE_OPEN_V5;
>> +		open.flags = flags;
>> +		open.mode_of_operation = path;
>> +		open.endpoint_id_1 = tmp_port;
>> +		open.topology_id = topology;
>> +		open.dev_num_channel = channel_mode & 0x00FF;
>> +		open.bit_width = bit_width;
>> +		open.sample_rate = rate;
> 
> This looks like a q6adm_device_open() helper function.
> 
yep!

>> +
>> +		ret = q6dsp_map_channels(&open.dev_channel_mapping[0],
>> +					 channel_mode);
>> +
>> +		if (ret)
>> +			return ret;
>> +
>> +		copp->stat = -1;
>> +		ret = apr_send_pkt(adm->apr, (uint32_t *)&open);
>> +		if (ret < 0) {
>> +			dev_err(dev, "port_id: 0x%x for[0x%x] failed %d\n",
>> +				tmp_port, port_id, ret);
>> +			return -EINVAL;
>> +		}
>> +		/* Wait for the callback with copp id */
>> +		ret =
>> +		    wait_event_timeout(copp->wait, copp->stat >= 0,
>> +				       msecs_to_jiffies(TIMEOUT_MS));
>> +		if (!ret) {
>> +			dev_err(dev, "ADM timedout port_id: 0x%x for [0x%x]\n",
>> +			       tmp_port, port_id);
>> +			return -EINVAL;
>> +		} else if (copp->stat > 0) {
>> +			dev_err(dev, "DSP returned error[%s]\n",
>> +				adsp_err_get_err_str(copp->stat));
>> +			return adsp_err_get_lnx_err_code(copp->stat);
>> +		}
>> +	}
>> +	copp->cnt++;
>> +	return copp->copp_idx;
>> +}
>> +EXPORT_SYMBOL_GPL(q6adm_open);
>> +/**
>> + * q6adm_matrix_map() - Map asm streams and afe ports using payload
>> + *
>> + * @dev: Pointer to adm child device.
>> + * @path: playback or capture path.
>> + * @payload_map: map between session id and afe ports.
>> + * @perf_mode: Performace mode.
>> + *
>> + * Return: Will be an negative on error or a zero on success.
>> + */
>> +int q6adm_matrix_map(struct device *dev, int path,
>> +		     struct route_payload payload_map, int perf_mode)
>> +{
>> +	struct adm_cmd_matrix_map_routings_v5 {
>> +		struct apr_hdr hdr;
>> +		u32 matrix_id;
>> +		u32 num_sessions;
>> +	} __packed * route;
>> +
>> +	struct adm_session_map_node_v5 {
>> +		u16 session_id;
>> +		u16 num_copps;
>> +	} __packed * node;
>> +	struct q6adm *adm = dev_get_drvdata(dev->parent);
>> +	uint16_t *copps_list;
>> +	int cmd_size = 0;
>> +	int ret = 0, i = 0;
>> +	void *payload = NULL;
>> +	void *matrix_map = NULL;
>> +	int port_idx, copp_idx;
>> +	struct copp *copp;
>> +
>> +	/* Assumes port_ids have already been validated during adm_open */
>> +	cmd_size = (sizeof(*route) +
>> +		    sizeof(*node) +
>> +		    (sizeof(uint32_t) * payload_map.num_copps));
>> +	matrix_map = kzalloc(cmd_size, GFP_KERNEL);
>> +	if (!matrix_map)
>> +		return -ENOMEM;
>> +
>> +	route = (struct adm_cmd_matrix_map_routings_v5 *)matrix_map;
>> +	route->hdr.hdr_field = APR_HDR_FIELD(APR_MSG_TYPE_SEQ_CMD,
>> +					     APR_HDR_LEN(APR_HDR_SIZE),
>> +					     APR_PKT_VER);
>> +	route->hdr.pkt_size = cmd_size;
>> +	route->hdr.src_svc = 0;
>> +	route->hdr.src_domain = APR_DOMAIN_APPS;
>> +	route->hdr.src_port = 0; /* Ignored */
> 
> Omit the ignored members instead.
yep!

> 
>> +	route->hdr.dest_svc = APR_SVC_ADM;
>> +	route->hdr.dest_domain = APR_DOMAIN_ADSP;
>> +	route->hdr.dest_port = 0; /* Ignored */
>> +	route->hdr.token = 0;
>> +	route->hdr.opcode = ADM_CMD_MATRIX_MAP_ROUTINGS_V5;
>> +	route->num_sessions = 1;
>> +
>> +	switch (path) {
>> +	case ADM_PATH_PLAYBACK:
>> +		route->matrix_id = ADM_MATRIX_ID_AUDIO_RX;
>> +		break;
>> +	default:
>> +		dev_err(dev, "Wrong path set[%d]\n", path);
>> +
>> +		break;
>> +	}
>> +
>> +	payload = ((u8 *) matrix_map + sizeof(*route));
> 
> matrix_map is a void *, so no need to cast it to u8 * to calculate the
> payload address.
> 
yep.

>> +	node = (struct adm_session_map_node_v5 *)payload;
> 
> payload is void *, so no need to typecast here. And for that matter, I'm
> not sure about the benefits of having this intermediate "payload"
> variable, just assign node directly.
> 
>> +
>> +	node->session_id = payload_map.session_id;
>> +	node->num_copps = payload_map.num_copps;
>> +	payload = (u8 *) node + sizeof(*node);
>> +	copps_list = (uint16_t *) payload;
> 
> As with node above, drop the temporary variable and drop the type casts.
> 
>> +
>> +	for (i = 0; i < payload_map.num_copps; i++) {
>> +		port_idx = payload_map.port_id[i];
>> +		if (port_idx < 0) {
>> +			dev_err(dev, "Invalid port_id 0x%x\n",
>> +				payload_map.port_id[i]);
> 
> Leaking matrix_map.
> 
yep!

>> +			return -EINVAL;
>> +		}
>> +		copp_idx = payload_map.copp_idx[i];
>> +
>> +		copp = adm_find_copp(adm, port_idx, copp_idx);
>> +		if (IS_ERR_OR_NULL(copp))
> 
> Dito.
> 
>> +			return -EINVAL;
>> +
>> +		copps_list[i] = copp->id;
>> +	}
>> +
>> +	adm->matrix_map_stat = -1;
>> +
>> +	ret = apr_send_pkt(adm->apr, (uint32_t *) matrix_map);
>> +	if (ret < 0) {
>> +		dev_err(dev, "routing for syream %d failed ret %d\n",
>> +		       payload_map.session_id, ret);
>> +		ret = -EINVAL;
>> +		goto fail_cmd;
>> +	}
>> +	ret = wait_event_timeout(adm->matrix_map_wait,
>> +				 adm->matrix_map_stat >= 0,
>> +				 msecs_to_jiffies(TIMEOUT_MS));
>> +	if (!ret) {
>> +		dev_err(dev, "routing for syream %d failed\n",
>> +		       payload_map.session_id);
>> +		ret = -EINVAL;
>> +		goto fail_cmd;
>> +	} else if (adm->matrix_map_stat > 0) {
>> +		dev_err(dev, "DSP returned error[%s]\n",
>> +		       adsp_err_get_err_str(adm->matrix_map_stat));
>> +		ret = adsp_err_get_lnx_err_code(adm->matrix_map_stat);
>> +		goto fail_cmd;
>> +	}
>> +
>> +fail_cmd:
>> +	kfree(matrix_map);
>> +	return ret;
>> +}
>> +EXPORT_SYMBOL_GPL(q6adm_matrix_map);
>> +
>> +static void adm_reset_copp(struct copp *c)
> 
> As far as I can see this will decommission the copp, so I don't think
> there is a point in updating any of this and then keep it around?

yes, if we free it as suggested above we can get rid of this totally.

> 
>> +{
>> +	c->id = RESET_COPP_ID;
>> +	c->cnt = 0;
>> +	c->topology = 0;
>> +	c->mode = 0;
>> +	c->stat = -1;
>> +	c->rate = 0;
>> +	c->channels = 0;
>> +	c->bit_width = 0;
>> +	c->app_type = 0;
>> +}
>> +/**
>> + * q6adm_close() - Close adm copp
>> + *
>> + * @dev: Pointer to adm child device.
>> + * @port_id: afe port id.
>> + * @perf_mode: perf_mode mode
>> + * @copp_idx: copp index to close
>> + *
>> + * Return: Will be an negative on error or a zero on success.
>> + */
>> +int q6adm_close(struct device *dev, int port_id, int perf_mode, int copp_idx)
>> +{
>> +	struct apr_hdr close;
>> +	struct copp *copp;
>> +
>> +	int ret = 0, port_idx;
>> +	int copp_id = RESET_COPP_ID;
>> +	struct q6adm *adm = dev_get_drvdata(dev->parent);
>> +
>> +	port_idx = port_id;
>> +	if (port_idx < 0) {
>> +		dev_err(dev, "Invalid port_id 0x%x\n", port_id);
>> +		return -EINVAL;
>> +	}
>> +
>> +	if ((copp_idx < 0) || (copp_idx >= MAX_COPPS_PER_PORT)) {
>> +		dev_err(dev, "Invalid copp idx: %d\n", copp_idx);
>> +		return -EINVAL;
>> +	}
>> +
>> +	copp = adm_find_copp(adm, port_id, copp_idx);
>> +	if (IS_ERR_OR_NULL(copp))
>> +		return -EINVAL;
>> +
>> +	copp->cnt--;
>> +	if (!copp->cnt) {
> 
> Again, this needs some locking.
Yes, this needs some protection, i will revisit this part.
> 
>> +		copp_id = copp->id;
>> +
>> +		close.hdr_field = APR_HDR_FIELD(APR_MSG_TYPE_SEQ_CMD,
>> +						APR_HDR_LEN(APR_HDR_SIZE),
>> +						APR_PKT_VER);
>> +		close.pkt_size = sizeof(close);
>> +		close.src_svc = APR_SVC_ADM;
>> +		close.src_domain = APR_DOMAIN_APPS;
>> +		close.src_port = port_id;
>> +		close.dest_svc = APR_SVC_ADM;
>> +		close.dest_domain = APR_DOMAIN_ADSP;
>> +		close.dest_port = copp_id;
>> +		close.token = port_idx << 16 | copp_idx;
>> +		close.opcode = ADM_CMD_DEVICE_CLOSE_V5;
>> +
> 
> Split this out into a separate helper function.
yep!

> 
>> +		ret = apr_send_pkt(adm->apr, (uint32_t *) &close);
>> +		if (ret < 0) {
>> +			dev_err(dev, "ADM close failed %d\n", ret);
>> +			return -EINVAL;
>> +		}
>> +
>> +		ret = wait_event_timeout(copp->wait, copp->stat >= 0,
>> +					 msecs_to_jiffies(TIMEOUT_MS));
>> +		if (!ret) {
>> +			dev_err(dev, "ADM cmd Route timedout for port 0x%x\n",
>> +				port_id);
>> +			return -EINVAL;
>> +		} else if (copp->stat > 0) {
>> +			dev_err(dev, "DSP returned error[%s]\n",
>> +				adsp_err_get_err_str(copp->stat));
>> +			return adsp_err_get_lnx_err_code(copp->stat);
>> +		}
>> +
>> +		adm_reset_copp(copp);
>> +		adm_free_copp(adm, copp, port_id);
>> +	}
>> +
>> +	return 0;
>> +}
>> +EXPORT_SYMBOL_GPL(q6adm_close);
> [..]
>> +static struct apr_driver qcom_q6adm_driver = {
>> +	.probe = q6adm_probe,
>> +	.remove = q6adm_exit,
>> +	.callback = adm_callback,
>> +	.id_table = adm_id,
>> +	.driver = {
>> +		   .name = "qcom-q6adm",
>> +	   },
> 
> Indentation.
yep.

> 
> Regards,
> Bjorn
> 
