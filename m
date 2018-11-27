From: alexandre.belloni@bootlin.com (Alexandre Belloni)
Date: Tue, 27 Nov 2018 22:35:59 +0100
Subject: [PATCH 1/4] rtc: add i.MX system controller RTC support
In-Reply-To: <1543311334-8807-2-git-send-email-Anson.Huang@nxp.com>
References: <1543311334-8807-1-git-send-email-Anson.Huang@nxp.com>
 <1543311334-8807-2-git-send-email-Anson.Huang@nxp.com>
Message-ID: <20181127213559.GB7569@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

Thank you for your submission.

On 27/11/2018 09:41:20+0000, Anson Huang wrote:
> diff --git a/drivers/rtc/Makefile b/drivers/rtc/Makefile
> index 290c173..965725f 100644
> --- a/drivers/rtc/Makefile
> +++ b/drivers/rtc/Makefile
> @@ -151,6 +151,7 @@ obj-$(CONFIG_RTC_DRV_SC27XX)	+= rtc-sc27xx.o
>  obj-$(CONFIG_RTC_DRV_SH)	+= rtc-sh.o
>  obj-$(CONFIG_RTC_DRV_SIRFSOC)	+= rtc-sirfsoc.o
>  obj-$(CONFIG_RTC_DRV_SNVS)	+= rtc-snvs.o
> +obj-$(CONFIG_RTC_DRV_IMX_SC)	+= rtc-imx-sc.o

This list must be sorted alphabetically.

>  obj-$(CONFIG_RTC_DRV_SPEAR)	+= rtc-spear.o
>  obj-$(CONFIG_RTC_DRV_STARFIRE)	+= rtc-starfire.o
>  obj-$(CONFIG_RTC_DRV_STK17TA8)	+= rtc-stk17ta8.o
> diff --git a/drivers/rtc/rtc-imx-sc.c b/drivers/rtc/rtc-imx-sc.c
> new file mode 100644
> index 0000000..2466b55
> --- /dev/null
> +++ b/drivers/rtc/rtc-imx-sc.c
> @@ -0,0 +1,104 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright 2018 NXP.
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.

As you have the SPDX identifier, I think this boiler plate license text
should be removed.

> + *
> + */
> +
> +#include <linux/init.h>
> +#include <linux/io.h>
> +#include <linux/kernel.h>
> +#include <linux/firmware/imx/sci.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/platform_device.h>
> +#include <linux/rtc.h>
> +
> +#define IMX_SC_TIMER_FUNC_GET_RTC_SEC1970	9
> +#define IMX_SC_TIMER_FUNC_SET_RTC_TIME		6
> +
> +struct imx_sc_ipc *rtc_ipc_handle;
> +struct rtc_device *rtc;
> +
> +struct imx_sc_msg_req_timer_get_rtc_time {
> +	struct imx_sc_rpc_msg hdr;
> +} __packed;
> +
> +struct imx_sc_msg_resp_timer_get_rtc_time {
> +	struct imx_sc_rpc_msg hdr;
> +	u32 time;
> +} __packed;
> +
> +static int imx_sc_rtc_read_time(struct device *dev, struct rtc_time *tm)
> +{
> +	struct imx_sc_msg_resp_timer_get_rtc_time *resp;
> +	struct imx_sc_msg_req_timer_get_rtc_time msg;
> +	struct imx_sc_rpc_msg *hdr = &msg.hdr;
> +	int ret;
> +
> +	hdr->ver = IMX_SC_RPC_VERSION;
> +	hdr->svc = IMX_SC_RPC_SVC_TIMER;
> +	hdr->func = IMX_SC_TIMER_FUNC_GET_RTC_SEC1970;
> +	hdr->size = 1;
> +
> +	ret = imx_scu_call_rpc(rtc_ipc_handle, &msg, true);
> +	if (ret) {
> +		pr_err("read rtc time failed, ret %d\n", ret);
> +		return ret;
> +	}
> +
> +	resp = (struct imx_sc_msg_resp_timer_get_rtc_time *)&msg;
> +	rtc_time_to_tm(resp->time, tm);
> +
> +	return 0;
> +}
> +
> +static const struct rtc_class_ops imx_sc_rtc_ops = {
> +	.read_time = imx_sc_rtc_read_time,
> +};
> +
> +static int imx_sc_rtc_probe(struct platform_device *pdev)
> +{
> +	int ret;
> +
> +	ret = imx_scu_get_handle(&rtc_ipc_handle);
> +	if (ret) {
> +		if (ret == -EPROBE_DEFER)
> +			return ret;
> +
> +		dev_err(&pdev->dev, "failed to get ipc handle: %d!\n", ret);
> +		return ret;
> +	}
> +
> +	rtc = devm_rtc_device_register(&pdev->dev, pdev->name,
> +					&imx_sc_rtc_ops, THIS_MODULE);

Please use devm_rtc_allocate_device and rtc_register_device to register
the RTC. If possible, you should also set range_min and range_max. If I
understand the code correctly, this should simply be range_max = U32_MAX;


-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
