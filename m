From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Sat, 15 Jul 2017 12:42:23 +0300
Subject: [PATCH v2 2/6] [media] rockchip/rga: v4l2 m2m support
In-Reply-To: <1500101920-24039-3-git-send-email-jacob-chen@iotwrt.com>
References: <1500101920-24039-1-git-send-email-jacob-chen@iotwrt.com>
 <1500101920-24039-3-git-send-email-jacob-chen@iotwrt.com>
Message-ID: <2363665.x6z9MR1vqI@avalon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jacob,

Thank you for the patch.

On Saturday 15 Jul 2017 14:58:36 Jacob Chen wrote:
> Rockchip RGA is a separate 2D raster graphic acceleration unit. It
> accelerates 2D graphics operations, such as point/line drawing, image
> scaling, rotation, BitBLT, alpha blending and image blur/sharpness.
> 
> The drvier is mostly based on s5p-g2d v4l2 m2m driver.
> And supports various operations from the rendering pipeline.
>  - copy
>  - fast solid color fill
>  - rotation
>  - flip
>  - alpha blending

I notice that you don't support the drawing operations. How do you plan to 
support them later through the V4L2 M2M API ? I hate stating the obvious, but 
wouldn't the DRM API be better fit for a graphic accelerator ?

Additionally, V4L2 M2M has one source and one destination. How do you 
implement alpha blending in that case, which by definition requires at least 
two sources ?

> The code in rga-hw.c is used to configure regs accroding to operations.
> 
> The code in rga-buf.c is used to create private mmu table for RGA.
> The tables is stored in a list, and be removed when buffer is cleanup.

Looking at the implementation it seems to be a scatter-gather list, not an 
MMU. Is that right ? Does the hardware documentation refer to it as an MMU ?

> Signed-off-by: Jacob Chen <jacob-chen@iotwrt.com>
> ---
>  drivers/media/platform/Kconfig                |  11 +
>  drivers/media/platform/Makefile               |   2 +
>  drivers/media/platform/rockchip-rga/Makefile  |   3 +
>  drivers/media/platform/rockchip-rga/rga-buf.c | 122 ++++
>  drivers/media/platform/rockchip-rga/rga-hw.c  | 652 ++++++++++++++++++
>  drivers/media/platform/rockchip-rga/rga-hw.h  | 437 ++++++++++++
>  drivers/media/platform/rockchip-rga/rga.c     | 958 +++++++++++++++++++++++
>  drivers/media/platform/rockchip-rga/rga.h     | 111 +++
>  8 files changed, 2296 insertions(+)
>  create mode 100644 drivers/media/platform/rockchip-rga/Makefile
>  create mode 100644 drivers/media/platform/rockchip-rga/rga-buf.c
>  create mode 100644 drivers/media/platform/rockchip-rga/rga-hw.c
>  create mode 100644 drivers/media/platform/rockchip-rga/rga-hw.h
>  create mode 100644 drivers/media/platform/rockchip-rga/rga.c
>  create mode 100644 drivers/media/platform/rockchip-rga/rga.h

-- 
Regards,

Laurent Pinchart
