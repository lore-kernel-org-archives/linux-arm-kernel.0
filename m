From: moinejf@free.fr (Jean-Francois Moine)
Date: Fri, 29 Jan 2016 08:20:00 +0100
Subject: [PATCH v8 1/2] drm/rockchip: hdmi: add Innosilicon HDMI support
In-Reply-To: <1454050059-31196-1-git-send-email-ykk@rock-chips.com>
References: <1454049768-30872-1-git-send-email-ykk@rock-chips.com>
 <1454050059-31196-1-git-send-email-ykk@rock-chips.com>
Message-ID: <20160129082000.b25fd19cea94c4f3ec45e17f@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 29 Jan 2016 14:47:39 +0800
Yakir Yang <ykk@rock-chips.com> wrote:

> The Innosilicon HDMI is a low power HDMI 1.4 transmitter
> IP, and it have been integrated on some rockchip CPUs
> (like RK3036, RK312x).
> 
> Signed-off-by: Yakir Yang <ykk@rock-chips.com>
> ---
> Changes in v8:
> - Don't check whether encoder output format is RGB colorspace, cause driver
>   default configure the output colorspace to RGB. (ZhengYang)
> - Correct the check condition in inno_hdmi_config_video_csc() (ZhengYang)
>     - if (data->enc_out_format == data->enc_out_format) {
>     + if (data->enc_in_format == data->enc_out_format) {
> 
> Changes in v7:
> - Correct the module licnese statement (Paul)
>      - MODULE_LICENSE("GPL");
>      + MODULE_LICENSE("GPLv2");
> - Start indentation with tabs and fix the misspell in Kconfig (Paul)
> - Carry the lost device-binding document (Heiko)
> 
> Changes in v6:
> - Rebase the Makefile/Kconfig files which add by Chris's rockchip-mipi driver (Caeser)
> 
> Changes in v5:
> - Use hdmi_infoframe helper functions to packed the infoframe (Russell)
> - Remove the unused double wait_for_completion_timeout for ddc transfer (Russell)
> - Remove the unused local variable in "inno_hdmi_i2c_write()" function (Russell)
> 
> Changes in v4:
> - Modify the commit title "drm/rockchip: hdmi: ..." (Mark)
> - Correct the "DKMS" to "DPMS" (Mark)
> - Fix over 80 characters problems (Mark)
> - Remove encoder .prepare/.commit helper functions, and move the vop mode
> configure function into encoder .enable helper functions. (Mark)
> 
> Changes in v3:
> - Use encoder enable/disable function, and remove the encoder DPMS function
> - Keep HDMI PLL power on in standby mode
> 
> Changes in v2:
> - Using DRM atomic helper functions for connector init (Mark)
> - Remove "hdmi->connector.encoder = encoder;" (Mark)
> 
>  drivers/gpu/drm/rockchip/Kconfig     |   8 +
>  drivers/gpu/drm/rockchip/Makefile    |   1 +
>  drivers/gpu/drm/rockchip/inno_hdmi.c | 939 +++++++++++++++++++++++++++++++++++
>  drivers/gpu/drm/rockchip/inno_hdmi.h | 362 ++++++++++++++
>  4 files changed, 1310 insertions(+)
>  create mode 100644 drivers/gpu/drm/rockchip/inno_hdmi.c
>  create mode 100644 drivers/gpu/drm/rockchip/inno_hdmi.h
> 
> diff --git a/drivers/gpu/drm/rockchip/Kconfig b/drivers/gpu/drm/rockchip/Kconfig
> index 8573985..76b3362 100644
> --- a/drivers/gpu/drm/rockchip/Kconfig
> +++ b/drivers/gpu/drm/rockchip/Kconfig
> @@ -35,3 +35,11 @@ config ROCKCHIP_DW_MIPI_DSI
>  	 for the Synopsys DesignWare HDMI driver. If you want to
>  	 enable MIPI DSI on RK3288 based SoC, you should selet this
>  	 option.
> +
> +config ROCKCHIP_INNO_HDMI
> +	tristate "Rockchip specific extensions for Innosilicon HDMI"
> +	depends on DRM_ROCKCHIP
> +	help
> +	  This selects support for Rockchip SoC specific extensions
> +	  for the Innosilicon HDMI driver. If you want to enable
> +	  HDMI on RK3036 based SoC, you should select this option.
> diff --git a/drivers/gpu/drm/rockchip/Makefile b/drivers/gpu/drm/rockchip/Makefile
> index f6a809a..df8fbef 100644
> --- a/drivers/gpu/drm/rockchip/Makefile
> +++ b/drivers/gpu/drm/rockchip/Makefile
> @@ -8,5 +8,6 @@ rockchipdrm-$(CONFIG_DRM_FBDEV_EMULATION) += rockchip_drm_fbdev.o
>  
>  obj-$(CONFIG_ROCKCHIP_DW_HDMI) += dw_hdmi-rockchip.o
>  obj-$(CONFIG_ROCKCHIP_DW_MIPI_DSI) += dw-mipi-dsi.o
> +obj-$(CONFIG_ROCKCHIP_INNO_HDMI) += inno_hdmi.o
>  
>  obj-$(CONFIG_DRM_ROCKCHIP) += rockchipdrm.o rockchip_vop_reg.o
> diff --git a/drivers/gpu/drm/rockchip/inno_hdmi.c b/drivers/gpu/drm/rockchip/inno_hdmi.c
> new file mode 100644
> index 0000000..c99d88d
> --- /dev/null
> +++ b/drivers/gpu/drm/rockchip/inno_hdmi.c
> @@ -0,0 +1,939 @@
> +/*
> + * Copyright (C) Fuzhou Rockchip Electronics Co.Ltd
> + *    Zheng Yang <zhengyang@rock-chips.com>
> + *    Yakir Yang <ykk@rock-chips.com>
> + *
> + * This software is licensed under the terms of the GNU General Public
> + * License version 2, as published by the Free Software Foundation, and
> + * may be copied, distributed, and modified under those terms.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + */
> +
> +#include <linux/irq.h>
> +#include <linux/clk.h>
> +#include <linux/delay.h>
> +#include <linux/err.h>
> +#include <linux/hdmi.h>
> +#include <linux/mfd/syscon.h>
> +#include <linux/module.h>
> +#include <linux/mutex.h>
> +#include <linux/of_device.h>
> +
> +#include <drm/drm_of.h>
> +#include <drm/drmP.h>
> +#include <drm/drm_atomic_helper.h>
> +#include <drm/drm_crtc_helper.h>
> +#include <drm/drm_edid.h>
> +#include <drm/drm_encoder_slave.h>

This is not needed.

> +
> +#include "rockchip_drm_drv.h"
> +#include "rockchip_drm_vop.h"
> +
> +#include "inno_hdmi.h"
	[snip]

-- 
Ken ar c'henta?	|	      ** Breizh ha Linux atav! **
Jef		|		http://moinejf.free.fr/
