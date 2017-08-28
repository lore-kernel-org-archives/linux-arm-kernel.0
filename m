From: aneela@codeaurora.org (Arun Kumar Neelakantam)
Date: Mon, 28 Aug 2017 17:20:31 +0530
Subject: [PATCH v2 15/20] rpmsg: glink: Add rx done command
In-Reply-To: <1503559302-3744-16-git-send-email-sricharan@codeaurora.org>
References: <1503559302-3744-1-git-send-email-sricharan@codeaurora.org>
 <1503559302-3744-16-git-send-email-sricharan@codeaurora.org>
Message-ID: <24490135-c5ce-8d9d-b523-22c3b0538ad8@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 8/24/2017 12:51 PM, Sricharan R wrote:
> Send RX data receive ack to remote and also inform
> that local intent buffer is used and freed. This
> informs the remote to request for next set of
> intent buffers before doing a send operation.
>
> Signed-off-by: Sricharan R <sricharan@codeaurora.org>
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Acked-by: Arun Kumar Neelakantam <aneela@codeaurora.org>

Regards,
Arun N
> ---
>   drivers/rpmsg/qcom_glink_native.c | 83 +++++++++++++++++++++++++++++++++++++++
>   1 file changed, 83 insertions(+)
>
> diff --git a/drivers/rpmsg/qcom_glink_native.c b/drivers/rpmsg/qcom_glink_native.c
> index ff83cbb..1458bdb 100644
> --- a/drivers/rpmsg/qcom_glink_native.c
> +++ b/drivers/rpmsg/qcom_glink_native.c
> @@ -77,6 +77,8 @@ struct glink_core_rx_intent {
>   	bool reuse;
>   	bool in_use;
>   	u32 offset;
> +
> +	struct list_head node;
>   };
>   
>   /**
> @@ -139,6 +141,8 @@ enum {
>    * @rcid:	channel id, in remote space
>    * @intent_lock: lock for protection of @liids
>    * @liids:	idr of all local intents
> + * @intent_work: worker responsible for transmitting rx_done packets
> + * @done_intents: list of intents that needs to be announced rx_done
>    * @buf:	receive buffer, for gathering fragments
>    * @buf_offset:	write offset in @buf
>    * @buf_size:	size of current @buf
> @@ -161,6 +165,8 @@ struct glink_channel {
>   
>   	spinlock_t intent_lock;
>   	struct idr liids;
> +	struct work_struct intent_work;
> +	struct list_head done_intents;
>   
>   	struct glink_core_rx_intent *buf;
>   	int buf_offset;
> @@ -180,15 +186,19 @@ struct glink_channel {
>   #define RPM_CMD_CLOSE			3
>   #define RPM_CMD_OPEN_ACK		4
>   #define RPM_CMD_INTENT			5
> +#define RPM_CMD_RX_DONE			6
>   #define RPM_CMD_RX_INTENT_REQ		7
>   #define RPM_CMD_RX_INTENT_REQ_ACK	8
>   #define RPM_CMD_TX_DATA			9
>   #define RPM_CMD_CLOSE_ACK		11
>   #define RPM_CMD_TX_DATA_CONT		12
>   #define RPM_CMD_READ_NOTIF		13
> +#define RPM_CMD_RX_DONE_W_REUSE		14
>   
>   #define GLINK_FEATURE_INTENTLESS	BIT(1)
>   
> +static void qcom_glink_rx_done_work(struct work_struct *work);
> +
>   static struct glink_channel *qcom_glink_alloc_channel(struct qcom_glink *glink,
>   						      const char *name)
>   {
> @@ -201,12 +211,16 @@ static struct glink_channel *qcom_glink_alloc_channel(struct qcom_glink *glink,
>   	/* Setup glink internal glink_channel data */
>   	spin_lock_init(&channel->recv_lock);
>   	spin_lock_init(&channel->intent_lock);
> +
>   	channel->glink = glink;
>   	channel->name = kstrdup(name, GFP_KERNEL);
>   
>   	init_completion(&channel->open_req);
>   	init_completion(&channel->open_ack);
>   
> +	INIT_LIST_HEAD(&channel->done_intents);
> +	INIT_WORK(&channel->intent_work, qcom_glink_rx_done_work);
> +
>   	idr_init(&channel->liids);
>   	kref_init(&channel->refcount);
>   
> @@ -402,6 +416,70 @@ static void qcom_glink_send_close_ack(struct qcom_glink *glink,
>   	qcom_glink_tx(glink, &req, sizeof(req), NULL, 0, true);
>   }
>   
> +static void qcom_glink_rx_done_work(struct work_struct *work)
> +{
> +	struct glink_channel *channel = container_of(work, struct glink_channel,
> +						     intent_work);
> +	struct qcom_glink *glink = channel->glink;
> +	struct glink_core_rx_intent *intent, *tmp;
> +	struct {
> +		u16 id;
> +		u16 lcid;
> +		u32 liid;
> +	} __packed cmd;
> +
> +	unsigned int cid = channel->lcid;
> +	unsigned int iid;
> +	bool reuse;
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&channel->intent_lock, flags);
> +	list_for_each_entry_safe(intent, tmp, &channel->done_intents, node) {
> +		list_del(&intent->node);
> +		spin_unlock_irqrestore(&channel->intent_lock, flags);
> +		iid = intent->id;
> +		reuse = intent->reuse;
> +
> +		cmd.id = reuse ? RPM_CMD_RX_DONE_W_REUSE : RPM_CMD_RX_DONE;
> +		cmd.lcid = cid;
> +		cmd.liid = iid;
> +
> +		qcom_glink_tx(glink, &cmd, sizeof(cmd), NULL, 0, true);
> +		if (!reuse) {
> +			kfree(intent->data);
> +			kfree(intent);
> +		}
> +		spin_lock_irqsave(&channel->intent_lock, flags);
> +	}
> +	spin_unlock_irqrestore(&channel->intent_lock, flags);
> +}
> +
> +static void qcom_glink_rx_done(struct qcom_glink *glink,
> +			       struct glink_channel *channel,
> +			       struct glink_core_rx_intent *intent)
> +{
> +	/* We don't send RX_DONE to intentless systems */
> +	if (glink->intentless) {
> +		kfree(intent->data);
> +		kfree(intent);
> +		return;
> +	}
> +
> +	/* Take it off the tree of receive intents */
> +	if (!intent->reuse) {
> +		spin_lock(&channel->intent_lock);
> +		idr_remove(&channel->liids, intent->id);
> +		spin_unlock(&channel->intent_lock);
> +	}
> +
> +	/* Schedule the sending of a rx_done indication */
> +	spin_lock(&channel->intent_lock);
> +	list_add_tail(&intent->node, &channel->done_intents);
> +	spin_unlock(&channel->intent_lock);
> +
> +	schedule_work(&channel->intent_work);
> +}
> +
>   /**
>    * qcom_glink_receive_version() - receive version/features from remote system
>    *
> @@ -718,6 +796,8 @@ static int qcom_glink_rx_data(struct qcom_glink *glink, size_t avail)
>   
>   		intent->offset = 0;
>   		channel->buf = NULL;
> +
> +		qcom_glink_rx_done(glink, channel, intent);
>   	}
>   
>   advance_rx:
> @@ -1107,6 +1187,9 @@ static void qcom_glink_rx_close(struct qcom_glink *glink, unsigned int rcid)
>   	if (WARN(!channel, "close request on unknown channel\n"))
>   		return;
>   
> +	/* cancel pending rx_done work */
> +	cancel_work_sync(&channel->intent_work);
> +
>   	if (channel->rpdev) {
>   		strncpy(chinfo.name, channel->name, sizeof(chinfo.name));
>   		chinfo.src = RPMSG_ADDR_ANY;
