From: carlo@caione.org (Carlo Caione)
Date: Fri, 29 May 2015 19:56:20 +0200
Subject: [PATCH v2 3/3] clk: meson8b: Add support for Meson8b clocks
In-Reply-To: <20150528220100.GE24204@codeaurora.org>
References: <1431773333-23567-1-git-send-email-carlo@caione.org>
 <1431773333-23567-4-git-send-email-carlo@caione.org>
 <20150528220100.GE24204@codeaurora.org>
Message-ID: <CAOQ7t2anBhNOTbxN7niDFB5UBDStKLb8oS+Xkmp3jxHifJVJiw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 29, 2015 at 12:01 AM, Stephen Boyd <sboyd@codeaurora.org> wrote:
>> + */
>> +
>> +#include <linux/clk.h>
>
> Do you need this include?

I guess I have to revise all the includes :)

>> +#include <linux/clk-provider.h>
>> +#include <linux/kernel.h>
>> +#include <linux/of.h>
>> +#include <linux/of_address.h>
>> +#include <linux/slab.h>
>> +#include <dt-bindings/clock/meson8b-clkc.h>
>> +
>> +#include "clkc.h"
>> +
>> +#define MESON8B_REG_CTL0_ADDR                0x0000
>> +#define MESON8B_REG_SYS_CPU_CNTL1    0x015c
>> +#define MESON8B_REG_HHI_MPEG         0x0174
>> +#define MESON8B_REG_MALI             0x01b0
>> +#define MESON8B_REG_PLL_FIXED                0x0280
>> +#define MESON8B_REG_PLL_SYS          0x0300
>> +#define MESON8B_REG_PLL_VID          0x0320
>> +
>> +static struct pll_rate_table sys_pll_rate_table[] = {
>
> const?

Ok

>> +
>> +static struct composite_conf clk81_conf __initdata = {
>
> Can this be __initconstdata?

Yes, probably better static const ... __initconst

>> +     .mux_table              = mux_table_clk81,
>> +     .mux_flags              = CLK_MUX_READ_ONLY,
>> +     .mux_parm               = PARM(0x00, 12, 3),
>> +     .div_parm               = PARM(0x00, 0, 7),
>> +     .gate_parm              = PARM(0x00, 7, 1),
>> +};
>> +
>> +static struct composite_conf mali_conf __initdata = {
>> +     .mux_table              = mux_table_mali,
>> +     .mux_parm               = PARM(0x00, 9, 3),
>> +     .div_parm               = PARM(0x00, 0, 7),
>> +     .gate_parm              = PARM(0x00, 8, 1),
>> +};
>> +
>> +static struct clk_conf meson8b_xtal_conf __initdata =
>> +     FIXED_RATE_P(MESON8B_REG_CTL0_ADDR, CLKID_XTAL, "xtal",
>> +                  CLK_IS_ROOT, PARM(0x00, 4, 7));
>> +
>> +static struct clk_conf meson8b_clk_confs[] __initdata = {
>
> const?

Agree

>> +     FIXED_RATE(CLKID_ZERO, "zero", CLK_IS_ROOT, 0),
>> +     PLL(MESON8B_REG_PLL_FIXED, CLKID_PLL_FIXED, "fixed_pll",
>> +         p_xtal, 0, &pll_confs),
>> +     PLL(MESON8B_REG_PLL_VID, CLKID_PLL_VID, "vid_pll",
>> +         p_xtal, 0, &pll_confs),
>> +     PLL(MESON8B_REG_PLL_SYS, CLKID_PLL_SYS, "sys_pll",
>> +         p_xtal, 0, &sys_pll_conf),
>> +     FIXED_FACTOR_DIV(CLKID_FCLK_DIV2, "fclk_div2", p_fclk_div, 0, 2),
>> +     FIXED_FACTOR_DIV(CLKID_FCLK_DIV3, "fclk_div3", p_fclk_div, 0, 3),
>> +     FIXED_FACTOR_DIV(CLKID_FCLK_DIV4, "fclk_div4", p_fclk_div, 0, 4),
>> +     FIXED_FACTOR_DIV(CLKID_FCLK_DIV5, "fclk_div5", p_fclk_div, 0, 5),
>> +     FIXED_FACTOR_DIV(CLKID_FCLK_DIV7, "fclk_div7", p_fclk_div, 0, 7),
>> +     CPU(MESON8B_REG_SYS_CPU_CNTL1, CLKID_CPUCLK, "a5_clk", p_cpu_clk),
>> +     COMPOSITE(MESON8B_REG_HHI_MPEG, CLKID_CLK81, "clk81", p_clk81,
>> +               CLK_SET_RATE_NO_REPARENT | CLK_IGNORE_UNUSED, &clk81_conf),
>> +     COMPOSITE(MESON8B_REG_MALI, CLKID_MALI, "mali", p_mali,
>> +               CLK_IGNORE_UNUSED, &mali_conf),
>
> Ah here we see the defines used.

Thank you!

-- 
Carlo Caione
