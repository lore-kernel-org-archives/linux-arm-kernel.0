From: bjorn.andersson@linaro.org (Bjorn Andersson)
Date: Tue, 2 Jan 2018 14:15:20 -0800
Subject: [RESEND PATCH v2 09/15] ASoC: qcom: qdsp6: Add support to Q6CORE
In-Reply-To: <20171214173402.19074-10-srinivas.kandagatla@linaro.org>
References: <20171214173402.19074-1-srinivas.kandagatla@linaro.org>
 <20171214173402.19074-10-srinivas.kandagatla@linaro.org>
Message-ID: <20180102221520.GQ478@tuxbook>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu 14 Dec 09:33 PST 2017, srinivas.kandagatla at linaro.org wrote:

> From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> 
> This patch adds support to core apr service, which is used to query
> status of other static and dynamic services on the dsp.
> 
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---
>  sound/soc/qcom/Kconfig        |   5 +
>  sound/soc/qcom/qdsp6/Makefile |   1 +
>  sound/soc/qcom/qdsp6/q6core.c | 227 ++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 233 insertions(+)
>  create mode 100644 sound/soc/qcom/qdsp6/q6core.c
> 
> diff --git a/sound/soc/qcom/Kconfig b/sound/soc/qcom/Kconfig
> index 7ebdb879a8a3..121b9c957024 100644
> --- a/sound/soc/qcom/Kconfig
> +++ b/sound/soc/qcom/Kconfig
> @@ -56,11 +56,16 @@ config SND_SOC_QDSP6_ASM
>  	tristate
>  	default n
>  
> +config SND_SOC_QDSP6_CORE
> +	tristate
> +	default n
> +
>  config SND_SOC_QDSP6
>  	tristate "SoC ALSA audio driver for QDSP6"
>  	select SND_SOC_QDSP6_AFE
>  	select SND_SOC_QDSP6_ADM
>  	select SND_SOC_QDSP6_ASM
> +	select SND_SOC_QDSP6_CORE
>  	help
>  	 To add support for MSM QDSP6 Soc Audio.
>  	 This will enable sound soc platform specific
> diff --git a/sound/soc/qcom/qdsp6/Makefile b/sound/soc/qcom/qdsp6/Makefile
> index 49dd3ccab27b..ad7f10691e54 100644
> --- a/sound/soc/qcom/qdsp6/Makefile
> +++ b/sound/soc/qcom/qdsp6/Makefile
> @@ -1,3 +1,4 @@
>  obj-$(CONFIG_SND_SOC_QDSP6_AFE) += q6afe.o
>  obj-$(CONFIG_SND_SOC_QDSP6_ADM) += q6adm.o
>  obj-$(CONFIG_SND_SOC_QDSP6_ASM) += q6asm.o
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
> +#include <linux/wait.h>
> +#include <linux/soc/qcom/apr.h>
> +#include <linux/platform_device.h>
> +#include <sound/asound.h>
> +#include "common.h"
> +
> +#define ADSP_STATE_READY_TIMEOUT_MS    3000
> +#define Q6_READY_TIMEOUT_MS 100
> +#define AVCS_CMD_ADSP_EVENT_GET_STATE		0x0001290C
> +#define AVCS_CMDRSP_ADSP_EVENT_GET_STATE	0x0001290D
> +#define AVCS_GET_VERSIONS       0x00012905
> +#define AVCS_GET_VERSIONS_RSP   0x00012906
> +
> +struct avcs_svc_info {
> +	uint32_t service_id;
> +	uint32_t version;
> +} __packed;
> +
> +struct q6core {
> +	struct apr_device *adev;
> +	wait_queue_head_t wait;
> +	uint32_t avcs_state;
> +	int resp_received;

bool

> +	uint32_t num_services;
> +	struct avcs_svc_info *svcs_info;
> +};
> +
> +static struct apr_device_id static_services[] = {
> +	ADSP_AUDIO_APR_DEV("AFE", APR_SVC_AFE),
> +	ADSP_AUDIO_APR_DEV("ASM", APR_SVC_ASM),
> +	ADSP_AUDIO_APR_DEV("ADM", APR_SVC_ADM),
> +	ADSP_AUDIO_APR_DEV("TEST", APR_SVC_TEST_CLIENT),
> +	ADSP_AUDIO_APR_DEV("MVM", APR_SVC_ADSP_MVM),
> +	ADSP_AUDIO_APR_DEV("CVS", APR_SVC_ADSP_CVS),
> +	ADSP_AUDIO_APR_DEV("CVP", APR_SVC_ADSP_CVP),
> +	ADSP_AUDIO_APR_DEV("USM", APR_SVC_USM),
> +	ADSP_AUDIO_APR_DEV("VIDC", APR_SVC_VIDC),
> +	ADSP_AUDIO_APR_DEV("LSM", APR_SVC_LSM),
> +};
> +
> +static int core_callback(struct apr_device *adev, struct apr_client_data *data)
> +{
> +	struct q6core *core = dev_get_drvdata(&adev->dev);
> +	uint32_t *payload;
> +
> +	switch (data->opcode) {
> +	case AVCS_GET_VERSIONS_RSP:
> +		payload = data->payload;
> +		core->num_services = payload[1];

Describe the payload in a struct (with flexible array member for the
svcs_info list).

> +
> +		if (!core->svcs_info)
> +			core->svcs_info = kcalloc(core->num_services,
> +						  sizeof(*core->svcs_info),
> +						  GFP_ATOMIC);
> +		if (!core->svcs_info)
> +			return -ENOMEM;
> +

If we receive this twice with different num_services for some reason the
memcpy might trash the heap.

But as this is the get_version response and we're only going to issue
that once you should remove the check for !core->svcs_info above.

And don't forget to free svcs_info once you have added your services.

> +		/* svc info is after 8 bytes */
> +		memcpy(core->svcs_info, payload + 2,
> +		       core->num_services * sizeof(*core->svcs_info));
> +
> +		core->resp_received = 1;
> +		wake_up(&core->wait);
> +
> +		break;
> +	case AVCS_CMDRSP_ADSP_EVENT_GET_STATE:
> +		payload = data->payload;
> +		core->avcs_state = payload[0];
> +
> +		core->resp_received = 1;
> +		wake_up(&core->wait);
> +		break;
> +	default:
> +		dev_err(&adev->dev, "Message id from adsp core svc: 0x%x\n",
> +			data->opcode);
> +		break;
> +	}
> +
> +	return 0;
> +}
> +
> +void q6core_add_service(struct device *dev, uint32_t svc_id, uint32_t version)
> +{
> +	int i;
> +
> +	for (i = 0; i < ARRAY_SIZE(static_services); i++) {
> +		if (static_services[i].svc_id == svc_id) {
> +			static_services[i].svc_version = version;
> +			apr_add_device(dev->parent, &static_services[i]);
> +			dev_info(dev,

Please don't spam the logs, dev_dbg() should be enough. And as
apr_add_device() returns you can find the devices registered in /sys

> +				"Adding SVC: %s: id 0x%x API Ver 0x%x:0x%x\n",
> +				 static_services[i].name, svc_id,
> +				 APR_SVC_MAJOR_VERSION(version),
> +				 APR_SVC_MINOR_VERSION(version));
> +		}
> +	}
> +}
> +
> +static void q6core_add_static_services(struct q6core *core)

The name of this function is deceiving, it doesn't really add the static
services. It adds devices for the services that we've been informed
exists, by the other side - using the static list of services.

Per the comment on a previous patch I don't think the "name" in
apr_device_id provides any real value and in this case if forces you to
perform a lookup using this table.

If you drop the name, you can loop over the list of service ids returned
from the remote and just register them with a hard coded domain id
(based on apr instance?) and client_id. You don't need the lookup table.

> +{
> +	int i;
> +	struct apr_device *adev = core->adev;
> +	struct avcs_svc_info *svcs_info = core->svcs_info;
> +
> +	for (i = 0; i < core->num_services; i++)
> +		q6core_add_service(&adev->dev, svcs_info[i].service_id,
> +				   svcs_info[i].version);
> +}
> +
> +static int q6core_get_svc_versions(struct q6core *core)
> +{
> +	struct apr_device *adev = core->adev;
> +	struct apr_hdr hdr = {0};
> +	int rc;
> +
> +	hdr.hdr_field = APR_HDR_FIELD(APR_MSG_TYPE_SEQ_CMD,
> +				      APR_HDR_LEN(APR_HDR_SIZE), APR_PKT_VER);
> +	hdr.pkt_size = APR_PKT_SIZE(APR_HDR_SIZE, 0);
> +	hdr.opcode = AVCS_GET_VERSIONS;
> +
> +	rc = apr_send_pkt(adev, (uint32_t *)&hdr);
> +	if (rc < 0)
> +		return rc;
> +
> +	rc = wait_event_timeout(core->wait, (core->resp_received == 1),
> +				msecs_to_jiffies(Q6_READY_TIMEOUT_MS));

The wait and resp_received could favourably be expressed as a completion
instead, as all we care about is that this happened once.

> +	if (rc > 0 && core->resp_received) {
> +		core->resp_received = 0;
> +		return 0;
> +	}

It wasn't obvious at first sight that this is the success case and the
return rc below was the error case...

> +
> +	return rc;

And this will actually be 0 if core->resp_received has not become 1 at
the timeout.

> +}
> +
> +static bool q6core_is_adsp_ready(struct q6core *core)
> +{
> +	struct apr_device *adev = core->adev;
> +	struct apr_hdr hdr = {0};
> +	int rc;
> +
> +	hdr.hdr_field = APR_HDR_FIELD(APR_MSG_TYPE_SEQ_CMD,
> +				      APR_HDR_LEN(APR_HDR_SIZE), APR_PKT_VER);
> +	hdr.pkt_size = APR_PKT_SIZE(APR_HDR_SIZE, 0);
> +	hdr.opcode = AVCS_CMD_ADSP_EVENT_GET_STATE;
> +
> +	rc = apr_send_pkt(adev, (uint32_t *)&hdr);
> +	if (rc < 0)
> +		return false;
> +
> +	rc = wait_event_timeout(core->wait, (core->resp_received == 1),
> +				msecs_to_jiffies(Q6_READY_TIMEOUT_MS));

I think this too would be nicer to describe with a completion.

Currently it's possible to ask is the dsp is ready, time out and ask
again, just to receive the first ack and continue. The service request
sleep might then wake up on this previous ack.

If you describe this by two different completions for the two waits you
avoid any such race conditions occurring. 

> +	if (rc > 0 && core->resp_received) {
> +		core->resp_received = 0;
> +		if (core->avcs_state == 0x1)
> +			return true;
> +	}
> +
> +	return false;
> +}
> +
> +static int q6core_probe(struct apr_device *adev)
> +{
> +	struct q6core *core;
> +	unsigned long  timeout = jiffies +
> +				 msecs_to_jiffies(ADSP_STATE_READY_TIMEOUT_MS);
> +	int ret = 0;
> +
> +	core = devm_kzalloc(&adev->dev, sizeof(*core), GFP_KERNEL);
> +	if (!core)
> +		return -ENOMEM;
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
> +			ret = q6core_get_svc_versions(core);
> +			if (!ret)
> +				q6core_add_static_services(core);
> +
> +			break;
> +		}
> +	} while (time_after(timeout, jiffies));

This would be much better rewritten as:

for (;;) {
	if (q6core_is_adsp_ready(core))
		break;

	if (time_after(timeout, jiffies))
		return -ETIMEDOUT;
}

ret = q6core_get_svc_versions(core);
if (ret)
	return ret;

q6core_add_static_services(core);

> +
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

Indentation.

> +};
> +
> +module_apr_driver(qcom_q6core_driver);
> +
> +MODULE_AUTHOR("Srinivas Kandagatla <srinivas.kandagatla@linaro.org");
> +MODULE_DESCRIPTION("q6 core");
> +MODULE_LICENSE("GPL v2");
> -- 
> 2.15.0
> 
