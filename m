From: rmallon@gmail.com (Ryan Mallon)
Date: Fri, 30 Sep 2011 22:35:05 +1000
Subject: [PATCH 2/2] ARM: Switch to using CLKDEV_INIT macro for creating
	clk_lookup instance
In-Reply-To: <1317381097-2691-3-git-send-email-padma.v@samsung.com>
References: <1317381097-2691-1-git-send-email-padma.v@samsung.com>
	<1317381097-2691-3-git-send-email-padma.v@samsung.com>
Message-ID: <4E85B779.7030402@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 30/09/11 21:11, Padmavathi Venna wrote:
> Replace platform specific macros that creates struct clk_lookup
> instance with the new common CLKDEV_INIT macro
>
> Suggested by: Russell King <rmk+kernel@arm.linux.org.uk>
> Signed-off-by: Padmavathi Venna <padma.v@samsung.com>
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
>
> diff --git a/arch/arm/mach-davinci/board-dm646x-evm.c b/arch/arm/mach-davinci/board-dm646x-evm.c
> index 993a314..4a30865 100644
> --- a/arch/arm/mach-davinci/board-dm646x-evm.c
> +++ b/arch/arm/mach-davinci/board-dm646x-evm.c
> @@ -24,6 +24,7 @@
>  #include <linux/i2c.h>
>  #include <linux/i2c/at24.h>
>  #include <linux/i2c/pcf857x.h>
> +#include <linux/clkdev.h>
>  
>  #include <media/tvp514x.h>
>  
> @@ -703,8 +704,8 @@ static struct clk cdce_clk_in = {
>  };
>  
>  static struct clk_lookup cdce_clks[] = {
> -	CLK(NULL, "xin", &cdce_clk_in),
> -	CLK(NULL, NULL, NULL),
> +	CLKDEV_INIT(NULL, "xin", cdce_clk_in)
> +	{.dev_id = NULL, .con_id = NULL, .clk = NULL,},

Why not CLKDEV_INIT(NULL, NULL, NULL)? Or create another macro
CLKDEV_NULL (or similar) for the last entry in the list rather than
duplicating this everywhere.

~Ryan
