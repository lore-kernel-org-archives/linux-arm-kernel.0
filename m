From: bgoswami@codeaurora.org (Banajit Goswami)
Date: Fri, 4 May 2018 12:04:30 -0700
Subject: [PATCH v7 08/24] ASoC: qdsp6: q6core: Add q6core driver
In-Reply-To: <20180501120820.11016-9-srinivas.kandagatla@linaro.org>
References: <20180501120820.11016-1-srinivas.kandagatla@linaro.org>
 <20180501120820.11016-9-srinivas.kandagatla@linaro.org>
Message-ID: <46511158-ed1d-7f07-0a8f-b325c088e386@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On 5/1/2018 5:08 AM, Srinivas Kandagatla wrote:
> This patch adds support to core apr service, which is used to query
> status of other static and dynamic services on the dsp.
>
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> Reviewed-and-tested-by: Rohit kumar <rohitkr@codeaurora.org>
> ---
>   sound/soc/qcom/Kconfig        |   4 +
>   sound/soc/qcom/qdsp6/Makefile |   1 +
>   sound/soc/qcom/qdsp6/q6core.c | 380 ++++++++++++++++++++++++++++++++++++++++++
>   sound/soc/qcom/qdsp6/q6core.h |  15 ++
>   4 files changed, 400 insertions(+)
>   create mode 100644 sound/soc/qcom/qdsp6/q6core.c
>   create mode 100644 sound/soc/qcom/qdsp6/q6core.h
>
> diff --git a/sound/soc/qcom/Kconfig b/sound/soc/qcom/Kconfig
> index b44a9fcd7ed3..37ee0d958145 100644
> --- a/sound/soc/qcom/Kconfig
> +++ b/sound/soc/qcom/Kconfig
> @@ -44,10 +44,14 @@ config SND_SOC_APQ8016_SBC
>   config SND_SOC_QDSP6_COMMON
>   	tristate
>   
> +config SND_SOC_QDSP6_CORE
> +	tristate
> +
>   config SND_SOC_QDSP6
>   	tristate "SoC ALSA audio driver for QDSP6"
>   	depends on QCOM_APR && HAS_DMA
>   	select SND_SOC_QDSP6_COMMON
> +	select SND_SOC_QDSP6_CORE
>   	help
>   	 To add support for MSM QDSP6 Soc Audio.
>   	 This will enable sound soc platform specific
> diff --git a/sound/soc/qcom/qdsp6/Makefile b/sound/soc/qcom/qdsp6/Makefile
> index accebdb49306..03b8e89c9731 100644
> --- a/sound/soc/qcom/qdsp6/Makefile
> +++ b/sound/soc/qcom/qdsp6/Makefile
> @@ -1 +1,2 @@
>   obj-$(CONFIG_SND_SOC_QDSP6_COMMON) += q6dsp-common.o
> +obj-$(CONFIG_SND_SOC_QDSP6_CORE) += q6core.o
> diff --git a/sound/soc/qcom/qdsp6/q6core.c b/sound/soc/qcom/qdsp6/q6core.c
> new file mode 100644
> index 000000000000..701aa3f50a6a
> --- /dev/null
> +++ b/sound/soc/qcom/qdsp6/q6core.c
> @@ -0,0 +1,380 @@
> +// SPDX-License-Identifier: GPL-2.0
> +// Copyright (c) 2011-2017, The Linux Foundation. All rights reserved.
> +// Copyright (c) 2018, Linaro Limited
> +
> +#include <linux/slab.h>
> +#include <linux/wait.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/sched.h>
> +#include <linux/of.h>
> +#include <linux/of_platform.h>
> +#include <linux/jiffies.h>
> +#include <linux/wait.h>
> +#include <linux/soc/qcom/apr.h>
> +#include "q6core.h"
> +#include "q6dsp-errno.h"
> +
> +#define ADSP_STATE_READY_TIMEOUT_MS    3000
> +#define Q6_READY_TIMEOUT_MS 100
> +#define AVCS_CMD_ADSP_EVENT_GET_STATE		0x0001290C
> +#define AVCS_CMDRSP_ADSP_EVENT_GET_STATE	0x0001290D
> +#define AVCS_GET_VERSIONS       0x00012905
> +#define AVCS_GET_VERSIONS_RSP   0x00012906
> +#define AVCS_CMD_GET_FWK_VERSION	0x001292c
> +#define AVCS_CMDRSP_GET_FWK_VERSION	0x001292d
> +
> +struct avcs_svc_info {
<snip>
> +};
> +
> +static struct q6core *g_core;
> +
> +static int q6core_callback(struct apr_device *adev, struct apr_resp_pkt *data)
> +{
> +	struct q6core *core = dev_get_drvdata(&adev->dev);
> +	struct aprv2_ibasic_rsp_result_t *result;
> +	struct apr_hdr *hdr = &data->hdr;
> +
> +	result = data->payload;
> +	switch (hdr->opcode) {
> +	case APR_BASIC_RSP_RESULT:{
> +		result = data->payload;
> +		switch (result->opcode) {
> +		case AVCS_GET_VERSIONS:
> +			if (result->status == ADSP_EUNSUPPORTED)
> +				core->get_version_supported = false;
> +			core->resp_received = true;
> +			break;
> +		case AVCS_CMD_GET_FWK_VERSION:
> +			if (result->status == ADSP_EUNSUPPORTED)
> +				core->fwk_version_supported = false;
> +			core->resp_received = true;
> +			break;
> +		case AVCS_CMD_ADSP_EVENT_GET_STATE:
> +			if (result->status == ADSP_EUNSUPPORTED)
> +				core->get_state_supported = false;
> +			core->resp_received = true;
> +			break;
> +		}
> +		break;
> +	}
> +	case AVCS_CMDRSP_GET_FWK_VERSION: {
> +		struct avcs_cmdrsp_get_fwk_version *fwk;
> +		int bytes;
> +
> +		fwk = data->payload;
> +		core->fwk_version_supported = true;
> +		bytes = sizeof(*fwk) + fwk->num_services *
> +				sizeof(fwk->svc_api_info[0]);
> +
> +		core->fwk_version = kzalloc(bytes, GFP_ATOMIC);
> +		if (!core->fwk_version)
> +			return -ENOMEM;
When the above allocation fails,? core->fwk_version_supported will be 
still true, and q6core_get_fwk_versions() will return 0 (timeout as 
core->resp_received will not be set to true). This can cause a NULL 
pointer dereference inside the if() loop pointed below (added comment).
Please move the line to set core->fwk_version_supported flag to after 
memset() to copy fwk version info.
> +
> +		memcpy(core->fwk_version, data->payload, bytes);
> +
> +		core->resp_received = true;
> +
> +		break;
> +	}
> +	case AVCS_GET_VERSIONS_RSP: {
> +		struct avcs_cmdrsp_get_version *v;
> +		int len;
> +
> +		v = data->payload;
> +		core->get_version_supported = true;
> +
<snip>
> +	}
> +
> +	return rc;
> +}
> +
> +static bool __q6core_is_adsp_ready(struct q6core *core)
> +{
> +	struct apr_device *adev = core->adev;
> +	struct apr_pkt pkt;
> +	int rc;
> +
> +	core->get_state_supported = false;
> +
> +	pkt.hdr.hdr_field = APR_HDR_FIELD(APR_MSG_TYPE_SEQ_CMD,
> +				      APR_HDR_LEN(APR_HDR_SIZE), APR_PKT_VER);
> +	pkt.hdr.pkt_size = APR_HDR_SIZE;
> +	pkt.hdr.opcode = AVCS_CMD_ADSP_EVENT_GET_STATE;
> +
> +	rc = apr_send_pkt(adev, &pkt);
> +	if (rc < 0)
> +		return false;
> +
> +	rc = wait_event_timeout(core->wait, (core->resp_received),
> +				msecs_to_jiffies(Q6_READY_TIMEOUT_MS));
> +	if (rc > 0 && core->resp_received) {
> +		core->resp_received = false;
> +
> +		if (core->avcs_state == 0x1)
The AVCS state can be different non-zero value then 0x1.
A better way to handle this can be check for (core->avcs_state > 0) for 
success, and then return the "core->avcs_state" to the caller.
> +			return true;
> +	}
> +
> +	/* assume that the adsp is up if we not support this command */
> +	if (!core->get_state_supported)
> +		return true;
> +
> +	return false;
> +}
> +
> +/**
> + * q6core_get_svc_api_info() - Get version number of a service.
> + *
> + * @svc_id: service id of the service.
> + * @info: Valid struct pointer to fill svc api information.
> + *
> + * Return: zero on success and error code on failure or unsupported
> + */
> +int q6core_get_svc_api_info(int svc_id, struct q6core_svc_api_info *ainfo)
> +{
> +	int i;
> +	int ret = -ENOTSUPP;
> +
> +	if (!g_core || !ainfo)
> +		return 0;
> +
> +	mutex_lock(&g_core->lock);
> +	if (!g_core->is_version_requested) {
> +		if (q6core_get_fwk_versions(g_core) == -ENOTSUPP)
> +			q6core_get_svc_versions(g_core);
> +		g_core->is_version_requested = true;
> +	}
> +
> +	if (g_core->fwk_version_supported) {
> +		for (i = 0; i < g_core->fwk_version->num_services; i++) {
..NULL pointer dereference here.
> +			struct avcs_svc_api_info *info;
> +
> +			info = &g_core->fwk_version->svc_api_info[i];
> +			if (svc_id != info->service_id)
> +				continue;
> +
> +			ainfo->api_version = info->api_version;
> +			ainfo->api_branch_version = info->api_branch_version;
> +			ret = 0;
> +			break;
> +		}
> +	} else if (g_core->get_version_supported) {
> +		for (i = 0; i < g_core->svc_version->num_services; i++) {
Similar issue of NULL pointer dereference is also present for 
g_core->get_version_supported flag.
> +			struct avcs_svc_info *info;
> +
> +			info = &g_core->svc_version->svc_api_info[i];
> +			if (svc_id != info->service_id)
> +				continue;
> +
> +			ainfo->api_version = info->version;
> +			ainfo->api_branch_version = 0;
> +			ret = 0;
> +			break;
<snip>
> +	init_waitqueue_head(&g_core->wait);
> +	return 0;
> +}
> +
> +static int q6core_exit(struct apr_device *adev)
> +{
> +	struct q6core *core = dev_get_drvdata(&adev->dev);
> +
> +	if (core->fwk_version_supported)
> +		kfree(core->fwk_version);
> +	if (core->get_version_supported)
> +		kfree(core->svc_version);
> +
> +	kfree(core);
> +	g_core = NULL;
This assignment can be before kfree() to avoid any possible issue in 
using g_core, after the pointer is freed.

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
