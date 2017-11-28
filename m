From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 28 Nov 2017 21:55:50 +0100
Subject: [PATCH 13/17] drm/sun4i: Add DE2 CSC library
In-Reply-To: <20171127205750.19277-14-jernej.skrabec@siol.net>
References: <20171127205750.19277-1-jernej.skrabec@siol.net>
 <20171127205750.19277-14-jernej.skrabec@siol.net>
Message-ID: <20171128205550.ls23xy5u4xtdlqgj@flea.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 27, 2017 at 09:57:46PM +0100, Jernej Skrabec wrote:
> DE2 have many CSC units - channel input CSC, channel output CSC and
> mixer output CSC and maybe more.
> 
> Fortunately, they have all same register layout, only base offsets
> differs.
> 
> Add support only for channel output CSC for now.
> 
> Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
> ---
>  drivers/gpu/drm/sun4i/Makefile    |  2 +-
>  drivers/gpu/drm/sun4i/sun8i_csc.c | 90 +++++++++++++++++++++++++++++++++++++++
>  drivers/gpu/drm/sun4i/sun8i_csc.h | 36 ++++++++++++++++
>  3 files changed, 127 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/gpu/drm/sun4i/sun8i_csc.c
>  create mode 100644 drivers/gpu/drm/sun4i/sun8i_csc.h
> 
> diff --git a/drivers/gpu/drm/sun4i/Makefile b/drivers/gpu/drm/sun4i/Makefile
> index 70df480792f9..f82cc69ede72 100644
> --- a/drivers/gpu/drm/sun4i/Makefile
> +++ b/drivers/gpu/drm/sun4i/Makefile
> @@ -9,7 +9,7 @@ sun4i-drm-hdmi-y		+= sun4i_hdmi_enc.o
>  sun4i-drm-hdmi-y		+= sun4i_hdmi_i2c.o
>  sun4i-drm-hdmi-y		+= sun4i_hdmi_tmds_clk.o
>  
> -sun8i-mixer-y			+= sun8i_mixer.o sun8i_layer.o sun8i_scaler.o
> +sun8i-mixer-y			+= sun8i_mixer.o sun8i_layer.o sun8i_scaler.o sun8i_csc.o

Please wrap that line.

>  
>  sun4i-tcon-y			+= sun4i_crtc.o
>  sun4i-tcon-y			+= sun4i_dotclock.o
> diff --git a/drivers/gpu/drm/sun4i/sun8i_csc.c b/drivers/gpu/drm/sun4i/sun8i_csc.c
> new file mode 100644
> index 000000000000..d48c28f8d568
> --- /dev/null
> +++ b/drivers/gpu/drm/sun4i/sun8i_csc.c
> @@ -0,0 +1,90 @@
> +/*
> + * Copyright (C) Jernej Skrabec <jernej.skrabec@siol.net>
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License as
> + * published by the Free Software Foundation; either version 2 of
> + * the License, or (at your option) any later version.
> + */
> +
> +#include "sun8i_csc.h"
> +
> +static const u32 ccsc_base[2][2] = {
> +	{CCSC00_OFFSET, CCSC01_OFFSET},
> +	{CCSC10_OFFSET, CCSC11_OFFSET},
> +};
> +
> +/*
> + * Factors are in two's complement format, 10 bits for fractinal part.
> + * First tree values in each line are multiplication factor and last
> + * value is constant, which is added at the end.
> + */
> +static const u32 yuv2rgb[] = {
> +	0x000004A8, 0x00000000, 0x00000662, 0xFFFC845A,
> +	0x000004A8, 0xFFFFFE6F, 0xFFFFFCBF, 0x00021DF4,
> +	0x000004A8, 0x00000813, 0x00000000, 0xFFFBAC4A,
> +};
> +
> +static const u32 yvu2rgb[] = {
> +	0x000004A8, 0x00000662, 0x00000000, 0xFFFC845A,
> +	0x000004A8, 0xFFFFFCBF, 0xFFFFFE6F, 0x00021DF4,
> +	0x000004A8, 0x00000000, 0x00000813, 0xFFFBAC4A,
> +};
> +
> +static void sun8i_csc_set_coefficients(struct regmap *map, u32 base,
> +				       enum sun8i_csc_mode mode)
> +{
> +	const u32 *table;
> +	int i, data;
> +
> +	switch (mode) {
> +	case SUN8I_CSC_MODE_YUV2RGB:
> +		table = yuv2rgb;
> +		break;
> +	case SUN8I_CSC_MODE_YVU2RGB:
> +		table = yvu2rgb;
> +		break;
> +	default:
> +		WARN(1, "Wrong CSC mode specified.");

A hard warn is a bit overkill here. What about a dev_warn?

Looks good otherwise.

Thanks!
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20171128/b836e56a/attachment.sig>
