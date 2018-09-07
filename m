From: hverkuil@xs4all.nl (Hans Verkuil)
Date: Fri, 7 Sep 2018 15:13:19 +0200
Subject: [PATCH v9 5/9] media: platform: Add Cedrus VPU decoder driver
In-Reply-To: <20180906222442.14825-6-contact@paulk.fr>
References: <20180906222442.14825-1-contact@paulk.fr>
 <20180906222442.14825-6-contact@paulk.fr>
Message-ID: <4b30c0bf-e525-1868-f625-569d4a104aa0@xs4all.nl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/07/2018 12:24 AM, Paul Kocialkowski wrote:
> From: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
> 
> This introduces the Cedrus VPU driver that supports the VPU found in
> Allwinner SoCs, also known as Video Engine. It is implemented through
> a V4L2 M2M decoder device and a media device (used for media requests).
> So far, it only supports MPEG-2 decoding.
> 
> Since this VPU is stateless, synchronization with media requests is
> required in order to ensure consistency between frame headers that
> contain metadata about the frame to process and the raw slice data that
> is used to generate the frame.
> 
> This driver was made possible thanks to the long-standing effort
> carried out by the linux-sunxi community in the interest of reverse
> engineering, documenting and implementing support for the Allwinner VPU.
> 
> Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
> Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>

One high-level comment:

Can you add a TODO file for this staging driver? This can be done in
a follow-up patch.

It should contain what needs to be done to get this out of staging:

- Request API needs to stabilize
- Userspace support for stateless codecs must be created
- Ideally one other stateless decoder driver and at least one
  stateless encoder driver should be implemented to ensure that nothing
  was forgotten in the Request API.
- Anything else?

And a few last code comments:

> ---
>  MAINTAINERS                                   |   7 +
>  drivers/staging/media/Kconfig                 |   2 +
>  drivers/staging/media/Makefile                |   1 +
>  drivers/staging/media/sunxi/Kconfig           |  15 +
>  drivers/staging/media/sunxi/Makefile          |   1 +
>  drivers/staging/media/sunxi/cedrus/Kconfig    |  14 +
>  drivers/staging/media/sunxi/cedrus/Makefile   |   3 +
>  drivers/staging/media/sunxi/cedrus/cedrus.c   | 422 ++++++++++++++
>  drivers/staging/media/sunxi/cedrus/cedrus.h   | 165 ++++++
>  .../staging/media/sunxi/cedrus/cedrus_dec.c   |  70 +++
>  .../staging/media/sunxi/cedrus/cedrus_dec.h   |  27 +
>  .../staging/media/sunxi/cedrus/cedrus_hw.c    | 322 +++++++++++
>  .../staging/media/sunxi/cedrus/cedrus_hw.h    |  30 +
>  .../staging/media/sunxi/cedrus/cedrus_mpeg2.c | 237 ++++++++
>  .../staging/media/sunxi/cedrus/cedrus_regs.h  | 233 ++++++++
>  .../staging/media/sunxi/cedrus/cedrus_video.c | 544 ++++++++++++++++++
>  .../staging/media/sunxi/cedrus/cedrus_video.h |  30 +
>  17 files changed, 2123 insertions(+)
>  create mode 100644 drivers/staging/media/sunxi/Kconfig
>  create mode 100644 drivers/staging/media/sunxi/Makefile
>  create mode 100644 drivers/staging/media/sunxi/cedrus/Kconfig
>  create mode 100644 drivers/staging/media/sunxi/cedrus/Makefile
>  create mode 100644 drivers/staging/media/sunxi/cedrus/cedrus.c
>  create mode 100644 drivers/staging/media/sunxi/cedrus/cedrus.h
>  create mode 100644 drivers/staging/media/sunxi/cedrus/cedrus_dec.c
>  create mode 100644 drivers/staging/media/sunxi/cedrus/cedrus_dec.h
>  create mode 100644 drivers/staging/media/sunxi/cedrus/cedrus_hw.c
>  create mode 100644 drivers/staging/media/sunxi/cedrus/cedrus_hw.h
>  create mode 100644 drivers/staging/media/sunxi/cedrus/cedrus_mpeg2.c
>  create mode 100644 drivers/staging/media/sunxi/cedrus/cedrus_regs.h
>  create mode 100644 drivers/staging/media/sunxi/cedrus/cedrus_video.c
>  create mode 100644 drivers/staging/media/sunxi/cedrus/cedrus_video.h
> 

<snip>

> +static int cedrus_request_validate(struct media_request *req)
> +{
> +	struct media_request_object *obj;
> +	struct v4l2_ctrl_handler *parent_hdl, *hdl;
> +	struct cedrus_ctx *ctx = NULL;
> +	struct v4l2_ctrl *ctrl_test;
> +	unsigned int i;
> +
> +	if (vb2_request_buffer_cnt(req) != 1)
> +		return -ENOENT;

I would return ENOENT if there are no buffers, and EINVAL if there are too
many. Returning ENOENT in the latter case would be very confusing.

I also highly recommend that you add v4l2_info lines for these errors.

> +
> +	list_for_each_entry(obj, &req->objects, list) {
> +		struct vb2_buffer *vb;
> +
> +		if (vb2_request_object_is_buffer(obj)) {
> +			vb = container_of(obj, struct vb2_buffer, req_obj);
> +			ctx = vb2_get_drv_priv(vb->vb2_queue);
> +
> +			break;
> +		}
> +	}
> +
> +	if (!ctx)
> +		return -ENOENT;
> +
> +	parent_hdl = &ctx->hdl;
> +
> +	hdl = v4l2_ctrl_request_hdl_find(req, parent_hdl);
> +	if (!hdl) {
> +		v4l2_err(&ctx->dev->v4l2_dev, "Missing codec control(s)\n");

Should be v4l2_info: it is not a driver error, it is just an info message.

> +		return -ENOENT;
> +	}
> +
> +	for (i = 0; i < CEDRUS_CONTROLS_COUNT; i++) {
> +		if (cedrus_controls[i].codec != ctx->current_codec ||
> +		    !cedrus_controls[i].required)
> +			continue;
> +
> +		ctrl_test = v4l2_ctrl_request_hdl_ctrl_find(hdl,
> +			cedrus_controls[i].id);
> +		if (!ctrl_test) {
> +			v4l2_err(&ctx->dev->v4l2_dev,
> +				 "Missing required codec control\n");

Ditto.

> +			return -ENOENT;
> +		}
> +	}
> +
> +	v4l2_ctrl_request_hdl_put(hdl);
> +
> +	return vb2_request_validate(req);
> +}

Not worth making a v10, but you can do this in a follow-up patch.

Once I have the two follow-up patches I'll make a pull request.

Regards,

	Hans
