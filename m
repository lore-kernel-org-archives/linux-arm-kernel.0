From: rohitkr@codeaurora.org (Rohit Kumar)
Date: Wed, 7 Feb 2018 17:45:53 +0530
Subject: [alsa-devel] [RESEND PATCH v2 09/15] ASoC: qcom: qdsp6: Add
 support to Q6CORE
In-Reply-To: <20171214173402.19074-10-srinivas.kandagatla@linaro.org>
References: <20171214173402.19074-1-srinivas.kandagatla@linaro.org>
 <20171214173402.19074-10-srinivas.kandagatla@linaro.org>
Message-ID: <39d78468-db2b-05ce-9602-c76b083d7f75@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 12/14/2017 11:03 PM, srinivas.kandagatla at linaro.org wrote:
> From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>
> This patch adds support to core apr service, which is used to query
> status of other static and dynamic services on the dsp.
>
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---
>   sound/soc/qcom/Kconfig        |   5 +
>   sound/soc/qcom/qdsp6/Makefile |   1 +
>   sound/soc/qcom/qdsp6/q6core.c | 227 ++++++++++++++++++++++++++++++++++++++++++
>   3 files changed, 233 insertions(+)
>   create mode 100644 sound/soc/qcom/qdsp6/q6core.c
>
> diff --git a/sound/soc/qcom/Kconfig b/sound/soc/qcom/Kconfig
> index 7ebdb879a8a3..121b9c957024 100644
> --- a/sound/soc/qcom/Kconfig
> +++ b/sound/soc/qcom/Kconfig
> @@ -56,11 +56,16 @@ config SND_SOC_QDSP6_ASM
>   	tristate
>   	default n
>   
> +config SND_SOC_QDSP6_CORE
> +	tristate
> +	default n
> +
>   config SND_SOC_QDSP6
>   	tristate "SoC ALSA audio driver for QDSP6"
>   	select SND_SOC_QDSP6_AFE
>   	select SND_SOC_QDSP6_ADM
>   	select SND_SOC_QDSP6_ASM
> +	select SND_SOC_QDSP6_CORE
>   	help
>   	 To add support for MSM QDSP6 Soc Audio.
>   	 This will enable sound soc platform specific
> diff --git a/sound/soc/qcom/qdsp6/Makefile b/sound/soc/qcom/qdsp6/Makefile
> index 49dd3ccab27b..ad7f10691e54 100644
> --- a/sound/soc/qcom/qdsp6/Makefile
> +++ b/sound/soc/qcom/qdsp6/Makefile
> @@ -1,3 +1,4 @@
>   obj-$(CONFIG_SND_SOC_QDSP6_AFE) += q6afe.o
>   obj-$(CONFIG_SND_SOC_QDSP6_ADM) += q6adm.o
>   obj-$(CONFIG_SND_SOC_QDSP6_ASM) += q6asm.o
> +obj-$(CONFIG_SND_SOC_QDSP6_CORE) += q6core.o
> diff --git a/sound/soc/qcom/qdsp6/q6core.c b/sound/soc/qcom/qdsp6/q6core.c
> new file mode 100644
> index 000000000000..d4e2dbc62489
> --- /dev/null
> +++ b/sound/soc/qcom/qdsp6/q6core.c
> @@ -0,0 +1,227 @@
> +/* SPDX-License-Identifier: GPL-2.0
> +* Copyright (c) 2017, Linaro Limited
> +*/
> +#include <linux/slab.h>
> +#include <linux/wait.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/sched.h>
> +#include <linux/jiffies.h>
[..]
> +
> +	dev_set_drvdata(&adev->dev, core);
> +
> +	core->adev = adev;
> +	init_waitqueue_head(&core->wait);
> +
> +	do {
> +		if (!q6core_is_adsp_ready(core)) {
> +			dev_info(&adev->dev, "ADSP Audio isn't ready\n");
> +		} else {
> +			dev_info(&adev->dev, "ADSP Audio is ready\n");
> +
If q6core_is_adsp_ready() return failure, then we should not call and 
ADSP API.
> +			ret = q6core_get_svc_versions(core);
> +			if (!ret)
> +				q6core_add_static_services(core);
> +
> +			break;
> +		}
> +	} while (time_after(timeout, jiffies));
> +
I think we should defer probe if q6core_is_adsp_ready() returns failure 
and timeouts.
> +	return ret;
> +}
> +
> +static int q6core_exit(struct apr_device *adev)
> +{
> +	return 0;
> +}
> +
> +static const struct apr_device_id core_id[] = {
> +	{"Q6CORE", APR_DOMAIN_ADSP, APR_SVC_ADSP_CORE, APR_CLIENT_AUDIO},
> +	{ },
> +};
> +
> +static struct apr_driver qcom_q6core_driver = {
> +	.probe = q6core_probe,
> +	.remove = q6core_exit,
> +	.callback = core_callback,
> +	.id_table = core_id,
> +	.driver = {
> +		   .name = "qcom-q6core",
> +		   },
> +};
> +
> +module_apr_driver(qcom_q6core_driver);
> +
> +MODULE_AUTHOR("Srinivas Kandagatla <srinivas.kandagatla@linaro.org");
> +MODULE_DESCRIPTION("q6 core");
> +MODULE_LICENSE("GPL v2");
