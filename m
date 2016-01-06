From: jenskuske@gmx.de (Jens Kuske)
Date: Wed, 6 Jan 2016 21:41:30 +0100
Subject: [PATCH RFC 2/2] drm: sunxi: Add a basic DRM driver for Allwinner
 DE2
In-Reply-To: <58463fd5b674c7eedec4ae05567ee56770a12996.1452021349.git.moinejf@free.fr>
References: <cover.1452021349.git.moinejf@free.fr>
 <58463fd5b674c7eedec4ae05567ee56770a12996.1452021349.git.moinejf@free.fr>
Message-ID: <568D7BFA.30802@gmx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/01/16 19:40, Jean-Francois Moine wrote:
[snip]
> diff --git a/drivers/gpu/drm/sunxi/de2_hdmi_h3.c b/drivers/gpu/drm/sunxi/de2_hdmi_h3.c
> new file mode 100644
> index 0000000..c54b090
> --- /dev/null
> +++ b/drivers/gpu/drm/sunxi/de2_hdmi_h3.c
> @@ -0,0 +1,478 @@
> +/*
> + * Allwinner H3 HDMI lowlevel functions
> + *
> + * Copyright (C) 2016 Jean-Francois Moine <moinejf@free.fr>
> + *
> + * Adapted from the file
> + *	lichee/linux-3.4/drivers/video/sunxi/disp2/hdmi/aw/hdmi_bsp_sun8iw7.c
> + * with no license nor copyright.
> + */
> +
> +#include <drm/drmP.h>
> +
> +#include "de2_hdmi.h"
> +#include "de2_hdmi_h3.h"
> +
> +struct para_tab {
> +	u32 para[19];
> +};
> +
> +struct pcm_sf {
> +	u32 	sf;
> +	unsigned char	cs_sf;
> +};
> +
> +/*
> + * [0] = vic (cea Video ID)
> + * [1] used in hdmi_phy_set / bsp_hdmi_audio
> + * [2..17] used in bsp_hdmi_video
> + */
> +static const struct para_tab ptbl[] = {
> +	{{  6,  1, 1,  1,  5,  3, 0, 1, 4, 0, 0, 160,  20,  38, 124, 240, 22, 0, 0}},
> +	{{ 21, 11, 1,  1,  5,  3, 1, 1, 2, 0, 0, 160,  32,  24, 126,  32, 24, 0, 0}},
> +	{{  2, 11, 0,  0,  2,  6, 1, 0, 9, 0, 0, 208, 138,  16,  62, 224, 45, 0, 0}},
> +	{{ 17, 11, 0,  0,  2,  5, 2, 0, 5, 0, 0, 208, 144,  12,  64,  64, 49, 0, 0}},
> +	{{ 19,  4, 0, 96,  5,  5, 2, 2, 5, 1, 0,   0, 188, 184,  40, 208, 30, 1, 1}},
> +	{{  4,  4, 0, 96,  5,  5, 2, 1, 5, 0, 0,   0, 114, 110,  40, 208, 30, 1, 1}},
> +	{{ 20,  4, 0, 97,  7,  5, 4, 2, 2, 2, 0, 128, 208,  16,  44,  56, 22, 1, 1}},
> +	{{  5,  4, 0, 97,  7,  5, 4, 1, 2, 0, 0, 128,  24,  88,  44,  56, 22, 1, 1}},
> +	{{ 31,  2, 0, 96,  7,  5, 4, 2, 4, 2, 0, 128, 208,  16,  44,  56, 45, 1, 1}},
> +	{{ 16,  2, 0, 96,  7,  5, 4, 1, 4, 0, 0, 128,  24,  88,  44,  56, 45, 1, 1}},
> +	{{ 32,  4, 0, 96,  7,  5, 4, 3, 4, 2, 0, 128,  62, 126,  44,  56, 45, 1, 1}},
> +	{{ 33,  4, 0,  0,  7,  5, 4, 2, 4, 2, 0, 128, 208,  16,  44,  56, 45, 1, 1}},
> +	{{ 34,  4, 0,  0,  7,  5, 4, 1, 4, 0, 0, 128,  24,  88,  44,  56, 45, 1, 1}},
> +	{{160,  2, 0, 96,  7,  5, 8, 3, 4, 2, 0, 128,  62, 126,  44, 157, 45, 1, 1}},
> +	{{147,  2, 0, 96,  5,  5, 5, 2, 5, 1, 0,   0, 188, 184,  40, 190, 30, 1, 1}},
> +	{{132,  2, 0, 96,  5,  5, 5, 1, 5, 0, 0,   0, 114, 110,  40, 160, 30, 1, 1}},
> +	{{257,  1, 0, 96, 15, 10, 8, 2, 8, 0, 0,   0,  48, 176,  88, 112, 90, 1, 1}},
> +	{{258,  1, 0, 96, 15, 10, 8, 5, 8, 4, 0,   0, 160,  32,  88, 112, 90, 1, 1}},
> +};

Hi,

did you try to figure out what the values in this table actually mean?

I tried it some time ago because I wanted to add some more resolutions
to 3.4, but never got further than what I'll add below. But it might be
useful now, to get rid of at least some of the magic constants.
With some more work (what does [1] mean?) we might be able to drop the
entire table and use the values from drm_display_mode directly instead.

unsure (hard to verify):
[2] = pixel repetition (1 = 2x)
[3] = bit0: interlaced (no idea about the 96/0x60 yet)
[17] = something csc related
[18] = unused

pretty sure (verified by comparing with timings):
[4] = horizontal active (high byte)
[5] = vsync width
[6] = vertical active (high byte)
[7] = horizontal blanking (high byte)
[8] = vertical front porch
[9] = horizontal front porch (high byte)
[10] = hsync width (high byte)
[11] = horizontal active (low byte)
[12] = horizontal blanking (low byte)
[13] = horizontal front porch (low byte)
[14] = hsync width (low byte)
[15] = vertical active (low byte)
[16] = vertical blanking


Generally, nice work. I only skimmed over it by now, but I hope to test
and review the hardware related parts more intensively sometime.

Regards,
Jens
