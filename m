From: paul.kocialkowski@bootlin.com (Paul Kocialkowski)
Date: Fri, 09 Mar 2018 11:18:56 +0100
Subject: [PATCH 0/9] Sunxi-Cedrus driver for the Allwinner Video Engine,
 using the V4L2 request API
In-Reply-To: <20180309100933.15922-1-paul.kocialkowski@bootlin.com>
References: <20180309100933.15922-1-paul.kocialkowski@bootlin.com>
Message-ID: <1520590736.15946.1.camel@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2018-03-09 at 11:09 +0100, Paul Kocialkowski wrote:
> This presents a newer version of the Sunxi-Cedrus driver, that
> supports
> the Video Engine found in most Allwinner SoCs, starting with the A10.

I had to send this series in two parts (and tried to keep them under the
original thread) after the mail server rejected one of the emails mid-
series, causing git-send-email to stop. Sorry for the mess.

> The first version of this driver[0] was originally written and
> submitted
> by Florent Revest using a previous version of the request API, that is
> necessary to provide coherency between controls and the buffers they
> apply
> to. The driver was since adapted to use the latest version of the
> request
> API[1], as submitted by Alexandre Courbot. It is a hard requirement
> for
> this driver.
> 
> This series also contains fixes for issues encountered with the
> current
> version of the request API. If accepted, these should eventually be
> squashed into the request API series.
> 
> The driver itself currently only supports MPEG2 and more codecs will
> be
> added to the driver eventually. The output frames provided by the
> Video Engine are in a multi-planar 32x32-tiled YUV format, with a
> plane
> for luminance (Y) and a plane for chrominance (UV). A specific format
> is
> introduced in the V4L2 API to describe it.
> 
> This implementation is based on the significant work that was
> conducted
> by various members of the linux-sunxi community for understanding and
> documenting the Video Engine's innards.
> 
> [0]: https://lkml.org/lkml/2016/8/25/246
> [1]: https://lkml.org/lkml/2018/2/19/872
> 
> Florent Revest (5):
>   v4l: Add sunxi Video Engine pixel format
>   v4l: Add MPEG2 low-level decoder API control
>   media: platform: Add Sunxi Cedrus decoder driver
>   sunxi-cedrus: Add device tree binding document
>   ARM: dts: sun5i: Use video-engine node
> 
> Icenowy Zheng (1):
>   ARM: dts: sun8i: add video engine support for A33
> 
> Paul Kocialkowski (2):
>   media: vim2m: Try to schedule a m2m device run on request submission
>   media: videobuf2-v4l2: Copy planes when needed in request qbuf
> 
> Thomas van Kleef (1):
>   ARM: dts: sun7i: Add video engine support for the A20
> 
>  .../devicetree/bindings/media/sunxi-cedrus.txt     |  44 ++
>  arch/arm/boot/dts/sun5i-a13.dtsi                   |  30 ++
>  arch/arm/boot/dts/sun7i-a20.dtsi                   |  47 ++
>  arch/arm/boot/dts/sun8i-a33.dtsi                   |  39 ++
>  drivers/media/common/videobuf2/videobuf2-v4l2.c    |  19 +
>  drivers/media/platform/Kconfig                     |  14 +
>  drivers/media/platform/Makefile                    |   1 +
>  drivers/media/platform/sunxi-cedrus/Makefile       |   4 +
>  drivers/media/platform/sunxi-cedrus/sunxi_cedrus.c | 313 ++++++++++++
>  .../platform/sunxi-cedrus/sunxi_cedrus_common.h    | 106 ++++
>  .../media/platform/sunxi-cedrus/sunxi_cedrus_dec.c | 568
> +++++++++++++++++++++
>  .../media/platform/sunxi-cedrus/sunxi_cedrus_dec.h |  33 ++
>  .../media/platform/sunxi-cedrus/sunxi_cedrus_hw.c  | 185 +++++++
>  .../media/platform/sunxi-cedrus/sunxi_cedrus_hw.h  |  36 ++
>  .../platform/sunxi-cedrus/sunxi_cedrus_mpeg2.c     | 152 ++++++
>  .../platform/sunxi-cedrus/sunxi_cedrus_regs.h      | 170 ++++++
>  drivers/media/platform/vim2m.c                     |  13 +-
>  drivers/media/v4l2-core/v4l2-ctrls.c               |  15 +
>  drivers/media/v4l2-core/v4l2-ioctl.c               |   1 +
>  include/uapi/linux/v4l2-controls.h                 |  26 +
>  include/uapi/linux/videodev2.h                     |   6 +
>  21 files changed, 1821 insertions(+), 1 deletion(-)
>  create mode 100644 Documentation/devicetree/bindings/media/sunxi-
> cedrus.txt
>  create mode 100644 drivers/media/platform/sunxi-cedrus/Makefile
>  create mode 100644 drivers/media/platform/sunxi-cedrus/sunxi_cedrus.c
>  create mode 100644 drivers/media/platform/sunxi-
> cedrus/sunxi_cedrus_common.h
>  create mode 100644 drivers/media/platform/sunxi-
> cedrus/sunxi_cedrus_dec.c
>  create mode 100644 drivers/media/platform/sunxi-
> cedrus/sunxi_cedrus_dec.h
>  create mode 100644 drivers/media/platform/sunxi-
> cedrus/sunxi_cedrus_hw.c
>  create mode 100644 drivers/media/platform/sunxi-
> cedrus/sunxi_cedrus_hw.h
>  create mode 100644 drivers/media/platform/sunxi-
> cedrus/sunxi_cedrus_mpeg2.c
>  create mode 100644 drivers/media/platform/sunxi-
> cedrus/sunxi_cedrus_regs.h
> 
-- 
Paul Kocialkowski, Bootlin (formerly Free Electrons)
Embedded Linux and kernel engineering
https://bootlin.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: This is a digitally signed message part
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180309/298bae2d/attachment-0001.sig>
