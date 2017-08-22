From: aneela@codeaurora.org (Arun Kumar Neelakantam)
Date: Tue, 22 Aug 2017 16:11:06 +0530
Subject: [PATCH 15/18] rpmsg: glink: Receive and store the remote intent
 buffers
In-Reply-To: <1502903951-5403-16-git-send-email-sricharan@codeaurora.org>
References: <1502903951-5403-1-git-send-email-sricharan@codeaurora.org>
 <1502903951-5403-16-git-send-email-sricharan@codeaurora.org>
Message-ID: <b6d07ac8-f496-43c5-ba90-e8ef120b17b4@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 8/16/2017 10:49 PM, Sricharan R wrote:
> Just like we allocating and sending intent ids to remote,
> remote side allocates and sends us the intents as well.
> So save the intent ids and use it later while sending
> data targeting the appropriate intents based on the size.
>
> Signed-off-by: Sricharan R <sricharan@codeaurora.org>
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---
>   drivers/rpmsg/qcom_glink_native.c | 69 +++++++++++++++++++++++++++++++++++++++
>   1 file changed, 69 insertions(+)
>
> diff --git a/drivers/rpmsg/qcom_glink_native.c b/drivers/rpmsg/qcom_glink_native.c
> index c111046..738303e 100644
> --- a/drivers/rpmsg/qcom_glink_native.c
> +++ b/drivers/rpmsg/qcom_glink_native.c
> @@ -139,6 +139,7 @@ enum {
>    * @rcid:	channel id, in remote space
>    * @intent_lock: lock for protection of @liids
>    * @liids:	idr of all local intents
> + * @riids:	idr of all remote intents
>    * @intent_work: worker responsible for transmitting rx_done packets
>    * @done_intents: list of intents that needs to be announced rx_done
>    * @buf:	receive buffer, for gathering fragments
> @@ -163,6 +164,7 @@ struct glink_channel {
>   
>   	spinlock_t intent_lock;
>   	struct idr liids;
> +	struct idr riids;
>   	struct work_struct intent_work;
>   	struct list_head done_intents;
>   
> @@ -219,6 +221,7 @@ static struct glink_channel *qcom_glink_alloc_channel(struct qcom_glink *glink,
>   	INIT_WORK(&channel->intent_work, qcom_glink_rx_done_work);
>   
>   	idr_init(&channel->liids);
> +	idr_init(&channel->riids);
>   	kref_init(&channel->refcount);
>   
>   	return channel;
> @@ -230,6 +233,7 @@ static void qcom_glink_channel_release(struct kref *ref)
>   						     refcount);
>   
>   	idr_destroy(&channel->liids);
> +	idr_destroy(&channel->riids);
>   	kfree(channel->name);
>   	kfree(channel);
>   }
> @@ -799,6 +803,68 @@ static int qcom_glink_rx_data(struct qcom_glink *glink, size_t avail)
>   	return ret;
>   }
>   
> +static void qcom_glink_handle_intent(struct qcom_glink *glink,
> +				     unsigned int cid,
> +				     unsigned int count,
> +				     size_t avail)
> +{
> +	struct glink_core_rx_intent *intent;
> +	struct glink_channel *channel;
> +	struct intent_pair {
> +		__le32 size;
> +		__le32 iid;
> +	};
> +
> +	struct {
> +		struct glink_msg msg;
> +		struct intent_pair intents[];
> +	} __packed *msg;
> +
> +	const size_t msglen = sizeof(*msg) + sizeof(struct intent_pair) * count;
> +	int ret;
> +	int i;
> +	unsigned long flags;
> +
> +	if (avail < msglen) {
> +		dev_dbg(glink->dev, "Not enough data in fifo\n");
> +		return;
> +	}
> +
> +	spin_lock_irqsave(&glink->idr_lock, flags);
> +	channel = idr_find(&glink->rcids, cid);
> +	spin_unlock_irqrestore(&glink->idr_lock, flags);
> +	if (!channel) {
> +		dev_err(glink->dev, "intents for non-existing channel\n");
> +		return;
> +	}
> +
> +	msg = kmalloc(msglen, GFP_ATOMIC);

Why kmalloc() instead of kzalloc() ?
> +	if (!msg)
> +		return;
> +
> +	qcom_glink_rx_peak(glink, msg, 0, msglen);
> +
> +	for (i = 0; i < count; ++i) {
> +		intent = kzalloc(sizeof(*intent), GFP_ATOMIC);
> +		if (!intent)
> +			break;
> +
> +		intent->id = le32_to_cpu(msg->intents[i].iid);
> +		intent->size = le32_to_cpu(msg->intents[i].size);
> +
> +		spin_lock_irqsave(&channel->intent_lock, flags);
> +		ret = idr_alloc(&channel->riids, intent,
> +				intent->id, intent->id + 1, GFP_ATOMIC);
> +		spin_unlock_irqrestore(&channel->intent_lock, flags);
> +
> +		if (ret < 0)
> +			dev_err(glink->dev, "failed to store remote intent\n");
> +	}
> +
> +	kfree(msg);
> +	qcom_glink_rx_advance(glink, ALIGN(msglen, 8));
> +}
> +
>   static int qcom_glink_rx_open_ack(struct qcom_glink *glink, unsigned int lcid)
>   {
>   	struct glink_channel *channel;
> @@ -864,6 +930,9 @@ static irqreturn_t qcom_glink_native_intr(int irq, void *data)
>   
>   			ret = 0;
>   			break;
> +		case RPM_CMD_INTENT:
> +			qcom_glink_handle_intent(glink, param1, param2, avail);
> +			break;
>   		default:
>   			qcom_glink_rx_advance(glink, ALIGN(sizeof(msg), 8));
>   			dev_err(glink->dev, "unhandled rx cmd: %d\n", cmd);
