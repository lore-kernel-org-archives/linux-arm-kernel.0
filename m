From: dongas86@gmail.com (Dong Aisheng)
Date: Thu, 13 Apr 2017 22:21:22 +0800
Subject: [RFC PATCH 3/3] cpufreq: imx6q: refine clk operations
In-Reply-To: <1491932908.31718.33.camel@nxp.com>
References: <1491969809-20154-1-git-send-email-aisheng.dong@nxp.com>
 <1491969809-20154-4-git-send-email-aisheng.dong@nxp.com>
 <1491932908.31718.33.camel@nxp.com>
Message-ID: <20170413142122.GC24254@b29396-OptiPlex-7040>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 11, 2017 at 08:48:28PM +0300, Leonard Crestez wrote:
> On Wed, 2017-04-12 at 12:03 +0800, Dong Aisheng wrote:
> > +static int num_clks;
> > +static struct clk_bulk_data clks[] = {
> > +	{ .id = "arm" },
> > +	{ .id = "pll1_sys" },
> > +	{ .id = "step" },
> > +	{ .id = "pll1_sw" },
> > +	{ .id = "pll2_pfd2_396m" },
> > +	{ .id = "pll2_bus" },
> > +	{ .id = "secondary_sel" },
> > +};
> 
> The .id is only required for initialization, it seems strange to keep
> it around runtime data.

Well, this is mainly referencing how regulator bulk does the job.

> It might be better for this API to work with an
> array of clk* and separate array of names (or clk_bulk_init_data if we
> need flags). Variable references would be shorter and it would allow
> more data to be const.

It also has side effect that we then need one more param for each API.
Is that worth?

> > -put_clk:
> > -	if (!IS_ERR(arm_clk))
> > -		clk_put(arm_clk);
> > -	if (!IS_ERR(pll1_sys_clk))
> > -		clk_put(pll1_sys_clk);
> > -	if (!IS_ERR(pll1_sw_clk))
> > -		clk_put(pll1_sw_clk);
> > -	if (!IS_ERR(step_clk))
> > -		clk_put(step_clk);
> > -	if (!IS_ERR(pll2_pfd2_396m_clk))
> > -		clk_put(pll2_pfd2_396m_clk);
> > -	if (!IS_ERR(pll2_bus_clk))
> > -		clk_put(pll2_bus_clk);
> > -	if (!IS_ERR(secondary_sel_clk))
> > -		clk_put(secondary_sel_clk);
> > +
> > +	clk_bulk_put(num_clks, clks);
> > +put_node:
> > ?	of_node_put(np);
> > +
> > ?	return ret;
> > ?}
> 
> 
> My subjective opinion is that a better way to clean this up would be to
> have a single imx6q_cpufreq_clean function that takes all resources and
> does stuff like:
> 
> if (!IS_ERR(clk)) clk_put(clk);
> clk = NULL;
> 
> That function can be called from both _remove and failed _probe without
> having to keep track of which resources have been allocated until then.
> Just free and NULL all clocks/regulators and simplify control flow.
> 

I once thought of that way.

Now i'd like to remove them rather than form them into a function
which can't permanently fix the issue.

But, if Maintainers dislike it, we could do that.

Regards
Dong Aisheng
