From: jszhang@marvell.com (Jisheng Zhang)
Date: Mon, 23 Nov 2015 13:56:53 +0800
Subject: [PATCH v2 4/6] clk: berlin: add clk support for berlin4ct
In-Reply-To: <564F8902.4000405@gmail.com>
References: <1448008952-1787-1-git-send-email-jszhang@marvell.com>
 <1448008952-1787-5-git-send-email-jszhang@marvell.com>
 <564F8902.4000405@gmail.com>
Message-ID: <20151123135653.7e2919d7@xhacker>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 20 Nov 2015 21:56:34 +0100
Sebastian Hesselbarth wrote:

> On 20.11.2015 09:42, Jisheng Zhang wrote:
> > This patch supports the gateclk and berlin-clk in berlin4ct SoC.
> > 
> > Signed-off-by: Jisheng Zhang <jszhang@marvell.com>
> > ---
> >  drivers/clk/berlin/Makefile        |  2 +-
> >  drivers/clk/berlin/clk-berlin4ct.c | 97 ++++++++++++++++++++++++++++++++++++++
> >  2 files changed, 98 insertions(+), 1 deletion(-)
> >  create mode 100644 drivers/clk/berlin/clk-berlin4ct.c
> > 
> > diff --git a/drivers/clk/berlin/Makefile b/drivers/clk/berlin/Makefile
> > index fc92151..accfc3a 100644
> > --- a/drivers/clk/berlin/Makefile
> > +++ b/drivers/clk/berlin/Makefile
> > @@ -1,5 +1,5 @@
> >  obj-y += berlin2-avpll.o berlin2-pll.o berlin2-div.o
> > -obj-y += pll.o clk.o gate.o
> > +obj-y += pll.o clk.o gate.o clk-berlin4ct.o  
> 
> This will always compile clk-berlin4ct unconditionally on bg2x too.

Indeed. this also always compile bg2x clk driver on BG4x too. Is it fine to
introduce config option? any suggestion?

> 
> Also, keep the naming style.

will do in v3

> 
> Sebastian
> 
> >  obj-$(CONFIG_MACH_BERLIN_BG2)	+= bg2.o
> >  obj-$(CONFIG_MACH_BERLIN_BG2CD)	+= bg2.o
> >  obj-$(CONFIG_MACH_BERLIN_BG2Q)	+= bg2q.o
> > diff --git a/drivers/clk/berlin/clk-berlin4ct.c b/drivers/clk/berlin/clk-berlin4ct.c
> > new file mode 100644
> > index 0000000..0d994a4
> > --- /dev/null
> > +++ b/drivers/clk/berlin/clk-berlin4ct.c
> > @@ -0,0 +1,97 @@
> > +/*
> > + * Copyright (c) 2015 Marvell Technology Group Ltd.
> > + *
> > + * Author: Jisheng Zhang <jszhang@marvell.com>
> > + *
> > + * This program is free software; you can redistribute it and/or modify it
> > + * under the terms and conditions of the GNU General Public License,
> > + * version 2, as published by the Free Software Foundation.
> > + *
> > + * This program is distributed in the hope it will be useful, but WITHOUT
> > + * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
> > + * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
> > + * more details.
> > + *
> > + * You should have received a copy of the GNU General Public License along with
> > + * this program.  If not, see <http://www.gnu.org/licenses/>.
> > + */
> > +
> > +#include <linux/clk-provider.h>
> > +
> > +#include "clk.h"
> > +
> > +static struct clk_onecell_data gateclk_data;
> > +static struct clk_onecell_data clk_data;
> > +
> > +static const struct gateclk_desc berlin4ct_gates[] __initconst = {
> > +	{ "tspsysclk",		"perifsysclk",	0 },
> > +	{ "usb0coreclk",	"perifsysclk",	1 },
> > +	{ "zspsysclk",		"perifsysclk",	2 },
> > +	{ "sdiosysclk",		"perifsysclk",	3 },
> > +	{ "ethcoreclk",		"perifsysclk",	4 },
> > +	{ "pcie0sys",		"perifsysclk",	6 },
> > +	{ "sata0core",		"perifsysclk",	7 },
> > +	{ "nfcsysclk",		"perifsysclk",	8 },
> > +	{ "emmcsysclk",		"perifsysclk",	9 },
> > +	{ "ihb0sysclk",		"perifsysclk",	10 },
> > +};
> > +
> > +static void __init berlin4ct_gateclk_setup(struct device_node *np)
> > +{
> > +	int n = ARRAY_SIZE(berlin4ct_gates);
> > +
> > +	berlin_gateclk_setup(np, berlin4ct_gates, &gateclk_data, n);
> > +}
> > +CLK_OF_DECLARE(berlin4ct_gateclk, "marvell,berlin4ct-gateclk",
> > +	       berlin4ct_gateclk_setup);
> > +
> > +static const struct clk_desc berlin4ct_descs[] __initconst = {
> > +	{ "cpufastrefclk",	0x0 },
> > +	{ "memfastrefclk",	0x4 },
> > +	{ "cfgclk",		0x20,	CLK_IGNORE_UNUSED },
> > +	{ "perifsysclk",	0x24,	CLK_IGNORE_UNUSED },
> > +	{ "hbclk",		0x28 },
> > +	{ "atbclk",		0x2c },
> > +	{ "decoderclk",		0x40 },
> > +	{ "decoderm3clk",	0x44 },
> > +	{ "decoderpcubeclk",	0x48 },
> > +	{ "encoderclk",		0x4c },
> > +	{ "ovpcoreclk",		0x50 },
> > +	{ "gfx2dcoreclk",	0x60 },
> > +	{ "gfx3dcoreclk",	0x64 },
> > +	{ "gfx3dshclk",		0x68 },
> > +	{ "gfx3dsysclk",	0x6c },
> > +	{ "gfx2dsysclk",	0x70 },
> > +	{ "aviosysclk",		0x80 },
> > +	{ "vppsysclk",		0x84 },
> > +	{ "eddcclk",		0x88 },
> > +	{ "aviobiuclk",		0x8c },
> > +	{ "zspclk",		0xa0 },
> > +	{ "tspclk",		0xc0 },
> > +	{ "tsprefclk",		0xc4 },
> > +	{ "ndsclk",		0xc8 },
> > +	{ "nocsclk",		0xcc },
> > +	{ "apbcoreclk",		0xd0,	CLK_IGNORE_UNUSED },
> > +	{ "emmcclk",		0xe0 },
> > +	{ "sd0clk",		0xe4 },
> > +	{ "sd1clk",		0xe8 },
> > +	{ "dllmstrefclk",	0xec },
> > +	{ "gethrgmiiclk",	0xf0 },
> > +	{ "gethrgmiisysclk",	0xf4 },
> > +	{ "usim0clk",		0x100 },
> > +	{ "pcietestclk",	0x110 },
> > +	{ "usb2testclk",	0x120 },
> > +	{ "usb3testclk",	0x124 },
> > +	{ "usb3coreclk",	0x128 },
> > +	{ "nfceccclk",		0x130 },
> > +	{ "bcmclk",		0x140 },
> > +};
> > +
> > +static void __init berlin4ct_clk_setup(struct device_node *np)
> > +{
> > +	int n = ARRAY_SIZE(berlin4ct_descs);
> > +
> > +	berlin_clk_setup(np, berlin4ct_descs, &clk_data, n);
> > +}
> > +CLK_OF_DECLARE(berlin4ct_clk, "marvell,berlin4ct-clk",
> > +	       berlin4ct_clk_setup);
> >   
> 
