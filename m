From: sboyd@codeaurora.org (Stephen Boyd)
Date: Fri, 15 May 2015 11:30:29 -0700
Subject: [PATCH 1/2 V3] clk: sirf: add CSR atlas7 clk and reset support
In-Reply-To: <1431675587-8637-1-git-send-email-21cnbao@gmail.com>
References: <1431675587-8637-1-git-send-email-21cnbao@gmail.com>
Message-ID: <20150515183029.GL31753@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/15, Barry Song wrote:
> From: Zhiwu Song <Zhiwu.Song@csr.com>
> 
> the hardware node includes both clock and reset support, so it
> is named as "car".
> this patch implements Flexible clocks(mux, divider, gate), Selectable
> clock(mux, divider, gate), root clock(gate),leaf clock(gate), others.
> it also implements the reset controller functionality.
> 
> Signed-off-by: Zhiwu Song <Zhiwu.Song@csr.com>
> Signed-off-by: Guo Zeng <Guo.Zeng@csr.com>
> Signed-off-by: Barry Song <Baohua.Song@csr.com>
> ---

Still a bunch of checkpatch warnings (dismissing the 80 char
limit). Please fix them.

WARNING: static const char * array should probably be static const char * const
#721: FILE: drivers/clk/sirf/clk-atlas7.c:618:
+static const char *disp1dto_clk_parents[] = {

WARNING: __initdata should be placed after divider_list[]
#742: FILE: drivers/clk/sirf/clk-atlas7.c:639:
+static __initdata struct atlas7_div_init_data divider_list[] = {

WARNING: static const char * array should probably be static const char * const
#1052: FILE: drivers/clk/sirf/clk-atlas7.c:949:
+static const char *sdr_clk_parents[] = {

WARNING: static const char * array should probably be static const char * const
#1063: FILE: drivers/clk/sirf/clk-atlas7.c:960:
+static const char *vip_clk_parents[] = {

WARNING: __initdata should be placed after mux_list[]
#1107: FILE: drivers/clk/sirf/clk-atlas7.c:1004:
+static __initdata struct atlas7_mux_init_data mux_list[] = {

WARNING: __initdata should be placed after unit_list[]
#1142: FILE: drivers/clk/sirf/clk-atlas7.c:1039:
+static __initdata struct atlas7_unit_init_data unit_list[] = {

ERROR: space prohibited before that ',' (ctx:WxW)
#1145: FILE: drivers/clk/sirf/clk-atlas7.c:1042:
+	{1 , "gnssm_gnss", "gnss_mux", 0, SIRFSOC_CLKC_ROOT_CLK_EN0_SET, 1, &root0_gate_lock},
 	   ^

ERROR: space prohibited before that ',' (ctx:WxW)

And many more...

>  .../devicetree/bindings/clock/csr,atlas7-car.txt   |   55 +
>  drivers/clk/sirf/Makefile                          |    2 +-
>  drivers/clk/sirf/clk-atlas7.c                      | 1635 ++++++++++++++++++++
>  3 files changed, 1691 insertions(+), 1 deletion(-)
>  create mode 100644 Documentation/devicetree/bindings/clock/csr,atlas7-car.txt
>  create mode 100644 drivers/clk/sirf/clk-atlas7.c
> diff --git a/drivers/clk/sirf/clk-atlas7.c b/drivers/clk/sirf/clk-atlas7.c
> new file mode 100644
> index 0000000..970239b
> --- /dev/null
> +++ b/drivers/clk/sirf/clk-atlas7.c
> @@ -0,0 +1,1635 @@
> +/*
> + * Clock tree for CSR SiRFAtlas7
> + *
> + * Copyright (c) 2014 Cambridge Silicon Radio Limited, a CSR plc group company.
> + *
> + * Licensed under GPLv2 or later.
> + */
> +
> +#include <linux/bitops.h>
> +#include <linux/io.h>
> +#include <linux/clk.h>

Do you need this include?

> +#include <linux/clk-provider.h>
> +#include <linux/delay.h>
> +#include <linux/of_address.h>
> +#include <linux/reset-controller.h>
> +#include <linux/syscore_ops.h>

Unused include?

> +#include <linux/slab.h>
> +
> +
> +static struct clk_ops ab_pll_ops = {

const?

> +	.recalc_rate = pll_clk_recalc_rate,
> +};

[...]
> +
> +
> +CLK_OF_DECLARE(atlas7_clk, "sirf,atlas7-car", atlas7_clk_init);
> 

I'm also curious if we actually need to use CLK_OF_DECLARE here
or if could we use a platform device.

Even if we need to use CLK_OF_DECLARE because some timer or other
early device needs a clock, I wonder if we shouldn't also make
these things into real platform drivers that register the other
clocks that aren't necessary for the early boot process.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
