From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 3 Feb 2010 09:24:53 +0000
Subject: [PATCHv2 05/11] mxc: Core support for i.MX5 series of
	processors from Freescale
In-Reply-To: <f10f79e7313ecdeeb59ab881795baedf2430c636.1265173480.git.amit.kucheria@canonical.com>
References: <cover.1265173480.git.amit.kucheria@canonical.com>
	<f10f79e7313ecdeeb59ab881795baedf2430c636.1265173480.git.amit.kucheria@canonical.com>
Message-ID: <20100203092453.GA21921@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 02, 2010 at 09:16:27PM -0800, Amit Kucheria wrote:
> +static int _clk_pll_set_rate(struct clk *clk, unsigned long rate)
> +{
> +	u32 reg;
> +	void __iomem *pllbase;
> +
> +	long mfi, pdf, mfn, mfd = 999999;
> +	s64 temp64;
> +	unsigned long quad_parent_rate;
> +	unsigned long pll_hfsm, dp_ctl;
> +	unsigned long parent_rate;
> +
> +	parent_rate = clk_get_rate(clk->parent);
> +
> +	pllbase = _get_pll_base(clk);
> +
> +	quad_parent_rate = 4 * parent_rate;
> +	pdf = mfi = -1;
> +	while (++pdf < 16 && mfi < 5)
> +		mfi = rate * (pdf+1) / quad_parent_rate;
> +	if (mfi > 15)
> +		return -1;

Why not "return -EPERM" since what you're actually saying here by
returning -1 is "Permission Denied"?  If you didn't mean "Permission
Denied", then don't use return -1.
