From: andrew@lunn.ch (Andrew Lunn)
Date: Fri, 9 Mar 2012 08:57:20 +0100
Subject: [PATCH v5 3/4] clk: introduce the common clock framework
In-Reply-To: <20120308232549.GU3852@pengutronix.de>
References: <20120303133158.GA26882@pengutronix.de>
 <CAJOA=zNFNEHxBDhRDdvm7DYR83R0LJjsp_AT3BoG+nL+iN5_tw@mail.gmail.com>
 <20120304115201.GB26882@pengutronix.de>
 <CAJOA=zP8d8wm==7=svOzh03Ft-1_LV71q0mA6Pncrh5vQSWGEA@mail.gmail.com>
 <20120305073836.GU3852@pengutronix.de>
 <CAJOA=zMs75ZQ24g5PXpSLV3AJzWEo12g86G8+4+ryQR_cTYpzA@mail.gmail.com>
 <20120306190039.GJ3852@pengutronix.de>
 <CAJOA=zOG_6eSWPEfFL6VKWeTpGKD9y11xeHoOwdS3b59tAZ45A@mail.gmail.com>
 <20120308062739.GE18513@lunn.ch>
 <20120308232549.GU3852@pengutronix.de>
Message-ID: <20120309075720.GC16608@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> I'd say use the nonstatic ones. I think using the static initializers
> will cause us much pain in the future. I've been through several rebases
> on the i.MX clock rework and everytime I wish my sed foo would be
> better. Now imagine what happens when it turns out that the internal
> struct clk layout or the structs for the muxes/dividers/gates have to
> be changed.

/*****************************************************************************
 * CLK tree
 ****************************************************************************/
static DEFINE_SPINLOCK(gating_lock);

#define DEFINE_KIRKWOOD_CLK_GATE(_name, _bit)                           \
        DEFINE_CLK_GATE(_name, "tclk", NULL, 0,                         \
                        (void __iomem *)CLOCK_GATING_CTRL,              \
                        _bit, 0, &gating_lock)

DEFINE_KIRKWOOD_CLK_GATE(clk_ge0,    CGC_BIT_GE0);
DEFINE_KIRKWOOD_CLK_GATE(clk_pex0,   CGC_BIT_PEX0);
DEFINE_KIRKWOOD_CLK_GATE(clk_usb0,   CGC_BIT_USB0);
DEFINE_KIRKWOOD_CLK_GATE(clk_sdio,   CGC_BIT_SDIO);
DEFINE_KIRKWOOD_CLK_GATE(clk_tsu,    CGC_BIT_TSU);
DEFINE_KIRKWOOD_CLK_GATE(clk_dunit,  CGC_BIT_DUNIT);
DEFINE_KIRKWOOD_CLK_GATE(clk_runit,  CGC_BIT_RUNIT);

I've so far not had any problems, and not needed an sed foo.  I do
only have a dozen or so clocks, which helps. But even so, all the real
pain is hidden inside DEFINE_CLK_GATE() which Mike maintains.

I guess the problem comes when you are not using the basic clk
providers, but your own provider. What might help is if
linux/clk-provider.h could provide some macros to do most of the
generic definitions. Something like:

#define DEFINE_CLK_GENERIC(_name, _flags, _ops)                 \
        static struct clk _name;                                \
        static char *_name##_parent_names[] = {};               \
        static struct clk _name = {                             \
                .name = #_name,                                 \
                .ops = &_ops,                                   \
                .hw = &_name##_hw.hw,                           \
                .parent_names = _name##_parent_names,           \
                .num_parents =                                  \
                        ARRAY_SIZE(_name##_parent_names),       \
                .flags = _flags,                                \
        };

and then you have something like

#define DEFINE_CLK_IMX(_name, _flags, _foo, _bar)               \
        static struct clk_imx _name##_hw = {                    \
                .hw = {                                         \
                        .clk = &_name,                          \
                },                                              \
                .foo = _foo,                                    \
                .bar = _bar,                                    \
        };                                                      \
	DEFINE_CLK_GENERIC(_name, _flags, clk_imx_ops)           

	Andrew
