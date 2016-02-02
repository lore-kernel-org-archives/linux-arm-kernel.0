From: sboyd@codeaurora.org (Stephen Boyd)
Date: Mon, 1 Feb 2016 17:15:45 -0800
Subject: [PATCH] clk: vt8500: don't return possibly uninitialized data
In-Reply-To: <4790407.6zgSQCdsSB@wuerfel>
References: <4790407.6zgSQCdsSB@wuerfel>
Message-ID: <20160202011545.GG4848@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/01, Arnd Bergmann wrote:
> The clk-vt8500.c driver would previously enter an endless loop
> when invalid settings got requested, this was now fixed. However,
> the driver will now return uninitialized data for a subset of those
> cases instead, as the gcc correctly warns:
> 
> clk/clk-vt8500.c: In function 'wm8650_find_pll_bits':
> clk/clk-vt8500.c:423:12: error: 'best_div2' may be used uninitialized in this function [-Werror=maybe-uninitialized]
>   *divisor2 = best_div2;
>             ^
> clk/clk-vt8500.c:422:12: error: 'best_div1' may be used uninitialized in this function [-Werror=maybe-uninitialized]
>   *divisor1 = best_div1;
>             ^
> clk/clk-vt8500.c:421:14: error: 'best_mul' may be used uninitialized in this function [-Werror=maybe-uninitialized]
>   *multiplier = best_mul;
> 
> This reworks the error handling in the driver so we now return
> -EINVAL from clk_round_rate() and clk_set_rate() when we get
> impossible inputs.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Fixes: 090341b0a95d ("clk: vt8500: fix sign of possible PLL values")

My compiler still gets warnings even after this patch is applied.

drivers/clk/clk-vt8500.c: In function ?wm8750_find_pll_bits?:
drivers/clk/clk-vt8500.c:509:12: warning: ?best_div2? may be used uninitialized in this function [-Wmaybe-uninitialized]
drivers/clk/clk-vt8500.c:508:12: warning: ?best_div1? may be used uninitialized in this function [-Wmaybe-uninitialized]
drivers/clk/clk-vt8500.c:507:14: warning: ?best_mul? may be used uninitialized in this function [-Wmaybe-uninitialized]
drivers/clk/clk-vt8500.c: In function ?wm8650_find_pll_bits?:
drivers/clk/clk-vt8500.c:430:12: warning: ?best_div2? may be used uninitialized in this function [-Wmaybe-uninitialized]
drivers/clk/clk-vt8500.c:429:12: warning: ?best_div1? may be used uninitialized in this function [-Wmaybe-uninitialized]
drivers/clk/clk-vt8500.c:428:14: warning: ?best_mul? may be used uninitialized in this function [-Wmaybe-uninitialized]
drivers/clk/clk-vt8500.c: In function ?wm8850_find_pll_bits?:
drivers/clk/clk-vt8500.c:560:12: warning: ?best_div2? may be used uninitialized in this function [-Wmaybe-uninitialized]
drivers/clk/clk-vt8500.c:559:12: warning: ?best_div1? may be used uninitialized in this function [-Wmaybe-uninitialized]
drivers/clk/clk-vt8500.c:558:14: warning: ?best_mul? may be used uninitialized in this function [-Wmaybe-uninitialized]

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
