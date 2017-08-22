From: aneela@codeaurora.org (Arun Kumar Neelakantam)
Date: Tue, 22 Aug 2017 11:28:54 +0530
Subject: [PATCH 04/18] rpmsg: glink: Move the common glink protocol
 implementation to glink_native.c
In-Reply-To: <1502903951-5403-5-git-send-email-sricharan@codeaurora.org>
References: <1502903951-5403-1-git-send-email-sricharan@codeaurora.org>
 <1502903951-5403-5-git-send-email-sricharan@codeaurora.org>
Message-ID: <3f055e52-bef9-c6d6-3d4f-97e4c772f04e@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 8/16/2017 10:48 PM, Sricharan R wrote:
> +
> +struct glink_msg {
> +	__le16 cmd;
> +	__le16 param1;
> +	__le32 param2;
> +	u8 data[];
> +} __packed;

why we are using extra u8 data[] member here ?

> +
> +/**
> + * struct glink_defer_cmd - deferred incoming control message
> + * @node:	list node
> + * @msg:	message header
> + * data:	payload of the message
> + *
> + * Copy of a received control message, to be added to @rx_queue and processed
> + * by @rx_work of @glink_rpm.
> + */
> +struct glink_defer_cmd {
> +	struct list_head node;
> +
> +	struct glink_msg msg;
> +	u8 data[];
> +};
> +
> +/**
> + * struct glink_rpm - driver context, relates to one remote subsystem

glink_rpm to qcom_glink

> +static int qcom_glink_tx(struct qcom_glink *glink,
> +			 const void *hdr, size_t hlen,
> +			 const void *data, size_t dlen, bool wait)
> +{
> +	unsigned int tlen = hlen + dlen;
> +	int ret;
> +
> +	/* Reject packets that are too big */
> +	if (tlen >= glink->tx_pipe->length)
> +		return -EINVAL;

we need to add support for split packets, in some cases packets may be 
greater than 16K.
> +
> +	if (WARN(tlen % 8, "Unaligned TX request"))
> +		return -EINVAL;
> +
> +	ret = mutex_lock_interruptible(&glink->tx_lock);
> +	if (ret)
> +		return ret;
> +
> +	while (qcom_glink_tx_avail(glink) < tlen) {
> +		if (!wait) {
> +			ret = -ENOMEM;

This condition is either reader is slow or not reading data, should we 
return -EAGAIN here instead of -ENOMEM?
> +			goto out;
> +		}
> +
> +		msleep(10);
> +	}
> +
> +	qcom_glink_tx_write(glink, hdr, hlen, data, dlen);
> +
> +	mbox_send_message(glink->mbox_chan, NULL);
> +	mbox_client_txdone(glink->mbox_chan, 0);
> +
> +out:
> +	mutex_unlock(&glink->tx_lock);
> +
> +	return ret;
> +}
> +


> +/**
> + * qcom_glink_send_open_req() - send a RPM_CMD_OPEN request to the remote
> + * @glink:
> + * @channel:

Missed information for @ glink and @channel
> + *
> + * Allocates a local channel id and sends a RPM_CMD_OPEN message to the remote.
> + * Will return with refcount held, regardless of outcome.
> + *
> + * Returns 0 on success, negative errno otherwise.
> + */
> +static int qcom_glink_send_open_req(struct qcom_glink *glink,
> +				    struct glink_channel *channel)


> +static irqreturn_t qcom_glink_native_intr(int irq, void *data)
> +{
> +	struct qcom_glink *glink = data;
> +	struct glink_msg msg;
> +	unsigned int param1;
> +	unsigned int param2;
> +	unsigned int avail;
> +	unsigned int cmd;
> +	int ret;
> +
> +	for (;;) {
> +		avail = qcom_glink_rx_avail(glink);
> +		if (avail < sizeof(msg))
> +			break;
> +
> +		qcom_glink_rx_peak(glink, &msg, sizeof(msg));
> +
> +		cmd = le16_to_cpu(msg.cmd);
> +		param1 = le16_to_cpu(msg.param1);
> +		param2 = le32_to_cpu(msg.param2);
> +
> +		switch (cmd) {
> +		case RPM_CMD_VERSION:
> +		case RPM_CMD_VERSION_ACK:
> +		case RPM_CMD_CLOSE:
> +		case RPM_CMD_CLOSE_ACK:
> +			ret = qcom_glink_rx_defer(glink, 0);
> +			break;
> +		case RPM_CMD_OPEN_ACK:
> +			ret = qcom_glink_rx_open_ack(glink, param1);
> +			qcom_glink_rx_advance(glink, ALIGN(sizeof(msg), 8));
> +			break;
> +		case RPM_CMD_OPEN:
> +			ret = qcom_glink_rx_defer(glink, param2);
> +			break;
> +		case RPM_CMD_TX_DATA:
> +		case RPM_CMD_TX_DATA_CONT:
> +			ret = qcom_glink_rx_data(glink, avail);
> +			break;
> +		case RPM_CMD_READ_NOTIF:
> +			qcom_glink_rx_advance(glink, ALIGN(sizeof(msg), 8));
> +
> +			mbox_send_message(glink->mbox_chan, NULL);
> +			mbox_client_txdone(glink->mbox_chan, 0);
> +
> +			ret = 0;
> +			break;
> +		default:
> +			dev_err(glink->dev, "unhandled rx cmd: %d\n", cmd);

please add more information in error log to find the remote peripheral 
also other wise after adding SMEM transport it will be difficult to find 
for which peripheral the error came.
> +			ret = -EINVAL;
> +			break;
> +		}
> +
> +		if (ret)
> +			break;
> +	}
> +
> +	return IRQ_HANDLED;
> +}
> +

> +struct qcom_glink *qcom_glink_native_probe(struct device *dev,
> +					   struct qcom_glink_pipe *rx,
> +					   struct qcom_glink_pipe *tx)
> +{
> +	int irq;
> +	int ret;
> +	struct qcom_glink *glink;
> +
> +	glink = devm_kzalloc(dev, sizeof(*glink), GFP_KERNEL);
> +	if (!glink)
> +		return ERR_PTR(-ENOMEM);
> +
> +	glink->dev = dev;
> +	glink->tx_pipe = tx;
> +	glink->rx_pipe = rx;
> +
> +	mutex_init(&glink->tx_lock);
> +	spin_lock_init(&glink->rx_lock);
> +	INIT_LIST_HEAD(&glink->rx_queue);
> +	INIT_WORK(&glink->rx_work, qcom_glink_work);
> +
> +	mutex_init(&glink->idr_lock);
> +	idr_init(&glink->lcids);
> +	idr_init(&glink->rcids);
> +
> +	glink->mbox_client.dev = dev;
> +	glink->mbox_chan = mbox_request_channel(&glink->mbox_client, 0);
> +	if (IS_ERR(glink->mbox_chan)) {
> +		if (PTR_ERR(glink->mbox_chan) != -EPROBE_DEFER)
> +			dev_err(dev, "failed to acquire IPC channel\n");
> +		return ERR_CAST(glink->mbox_chan);
> +	}
> +
> +	irq = of_irq_get(dev->of_node, 0);
> +	ret = devm_request_irq(dev, irq,
> +			       qcom_glink_native_intr,
> +			       IRQF_NO_SUSPEND | IRQF_SHARED,
> +			       "glink-native", glink);
> +	if (ret) {
> +		dev_err(dev, "failed to request IRQ\n");
> +		return ERR_PTR(ret);
> +	}

These IRQs are wake-up-capable, please use enable_irq_wale() also
> +
> +	ret = qcom_glink_send_version(glink);
> +	if (ret)
> +		return ERR_PTR(ret);
> +
> +	return glink;
> +}
> +
