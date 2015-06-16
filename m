From: khilman@kernel.org (Kevin Hilman)
Date: Tue, 16 Jun 2015 08:02:34 -0700
Subject: [PATCH] clk: mvebu: flag the crypto clk as CLK_IGNORE_UNUSED
In-Reply-To: <1434453721-24070-1-git-send-email-boris.brezillon@free-electrons.com>
 (Boris Brezillon's message of "Tue, 16 Jun 2015 13:22:01 +0200")
References: <1434453721-24070-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <7h381r1yt1.fsf@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Boris Brezillon <boris.brezillon@free-electrons.com> writes:

> Fixes: 29e623475c50267ee3aaa49ebb6cbe107bce8d2a ("clk: mvebu: add
> missing CESA gate clk").

Which was:

Reported-by: Kevin Hilman <khilman@linaro.org>

> The crypto SRAM, used by the armada 370 cpuidle code to workaround a bug
> in the BootROM code, requires the crypto clk to be up and running.
> Flag the the crypto clk as IGNORE_UNUSED until we add the proper
> infrastructure to define the crypto SRAM in the DT and reference the crypto
> clk in this SRAM node.
>
> Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
> Cc: <stable@vger.kernel.org> #4.1

> ---
>  drivers/clk/mvebu/armada-370.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/clk/mvebu/armada-370.c b/drivers/clk/mvebu/armada-370.c
> index c19fd77..7c2a58c 100644
> --- a/drivers/clk/mvebu/armada-370.c
> +++ b/drivers/clk/mvebu/armada-370.c
> @@ -163,7 +163,7 @@ static const struct clk_gating_soc_desc a370_gating_desc[] __initconst = {
>  	{ "pex1", "pex1_en", 9, 0 },
>  	{ "sata0", NULL, 15, 0 },
>  	{ "sdio", NULL, 17, 0 },
> -	{ "crypto", NULL, 23, 0 },
> +	{ "crypto", NULL, 23, CLK_IGNORE_UNUSED }

Doesn't compile.  Needs trailing ','

>  	{ "tdm", NULL, 25, 0 },
>  	{ "ddr", NULL, 28, CLK_IGNORE_UNUSED },
>  	{ "sata1", NULL, 30, 0 },

With that fixed, I tested this on top of next-20150615 where mirabox was
previously broken and I confirm it's now working.

Tested-by: Kevin Hilman <khilman@linaro.org>

Kevin
