From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 11 Nov 2014 12:04:57 +0000
Subject: [RFC 1/2] mfd: qcom-rpm: Expose sleep state resources to clients
In-Reply-To: <1415659966-16200-2-git-send-email-bjorn.andersson@sonymobile.com>
References: <1415659966-16200-1-git-send-email-bjorn.andersson@sonymobile.com>
 <1415659966-16200-2-git-send-email-bjorn.andersson@sonymobile.com>
Message-ID: <20141111120457.GZ24004@x1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 10 Nov 2014, Bjorn Andersson wrote:

> Resources exposed from the RPM have an "active state" that is used during
> normal operations and a "sleep state" that is used for HW assisted sleep
> modes. Expose this in the api to let client drivers set the "sleep
> state" as well.

I assume you have users lined up which will request a sleeping state?

> Signed-off-by: Bjorn Andersson <bjorn.andersson@sonymobile.com>
> ---
>  drivers/mfd/qcom_rpm.c                 |    9 +++++----
>  drivers/regulator/qcom_rpm-regulator.c |    1 +
>  include/linux/mfd/qcom_rpm.h           |    5 ++++-
>  3 files changed, 10 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/mfd/qcom_rpm.c b/drivers/mfd/qcom_rpm.c
> index 0dd7a6fe..f696328 100644
> --- a/drivers/mfd/qcom_rpm.c
> +++ b/drivers/mfd/qcom_rpm.c
> @@ -67,7 +67,6 @@ struct qcom_rpm {
>  #define RPM_ACK_SELECTOR	23
>  #define RPM_SELECT_SIZE		7
>  
> -#define RPM_ACTIVE_STATE	BIT(0)
>  #define RPM_NOTIFICATION	BIT(30)
>  #define RPM_REJECTED		BIT(31)
>  
> @@ -332,7 +331,10 @@ static const struct of_device_id qcom_rpm_of_match[] = {
>  };
>  MODULE_DEVICE_TABLE(of, qcom_rpm_of_match);
>  
> -int qcom_rpm_write(struct qcom_rpm *rpm, int resource, u32 *buf, size_t count)
> +int qcom_rpm_write(struct qcom_rpm *rpm,
> +		   int state,
> +		   int resource,
> +		   u32 *buf, size_t count)
>  {
>  	const struct qcom_rpm_resource *res;
>  	const struct qcom_rpm_data *data = rpm->data;
> @@ -359,8 +361,7 @@ int qcom_rpm_write(struct qcom_rpm *rpm, int resource, u32 *buf, size_t count)
>  			       RPM_CTRL_REG(rpm, RPM_REQ_SELECT + i));
>  	}
>  
> -	writel_relaxed(RPM_ACTIVE_STATE,
> -		       RPM_CTRL_REG(rpm, RPM_REQUEST_CONTEXT));
> +	writel_relaxed(BIT(state), RPM_CTRL_REG(rpm, RPM_REQUEST_CONTEXT));

How are the state bits organised?

>  	reinit_completion(&rpm->ack);
>  	regmap_write(rpm->ipc_regmap, rpm->ipc_offset, BIT(rpm->ipc_bit));
> diff --git a/drivers/regulator/qcom_rpm-regulator.c b/drivers/regulator/qcom_rpm-regulator.c
> index b55cd5b..4fc1c7e 100644
> --- a/drivers/regulator/qcom_rpm-regulator.c
> +++ b/drivers/regulator/qcom_rpm-regulator.c
> @@ -198,6 +198,7 @@ static int rpm_reg_write(struct qcom_rpm_reg *vreg,
>  	vreg->val[req->word] |= value << req->shift;
>  
>  	return qcom_rpm_write(vreg->rpm,
> +			      RPM_ACTIVE_STATE,
>  			      vreg->resource,
>  			      vreg->val,
>  			      vreg->parts->request_len);
> diff --git a/include/linux/mfd/qcom_rpm.h b/include/linux/mfd/qcom_rpm.h
> index a60798d..f0e70b2 100644
> --- a/include/linux/mfd/qcom_rpm.h
> +++ b/include/linux/mfd/qcom_rpm.h
> @@ -5,6 +5,9 @@
>  
>  struct qcom_rpm;
>  
> -int qcom_rpm_write(struct qcom_rpm *rpm, int resource, u32 *buf, size_t count);
> +#define RPM_ACTIVE_STATE	0
> +#define RPM_SLEEP_STATE		1
> +
> +int qcom_rpm_write(struct qcom_rpm *rpm, int state, int resource, u32 *buf, size_t count);
>  
>  #endif

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
