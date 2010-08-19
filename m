From: myungjoo.ham@gmail.com (MyungJoo Ham)
Date: Thu, 19 Aug 2010 11:57:14 +0900
Subject: [PATCH 02/14] ARM: S5PV310: Removed unused clock
In-Reply-To: <1282140084-10265-3-git-send-email-kgene.kim@samsung.com>
References: <1282140084-10265-1-git-send-email-kgene.kim@samsung.com>
	<1282140084-10265-3-git-send-email-kgene.kim@samsung.com>
Message-ID: <AANLkTinjDBxahumErXmXXDW2FLxFi6oXpu-jZa+xzYhF@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Wed, Aug 18, 2010 at 11:01 PM, Kukjin Kim <kgene.kim@samsung.com> wrote:
> This pach removed unused clock on S5PV310/S5PC210.
>
> Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>

In this patch, you've removed corem0, corem1, cores, periph, atclk,
and pclk_dbg, which are directly affected by cpu-freq drivers. As long
as CPUFREQ uses clocks under 800MHz, corem0, corem1, cores, and
periph's dividers should be updated and as long as CPUFREQ uses clocks
over 800MHz, atclk and pclk_dbg's dividers should also be updated.
Although in the cpu-freq patches of S5PV210, the cpu-freq driver did
not use the clock framework and accessed clock registers directly, I
thought cpu-freq should consider using the clock framework later as,
sometimes, other drivers and modules are interested in the values
related with this domain (e.g., for the stability issues,
suspend-to-mem/disk may want to read and save the clock rates of CPU).

Do you think CPUFREQ should keep accessing the clock registers
directly? or should start using clock frameworks later?

ps. If we are going to change the bus speed as well (as in S5PV210's
100MHz mode), we may need to access aclk_cored, aclk_corep, and
aclk_acp as well.

> ---
> ?arch/arm/mach-s5pv310/clock.c | ?126 +----------------------------------------
> ?1 files changed, 2 insertions(+), 124 deletions(-)
>
> diff --git a/arch/arm/mach-s5pv310/clock.c b/arch/arm/mach-s5pv310/clock.c
> index 77f2b4d..e3098d5 100644
> --- a/arch/arm/mach-s5pv310/clock.c
> +++ b/arch/arm/mach-s5pv310/clock.c
> @@ -96,60 +96,6 @@ static struct clksrc_clk clk_armclk = {
> ? ? ? ?},
> ?};
>
> -static struct clksrc_clk clk_aclk_corem0 = {
> - ? ? ? .clk ? ?= {
> - ? ? ? ? ? ? ? .name ? ? ? ? ? = "aclk_corem0",
> - ? ? ? ? ? ? ? .id ? ? ? ? ? ? = -1,
> - ? ? ? ? ? ? ? .parent ? ? ? ? = &clk_coreclk.clk,
> - ? ? ? },
> - ? ? ? .reg_div ? ? ? ?= { .reg = S5P_CLKDIV_CPU, .shift = 4, .size = 3 },
> -};
> -
> -static struct clksrc_clk clk_aclk_cores = {
> - ? ? ? .clk ? ?= {
> - ? ? ? ? ? ? ? .name ? ? ? ? ? = "aclk_cores",
> - ? ? ? ? ? ? ? .id ? ? ? ? ? ? = -1,
> - ? ? ? ? ? ? ? .parent ? ? ? ? = &clk_coreclk.clk,
> - ? ? ? },
> - ? ? ? .reg_div ? ? ? ?= { .reg = S5P_CLKDIV_CPU, .shift = 4, .size = 3 },
> -};
> -
> -static struct clksrc_clk clk_aclk_corem1 = {
> - ? ? ? .clk ? ?= {
> - ? ? ? ? ? ? ? .name ? ? ? ? ? = "aclk_corem1",
> - ? ? ? ? ? ? ? .id ? ? ? ? ? ? = -1,
> - ? ? ? ? ? ? ? .parent ? ? ? ? = &clk_coreclk.clk,
> - ? ? ? },
> - ? ? ? .reg_div ? ? ? ?= { .reg = S5P_CLKDIV_CPU, .shift = 8, .size = 3 },
> -};
> -
> -static struct clksrc_clk clk_periphclk = {
> - ? ? ? .clk ? ?= {
> - ? ? ? ? ? ? ? .name ? ? ? ? ? = "periphclk",
> - ? ? ? ? ? ? ? .id ? ? ? ? ? ? = -1,
> - ? ? ? ? ? ? ? .parent ? ? ? ? = &clk_coreclk.clk,
> - ? ? ? },
> - ? ? ? .reg_div ? ? ? ?= { .reg = S5P_CLKDIV_CPU, .shift = 12, .size = 3 },
> -};
> -
> -static struct clksrc_clk clk_atclk = {
> - ? ? ? .clk ? ?= {
> - ? ? ? ? ? ? ? .name ? ? ? ? ? = "atclk",
> - ? ? ? ? ? ? ? .id ? ? ? ? ? ? = -1,
> - ? ? ? ? ? ? ? .parent ? ? ? ? = &clk_moutcore.clk,
> - ? ? ? },
> - ? ? ? .reg_div ? ? ? ?= { .reg = S5P_CLKDIV_CPU, .shift = 16, .size = 3 },
> -};
> -
> -static struct clksrc_clk clk_pclk_dbg = {
> - ? ? ? .clk ? ?= {
> - ? ? ? ? ? ? ? .name ? ? ? ? ? = "pclk_dbg",
> - ? ? ? ? ? ? ? .id ? ? ? ? ? ? = -1,
> - ? ? ? ? ? ? ? .parent ? ? ? ? = &clk_atclk.clk,
> - ? ? ? },
> - ? ? ? .reg_div ? ? ? ?= { .reg = S5P_CLKDIV_CPU, .shift = 20, .size = 3 },
> -};
> -
> ?/* Core list of CMU_CORE side */
>
> ?static struct clk *clkset_corebus_list[] = {
> @@ -180,42 +126,6 @@ static struct clksrc_clk clk_sclk_dmc = {
> ? ? ? ?.reg_div ? ? ? ?= { .reg = S5P_CLKDIV_CORE0, .shift = 12, .size = 3 },
> ?};
>
> -static struct clksrc_clk clk_aclk_cored = {
> - ? ? ? .clk ? ?= {
> - ? ? ? ? ? ? ? .name ? ? ? ? ? = "aclk_cored",
> - ? ? ? ? ? ? ? .id ? ? ? ? ? ? = -1,
> - ? ? ? ? ? ? ? .parent ? ? ? ? = &clk_sclk_dmc.clk,
> - ? ? ? },
> - ? ? ? .reg_div ? ? ? ?= { .reg = S5P_CLKDIV_CORE0, .shift = 16, .size = 3 },
> -};
> -
> -static struct clksrc_clk clk_aclk_corep = {
> - ? ? ? .clk ? ?= {
> - ? ? ? ? ? ? ? .name ? ? ? ? ? = "aclk_corep",
> - ? ? ? ? ? ? ? .id ? ? ? ? ? ? = -1,
> - ? ? ? ? ? ? ? .parent ? ? ? ? = &clk_aclk_cored.clk,
> - ? ? ? },
> - ? ? ? .reg_div ? ? ? ?= { .reg = S5P_CLKDIV_CORE0, .shift = 20, .size = 3 },
> -};
> -
> -static struct clksrc_clk clk_aclk_acp = {
> - ? ? ? .clk ? ?= {
> - ? ? ? ? ? ? ? .name ? ? ? ? ? = "aclk_acp",
> - ? ? ? ? ? ? ? .id ? ? ? ? ? ? = -1,
> - ? ? ? ? ? ? ? .parent ? ? ? ? = &clk_mout_corebus.clk,
> - ? ? ? },
> - ? ? ? .reg_div ? ? ? ?= { .reg = S5P_CLKDIV_CORE0, .shift = 0, .size = 3 },
> -};
> -
> -static struct clksrc_clk clk_pclk_acp = {
> - ? ? ? .clk ? ?= {
> - ? ? ? ? ? ? ? .name ? ? ? ? ? = "pclk_acp",
> - ? ? ? ? ? ? ? .id ? ? ? ? ? ? = -1,
> - ? ? ? ? ? ? ? .parent ? ? ? ? = &clk_aclk_acp.clk,
> - ? ? ? },
> - ? ? ? .reg_div ? ? ? ?= { .reg = S5P_CLKDIV_CORE0, .shift = 4, .size = 3 },
> -};
> -
> ?/* Core list of CMU_TOP side */
>
> ?static struct clk *clkset_aclk_top_list[] = {
> @@ -416,18 +326,8 @@ static struct clksrc_clk *sysclks[] = {
> ? ? ? ?&clk_moutcore,
> ? ? ? ?&clk_coreclk,
> ? ? ? ?&clk_armclk,
> - ? ? ? &clk_aclk_corem0,
> - ? ? ? &clk_aclk_cores,
> - ? ? ? &clk_aclk_corem1,
> - ? ? ? &clk_periphclk,
> - ? ? ? &clk_atclk,
> - ? ? ? &clk_pclk_dbg,
> ? ? ? ?&clk_mout_corebus,
> ? ? ? ?&clk_sclk_dmc,
> - ? ? ? &clk_aclk_cored,
> - ? ? ? &clk_aclk_corep,
> - ? ? ? &clk_aclk_acp,
> - ? ? ? &clk_pclk_acp,
> ? ? ? ?&clk_vpllsrc,
> ? ? ? ?&clk_sclk_vpll,
> ? ? ? ?&clk_aclk_200,
> @@ -446,15 +346,7 @@ void __init_or_cpufreq s5pv310_setup_clocks(void)
> ? ? ? ?unsigned long vpllsrc;
> ? ? ? ?unsigned long xtal;
> ? ? ? ?unsigned long armclk;
> - ? ? ? unsigned long aclk_corem0;
> - ? ? ? unsigned long aclk_cores;
> - ? ? ? unsigned long aclk_corem1;
> - ? ? ? unsigned long periphclk;
> ? ? ? ?unsigned long sclk_dmc;
> - ? ? ? unsigned long aclk_cored;
> - ? ? ? unsigned long aclk_corep;
> - ? ? ? unsigned long aclk_acp;
> - ? ? ? unsigned long pclk_acp;
> ? ? ? ?unsigned int ptr;
>
> ? ? ? ?printk(KERN_DEBUG "%s: registering clocks\n", __func__);
> @@ -485,26 +377,12 @@ void __init_or_cpufreq s5pv310_setup_clocks(void)
> ? ? ? ? ? ? ? ? ? ? ? ?apll, mpll, epll, vpll);
>
> ? ? ? ?armclk = clk_get_rate(&clk_armclk.clk);
> - ? ? ? aclk_corem0 = clk_get_rate(&clk_aclk_corem0.clk);
> - ? ? ? aclk_cores = clk_get_rate(&clk_aclk_cores.clk);
> - ? ? ? aclk_corem1 = clk_get_rate(&clk_aclk_corem1.clk);
> - ? ? ? periphclk = clk_get_rate(&clk_periphclk.clk);
> ? ? ? ?sclk_dmc = clk_get_rate(&clk_sclk_dmc.clk);
> - ? ? ? aclk_cored = clk_get_rate(&clk_aclk_cored.clk);
> - ? ? ? aclk_corep = clk_get_rate(&clk_aclk_corep.clk);
> - ? ? ? aclk_acp = clk_get_rate(&clk_aclk_acp.clk);
> - ? ? ? pclk_acp = clk_get_rate(&clk_pclk_acp.clk);
> -
> - ? ? ? printk(KERN_INFO "S5PV310: ARMCLK=%ld, COREM0=%ld, CORES=%ld\n"
> - ? ? ? ? ? ? ? ? ? ? ? ?"COREM1=%ld, PERI=%ld, DMC=%ld, CORED=%ld\n"
> - ? ? ? ? ? ? ? ? ? ? ? ?"COREP=%ld, ACLK_ACP=%ld, PCLK_ACP=%ld",
> - ? ? ? ? ? ? ? ? ? ? ? armclk, aclk_corem0, aclk_cores, aclk_corem1,
> - ? ? ? ? ? ? ? ? ? ? ? periphclk, sclk_dmc, aclk_cored, aclk_corep,
> - ? ? ? ? ? ? ? ? ? ? ? aclk_acp, pclk_acp);
> +
> + ? ? ? printk(KERN_INFO "S5PV310: ARMCLK=%ld, DMC=%ld\n", armclk, sclk_dmc);
>
> ? ? ? ?clk_f.rate = armclk;
> ? ? ? ?clk_h.rate = sclk_dmc;
> - ? ? ? clk_p.rate = periphclk;
>
> ? ? ? ?for (ptr = 0; ptr < ARRAY_SIZE(clksrcs); ptr++)
> ? ? ? ? ? ? ? ?s3c_set_clksrc(&clksrcs[ptr], true);
> --
> 1.6.2.5
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>



-- 
MyungJoo Ham, Ph.D.
Mobile Software Platform Lab,
Digital Media and Communications (DMC) Business
Samsung Electronics
cell: 82-10-6714-2858
