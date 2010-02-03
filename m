From: ben-linux@fluff.org (Ben Dooks)
Date: Wed, 3 Feb 2010 17:59:00 +0000
Subject: [PATCH v3 2/7 RE-SEND] ARM: S5P6442: Add clock support for S5P6442
In-Reply-To: <1265116976-10140-1-git-send-email-kgene.kim@samsung.com>
References: <1265116976-10140-1-git-send-email-kgene.kim@samsung.com>
Message-ID: <20100203175900.GB13267@trinity.fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 02, 2010 at 10:22:56PM +0900, Kukjin Kim wrote:
> This patch adds clock support for S5P6442. This patch adds the clock
> register definitions and the various system clocks in S5P6442.
> 
> Signed-off-by: Adityapratap Sharma <aditya.ps@samsung.com>
> Signed-off-by: Atul Dahiya <atul.dahiya@samsung.com>
> Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>


> +#include <linux/init.h>
> +#include <linux/module.h>
> +#include <linux/kernel.h>
> +#include <linux/list.h>
> +#include <linux/errno.h>
> +#include <linux/err.h>
> +#include <linux/clk.h>
> +#include <linux/sysdev.h>
> +#include <linux/io.h>

interested to see if these two files are needed in the include, I don't
think we've actually got an IO functions or use of sysdev atm.

> +#include <mach/map.h>
> +
> +#include <plat/cpu-freq.h>
> +#include <mach/regs-clock.h>
> +#include <plat/clock.h>
> +#include <plat/cpu.h>
> +#include <plat/pll.h>
> +#include <plat/s5p-clock.h>
> +#include <plat/clock-clksrc.h>
> +#include <plat/s5p6442.h>
> +
> +static struct clk clk_dout_p0clk = {
> +	.name		= "dout_p0clk",
> +	.id		= -1,
> +	.parent		= &clk_dout_d0clk,
> +};
> +
> +static struct clk clk_dout_p1clk = {
> +	.name		= "dout_p1clk",
> +	.id		= -1,
> +	.parent		= &clk_dout_d1clk,
> +};

do we really need these clocks in the way? either #define them if the
naming is really important. if they get implemented later then we can
deal with that then.

> +void __init_or_cpufreq s5p6442_setup_clocks(void)
> +{
> +	struct clk *xtal_clk;
> +	struct clk *arm_clk;
> +	struct clk *hclkd0_clk;
> +	struct clk *hclkd1_clk;
> +	struct clk *pclkd0_clk;
> +	struct clk *pclkd1_clk;
> +
> +	unsigned long xtal;
> +	unsigned long arm;
> +	unsigned long hclkd0 = 0;
> +	unsigned long hclkd1 = 0;
> +	unsigned long pclkd0 = 0;
> +	unsigned long pclkd1 = 0;
> +
> +	unsigned long apll;
> +	unsigned long mpll;
> +	unsigned long epll;
> +	unsigned int ptr;
> +
> +	printk(KERN_DEBUG "%s: registering clocks\n", __func__);
> +
> +	xtal_clk = clk_get(NULL, "xtal");
> +	BUG_ON(IS_ERR(xtal_clk));
> +
> +	xtal = clk_get_rate(xtal_clk);
> +	clk_put(xtal_clk);

tbh, either make a function to do the clk_get,BUG,clk_put or simply
use the clock structures we have in the file.

> +	printk(KERN_DEBUG "%s: xtal is %ld\n", __func__, xtal);
> +
> +	apll = s5p_get_pll45xx(xtal, __raw_readl(S5P_APLL_CON), pll_4508);
> +	mpll = s5p_get_pll45xx(xtal, __raw_readl(S5P_MPLL_CON), pll_4502);
> +	epll = s5p_get_pll45xx(xtal, __raw_readl(S5P_EPLL_CON), pll_4500);
> +
> +	printk(KERN_INFO "S5P6440: PLL settings, A=%ld, M=%ld, E=%ld",
> +			apll, mpll, epll);
> +
> +	clk_fout_apll.rate = apll;
> +	clk_fout_mpll.rate = mpll;
> +	clk_fout_epll.rate = epll;
> +
> +	for (ptr = 0; ptr < ARRAY_SIZE(init_parents); ptr++)
> +		s3c_set_clksrc(init_parents[ptr], true);
> +
> +	for (ptr = 0; ptr < ARRAY_SIZE(clksrcs); ptr++)
> +		s3c_set_clksrc(&clksrcs[ptr], true);
> +
> +	arm_clk = clk_get(NULL, "dout_apll");
> +	BUG_ON(IS_ERR(arm_clk));
> +
> +	arm = clk_get_rate(arm_clk);
> +	clk_put(arm_clk);
> +
> +	hclkd0_clk = clk_get(NULL, "dout_d0clk");
> +	BUG_ON(IS_ERR(hclkd0_clk));
> +
> +	hclkd0 = clk_get_rate(hclkd0_clk);
> +	clk_put(hclkd0_clk);
> +
> +	pclkd0_clk = clk_get(NULL, "dout_p0clk");
> +	BUG_ON(IS_ERR(pclkd0_clk));
> +
> +	pclkd0 = clk_get_rate(pclkd0_clk);
> +	clk_put(pclkd0_clk);
> +
> +	hclkd1_clk = clk_get(NULL, "dout_d1clk");
> +	BUG_ON(IS_ERR(hclkd1_clk));
> +
> +	hclkd1 = clk_get_rate(hclkd1_clk);
> +	clk_put(hclkd1_clk);
> +
> +	pclkd1_clk = clk_get(NULL, "dout_p1clk");
> +	BUG_ON(IS_ERR(pclkd1_clk));
> +
> +	pclkd1 = clk_get_rate(pclkd1_clk);
> +	clk_put(pclkd1_clk);

see above comment.

> +	printk(KERN_INFO "S5P6442: HCLKD0=%ld, HCLKD1=%ld, PCLKD0=%ld, PCLKD1=%ld\n",
> +			hclkd0, hclkd1, pclkd0, pclkd1);
> +
> +	/* For backward compatibility */
> +	clk_f.rate = arm;
> +	clk_h.rate = hclkd1;
> +	clk_p.rate = pclkd1;
> +
> +	clk_dout_p1clk.rate = clk_p.rate;
> +}
> +
> +static struct clk init_clocks[] = {
> +	{
> +		.name		= "systimer",
> +		.id		= -1,
> +		.parent		= &clk_dout_p1clk,
> +		.enable		= s5p6442_clk_ip3_ctrl,
> +		.ctrlbit	= (1<<16),
> +	}, {
> +		.name		= "uart",
> +		.id		= 0,
> +		.parent		= &clk_dout_p1clk,
> +		.enable		= s5p6442_clk_ip3_ctrl,
> +		.ctrlbit	= (1<<17),
> +	}, {
> +		.name		= "uart",
> +		.id		= 1,
> +		.parent		= &clk_dout_p1clk,
> +		.enable		= s5p6442_clk_ip3_ctrl,
> +		.ctrlbit	= (1<<18),
> +	}, {
> +		.name		= "uart",
> +		.id		= 2,
> +		.parent		= &clk_dout_p1clk,
> +		.enable		= s5p6442_clk_ip3_ctrl,
> +		.ctrlbit	= (1<<19),
> +	}, {
> +		.name		= "timers",
> +		.id		= -1,
> +		.parent		= &clk_dout_p1clk,
> +		.enable		= s5p6442_clk_ip3_ctrl,
> +		.ctrlbit	= (1<<23),
> +	},
> +};
> +
> +static struct clk *clks[] __initdata = {
> +	&clk_ext,
> +	&clk_epll,
> +	&clk_mout_apll.clk,
> +	&clk_mout_mpll.clk,
> +	&clk_mout_epll.clk,
> +	&clk_mout_arm.clk,
> +	&clk_mout_d0.clk,
> +	&clk_mout_d0sync.clk,
> +	&clk_mout_d1.clk,
> +	&clk_mout_d1sync.clk,
> +	&clk_dout_apll,
> +	&clk_dout_a2m,
> +	&clk_dout_d0clk,
> +	&clk_dout_p0clk,
> +	&clk_dout_d1clk,
> +	&clk_dout_p1clk,
> +};
> +
> +void __init s5p6442_register_clocks(void)
> +{
> +	s3c24xx_register_clocks(clks, ARRAY_SIZE(clks));
> +
> +	s3c_register_clksrc(clksrcs, ARRAY_SIZE(clksrcs));
> +	s3c_register_clocks(init_clocks, ARRAY_SIZE(init_clocks));
> +
> +	s3c_pwmclk_init();
> +}

Did you clean the unused definitions out of the clock register file too?

-- 
Ben

Q:      What's a light-year?
A:      One-third less calories than a regular year.
