From: dirk.behme@de.bosch.com (Dirk Behme)
Date: Thu, 2 Jun 2016 07:54:28 +0200
Subject: [PATCH/RFC v3 20/22] clk: renesas: r8a7778: Remove obsolete
 r8a7778_clocks_init()
In-Reply-To: <1464808880-343-21-git-send-email-geert+renesas@glider.be>
References: <1464808880-343-1-git-send-email-geert+renesas@glider.be>
 <1464808880-343-21-git-send-email-geert+renesas@glider.be>
Message-ID: <9f19c6e5-54d1-abd8-b666-bdf1a502d9c4@de.bosch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01.06.2016 21:21, Geert Uytterhoeven wrote:
> The R-Car M1A board code no longer calls r8a7778_clocks_init().
>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> v3:
>   - New.
> ---
>  drivers/clk/renesas/clk-r8a7778.c | 13 -------------
>  include/linux/clk/renesas.h       |  1 -
>  2 files changed, 14 deletions(-)
>
> diff --git a/drivers/clk/renesas/clk-r8a7778.c b/drivers/clk/renesas/clk-r8a7778.c
> index 07ea411098a75ad1..886a8380e91247a1 100644
> --- a/drivers/clk/renesas/clk-r8a7778.c
> +++ b/drivers/clk/renesas/clk-r8a7778.c
> @@ -143,16 +143,3 @@ static void __init r8a7778_cpg_clocks_init(struct device_node *np)
>
>  CLK_OF_DECLARE(r8a7778_cpg_clks, "renesas,r8a7778-cpg-clocks",
>  	       r8a7778_cpg_clocks_init);
> -
> -void __init r8a7778_clocks_init(u32 mode)
> -{
> -	BUG_ON(!(mode & BIT(19)));
> -
> -	cpg_mode_rates = (!!(mode & BIT(18)) << 2) |
> -			 (!!(mode & BIT(12)) << 1) |
> -			 (!!(mode & BIT(11)));
> -	cpg_mode_divs = (!!(mode & BIT(2)) << 1) |
> -			(!!(mode & BIT(1)));
> -
> -	of_clk_init(NULL);
> -}


Just a question on how you structured the patches: Is there a special 
reason why you do the adding of new code and the removal of dead code in 
two patches?

Having both in one patch normally makes it more obvious which old code 
is replaced by which new code.

An example: In patch

[PATCH/RFC v3 11/22] clk: renesas: r8a7778: Obtain mode pin values using 
R-Car RST driver

I wondered where the section

+	BUG_ON(!(mode & BIT(19)));
+
+	cpg_mode_rates = (!!(mode & BIT(18)) << 2) |
+			 (!!(mode & BIT(12)) << 1) |
+			 (!!(mode & BIT(11)));
+	cpg_mode_divs = (!!(mode & BIT(2)) << 1) |
+			(!!(mode & BIT(1)));

comes from. This becomes obvious with this patch 20/22. But it's 9 
patches later ;) So why don't make the whole replacement visible in one 
patch?

Best regards

Dirk
