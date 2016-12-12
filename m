From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Mon, 12 Dec 2016 10:50:49 +0200
Subject: [PATCH] media: platform: xilinx: xilinx-tpg: constify
 v4l2_subdev_* structures
In-Reply-To: <1481449952-26119-1-git-send-email-bhumirks@gmail.com>
References: <1481449952-26119-1-git-send-email-bhumirks@gmail.com>
Message-ID: <2425766.trygpAiYzB@avalon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Bhumika,

Thank you for the patch.

On Sunday 11 Dec 2016 15:22:32 Bhumika Goyal wrote:
> v4l2_subdev_{core/pad/video}_ops structures are stored in the
> fields of the v4l2_subdev_ops structure which are of type const.
> Also, v4l2_subdev_ops structure is passed to a function
> having its argument of type const. As these structures are never
> modified, so declare them as const.
> Done using Coccinelle: (One of the scripts used)
> 
> @r1 disable optional_qualifier @
> identifier i;
> position p;
> @@
> static struct v4l2_subdev_video_ops i at p = {...};
> 
> @ok1@
> identifier r1.i;
> position p;
> struct v4l2_subdev_ops obj;
> @@
> obj.video=&i at p;
> 
> @bad@
> position p!={r1.p,ok1.p};
> identifier r1.i;
> @@
> i at p
> 
> @depends on !bad disable optional_qualifier@
> identifier r1.i;
> @@
> +const
> struct v4l2_subdev_video_ops i;
> 
> File size before:
>    text	   data	    bss	    dec	    hex	filename
>    6170	   2752	    144	   9066	   236a media/platform/xilinx/xilinx-
tpg.o
> 
> File size after:
>    text	   data	    bss	    dec	    hex	filename
>    6666	   2384	      8	   9058	   2362 media/platform/xilinx/xilinx-
tpg.o
> 
> Signed-off-by: Bhumika Goyal <bhumirks@gmail.com>

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
>  drivers/media/platform/xilinx/xilinx-tpg.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/media/platform/xilinx/xilinx-tpg.c
> b/drivers/media/platform/xilinx/xilinx-tpg.c index 2ec1f6c..9c49d1d 100644
> --- a/drivers/media/platform/xilinx/xilinx-tpg.c
> +++ b/drivers/media/platform/xilinx/xilinx-tpg.c
> @@ -460,21 +460,21 @@ static int xtpg_s_ctrl(struct v4l2_ctrl *ctrl)
>  	.s_ctrl	= xtpg_s_ctrl,
>  };
> 
> -static struct v4l2_subdev_core_ops xtpg_core_ops = {
> +static const struct v4l2_subdev_core_ops xtpg_core_ops = {
>  };
> 
> -static struct v4l2_subdev_video_ops xtpg_video_ops = {
> +static const struct v4l2_subdev_video_ops xtpg_video_ops = {
>  	.s_stream = xtpg_s_stream,
>  };
> 
> -static struct v4l2_subdev_pad_ops xtpg_pad_ops = {
> +static const struct v4l2_subdev_pad_ops xtpg_pad_ops = {
>  	.enum_mbus_code		= xvip_enum_mbus_code,
>  	.enum_frame_size	= xtpg_enum_frame_size,
>  	.get_fmt		= xtpg_get_format,
>  	.set_fmt		= xtpg_set_format,
>  };
> 
> -static struct v4l2_subdev_ops xtpg_ops = {
> +static const struct v4l2_subdev_ops xtpg_ops = {
>  	.core   = &xtpg_core_ops,
>  	.video  = &xtpg_video_ops,
>  	.pad    = &xtpg_pad_ops,

-- 
Regards,

Laurent Pinchart
