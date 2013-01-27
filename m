From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Sun, 27 Jan 2013 11:52:41 +0100
Subject: [PATCH v2 1/2] ARM: kirkwood: Ensure that kirkwood_ge0[01]_init()
 finds its clock
In-Reply-To: <1359283223-23082-2-git-send-email-gmbnomis@gmail.com>
References: <1359283223-23082-1-git-send-email-gmbnomis@gmail.com>
 <1359283223-23082-2-git-send-email-gmbnomis@gmail.com>
Message-ID: <510506F9.3070500@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/27/2013 11:40 AM, Simon Baatz wrote:
> Commit 1611f87 (ARM: Kirkwood: switch to DT clock providers) broke the
> functions to initialize the ethernet interfaces (kirkwood_ge00_init() and
> kirkwood_ge01_init()).  In the DT case, the functions could not enable the
> correct clocks.
>
> Fix this by looking up the clocks through the device name.
>
> Signed-off-by: Simon Baatz<gmbnomis@gmail.com>
> ---
>   arch/arm/mach-kirkwood/common.c |   13 +++++++++----
>   1 file changed, 9 insertions(+), 4 deletions(-)
>
> diff --git a/arch/arm/mach-kirkwood/common.c b/arch/arm/mach-kirkwood/common.c
> index bac21a5..2c97847 100644
> --- a/arch/arm/mach-kirkwood/common.c
> +++ b/arch/arm/mach-kirkwood/common.c
> ...
>   	tclk = clk_register_fixed_rate(NULL, "tclk", NULL,
> @@ -288,12 +287,15 @@ void __init kirkwood_ehci_init(void)
>    ****************************************************************************/
>   void __init kirkwood_ge00_init(struct mv643xx_eth_platform_data *eth_data)
>   {
> +	struct clk *ge0;
>   	orion_ge00_init(eth_data,
>   			GE00_PHYS_BASE, IRQ_KIRKWOOD_GE00_SUM,
>   			IRQ_KIRKWOOD_GE00_ERR, 1600);
>   	/* The interface forgets the MAC address assigned by u-boot if
>   	the clock is turned off, so claim the clk now. */
> -	clk_prepare_enable(ge0);
> +	ge0 = clk_get_sys(MV643XX_ETH_NAME ".0", NULL);
> +	if (!IS_ERR(ge0))
> +		clk_prepare_enable(ge0);
>   }

Simon,

Jason posted a patch set that makes mv643xx DT compatible. IMHO this
patch is obsolete when we have DT support for mv643xx.
kirkwood_ge00/01_init will not be called with DT support at all.

I agree that loosing the MAC address _is_ an issue but there must
be another way to retain it during gated ge clocks than not gate the
clocks at all.

I can think of some ways to retain it but don't know what is the most
common with linux:
- make u-boot pass it through cmdline and let mv643xx get it from there
- have kirkwood's common code grab it before clk gates kick in

I will do some tests on dove if it also suffers from loosing it's MAC
on gated clock.

Sebastian
