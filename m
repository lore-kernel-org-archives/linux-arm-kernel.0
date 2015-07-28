From: sboyd@codeaurora.org (Stephen Boyd)
Date: Tue, 28 Jul 2015 15:07:30 -0700
Subject: [PATCH 5/7] clk: atlas7: fix the clock tree for bluetooth stuff
In-Reply-To: <1438064845-17894-6-git-send-email-21cnbao@gmail.com>
References: <1438064845-17894-1-git-send-email-21cnbao@gmail.com>
 <1438064845-17894-6-git-send-email-21cnbao@gmail.com>
Message-ID: <55B7FD22.10609@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/27/2015 11:27 PM, Barry Song wrote:
> From: Guo Zeng <guo.zeng@csr.com>
>
> normally dmac should depends on only one clock, to operate
> dmac internal register, but dmac4 is very special case, it
> normally dmac should depends on only one clock, to operate
> dmac internal register, but dmac4 is very special case, it

The sentence is duplicated twice here

> depends on two additional clock, the reason is that dmac4
> is wrapped in hw into bt a7ca module, and accessing dmac4
> internal register would also require that the a7ca_io and
> related bt macro io clk also enabled.
> here workaround this by setting depend clk into parent of
> dmac4, and also related clks, to reflect dependency.

We don't put clocks as parents of other clocks just because the child
depends on the parent to be accessed. It isn't very clear from the
description, but it sounds like a7ca_io is just another clock that the
bluetooth driver needs to control? We want to express the true clk
hierarchy, not some psuedo dependency tree.

> noc_io
>     -btm_noc_clk
>             -a7ca_io
>                     -dmac4_io
>                                     -uart6_io
>                                     -usp3_io
>
> Signed-off-by: Guo Zeng <guo.zeng@csr.com>
> Signed-off-by: Barry Song <Baohua.Song@csr.com>
> ---
>  drivers/clk/sirf/clk-atlas7.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/clk/sirf/clk-atlas7.c b/drivers/clk/sirf/clk-atlas7.c
> index 1000421..c1788df 100644
> --- a/drivers/clk/sirf/clk-atlas7.c
> +++ b/drivers/clk/sirf/clk-atlas7.c
> @@ -1169,10 +1169,10 @@ static struct atlas7_unit_init_data unit_list[] __initdata = {
>  	{ 127, "vss_sdr", "gpum_sdr", 0, SIRFSOC_CLKC_LEAF_CLK_EN7_SET, 1, &leaf7_gate_lock },
>  	{ 128, "thgpum_nocr", "gpum_nocr", 0, SIRFSOC_CLKC_LEAF_CLK_EN7_SET, 2, &leaf7_gate_lock },
>  	{ 129, "a7ca_btss", "btm_btss", 0, SIRFSOC_CLKC_LEAF_CLK_EN8_SET, 1, &leaf8_gate_lock },
> -	{ 130, "dmac4_io", "btm_io", 0, SIRFSOC_CLKC_LEAF_CLK_EN8_SET, 2, &leaf8_gate_lock },
> -	{ 131, "uart6_io", "btm_io", 0, SIRFSOC_CLKC_LEAF_CLK_EN8_SET, 3, &leaf8_gate_lock },
> -	{ 132, "usp3_io", "btm_io", 0, SIRFSOC_CLKC_LEAF_CLK_EN8_SET, 4, &leaf8_gate_lock },
> -	{ 133, "a7ca_io", "btm_io", 0, SIRFSOC_CLKC_LEAF_CLK_EN8_SET, 5, &leaf8_gate_lock },
> +	{ 130 , "dmac4_io", "a7ca_io", 0, SIRFSOC_CLKC_LEAF_CLK_EN8_SET, 2, &leaf8_gate_lock },
> +	{ 131 , "uart6_io", "dmac4_io", 0, SIRFSOC_CLKC_LEAF_CLK_EN8_SET, 3, &leaf8_gate_lock },
> +	{ 132 , "usp3_io", "dmac4_io", 0, SIRFSOC_CLKC_LEAF_CLK_EN8_SET, 4, &leaf8_gate_lock },
> +	{ 133 , "a7ca_io", "noc_btm_io", 0, SIRFSOC_CLKC_LEAF_CLK_EN8_SET, 5, &leaf8_gate_lock },
>  	{ 134, "noc_btm_io", "btm_io", 0, SIRFSOC_CLKC_LEAF_CLK_EN8_SET, 6, &leaf8_gate_lock },
>  	{ 135, "thbtm_io", "btm_io", 0, SIRFSOC_CLKC_LEAF_CLK_EN8_SET, 7, &leaf8_gate_lock },
>  	{ 136, "btslow", "xinw_fixdiv_btslow", 0, SIRFSOC_CLKC_ROOT_CLK_EN1_SET, 25, &root1_gate_lock },


-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
