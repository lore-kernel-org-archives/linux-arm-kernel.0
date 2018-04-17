From: tfiga@chromium.org (Tomasz Figa)
Date: Tue, 17 Apr 2018 08:44:14 +0000
Subject: [PATCH v6 08/17] media: rkisp1: add capture device driver
In-Reply-To: <20180308094807.9443-9-jacob-chen@iotwrt.com>
References: <20180308094807.9443-1-jacob-chen@iotwrt.com>
 <20180308094807.9443-9-jacob-chen@iotwrt.com>
Message-ID: <CAAFQd5CF9-T24sw9fPw050G=fPha46DnCb8g6m7V2wtNVx_=1A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jacob,

On Thu, Mar 8, 2018 at 6:49 PM Jacob Chen <jacob-chen@iotwrt.com> wrote:

> From: Jacob Chen <jacob2.chen@rock-chips.com>

> This is the capture device interface driver that provides the v4l2
> user interface. Frames can be received from ISP1.

Thanks for the patch. Please find my comment inline.

[snip]
> +static int
> +rkisp1_start_streaming(struct vb2_queue *queue, unsigned int count)
> +{
> +       struct rkisp1_stream *stream = queue->drv_priv;
> +       struct rkisp1_vdev_node *node = &stream->vnode;
> +       struct rkisp1_device *dev = stream->ispdev;
> +       struct v4l2_device *v4l2_dev = &dev->v4l2_dev;
> +       int ret;
> +
> +       if (WARN_ON(stream->state != RKISP1_STATE_READY))
> +               goto return_queued_buf;

We jump out with ret unitialized here. For reference, it triggers a
compiler warning for me.

Note that rather than initializing ret at its definition, I'd recommend
adding an assignment before the goto statement. This will still let the
compiler issue warnings, without assuming that the default value is correct.

Best regards,
Tomasz
