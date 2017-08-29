From: bjorn.andersson@linaro.org (Bjorn Andersson)
Date: Tue, 29 Aug 2017 13:57:15 -0700
Subject: [PATCH v2 09/20] rpmsg: glink: Fix default case while handling
 received commands
In-Reply-To: <1503559302-3744-10-git-send-email-sricharan@codeaurora.org>
References: <1503559302-3744-1-git-send-email-sricharan@codeaurora.org>
 <1503559302-3744-10-git-send-email-sricharan@codeaurora.org>
Message-ID: <20170829205715.GJ29306@minitux>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu 24 Aug 00:21 PDT 2017, Sricharan R wrote:

> Currently if we receive a command that we still do not
> support, then its simply discarded. While doing so, the
> RX FIFO pointer also needs to be incremented. Fixing this.
> 

Messages are variable length, so when we hit a unrecognized message we
don't know how far to advance the rx tail, meaning that with this change
we're more likely to get out of sync than to actually find the next
message. Which like would make people debug side effects of this.

I believe a better way to handle this would be to acquire a reference to
the parent struct rproc and call rproc_report_crash() on this, if it
exist (i.e. it's not RPM).

Regards,
Bjorn

> Signed-off-by: Sricharan R <sricharan@codeaurora.org>
> ---
>  drivers/rpmsg/qcom_glink_native.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/rpmsg/qcom_glink_native.c b/drivers/rpmsg/qcom_glink_native.c
> index 50a8008..9a58925 100644
> --- a/drivers/rpmsg/qcom_glink_native.c
> +++ b/drivers/rpmsg/qcom_glink_native.c
> @@ -541,6 +541,7 @@ static irqreturn_t qcom_glink_native_intr(int irq, void *data)
>  			ret = 0;
>  			break;
>  		default:
> +			qcom_glink_rx_advance(glink, ALIGN(sizeof(msg), 8));
>  			dev_err(glink->dev, "unhandled rx cmd: %d\n", cmd);
>  			ret = -EINVAL;
>  			break;
> -- 
> QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
> 
