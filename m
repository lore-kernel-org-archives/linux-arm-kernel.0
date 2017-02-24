From: robh+dt@kernel.org (Rob Herring)
Date: Fri, 24 Feb 2017 07:30:36 -0600
Subject: [PATCH 4/8] drm/sun4i: add support for sun8i DE2 mixers and
 display engines
In-Reply-To: <20170222200947.3ikrhvv76ymfu5tv@lukather>
References: <20170222152310.3719-5-icenowy@aosc.xyz>
 <20170222200947.3ikrhvv76ymfu5tv@lukather>
Message-ID: <CAL_JsqKY1sXT9g9wHhQEt9-x32PaY0yQi8++bTajcEVk1x8E_w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 22, 2017 at 2:09 PM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> Hi,
>
> On Wed, Feb 22, 2017 at 11:23:06PM +0800, Icenowy Zheng wrote:
>> Allwinner have a new "Display Engine 2.0" in there new SoCs, which comes
>> in a new "Display Engine" (mixers instead of old backends and
>> frontends).
>>
>> Add support for the mixer on Allwinner V3s SoC; it's the simplest one.
>>
>> Signed-off-by: Icenowy Zheng <icenowy@aosc.xyz>
>> ---

[...]

>> diff --git a/drivers/gpu/drm/sun4i/sun8i_mixer.c b/drivers/gpu/drm/sun4i/sun8i_mixer.c
>> new file mode 100644
>> index 000000000000..9427b57240d3
>> --- /dev/null
>> +++ b/drivers/gpu/drm/sun4i/sun8i_mixer.c
>> @@ -0,0 +1,417 @@
>> +/*
>> + * Copyright (C) 2017 Icenowy Zheng <icenowy@aosc.xyz>
>> + *
>> + * Based on sun4i_backend.c, which is:
>> + *   Copyright (C) 2015 Free Electrons
>> + *   Copyright (C) 2015 NextThing Co
>> + *
>> + * This program is free software; you can redistribute it and/or
>> + * modify it under the terms of the GNU General Public License as
>> + * published by the Free Software Foundation; either version 2 of
>> + * the License, or (at your option) any later version.
>> + */
>> +
>> +#include <drm/drmP.h>
>> +#include <drm/drm_atomic_helper.h>
>> +#include <drm/drm_crtc.h>
>> +#include <drm/drm_crtc_helper.h>
>> +#include <drm/drm_fb_cma_helper.h>
>> +#include <drm/drm_gem_cma_helper.h>
>> +#include <drm/drm_plane_helper.h>
>> +
>> +#include <linux/component.h>
>> +#include <linux/reset.h>
>> +#include <linux/of_device.h>
>> +
>> +#include "sun8i_mixer.h"
>> +#include "sun4i_drv.h"
>> +
>> +#define SUN8I_DRAM_OFFSET 0x40000000
>
> PHYS_OFFSET?

PHYS_OFFSET is not portable. __pa(PAGE_OFFSET) instead.

If your DMA addresses are different from CPU addresses (i.e. have some
offset), then use "dma-ranges" in DT.

Rob
