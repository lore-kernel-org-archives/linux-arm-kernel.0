From: hjk@hansjkoch.de (Hans J. Koch)
Date: Fri, 30 Sep 2011 13:26:33 +0200
Subject: [PATCH 2/2] ARM: Switch to using CLKDEV_INIT macro for creating
	clk_lookup instance
In-Reply-To: <1317381097-2691-3-git-send-email-padma.v@samsung.com>
References: <1317381097-2691-1-git-send-email-padma.v@samsung.com>
	<1317381097-2691-3-git-send-email-padma.v@samsung.com>
Message-ID: <20110930112633.GB9046@local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 30, 2011 at 04:41:37PM +0530, Padmavathi Venna wrote:
> Replace platform specific macros that creates struct clk_lookup
> instance with the new common CLKDEV_INIT macro

Well, for mach-tcc8k, it only saves 7 lines, but it's surely a good idea to
have one common macro for all arm subarchs.

> 
> Suggested by: Russell King <rmk+kernel@arm.linux.org.uk>
> Signed-off-by: Padmavathi Venna <padma.v@samsung.com>

For the tcc8k part:

Acked-by: "Hans J. Koch" <hjk@hansjkoch.de>

> ---
>  arch/arm/mach-davinci/board-dm646x-evm.c |    5 +-
>  arch/arm/mach-davinci/clock.h            |    7 --
>  arch/arm/mach-davinci/da830.c            |  101 +++++++++++----------
>  arch/arm/mach-davinci/da850.c            |   95 ++++++++++----------
>  arch/arm/mach-davinci/dm355.c            |   86 +++++++++---------
>  arch/arm/mach-davinci/dm365.c            |  112 ++++++++++++------------
>  arch/arm/mach-davinci/dm644x.c           |   77 ++++++++--------
>  arch/arm/mach-davinci/dm646x.c           |   81 +++++++++--------
>  arch/arm/mach-davinci/tnetv107x.c        |  134 ++++++++++++++--------------
>  arch/arm/mach-ep93xx/clock.c             |   61 ++++++-------
>  arch/arm/mach-imx/clock-imx1.c           |   38 ++++-----
>  arch/arm/mach-imx/clock-imx21.c          |   91 +++++++++----------
>  arch/arm/mach-imx/clock-imx25.c          |   77 +++++++---------
>  arch/arm/mach-imx/clock-imx27.c          |  111 +++++++++++------------
>  arch/arm/mach-imx/clock-imx31.c          |  103 ++++++++++-----------
>  arch/arm/mach-imx/clock-imx35.c          |  117 +++++++++++-------------
>  arch/arm/mach-lpc32xx/clock.c            |   75 +++++++---------
>  arch/arm/mach-mx5/clock-mx51-mx53.c      |  145 ++++++++++++++----------------
>  arch/arm/mach-mxs/clock-mx23.c           |   39 ++++-----
>  arch/arm/mach-mxs/clock-mx28.c           |   67 ++++++--------
>  arch/arm/mach-tcc8k/clock.c              |  107 ++++++++++------------
>  21 files changed, 825 insertions(+), 904 deletions(-)

[...]

> diff --git a/arch/arm/mach-tcc8k/clock.c b/arch/arm/mach-tcc8k/clock.c
> index e7cdae5..086a9b4 100644
> --- a/arch/arm/mach-tcc8k/clock.c
> +++ b/arch/arm/mach-tcc8k/clock.c
> @@ -468,64 +468,57 @@ DEFINE_BCLOCK(gdma2, BCLKCTR1, 17, NULL, NULL)
>  DEFINE_BCLOCK(gdma3, BCLKCTR1, 18, NULL, NULL)
>  DEFINE_BCLOCK(ddrc, BCLKCTR1, 19, NULL, NULL)
>  
> -#define _REGISTER_CLOCK(d, n, c) \
> -	{ \
> -		.dev_id = d, \
> -		.con_id = n, \
> -		.clk = &c, \
> -	},
> -
>  static struct clk_lookup lookups[] = {
> -	_REGISTER_CLOCK(NULL, "bus", bus)
> -	_REGISTER_CLOCK(NULL, "cpu", cpu)
> -	_REGISTER_CLOCK(NULL, "tct", tct)
> -	_REGISTER_CLOCK(NULL, "tcx", tcx)
> -	_REGISTER_CLOCK(NULL, "tcz", tcz)
> -	_REGISTER_CLOCK(NULL, "ref", ref)
> -	_REGISTER_CLOCK(NULL, "dai0", dai0)
> -	_REGISTER_CLOCK(NULL, "pic", pic)
> -	_REGISTER_CLOCK(NULL, "tc", tc)
> -	_REGISTER_CLOCK(NULL, "gpio", gpio)
> -	_REGISTER_CLOCK(NULL, "usbd", usbd)
> -	_REGISTER_CLOCK("tcc-uart.0", NULL, uart0)
> -	_REGISTER_CLOCK("tcc-uart.2", NULL, uart2)
> -	_REGISTER_CLOCK("tcc-i2c", NULL, i2c)
> -	_REGISTER_CLOCK("tcc-uart.3", NULL, uart3)
> -	_REGISTER_CLOCK(NULL, "ecc", ecc)
> -	_REGISTER_CLOCK(NULL, "adc", adc)
> -	_REGISTER_CLOCK("tcc-usbh.0", "usb", usbh0)
> -	_REGISTER_CLOCK(NULL, "gdma0", gdma0)
> -	_REGISTER_CLOCK(NULL, "lcd", lcd)
> -	_REGISTER_CLOCK(NULL, "rtc", rtc)
> -	_REGISTER_CLOCK(NULL, "nfc", nfc)
> -	_REGISTER_CLOCK("tcc-mmc.0", NULL, sd0)
> -	_REGISTER_CLOCK(NULL, "g2d", g2d)
> -	_REGISTER_CLOCK(NULL, "gdma1", gdma1)
> -	_REGISTER_CLOCK("tcc-uart.1", NULL, uart1)
> -	_REGISTER_CLOCK("tcc-spi.0", NULL, spi0)
> -	_REGISTER_CLOCK(NULL, "mscl", mscl)
> -	_REGISTER_CLOCK("tcc-spi.1", NULL, spi1)
> -	_REGISTER_CLOCK(NULL, "bdma", bdma)
> -	_REGISTER_CLOCK(NULL, "adma0", adma0)
> -	_REGISTER_CLOCK(NULL, "spdif", spdif)
> -	_REGISTER_CLOCK(NULL, "scfg", scfg)
> -	_REGISTER_CLOCK(NULL, "cid", cid)
> -	_REGISTER_CLOCK("tcc-mmc.1", NULL, sd1)
> -	_REGISTER_CLOCK("tcc-uart.4", NULL, uart4)
> -	_REGISTER_CLOCK(NULL, "dai1", dai1)
> -	_REGISTER_CLOCK(NULL, "adma1", adma1)
> -	_REGISTER_CLOCK(NULL, "c3dec", c3dec)
> -	_REGISTER_CLOCK("tcc-can.0", NULL, can0)
> -	_REGISTER_CLOCK("tcc-can.1", NULL, can1)
> -	_REGISTER_CLOCK(NULL, "gps", gps)
> -	_REGISTER_CLOCK("tcc-gsb.0", NULL, gsb0)
> -	_REGISTER_CLOCK("tcc-gsb.1", NULL, gsb1)
> -	_REGISTER_CLOCK("tcc-gsb.2", NULL, gsb2)
> -	_REGISTER_CLOCK("tcc-gsb.3", NULL, gsb3)
> -	_REGISTER_CLOCK(NULL, "gdma2", gdma2)
> -	_REGISTER_CLOCK(NULL, "gdma3", gdma3)
> -	_REGISTER_CLOCK(NULL, "ddrc", ddrc)
> -	_REGISTER_CLOCK("tcc-usbh.1", "usb", usbh1)
> +	CLKDEV_INIT(NULL, "bus", bus)
> +	CLKDEV_INIT(NULL, "cpu", cpu)
> +	CLKDEV_INIT(NULL, "tct", tct)
> +	CLKDEV_INIT(NULL, "tcx", tcx)
> +	CLKDEV_INIT(NULL, "tcz", tcz)
> +	CLKDEV_INIT(NULL, "ref", ref)
> +	CLKDEV_INIT(NULL, "dai0", dai0)
> +	CLKDEV_INIT(NULL, "pic", pic)
> +	CLKDEV_INIT(NULL, "tc", tc)
> +	CLKDEV_INIT(NULL, "gpio", gpio)
> +	CLKDEV_INIT(NULL, "usbd", usbd)
> +	CLKDEV_INIT("tcc-uart.0", NULL, uart0)
> +	CLKDEV_INIT("tcc-uart.2", NULL, uart2)
> +	CLKDEV_INIT("tcc-i2c", NULL, i2c)
> +	CLKDEV_INIT("tcc-uart.3", NULL, uart3)
> +	CLKDEV_INIT(NULL, "ecc", ecc)
> +	CLKDEV_INIT(NULL, "adc", adc)
> +	CLKDEV_INIT("tcc-usbh.0", "usb", usbh0)
> +	CLKDEV_INIT(NULL, "gdma0", gdma0)
> +	CLKDEV_INIT(NULL, "lcd", lcd)
> +	CLKDEV_INIT(NULL, "rtc", rtc)
> +	CLKDEV_INIT(NULL, "nfc", nfc)
> +	CLKDEV_INIT("tcc-mmc.0", NULL, sd0)
> +	CLKDEV_INIT(NULL, "g2d", g2d)
> +	CLKDEV_INIT(NULL, "gdma1", gdma1)
> +	CLKDEV_INIT("tcc-uart.1", NULL, uart1)
> +	CLKDEV_INIT("tcc-spi.0", NULL, spi0)
> +	CLKDEV_INIT(NULL, "mscl", mscl)
> +	CLKDEV_INIT("tcc-spi.1", NULL, spi1)
> +	CLKDEV_INIT(NULL, "bdma", bdma)
> +	CLKDEV_INIT(NULL, "adma0", adma0)
> +	CLKDEV_INIT(NULL, "spdif", spdif)
> +	CLKDEV_INIT(NULL, "scfg", scfg)
> +	CLKDEV_INIT(NULL, "cid", cid)
> +	CLKDEV_INIT("tcc-mmc.1", NULL, sd1)
> +	CLKDEV_INIT("tcc-uart.4", NULL, uart4)
> +	CLKDEV_INIT(NULL, "dai1", dai1)
> +	CLKDEV_INIT(NULL, "adma1", adma1)
> +	CLKDEV_INIT(NULL, "c3dec", c3dec)
> +	CLKDEV_INIT("tcc-can.0", NULL, can0)
> +	CLKDEV_INIT("tcc-can.1", NULL, can1)
> +	CLKDEV_INIT(NULL, "gps", gps)
> +	CLKDEV_INIT("tcc-gsb.0", NULL, gsb0)
> +	CLKDEV_INIT("tcc-gsb.1", NULL, gsb1)
> +	CLKDEV_INIT("tcc-gsb.2", NULL, gsb2)
> +	CLKDEV_INIT("tcc-gsb.3", NULL, gsb3)
> +	CLKDEV_INIT(NULL, "gdma2", gdma2)
> +	CLKDEV_INIT(NULL, "gdma3", gdma3)
> +	CLKDEV_INIT(NULL, "ddrc", ddrc)
> +	CLKDEV_INIT("tcc-usbh.1", "usb", usbh1)
>  };
>  
>  static struct clk *root_clk_by_index(enum root_clks src)
> -- 
> 1.7.4.4
> 
> 
