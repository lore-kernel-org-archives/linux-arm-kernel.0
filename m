From: wens@csie.org (Chen-Yu Tsai)
Date: Fri, 18 Nov 2016 21:19:41 +0800
Subject: [PATCH] clk: sunxi-ng: enable so-said LDOs for A33 SoC's pll-mipi
 clock
In-Reply-To: <20161117164954.62658-1-icenowy@aosc.xyz>
References: <20161117164954.62658-1-icenowy@aosc.xyz>
Message-ID: <CAGb2v67R5=4JAcvzxrYK5YR5cWpwhTJMpviVNQtriYjHScrYNg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 18, 2016 at 12:49 AM, Icenowy Zheng <icenowy@aosc.xyz> wrote:
> In the user manual of A33 SoC, the bit 22 and 23 of pll-mipi control
> register is called "LDO{1,2}_EN", and according to the BSP source code
> from Allwinner [1], the LDOs are enabled during the clock's enabling
> process.
>
> The clock failed to generate output if the two LDOs are not enabled.
>
> Add the two bits to the clock's gate bits, so that the LDOs are enabled
> when the PLL is enabled.
>
> [1] https://github.com/allwinner-zh/linux-3.4-sunxi/blob/master/drivers/clk/sunxi/clk-sun8iw5.c#L429
>
> Fixes: d05c748bd730 ("clk: sunxi-ng: Add A33 CCU support")
>

You don't need the extra line.

> Signed-off-by: Icenowy Zheng <icenowy@aosc.xyz>

Acked-by: Chen-Yu Tsai <wens@csie.org>

> ---
> Dear Chen-Yu:
> As you said, the two bits are also present in the CCU of A23 and A31.
> Could you please check whether the PLL works on the two SoCs?
> I remembered you mentioned you failed to make TCON enabled on A23.
> On A31, you may hack the parent of tcon-ch0 to force the tcon clock to
> use pll-mipi as parent, in order to check whether the pll works.
>
> However, I didn't found the code that enables the LDOs in the BSP A23/31
> sources, so you must test them to ensure whether the code is needed for
> these SoCs.

I tested out this for both the A31 and the A23. It fixes issues I've
had with DRM. I'll send patches for them.

ChenYu

> Regards,
> Icenowy
>  drivers/clk/sunxi-ng/ccu-sun8i-a33.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/clk/sunxi-ng/ccu-sun8i-a33.c b/drivers/clk/sunxi-ng/ccu-sun8i-a33.c
> index 96b40ca..9bd1f78 100644
> --- a/drivers/clk/sunxi-ng/ccu-sun8i-a33.c
> +++ b/drivers/clk/sunxi-ng/ccu-sun8i-a33.c
> @@ -131,7 +131,7 @@ static SUNXI_CCU_NKM_WITH_GATE_LOCK(pll_mipi_clk, "pll-mipi",
>                                     8, 4,               /* N */
>                                     4, 2,               /* K */
>                                     0, 4,               /* M */
> -                                   BIT(31),            /* gate */
> +                                   BIT(31) | BIT(23) | BIT(22), /* gate */
>                                     BIT(28),            /* lock */
>                                     CLK_SET_RATE_UNGATE);
>
> --
> 2.10.1
>
