From: slongerbeam@gmail.com (Steve Longerbeam)
Date: Fri, 6 Jan 2017 10:05:54 -0800
Subject: [PATCH v2 11/19] media: imx: Add CSI subdev driver
In-Reply-To: <21b54a7b-1254-a14f-767c-c92feed7433d@mentor.com>
References: <1483477049-19056-1-git-send-email-steve_longerbeam@mentor.com>
 <1483477049-19056-12-git-send-email-steve_longerbeam@mentor.com>
 <21b54a7b-1254-a14f-767c-c92feed7433d@mentor.com>
Message-ID: <4800b65e-1168-9a10-df5e-4e9eaa0d99d3@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 01/04/2017 05:44 AM, Vladimir Zapolskiy wrote:
>
>> diff --git a/drivers/staging/media/imx/imx-csi.c b/drivers/staging/media/imx/imx-csi.c
>> new file mode 100644
>> index 0000000..975eafb
>> --- /dev/null
>> +++ b/drivers/staging/media/imx/imx-csi.c
>> @@ -0,0 +1,638 @@
>> +/*
>> + * V4L2 Capture CSI Subdev for Freescale i.MX5/6 SOC
>> + *
>> + * Copyright (c) 2014-2016 Mentor Graphics Inc.
>> + *
>> + * This program is free software; you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License as published by
>> + * the Free Software Foundation; either version 2 of the License, or
>> + * (at your option) any later version.
>> + */
>> +#include <linux/module.h>
>> +#include <linux/platform_device.h>
>> +#include <media/v4l2-device.h>
>> +#include <media/v4l2-subdev.h>
>> +#include <media/videobuf2-dma-contig.h>
>> +#include <media/v4l2-of.h>
>> +#include <media/v4l2-ctrls.h>
> Please add the headers alphabetically ordered.

done.

>> +
>> +static int csi_start(struct csi_priv *priv)
>> +{
>> +	int ret;
>> +
>> +	if (!priv->sensor) {
>> +		v4l2_err(&priv->sd, "no sensor attached\n");
>> +		return -EINVAL;
>> +	}
>> +
>> +	ret = csi_setup(priv);
>> +	if (ret)
>> +		return ret;
>> +
>> +	/* start the frame interval monitor */
>> +	ret = imx_media_fim_set_stream(priv->fim, priv->sensor, true);
>> +	if (ret)
>> +		return ret;
>> +
>> +	ret = ipu_csi_enable(priv->csi);
>> +	if (ret) {
>> +		v4l2_err(&priv->sd, "CSI enable error: %d\n", ret);
>> +		return ret;
>> +	}
>> +
>> +	return 0;
> if (ret)
> 	v4l2_err(&priv->sd, "CSI enable error: %d\n", ret);
>
> return ret;

I failed to cleanup in this path, so it is now:

     ret = ipu_csi_enable(priv->csi);
     if (ret) {
         v4l2_err(&priv->sd, "CSI enable error: %d\n", ret);
         goto fim_off;
     }

     return 0;
fim_off:
     if (priv->fim)
         imx_media_fim_set_stream(priv->fim, priv->sensor, false);
     return ret;

>> +
>> +static int csi_link_setup(struct media_entity *entity,
>> +			  const struct media_pad *local,
>> +			  const struct media_pad *remote, u32 flags)
>> +{
>> +	struct v4l2_subdev *sd = media_entity_to_v4l2_subdev(entity);
>> +	struct csi_priv *priv = v4l2_get_subdevdata(sd);
>> +	struct v4l2_subdev *remote_sd;
>> +
>> +	dev_dbg(priv->dev, "link setup %s -> %s", remote->entity->name,
>> +		local->entity->name);
>> +
>> +	remote_sd = media_entity_to_v4l2_subdev(remote->entity);
>> +
>> +	if (local->flags & MEDIA_PAD_FL_SINK) {
>> +		if (flags & MEDIA_LNK_FL_ENABLED) {
>> +			if (priv->src_sd)
>> +				return -EBUSY;
>> +			priv->src_sd = remote_sd;
>> +		} else {
>> +			priv->src_sd = NULL;
>> +			return 0;
> You can remove the return above.

right, fixed.

>
>> +
>> +	ret = v4l2_async_register_subdev(&priv->sd);
>> +	if (ret)
>> +		goto free_ctrls;
>> +
>> +	return 0;
>> +free_ctrls:
>> +	v4l2_ctrl_handler_free(&priv->ctrl_hdlr);
>> +	return ret;
> This is a functionally equal and simplified version:
>
> if (ret)
> 	v4l2_ctrl_handler_free(&priv->ctrl_hdlr);
>
> return ret;

thanks, done.

>> +
>> +static struct platform_driver imx_csi_driver = {
>> +	.probe = imx_csi_probe,
>> +	.remove = imx_csi_remove,
>> +	.id_table = imx_csi_ids,
>> +	.driver = {
>> +		.name = "imx-ipuv3-csi",
>> +		.owner = THIS_MODULE,
> Please drop .owner.

ok, I tested this and there are no regressions, done
for all modules.

Steve
