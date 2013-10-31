From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Thu, 31 Oct 2013 09:03:26 +0100
Subject: [PATCH RFC] ARM: dts: imx6qdl: make pinctrl nodes board specific
In-Reply-To: <1382672542-16100-1-git-send-email-shawn.guo@linaro.org>
References: <1382672542-16100-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <20131031080326.GK24559@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 25, 2013 at 11:42:22AM +0800, Shawn Guo wrote:
> Currently, all pinctrl setting nodes are defined in <soc>.dtsi, so that
> boards that share the same pinctrl setting do not have to define it time
> and time again in <board>.dts.  However, along with the devices and use
> cases being added continuously, the pinctrl setting nodes under iomuxc
> becomes more than expected.  This bloats device tree blob for particular
> board unnecessarily since only a small subset of those pinctrl setting
> nodes will be used by the board.  It impacts not only the DTB file size
> but also the run-time device tree lookup efficiency.
> 
> The patch proposes a solution to avoid this device tree bloating problem
> while still keeping boards share the common pinctrl setting data by
> using DTC macro support.  It creates imx6qdl-pingrp.h and move all those
> pinctrl setting data into there as macro definitions.  The <board>.dts
> will instead define the pinctrl setting nodes that are necessary for the
> board by referring to the macros in imx6qdl-pingrp.h, so that only the
> pinctrl setting data that will be used by the board will get compiled
> into the DTB for the board.
> 
> With the changes, the pinctrl setting nodes becomes local to particular
> board, and it makes no sense to continue numbering the setting for
> given peripheral.  Thus, all the pinctrl phandler name gets updated to
> have only peripheral name in there.
> 
> Using imx6q-sabresd.dtb today as example, the change shrinks the file
> from 37KiB to 26KiB.

Nice. Having all these unused nodes in the i.MX DTs concerned me aswell.

> 
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> ---
> Russell,
> 
> With this approach, I will have no concern with adding another full
> group of USDHC pins with only one different from the existing group.
> 
> #define MX6QDL_USDHC1_PINGRP1_DAT3CD \
>         MX6QDL_PAD_SD1_CMD__SD1_CMD    0x17059 \
>         MX6QDL_PAD_SD1_CLK__SD1_CLK    0x10059 \
>         MX6QDL_PAD_SD1_DAT0__SD1_DATA0 0x17059 \
>         MX6QDL_PAD_SD1_DAT1__SD1_DATA1 0x17059 \
>         MX6QDL_PAD_SD1_DAT2__SD1_DATA2 0x17059 \
>         MX6QDL_PAD_SD1_DAT3__SD1_DATA3 0x13059 \
>         MX6QDL_PAD_NANDF_D0__SD1_DATA4 0x17059 \
>         MX6QDL_PAD_NANDF_D1__SD1_DATA5 0x17059 \
>         MX6QDL_PAD_NANDF_D2__SD1_DATA6 0x17059 \
>         MX6QDL_PAD_NANDF_D3__SD1_DATA7 0x17059

What I'm thinking about now for some time is whether I like these
defines. They add another level of indirection and still the pinctrl
settings cannot be adjusted by board dts files.
On the other hand nobody forces us to actually use these defines. If
we realize that these defines are too inconvenient we could easily put
the inidividual pins into the board dts files and remove the defines
later.

So:

Acked-by: Sascha Hauer <s.hauer@pengutronix.de>

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
