From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 2 Mar 2017 15:21:40 +0100
Subject: [linux-sunxi] Re: [PATCH 2/4] clk: sunxi-ng: Add sun7i-a20 CCU
 driver
In-Reply-To: <1488404294.29650.3.camel@plaes.org>
References: <20170227210914.18954-1-plaes@plaes.org>
 <20170227210914.18954-3-plaes@plaes.org>
 <20170228082108.cthaanfuffbwbkaf@lukather>
 <1488404294.29650.3.camel@plaes.org>
Message-ID: <20170302142140.mjbqqhjuhmc2jgwq@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Priit,

On Wed, Mar 01, 2017 at 11:38:14PM +0200, Priit Laes wrote:
> > > +/* PLL2 - Audio clock */
> > > +static struct ccu_nm pll_audio_base_clk = {
> > > > > > > +	.enable		= BIT(31),
> > > > > > > +	.n		= _SUNXI_CCU_MULT_OFFSET(8, 7, 0),
> > > > > > > +	.m		= _SUNXI_CCU_DIV_OFFSET(0, 5, 0),
> > > > > > > +	.common		= {
> > > > > > > +		.reg		= 0x008,
> > > > > > > +		.hw.init	= CLK_HW_INIT("pll-audio-base",
> > > > > +					??????"hosc",
> > > > > +					??????&ccu_nm_ops,
> > > > > +					??????0),
> > > > > +	},
> > > +
> > > +};
> > 
> > You're forgetting the post-divider here
> 
> It's hardcoded to 4 during ccu initialization, similar to what is done
> on the other SoCs (A13, A31..).

Right, sorry, I only saw it later. Please move that define you've been
using here, and it will be fine :)

> > > +/* TODO: pll8 gpu 0x040 */
> > 
> > Please add all the clocks.
> 
> I'm not really comfortable adding clocks for blocks that currently lack
> drivers.

Yet, you did it for quite a significant amount already (VE, NAND,
AC97, DE MP, etc.). Don't get me wrong, this is definitely not a
criticism. One of the point of the switch to sunxi-ng was that we
would get out of the previous situation where every time you wanted to
do something, you needed to add some clocks.

We have some generic code that, if fed the right data, will
(hopefully) just work. So it's pretty safe to add (and this is better
to be consistent, and that's the policy we had for all the other CCU
drivers).

> > > +/* BIT(21 .. 31) - reserved */
> > 
> > I'm not sure we need those comments either.
> > 
> > > +/*
> > > + * TODO: SATA clock also supports external clock as parent.
> > > + * Currently we default to using PLL6 SATA gate.
> > > + */
> > 
> > Which external clock? It should be modelled anyway. If we have a
> > dependency on some other clock, it should be in our DT binding, and
> > listed in the mux there.
> > 
> > Otherwise, the clock framework will not be able to deal with that mux
> > being already set by the bootloader, and if we need to support that
> > clock in the future, our binding will be ready for it.
> 
> I wish I knew which clock they're talking about..
> 
> User manuals (A10/A20) only specify following in the clock register
> description:
> 
> BIT(24) - CLK_SRC_GATING, default 0x0
> Clock Source Select:
> 0: PLL6 for SATA(100MHz)
> 1: External Clock
> 
> There's no section for SATA?(called NC) in A10 manual, and in A20
> manual only contains list of SATA/AHCI features.

Hmmmm, ok :/

> > > +/* Some AHB gates are exported */
> > > > > +#define CLK_AHB_BIST		31
> > > > > +#define CLK_AHB_MS		36
> > > > > +#define CLK_AHB_SDRAM		38
> > > > > +#define CLK_AHB_ACE		39
> > > > > +#define CLK_AHB_TS		41
> > > > > +#define CLK_AHB_VE		48
> > > > > +#define CLK_AHB_TVD		49
> > > > > +#define CLK_AHB_TVE1		51
> > > > > +#define CLK_AHB_LCD1		53
> > > > > +#define CLK_AHB_CSI0		54
> > > > > +#define CLK_AHB_CSI1		55
> > > > > +#define CLK_AHB_HDMI0		56
> > > > > +#define CLK_AHB_DE_BE1		59
> > > > > +#define CLK_AHB_DE_FE0		60
> > > > > +#define CLK_AHB_DE_FE1		61
> > > > > +#define CLK_AHB_MP		63
> > > > > +#define CLK_AHB_GPU		64
> > > +
> > > +/* Some APB0 gates are exported */
> > > > > +#define CLK_APB0_AC97		67
> > > > > +#define CLK_APB0_KEYPAD		74
> > > +
> > > +/* Some APB1 gates are exported */
> > > > > +#define CLK_APB1_CAN		79
> > > > > +#define CLK_APB1_SCR		80
> > > +
> > > +/* Some IP module clocks are exported */
> > > > > +#define CLK_MS			93
> > > > > +#define CLK_TS			106
> > > > > +#define CLK_PATA		111
> > > > > +#define CLK_AC97		115
> > > > > +#define CLK_KEYPAD		117
> > > > > +#define CLK_SATA		118
> > > +
> > > +/* Some DRAM gates are exported */
> > > > > +#define CLK_DRAM_VE		125
> > > > > +#define CLK_DRAM_CSI0		126
> > > > > +#define CLK_DRAM_CSI1		127
> > > > > +#define CLK_DRAM_TS		128
> > > > > +#define CLK_DRAM_TVD		129
> > > > > +#define CLK_DRAM_TVE1		131
> > > > > +#define CLK_DRAM_OUT		132
> > > > > +#define CLK_DRAM_DE_FE1		133
> > > > > +#define CLK_DRAM_DE_FE0		134
> > > > > +#define CLK_DRAM_DE_BE1		136
> > > > > +#define CLK_DRAM_MP		137
> > > > > +#define CLK_DRAM_ACE		138
> > > +
> > > > > +#define CLK_DE_BE1		140
> > > > > +#define CLK_DE_FE0		141
> > > > > +#define CLK_DE_FE1		142
> > > > > +#define CLK_DE_MP		143
> > > > > +#define CLK_TCON1_CH0		145
> > > > > +#define CLK_CSI_SPECIAL		146
> > > > > +#define CLK_TVD			147
> > > > > +#define CLK_TCON0_CH1_SCLK2	148
> > > > > +#define CLK_TCON1_CH1_SCLK2	150
> > > > > +#define CLK_TCON1_CH1		151
> > > > > +#define CLK_CSI0		152
> > > > > +#define CLK_CSI1		153
> > > > > +#define CLK_VE			154
> > > > > +#define CLK_AVS			156
> > > > > +#define CLK_ACE			157
> > > > > +#define CLK_HDMI		158
> > > > > +#define CLK_GPU			159
> > > > > +#define CLK_MBUS		160
> > > > > +#define CLK_HDMI1_SLOW		161
> > > > > +#define CLK_HDMI1_REPEAT	162
> > > > > +#define CLK_OUT_A		163
> > > +#define CLK_OUT_B		164
> > 
> > Is there a reason not to expose these clocks?
> 
> I exposed them on need to have basis. And basically did one-to-one
> conversion from devicetree.

I guess we can still make some pretty good assumptions on what's going
to be needed at some point.

All the mod clocks will be, the bus gates too, the CPU too. All the
internal ones (PLL, AXI, APB, etc) can remain hidden though.

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
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170302/1bf64653/attachment-0001.sig>
