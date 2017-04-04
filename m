From: slongerbeam@gmail.com (Steve Longerbeam)
Date: Tue, 4 Apr 2017 15:11:46 -0700
Subject: [RFC] [media] imx: assume MEDIA_ENT_F_ATV_DECODER entities output
 video on pad 1
In-Reply-To: <1490894749.2404.33.camel@pengutronix.de>
References: <1490661656-10318-1-git-send-email-steve_longerbeam@mentor.com>
 <1490661656-10318-20-git-send-email-steve_longerbeam@mentor.com>
 <1490894749.2404.33.camel@pengutronix.de>
Message-ID: <9bfabc5c-d90f-6487-537d-20515ec61f9c@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 03/30/2017 10:25 AM, Philipp Zabel wrote:
> The TVP5150 DT bindings specify a single output port (port 0) that
> corresponds to the video output pad (pad 1, DEMOD_PAD_VID_OUT).
>
> Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
> ---
> I'm trying to get this to work with a TVP5150 analog TV decoder, and the
> first problem is that this device doesn't have pad 0 as its single
> output pad. Instead, as a MEDIA_ENT_F_ATV_DECODER entity, it has for
> pads (input, video out, vbi out, audio out), and video out is pad 1,
> whereas the device tree only defines a single port (0).

Shouldn't the DT bindings define ports for these other pads?
I haven't seen this documented anywhere, but shouldn't there
be a 1:1 correspondence between DT ports and media pads?

Steve


> ---
>
>  drivers/staging/media/imx/imx-media-dev.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/drivers/staging/media/imx/imx-media-dev.c b/drivers/staging/media/imx/imx-media-dev.c
> index 17e2386a3ca3a..c52d6ca797965 100644
> --- a/drivers/staging/media/imx/imx-media-dev.c
> +++ b/drivers/staging/media/imx/imx-media-dev.c
> @@ -267,6 +267,15 @@ static int imx_media_create_link(struct imx_media_dev *imxmd,
>  	source_pad = link->local_pad;
>  	sink_pad = link->remote_pad;
>
> +	/*
> +	 * If the source subdev is an analog video decoder with a single source
> +	 * port, assume that this port 0 corresponds to the DEMOD_PAD_VID_OUT
> +	 * entity pad.
> +	 */
> +	if (source->entity.function == MEDIA_ENT_F_ATV_DECODER &&
> +	    local_sd->num_sink_pads == 0 && local_sd->num_src_pads == 1)
> +		source_pad = DEMOD_PAD_VID_OUT;
> +
>  	v4l2_info(&imxmd->v4l2_dev, "%s: %s:%d -> %s:%d\n", __func__,
>  		  source->name, source_pad, sink->name, sink_pad);
>
>
