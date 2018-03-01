From: broonie@kernel.org (Mark Brown)
Date: Thu, 1 Mar 2018 20:59:40 +0000
Subject: [PATCH v3 05/25] ASoC: qcom: qdsp6: Add support to Q6AFE
In-Reply-To: <20180213165837.1620-6-srinivas.kandagatla@linaro.org>
References: <20180213165837.1620-1-srinivas.kandagatla@linaro.org>
 <20180213165837.1620-6-srinivas.kandagatla@linaro.org>
Message-ID: <20180301205940.GR12864@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 13, 2018 at 04:58:17PM +0000, srinivas.kandagatla at linaro.org wrote:

> +// SPDX-License-Identifier: GPL-2.0
> +#ifndef __DT_BINDINGS_Q6_AFE_H__
> +#define __DT_BINDINGS_Q6_AFE_H__
> +
> +/* Audio Front End (AFE) Ports */
> +#define AFE_PORT_HDMI_RX	8
> +
> +#endif /* __DT_BINDINGS_Q6_AFE_H__ */

Please use a C++ comment here as well for consistency, it looks more
intentional.

> +config SND_SOC_QDSP6_AFE
> +	tristate
> +	default n
> +

n is the default anyway, no need to specify it (I know some uses already
slipped through here but it'd be better to fix those).

> index 000000000000..0a5af06bb50e
> --- /dev/null
> +++ b/sound/soc/qcom/qdsp6/q6afe.c
> @@ -0,0 +1,520 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2011-2017, The Linux Foundation
> + * Copyright (c) 2018, Linaro Limited
> + */

Same here with the comment, just make the whole comment a C++ comment
rather than having one comment using both styles.  Similar things apply
elsewhere.

> +/* Port map of index vs real hw port ids */
> +static struct afe_port_map port_maps[AFE_PORT_MAX] = {
> +	[AFE_PORT_HDMI_RX] = { AFE_PORT_ID_MULTICHAN_HDMI_RX,
> +				AFE_PORT_HDMI_RX, 1, 1},
> +};

Is this not device specific in any way?  It looks likely to be.

> +static struct q6afe_port *afe_find_port(struct q6afe *afe, int token)
> +{
> +	struct q6afe_port *p = NULL;
> +
> +	spin_lock(&afe->port_list_lock);
> +	list_for_each_entry(p, &afe->port_list, node)
> +		if (p->token == token)
> +			break;
> +
> +	spin_unlock(&afe->port_list_lock);

Why do we need to lock the port list, what are we protecting it against?
We don't write here which suggests either there's some kind of race
condition in this lookup or the lock is not doing anything.

> +static int afe_callback(struct apr_device *adev,
> +			struct apr_client_message *data)
> +{
> +	struct q6afe *afe = dev_get_drvdata(&adev->dev);
> +	struct aprv2_ibasic_rsp_result_t *res;
> +	struct q6afe_port *port;
> +
> +	if (!data->payload_size)
> +		return 0;
> +
> +	res = data->payload;
> +	if (data->opcode == APR_BASIC_RSP_RESULT) {
> +		if (res->status) {

Shouldn't we use a switch statement here in case we want to handle
something else?

> +		switch (res->opcode) {
> +		case AFE_PORT_CMD_SET_PARAM_V2:
> +		case AFE_PORT_CMD_DEVICE_STOP:
> +		case AFE_PORT_CMD_DEVICE_START:
> +			afe->state = AFE_CMD_RESP_AVAIL;
> +			port = afe_find_port(afe, data->token);
> +			if (port)
> +				wake_up(&port->wait);

No locking here?  It seems a bit odd that the AFE global state is being
set to say there's a response available but we wake a specific port.

> +	ret = apr_send_pkt(afe->apr, data);
> +	if (ret < 0) {
> +		dev_err(afe->dev, "packet not transmitted\n");
> +		ret = -EINVAL;
> +		goto err;

Why squash the error code here?  We don't even print it.

> +	}
> +
> +	ret = wait_event_timeout(*wait, (afe->state == AFE_CMD_RESP_AVAIL),
> +				 msecs_to_jiffies(TIMEOUT_MS));
> +	if (!ret) {
> +		ret = -ETIMEDOUT;
> +	} else if (afe->status > 0) {
> +		dev_err(afe->dev, "DSP returned error[%s]\n",
> +		       q6dsp_strerror(afe->status));
> +		ret = q6dsp_errno(afe->status);

If we time out here and the DSP delivers a response later it looks like
we'll get data corruption - the DSP will happily deliver the response
into shared state.

> +static int afe_port_start(struct q6afe_port *port,
> +			  union afe_port_config *afe_config)
> +{
> +	struct afe_audioif_config_command config = {0,};
> +	struct q6afe *afe = port->afe;
> +	int port_id = port->id;
> +	int ret, param_id = port->cfg_type;
> +
> +	config.port = *afe_config;
> +
> +	ret  = q6afe_port_set_param_v2(port, &config, param_id,
> +				       sizeof(*afe_config));
> +	if (ret) {
> +		dev_err(afe->dev, "AFE enable for port 0x%x failed %d\n",
> +			port_id, ret);
> +		return ret;
> +	}
> +	return afe_send_cmd_port_start(port);

Why not just inline this function here?  It appears to have only this
user.

> +	int index = 0;

We set index to 0...
> +
> +	port_id = port->id;
> +	index = port->token;

...the unconditionally overwrite it?

> +/**
> + * q6afe_port_start() - Start a afe port
> + *
> + * @port: Instance of port to start
> + *
> + * Return: Will be an negative on packet size on success.
> + */
> +int q6afe_port_start(struct q6afe_port *port)
> +{
> +	return afe_port_start(port, &port->port_cfg);
> +}
> +EXPORT_SYMBOL_GPL(q6afe_port_start);

This is the third level of wrapper for the port start command in this
file.  Do we *really* need all these wrappers?

> +struct q6afe_port *q6afe_port_get_from_id(struct device *dev, int id)
> +{

> +	port = devm_kzalloc(dev, sizeof(*port), GFP_KERNEL);
> +	if (!port)
> +		return ERR_PTR(-ENOMEM);

The _port_get_ function is allocating data but...

> +/**
> + * q6afe_port_put() - Release port reference
> + *
> + * @port: Instance of port to put
> + */
> +void q6afe_port_put(struct q6afe_port *port)
> +{
> +	struct q6afe *afe = port->afe;
> +
> +	spin_lock(&afe->port_list_lock);
> +	list_del(&port->node);
> +	spin_unlock(&afe->port_list_lock);
> +}
> +EXPORT_SYMBOL_GPL(q6afe_port_put);

...the _port_put() function isn't freeing it.  That seems leaky.  I'm
also a bit worried about this being a spinlock that we're using for
allocation, and not even spin_lock_irqsave().  Presumably this is
protecting against interrupts otherwise we'd not need a spinlock but
for that to work we'd need the _irqsave()?  
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180301/a9da1a6f/attachment.sig>
