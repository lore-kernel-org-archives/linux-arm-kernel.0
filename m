From: khilman@baylibre.com (Kevin Hilman)
Date: Wed, 13 Jun 2018 15:42:28 -0700
Subject: [PATCH] clk: meson-gxbb: set fclk_div2 as CLK_IS_CRITICAL
In-Reply-To: <1528892421-12180-1-git-send-email-narmstrong@baylibre.com> (Neil
 Armstrong's message of "Wed, 13 Jun 2018 14:20:21 +0200")
References: <1528892421-12180-1-git-send-email-narmstrong@baylibre.com>
Message-ID: <7hsh5qwbor.fsf@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Neil Armstrong <narmstrong@baylibre.com> writes:

> On Amlogic Meson GXBB & GXL platforms, the SCPI Cortex-M4 Co-Processor
> seems to be dependent on the FCLK_DIV2 to be operationnal.
>
> The issue occured since v4.17-rc1 by freezing the kernel boot when
> the 'schedutil' cpufreq governor was selected as default :
>
>   [   12.071837] scpi_protocol scpi: SCP Protocol 0.0 Firmware 0.0.0 version
>   domain-0 init dvfs: 4
>   [   12.087757] hctosys: unable to open rtc device (rtc0)
>   [   12.087907] cfg80211: Loading compiled-in X.509 certificates for regulatory database
>   [   12.102241] cfg80211: Loaded X.509 cert 'sforshee: 00b28ddf47aef9cea7'
>
> But when disabling the MMC driver, the boot finished but cpufreq failed to
> change the CPU frequency :
>
>   [   12.153045] cpufreq: __target_index: Failed to change cpu frequency: -5
>
> A bisect between v4.16 and v4.16-rc1 gave the 05f814402d61 commit to be
> the first bad commit.
> This commit added support for the missing clock gates before the fixed PLL
> fixed dividers (FCLK_DIVx) and the clock framework basically disabled
> all the unused fixed dividers, thus disabled a critical clock path for
> the SCPI Co-Processor.
>
> This patch simply sets the FCLK_DIV2 gate as critical to ensure
> nobody can disable it.
>
> Fixes: 05f814402d61 ("clk: meson: add fdiv clock gates")
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>

Nice!  this also fixes the boot hang I had noticed on gxm-nexbox-a1
(though MMC still needs to be disabled to fully boot.)

Tested-by: Kevin Hilman <khilman@baylibre.com>

Kevin

> ---
>  drivers/clk/meson/gxbb.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/clk/meson/gxbb.c b/drivers/clk/meson/gxbb.c
> index b1e4d95..0e053c1 100644
> --- a/drivers/clk/meson/gxbb.c
> +++ b/drivers/clk/meson/gxbb.c
> @@ -511,6 +511,7 @@ static struct clk_regmap gxbb_fclk_div2 = {
>  		.ops = &clk_regmap_gate_ops,
>  		.parent_names = (const char *[]){ "fclk_div2_div" },
>  		.num_parents = 1,
> +		.flags = CLK_IS_CRITICAL,
>  	},
>  };
