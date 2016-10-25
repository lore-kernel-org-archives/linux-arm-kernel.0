From: andre.przywara@arm.com (=?UTF-8?Q?Andr=c3=a9_Przywara?=)
Date: Wed, 26 Oct 2016 00:52:28 +0100
Subject: [linux-sunxi] Re: [PATCH v5 1/7] drm: sunxi: Add a basic DRM
 driver for Allwinner DE2
In-Reply-To: <20161025161441.6b248efe9229bd80e3f7a33c@free.fr>
References: <cover.1477142934.git.moinejf@free.fr>
 <8afc5e020c5767face34fe3a9ab300ce9e67ba00.1477142934.git.moinejf@free.fr>
 <20161024140419.ah6hywf3b24pj3fv@lukather>
 <20161025161441.6b248efe9229bd80e3f7a33c@free.fr>
Message-ID: <94958c6b-22e9-7ba7-c9dd-d79924551f2d@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 25/10/16 15:14, Jean-Francois Moine wrote:
> On Mon, 24 Oct 2016 16:04:19 +0200
> Maxime Ripard <maxime.ripard@free-electrons.com> wrote:
> 
>> Hi,
> 
> Hi Maxime,
> 
>> On Fri, Oct 21, 2016 at 09:26:18AM +0200, Jean-Francois Moine wrote:
>>> Allwinner's recent SoCs, as A64, A83T and H3, contain a new display
>>> engine, DE2.
>>> This patch adds a DRM video driver for this device.
>>>
>>> Signed-off-by: Jean-Francois Moine <moinejf@free.fr>
>>
>> Output from checkpatch:
>> total: 0 errors, 20 warnings, 83 checks, 1799 lines checked
>>
>>> ---
>>>  .../bindings/display/sunxi/sunxi-de2.txt           |  83 +++
>>>  drivers/gpu/drm/Kconfig                            |   2 +
>>>  drivers/gpu/drm/Makefile                           |   1 +
>>>  drivers/gpu/drm/sunxi/Kconfig                      |  21 +
>>>  drivers/gpu/drm/sunxi/Makefile                     |   7 +
>>>  drivers/gpu/drm/sunxi/de2_crtc.c                   | 475 +++++++++++++++++
>>>  drivers/gpu/drm/sunxi/de2_crtc.h                   |  63 +++
>>>  drivers/gpu/drm/sunxi/de2_de.c                     | 591 +++++++++++++++++++++
>>>  drivers/gpu/drm/sunxi/de2_drm.h                    |  47 ++
>>>  drivers/gpu/drm/sunxi/de2_drv.c                    | 378 +++++++++++++
>>>  drivers/gpu/drm/sunxi/de2_plane.c                  | 119 +++++
>>>  11 files changed, 1787 insertions(+)
>>>  create mode 100644 Documentation/devicetree/bindings/display/sunxi/sunxi-de2.txt
>>>  create mode 100644 drivers/gpu/drm/sunxi/Kconfig
>>>  create mode 100644 drivers/gpu/drm/sunxi/Makefile
>>>  create mode 100644 drivers/gpu/drm/sunxi/de2_crtc.c
>>>  create mode 100644 drivers/gpu/drm/sunxi/de2_crtc.h
>>>  create mode 100644 drivers/gpu/drm/sunxi/de2_de.c
>>>  create mode 100644 drivers/gpu/drm/sunxi/de2_drm.h
>>>  create mode 100644 drivers/gpu/drm/sunxi/de2_drv.c
>>>  create mode 100644 drivers/gpu/drm/sunxi/de2_plane.c
>>>
>>> diff --git a/Documentation/devicetree/bindings/display/sunxi/sunxi-de2.txt b/Documentation/devicetree/bindings/display/sunxi/sunxi-de2.txt
>>> new file mode 100644
>>> index 0000000..f9cd67a
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/display/sunxi/sunxi-de2.txt
>>> @@ -0,0 +1,83 @@
>>> +Allwinner sunxi Display Engine 2 subsystem
>>> +==========================================
>>> +
>>> +The sunxi DE2 subsystem contains a display controller (DE2),
>>
>> sunxi is a made up name, and doesn't really mean anything. You can
>> call it either sun8i (because it was introduced in that family).
> 
> OK.
> 
>>> +one or two LCD controllers (TCON) and their external interfaces.
>>> +
>>> +Display controller
>>> +==================
>>> +
>>> +Required properties:
>>> +
>>> +- compatible: value should be one of the following
>>> +		"allwinner,sun8i-a83t-display-engine"
>>> +		"allwinner,sun8i-h3-display-engine"
>>> +
>>> +- clocks: must include clock specifiers corresponding to entries in the
>>> +		clock-names property.
>>> +
>>> +- clock-names: must contain
>>> +		"gate": for DE activation
>>> +		"clock": DE clock
>>
>> We've been calling them bus and mod.
> 
> I can understand "bus" (which is better than "apb"), but why "mod"?
> 
>>> +
>>> +- resets: phandle to the reset of the device
>>> +
>>> +- ports: phandle's to the LCD ports
>>
>> Please use the OF graph.
> 
> These ports are references to the graph of nodes. See
> 	http://www.kernelhub.org/?msg=911825&p=2
> 
> 	[snip]
>>> diff --git a/drivers/gpu/drm/sunxi/de2_crtc.c b/drivers/gpu/drm/sunxi/de2_crtc.c
>>> new file mode 100644
>>> index 0000000..dae0fab
>>> --- /dev/null
>>> +++ b/drivers/gpu/drm/sunxi/de2_crtc.c
>>> @@ -0,0 +1,475 @@
>>> +/*
>>> + * Allwinner DRM driver - DE2 CRTC
>>> + *
>>> + * Copyright (C) 2016 Jean-Francois Moine <moinejf@free.fr>
>>> + *
>>> + * This program is free software; you can redistribute it and/or
>>> + * modify it under the terms of the GNU General Public License as
>>> + * published by the Free Software Foundation; either version 2 of
>>> + * the License, or (at your option) any later version.
>>> + */
>>> +
>>> +#include <linux/component.h>
>>> +#include <drm/drm_crtc_helper.h>
>>> +#include <drm/drm_atomic_helper.h>
>>> +#include <asm/io.h>
>>> +#include <linux/of_irq.h>
>>> +
>>> +#include "de2_drm.h"
>>> +#include "de2_crtc.h"
>>> +
>>> +/* I/O map */
>>> +
>>> +struct tcon {
>>> +	u32 gctl;
>>> +#define		TCON_GCTL_TCON_En BIT(31)
>>> +	u32 gint0;
>>> +#define		TCON_GINT0_TCON1_Vb_Int_En BIT(30)
>>> +#define		TCON_GINT0_TCON1_Vb_Int_Flag BIT(14)
>>> +	u32 gint1;
>>> +	u32 dum0[13];
>>> +	u32 tcon0_ctl;				/* 0x40 */
>>> +#define		TCON0_CTL_TCON_En BIT(31)
>>> +	u32 dum1[19];
>>> +	u32 tcon1_ctl;				/* 0x90 */
>>> +#define		TCON1_CTL_TCON_En BIT(31)
>>> +#define		TCON1_CTL_Interlace_En BIT(20)
>>> +#define		TCON1_CTL_Start_Delay_SHIFT 4
>>> +#define		TCON1_CTL_Start_Delay_MASK GENMASK(8, 4)
>>> +	u32 basic0;			/* XI/YI */
>>> +	u32 basic1;			/* LS_XO/LS_YO */
>>> +	u32 basic2;			/* XO/YO */
>>> +	u32 basic3;			/* HT/HBP */
>>> +	u32 basic4;			/* VT/VBP */
>>> +	u32 basic5;			/* HSPW/VSPW */
>>> +	u32 dum2;
>>> +	u32 ps_sync;				/* 0xb0 */
>>> +	u32 dum3[15];
>>> +	u32 io_pol;				/* 0xf0 */
>>> +#define		TCON1_IO_POL_IO0_inv BIT(24)
>>> +#define		TCON1_IO_POL_IO1_inv BIT(25)
>>> +#define		TCON1_IO_POL_IO2_inv BIT(26)
>>> +	u32 io_tri;
>>> +	u32 dum4[2];
>>> +
>>> +	u32 ceu_ctl;				/* 0x100 */
>>> +#define     TCON_CEU_CTL_ceu_en BIT(31)
>>> +	u32 dum5[3];
>>> +	u32 ceu_rr;
>>> +	u32 ceu_rg;
>>> +	u32 ceu_rb;
>>> +	u32 ceu_rc;
>>> +	u32 ceu_gr;
>>> +	u32 ceu_gg;
>>> +	u32 ceu_gb;
>>> +	u32 ceu_gc;
>>> +	u32 ceu_br;
>>> +	u32 ceu_bg;
>>> +	u32 ceu_bb;
>>> +	u32 ceu_bc;
>>> +	u32 ceu_rv;
>>> +	u32 ceu_gv;
>>> +	u32 ceu_bv;
>>> +	u32 dum6[45];
>>> +
>>> +	u32 mux_ctl;				/* 0x200 */
>>> +	u32 dum7[63];
>>> +
>>> +	u32 fill_ctl;				/* 0x300 */
>>> +	u32 fill_start0;
>>> +	u32 fill_end0;
>>> +	u32 fill_data0;
>>> +};
>>
>> Please use defines instead of the structures.
> 
> I think that structures are more readable.

I think for the kernel we don't use C structs to model register frames.
The main argument against it is that putting them into a structure puts
the actual offset into the hands of the compiler, which is free to
insert padding and alignment - within the rules of the ABI. This happens
to work when we use 32-bit registers and maybe char fillers only. Most
ABIs seem to agree on this part, but there is no guarantee.
In fact all those various ABIs used by the kernel could have subtle
differences between architectures (for instance for alignment of 64-bit
members), so we produce potentially non-portable code.

Also I find it actually harder to read, since the manual refers to
register offset addresses, which makes it hard to match with the code,
especially if we deviate with the register naming. The fact that we have
occasional *comments* to denote the actual offset is a hint that
something is sub-optimal.
Also having these dummy fillers is really error prone once we insert new
registers, as the fill value has to be adjusted accordingly.

So can we stick with what the kernel uses elsewhere and don't pretend
that because the current GCC compiles that fine on ARM it will be good
forever?

Thanks!
Andre.
