From: aneela@codeaurora.org (Arun Kumar Neelakantam)
Date: Tue, 22 Aug 2017 14:56:08 +0530
Subject: [PATCH 11/18] rpmsg: glink: Use the local intents when receiving
 data
In-Reply-To: <1502903951-5403-12-git-send-email-sricharan@codeaurora.org>
References: <1502903951-5403-1-git-send-email-sricharan@codeaurora.org>
 <1502903951-5403-12-git-send-email-sricharan@codeaurora.org>
Message-ID: <1dc63580-4a6c-750a-7cb6-00906a4ea4c0@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 8/16/2017 10:49 PM, Sricharan R wrote:
> So previously on request from remote side, we allocated local
> intent buffers and passed the ids to the remote. Now when
> we receive data buffers from remote directed to that intent
> id, copy the data to the corresponding preallocated intent
> buffer.
>
> Signed-off-by: Sricharan R <sricharan@codeaurora.org>
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---
>   drivers/rpmsg/qcom_glink_native.c | 75 ++++++++++++++++++++++++++-------------
>   1 file changed, 50 insertions(+), 25 deletions(-)
>
> diff --git a/drivers/rpmsg/qcom_glink_native.c b/drivers/rpmsg/qcom_glink_native.c
> index cbc9f9e..d6aa589 100644
> --- a/drivers/rpmsg/qcom_glink_native.c
> +++ b/drivers/rpmsg/qcom_glink_native.c
> @@ -160,7 +160,7 @@ struct glink_channel {
>   	spinlock_t intent_lock;
>   	struct idr liids;
>   
> -	void *buf;
> +	struct glink_core_rx_intent *buf;
>   	int buf_offset;
>   	int buf_size;
>   
> @@ -607,6 +607,7 @@ static int qcom_glink_rx_defer(struct qcom_glink *glink, size_t extra)
>   
>   static int qcom_glink_rx_data(struct qcom_glink *glink, size_t avail)
>   {
> +	struct glink_core_rx_intent *intent;
>   	struct glink_channel *channel;
>   	struct {
>   		struct glink_msg msg;
> @@ -616,6 +617,8 @@ static int qcom_glink_rx_data(struct qcom_glink *glink, size_t avail)
>   	unsigned int chunk_size;
>   	unsigned int left_size;
>   	unsigned int rcid;
> +	unsigned int liid;
> +	int ret = 0;
>   	unsigned long flags;
>   
>   	if (avail < sizeof(hdr)) {
> @@ -643,56 +646,78 @@ static int qcom_glink_rx_data(struct qcom_glink *glink, size_t avail)
>   		dev_dbg(glink->dev, "Data on non-existing channel\n");
>   
>   		/* Drop the message */
> -		qcom_glink_rx_advance(glink,
> -				      ALIGN(sizeof(hdr) + chunk_size, 8));
> -		return 0;
> +		goto advance_rx;
>   	}
>   
> -	/* Might have an ongoing, fragmented, message to append */
> -	if (!channel->buf) {
> -		channel->buf = kmalloc(chunk_size + left_size, GFP_ATOMIC);
> -		if (!channel->buf)
> -			return -ENOMEM;
> +	if (glink->intentless) {
> +		/* Might have an ongoing, fragmented, message to append */
> +		if (!channel->buf) {
> +			intent = kzalloc(sizeof(*intent), GFP_ATOMIC);
> +			if (!intent)
> +				return -ENOMEM;
> +
> +			intent->data = kmalloc(chunk_size + left_size,
> +					       GFP_ATOMIC);

Who is supposed to free the intent and intent->data memory ?
> +			if (!intent->data) {
> +				kfree(intent);
> +				return -ENOMEM;
> +			}
> +
> +			intent->id = 0xbabababa;
> +			intent->size = chunk_size + left_size;
> +			intent->offset = 0;
> +
> +			channel->buf = intent;
> +		} else {
> +			intent = channel->buf;
> +		}
> +	} else {
> +		liid = le32_to_cpu(hdr.msg.param2);
>   
> -		channel->buf_size = chunk_size + left_size;
> -		channel->buf_offset = 0;
> -	}
> +		spin_lock_irqsave(&channel->intent_lock, flags);
> +		intent = idr_find(&channel->liids, liid);
> +		spin_unlock_irqrestore(&channel->intent_lock, flags);
>   
> -	qcom_glink_rx_advance(glink, sizeof(hdr));
> +		if (!intent) {
> +			dev_err(glink->dev,
> +				"no intent found for channel %s intent %d",
> +				channel->name, liid);
> +			goto advance_rx;
> +		}
> +	}
>   
> -	if (channel->buf_size - channel->buf_offset < chunk_size) {
> -		dev_err(glink->dev, "Insufficient space in input buffer\n");
> +	if (intent->size - intent->offset < chunk_size) {
> +		dev_err(glink->dev, "Insufficient space in intent\n");
>   
>   		/* The packet header lied, drop payload */
> -		qcom_glink_rx_advance(glink, chunk_size);
> -		return -ENOMEM;
> +		goto advance_rx;
>   	}
>   
> -	qcom_glink_rx_peak(glink, channel->buf + channel->buf_offset,
> +	qcom_glink_rx_advance(glink, ALIGN(sizeof(hdr), 8));
> +	qcom_glink_rx_peak(glink, intent->data + intent->offset,
>   			   chunk_size);
> -	channel->buf_offset += chunk_size;
> +	intent->offset += chunk_size;
>   
>   	/* Handle message when no fragments remain to be received */
>   	if (!left_size) {
>   		spin_lock(&channel->recv_lock);
>   		if (channel->ept.cb) {
>   			channel->ept.cb(channel->ept.rpdev,
> -					channel->buf,
> -					channel->buf_offset,
> +					intent->data,
> +					intent->offset,
>   					channel->ept.priv,
>   					RPMSG_ADDR_ANY);
>   		}
>   		spin_unlock(&channel->recv_lock);
>   
> -		kfree(channel->buf);
> +		intent->offset = 0;
>   		channel->buf = NULL;
> -		channel->buf_size = 0;
>   	}
>   
> -	/* Each message starts at 8 byte aligned address */
> +advance_rx:
>   	qcom_glink_rx_advance(glink, ALIGN(chunk_size, 8));
>   
> -	return 0;
> +	return ret;
>   }
>   
>   static int qcom_glink_rx_open_ack(struct qcom_glink *glink, unsigned int lcid)
