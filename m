From: phorton@bitbox.co.uk (Peter Horton)
Date: Wed, 15 Dec 2010 16:12:50 +0000
Subject: [PATCH] i.MX51: Full iomux support
In-Reply-To: <1292421691-14615-1-git-send-email-s.hauer@pengutronix.de>
References: <1292421691-14615-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <4D08E902.80308@bitbox.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 15/12/2010 14:01, Sascha Hauer wrote:
>
> The following series picks up the patch from Lothar Wa?mann replacing
> the struct pad_desc with a 64bit variable and adds full i.MX51 iomux
> support based on this patch.
> The iomux configurations are taken from the Freescale pinmux tool, so the
> definitions should be rather complete. Anyway, there are some modes
> not present in the tool.
> I took the padmux settings from the old iomux support where present.
> This series was tested on the babbage board, but due to the mass of defines
> they are of course not completely tested, so please test yourself if
> your board still works.
>

I had just started implementing an alternative solution :(

MACROS
======

#define _MX51_PAD_DEF(mux, pad)	.mux_ctrl_ofs = (mux), .pad_ctrl_ofs = (pad)
#define _MX51_SIG_DEF(sel)	.select_input_ofs = (sel)
#define _MX51_MAP_DEF(mux, sel)	.mux_mode = (mux), .select_input = (sel)
#define _MX51_CTL_DEF(ctl)	.pad_ctrl = (ctl)

/* pad definitions */

...
#define _MX51_PAD_EIM_D25		_MX51_PAD_DEF(0x414, 0x080)
...

/* signal definitions */

...
#define _MX51_SIG_UART3_RXD		_MX51_SIG_DEF(0x9f4)
...

/* pad to signal mappings */

...
#define _MX51_MAP_EIM_D25__UART3_RXD	_MX51_MAP_DEF(3, 0)
...

/* default pad control settings */

...
#define _MX51_CTL_EIM_D25__UART3_RXD	_MX51_CTL_DEF(MX51_UART3_PAD_CTRL)
...

/* external macros */

#define MX51_PAD(pad, sig) \
	{ _MX51_PAD_##pad, _MX51_SIG_##sig, _MX51_MAP_##pad##__##sig, 
_MX51_CTL_##pad##__##sig }

#define MX51_PAD_CTL(pad, sig, ctl) \
	{ _MX51_PAD_##pad, _MX51_SIG_##sig, _MX51_MAP_##pad##__##sig, 
_MX51_CTL_DEF(ctl) }

USAGE
=====

/* using the default pad control value */

static iomux_v3_cfg_t board_pads[] = {
	...
	MX51_PAD(EIM_D25, UART3_RXD),
	...
};

/* specifying a pad control value */

static iomux_v3_cfg_t board_pads[] = {
	...
	MX51_PAD_CTL(EIM_D25, UART3_RXD, PAD_CTL_DSE_HIGH),
	...
};
