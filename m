From: sboyd@codeaurora.org (Stephen Boyd)
Date: Thu, 3 Sep 2015 14:33:22 -0700
Subject: [PATCH] firmware: qcom: scm: Convert to platform driver
In-Reply-To: <1437431152-6730-1-git-send-email-agross@codeaurora.org>
References: <1437431152-6730-1-git-send-email-agross@codeaurora.org>
Message-ID: <20150903213322.GI15099@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/20, Andy Gross wrote:
> This patch creates a platform driver for the SCM so that we can adequately
> manage resources.  This removes clients having to carry the necessary
> clocks to use the SCM resources.
> 
> Signed-off-by: Andy Gross <agross@codeaurora.org>
> ---

It would be nice if we could use this platform device for doing
the DMAish memory allocations that we do in this driver too. I
guess one complication there is that we would need to allocate
memory with the DMA APIs before CPUs are brought up
(early_initcall level).

> diff --git a/drivers/firmware/qcom_scm.c b/drivers/firmware/qcom_scm.c
> index 45c008d..5dd0514 100644
> --- a/drivers/firmware/qcom_scm.c
> +++ b/drivers/firmware/qcom_scm.c
> @@ -15,14 +15,57 @@
>   * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
>   * 02110-1301, USA.
>   */
> -
> +#include <linux/platform_device.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>

This include is here twice.

>  #include <linux/cpumask.h>
>  #include <linux/export.h>
>  #include <linux/types.h>
>  #include <linux/qcom_scm.h>
> +#include <linux/of.h>
> +#include <linux/clk.h>
>  
[...]
> +
> +/**
> + * qcom_scm_is_available() - Checks if SCM is available
> + */
> +bool qcom_scm_is_available(void)
> +{
> +	return !!__scm;
> +}
> +EXPORT_SYMBOL(qcom_scm_is_available);
> +
> +static int qcom_scm_remove(struct platform_device *pdev)
> +{
> +	__scm = NULL;
> +
> +	return 0;
> +}

Maybe we just shouldn't allow this? The firmware isn't going
anywhere at runtime, and this driver is currently marked as
bool in the Kconfig.

> +
> +static const struct of_device_id qcom_scm_dt_match[] = {
> +	{ .compatible = "qcom,scm",},
> +	{},
> +};
> +
> +MODULE_DEVICE_TABLE(of, qcom_scm_dt_match);
> +
> +static struct platform_driver qcom_scm_driver = {
> +	.driver = {
> +		.name	= "scm",

Maybe 'qcom_scm' ?

> +		.of_match_table = qcom_scm_dt_match,
> +	},
> +	.probe = qcom_scm_probe,
> +	.remove = qcom_scm_remove,
> +};
> +
> +module_platform_driver(qcom_scm_driver);

Isn't there some sort of builtin_platform_driver() macro for
builtin modules?

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
