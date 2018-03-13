From: rohitkr@codeaurora.org (Rohit Kumar)
Date: Tue, 13 Mar 2018 16:59:27 +0530
Subject: [alsa-devel] [PATCH v4 07/24] ASoC: qdsp6: q6afe: Add q6afe driver
In-Reply-To: <20180310022456.26739-8-srinivas.kandagatla@linaro.org>
References: <20180310022456.26739-1-srinivas.kandagatla@linaro.org>
 <20180310022456.26739-8-srinivas.kandagatla@linaro.org>
Message-ID: <3d750b29-d341-af4d-41b3-30260f8296b7@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 3/10/2018 7:54 AM, srinivas.kandagatla at linaro.org wrote:
> From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>
> This patch adds support to Q6AFE (Audio Front End) module on Q6DSP.
>
[..]
> +		if (res->status) {
> +			dev_err(afe->dev, "cmd = 0x%x returned error = 0x%x\n",
> +				res->opcode, res->status);
> +		}
> +		switch (res->opcode) {
> +		case AFE_PORT_CMD_SET_PARAM_V2:
> +		case AFE_PORT_CMD_DEVICE_STOP:
> +		case AFE_PORT_CMD_DEVICE_START:

case AFE_SVC_CMD_SET_PARAM: needs to be added
> +			port = afe_find_port(afe, data->token);
> +			if (port) {
> +				port->result = *res;
> +				wake_up(&port->wait);
> +			}
[..]
> +
> +static int q6afe_port_set_param_v2(struct q6afe_port *port, void *data,
> +				   int param_id, int psize)
> +{
> +	struct apr_hdr *hdr;
> +	struct afe_port_cmd_set_param_v2 *param;
> +	struct afe_port_param_data_v2 *pdata;
> +	struct q6afe *afe = port->afe;
> +	u16 port_id = port->id;
> +	int ret;
> +
> +	hdr = data;
> +	param = data + sizeof(*hdr);
> +	pdata = data + sizeof(*hdr) + sizeof(*param);
> +
> +	hdr->hdr_field = APR_HDR_FIELD(APR_MSG_TYPE_SEQ_CMD,
> +					      APR_HDR_LEN(APR_HDR_SIZE),
> +					      APR_PKT_VER);
> +	hdr->pkt_size = sizeof(*hdr) + sizeof(*param) +
> +			sizeof(*pdata) + psize;
> +	hdr->src_port = 0;
> +	hdr->dest_port = 0;
> +	hdr->token = port->token;
> +	hdr->opcode = AFE_PORT_CMD_SET_PARAM_V2;
> +	param->port_id = port_id;
> +	param->payload_size = sizeof(*pdata) + psize;
> +	param->payload_address_lsw = 0x00;
> +	param->payload_address_msw = 0x00;
> +	param->mem_map_handle = 0x00;
> +	pdata->module_id = AFE_MODULE_AUDIO_DEV_INTERFACE;
> +	pdata->param_id = param_id;
> +	pdata->param_size = psize;
> +
> +	ret = afe_apr_send_pkt(afe, data, port);
> +	if (ret)
> +		dev_err(afe->dev, "AFE enable for port 0x%x failed %d\n",

we should add %s to distinguish different functions with similar error 
logs. Also, q6afe_port_set_param_v2() can be called for different 
purpose.? AFE enable for port 0x%x failed is suitable only for port 
start failure. Error message needs to be updated here.

> +		       port_id, ret);
> +
> +
> +	return ret;
> +}
> +
