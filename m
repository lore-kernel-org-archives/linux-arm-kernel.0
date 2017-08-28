From: aneela@codeaurora.org (Arun Kumar Neelakantam)
Date: Mon, 28 Aug 2017 17:20:53 +0530
Subject: [PATCH v2 16/20] rpmsg: glink: Add announce_create ops and
 preallocate intents
In-Reply-To: <1503559302-3744-17-git-send-email-sricharan@codeaurora.org>
References: <1503559302-3744-1-git-send-email-sricharan@codeaurora.org>
 <1503559302-3744-17-git-send-email-sricharan@codeaurora.org>
Message-ID: <98437e4e-36e1-4833-2bd2-92d7f42e05b4@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 8/24/2017 12:51 PM, Sricharan R wrote:
> Preallocate local intent buffers and pass the intent ids
> to the remote. This way there are some default intents
> available  for the remote to start sending data without
> having to wait by sending intent requests. Do this by
> adding the rpmsg announce_create ops, which gets called
> right after the rpmsg device gets probed.
>
> Signed-off-by: Sricharan R <sricharan@codeaurora.org>
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Acked-by: Arun Kumar Neelakantam <aneela@codeaurora.org>

Regards,
Arun N
> ---
>   drivers/rpmsg/qcom_glink_native.c | 20 ++++++++++++++++++++
>   1 file changed, 20 insertions(+)
>
> diff --git a/drivers/rpmsg/qcom_glink_native.c b/drivers/rpmsg/qcom_glink_native.c
> index 1458bdb..76ee86e 100644
> --- a/drivers/rpmsg/qcom_glink_native.c
> +++ b/drivers/rpmsg/qcom_glink_native.c
> @@ -1002,6 +1002,25 @@ static struct rpmsg_endpoint *qcom_glink_create_ept(struct rpmsg_device *rpdev,
>   	return ept;
>   }
>   
> +static int qcom_glink_announce_create(struct rpmsg_device *rpdev)
> +{
> +	struct glink_channel *channel = to_glink_channel(rpdev->ept);
> +	struct glink_core_rx_intent *intent;
> +	struct qcom_glink *glink = channel->glink;
> +	int num_intents = glink->intentless ? 0 : 5;
> +
> +	/* Channel is now open, advertise base set of intents */
> +	while (num_intents--) {
> +		intent = qcom_glink_alloc_intent(glink, channel, SZ_1K, true);
> +		if (!intent)
> +			break;
> +
> +		qcom_glink_advertise_intent(glink, channel, intent);
> +	}
> +
> +	return 0;
> +}
> +
>   static void qcom_glink_destroy_ept(struct rpmsg_endpoint *ept)
>   {
>   	struct glink_channel *channel = to_glink_channel(ept);
> @@ -1077,6 +1096,7 @@ static struct device_node *qcom_glink_match_channel(struct device_node *node,
>   
>   static const struct rpmsg_device_ops glink_device_ops = {
>   	.create_ept = qcom_glink_create_ept,
> +	.announce_create = qcom_glink_announce_create,
>   };
>   
>   static const struct rpmsg_endpoint_ops glink_endpoint_ops = {
