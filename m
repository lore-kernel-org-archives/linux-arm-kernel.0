From: clew@codeaurora.org (Chris Lew)
Date: Mon, 28 Aug 2017 14:51:51 -0700
Subject: [PATCH v2 11/20] rpmsg: glink: Fix idr_lock from mutex to spinlock
In-Reply-To: <1503559302-3744-12-git-send-email-sricharan@codeaurora.org>
References: <1503559302-3744-1-git-send-email-sricharan@codeaurora.org>
 <1503559302-3744-12-git-send-email-sricharan@codeaurora.org>
Message-ID: <88b34df6-d697-1d98-6427-5ddfe14785b1@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sricharan,

Minor bug in this patch.

On 8/24/2017 12:21 AM, Sricharan R wrote:
[..]
> @@ -829,11 +839,14 @@ static int qcom_glink_rx_open(struct qcom_glink *glink, unsigned int rcid,
>   	struct device_node *node;
>   	int lcid;
>   	int ret;
> +	unsigned long flags;
>   
> +	spin_lock_irqsave(&glink->idr_lock, flags);
>   	idr_for_each_entry(&glink->lcids, channel, lcid) {
>   		if (!strcmp(channel->name, name))
>   			break;
>   	}
> +	spin_unlock_irqrestore(&glink->idr_lock, flags);
>   
>   	if (!channel) {
>   		channel = qcom_glink_alloc_channel(glink, name);
> @@ -844,15 +857,15 @@ static int qcom_glink_rx_open(struct qcom_glink *glink, unsigned int rcid,
>   		create_device = true;
>   	}
>   
> -	mutex_lock(&glink->idr_lock);
> +	spin_lock_irqsave(&glink->idr_lock, flags);
>   	ret = idr_alloc(&glink->rcids, channel, rcid, rcid + 1, GFP_KERNEL);

I think GFP_KERNEL should be changed to GFP_ATOMIC if the mutex is 
changed to spinlock.

Thanks,
Chris
-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
