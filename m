From: rohitkr@codeaurora.org (Rohit Kumar)
Date: Wed, 7 Feb 2018 17:04:06 +0530
Subject: [alsa-devel] [RESEND PATCH v2 11/15] ASoC: qcom: qdsp6: Add
 support to q6afe dai driver
In-Reply-To: <20171214173402.19074-12-srinivas.kandagatla@linaro.org>
References: <20171214173402.19074-1-srinivas.kandagatla@linaro.org>
 <20171214173402.19074-12-srinivas.kandagatla@linaro.org>
Message-ID: <33dbc1d9-ec33-b779-9258-4d1b13e17aaa@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 12/14/2017 11:03 PM, srinivas.kandagatla at linaro.org wrote:
> From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>
> This patch adds support to q6afe backend dais driver.
>
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---
>   sound/soc/qcom/Kconfig           |   5 +
>   sound/soc/qcom/qdsp6/Makefile    |   1 +
>   sound/soc/qcom/qdsp6/q6afe-dai.c | 241 +++++++++++++++++++++++++++++++++++++++
>   3 files changed, 247 insertions(+)
>   create mode 100644 sound/soc/qcom/qdsp6/q6afe-dai.c
>
> diff --git a/sound/soc/qcom/Kconfig b/sound/soc/qcom/Kconfig
> index dd8fb0cde614..003ce182691c 100644
> --- a/sound/soc/qcom/Kconfig
> +++ b/sound/soc/qcom/Kconfig
> @@ -64,6 +64,10 @@ config SND_SOC_QDSP6_ROUTING
>   	tristate
>   	default n
>   
> +config SND_SOC_QDSP6_AFE_DAI
> +	tristate
> +	default n
> +
>   config SND_SOC_QDSP6
>   	tristate "SoC ALSA audio driver for QDSP6"
>   	select SND_SOC_QDSP6_AFE
> @@ -71,6 +75,7 @@ config SND_SOC_QDSP6
>   	select SND_SOC_QDSP6_ASM
>   	select SND_SOC_QDSP6_CORE
>   	select SND_SOC_QDSP6_ROUTING
> +	select SND_SOC_QDSP6_AFE_DAI
>   	help
>   	 To add support for MSM QDSP6 Soc Audio.
>   	 This will enable sound soc platform specific
> diff --git a/sound/soc/qcom/qdsp6/Makefile b/sound/soc/qcom/qdsp6/Makefile
> index c1ad060a2341..bd8bd02bf09e 100644
> --- a/sound/soc/qcom/qdsp6/Makefile
> +++ b/sound/soc/qcom/qdsp6/Makefile
> @@ -3,3 +3,4 @@ obj-$(CONFIG_SND_SOC_QDSP6_ADM) += q6adm.o
>   obj-$(CONFIG_SND_SOC_QDSP6_ASM) += q6asm.o
>   obj-$(CONFIG_SND_SOC_QDSP6_CORE) += q6core.o
>   obj-$(CONFIG_SND_SOC_QDSP6_ROUTING) += q6routing.o
> +obj-$(CONFIG_SND_SOC_QDSP6_AFE_DAI) += q6afe-dai.o
> diff --git a/sound/soc/qcom/qdsp6/q6afe-dai.c b/sound/soc/qcom/qdsp6/q6afe-dai.c
> new file mode 100644
> index 000000000000..e9865c684bcb
> --- /dev/null
> +++ b/sound/soc/qcom/qdsp6/q6afe-dai.c
> @@ -0,0 +1,241 @@
> +/* SPDX-License-Identifier: GPL-2.0
> +* Copyright (c) 2011-2016, The Linux Foundation
> +* Copyright (c) 2017, Linaro Limited
> +*/
> +#include <linux/err.h>
> +#include <linux/init.h>
> +#include <linux/module.h>
> +#include <linux/device.h>
> +#include <linux/platform_device.h>
> +#include <linux/slab.h>
> +#include <sound/pcm.h>
> +#include <sound/soc.h>
> +#include <sound/pcm_params.h>
> +#include "q6afe.h"
> +
> +struct q6hdmi_dai_data {
> +	struct q6afe_port *port;
> +	struct q6afe_hdmi_cfg port_config;
> +	bool is_port_started;
> +};
> +
> +static int q6hdmi_format_put(struct snd_kcontrol *kcontrol,
> +				struct snd_ctl_elem_value *ucontrol)
> +{
> +	struct q6hdmi_dai_data *dai_data = kcontrol->private_data;
> +	int value = ucontrol->value.integer.value[0];
> +
> +	dai_data->port_config.datatype = value;
....
> +
> +static struct platform_driver q6afe_dai_driver = {
> +	.probe  = q6afe_dai_dev_probe,
> +	.remove = q6afe_dai_dev_remove,
> +	.driver = {
> +		.name = "q6afe_dai",
> +		.owner = THIS_MODULE,
> +	},
> +};
> +
> +module_platform_driver(q6afe_dai_driver);
MODULE_LICENSE missing.
