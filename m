From: stillcompiling@gmail.com (Joshua Clayton)
Date: Sat, 16 Jul 2016 13:55:10 -0700 (PDT)
Subject: [PATCH v5 3/3] clk: imx6: Fix procedure to switch the parent of
 LDB_DI_CLK
In-Reply-To: <5787C558.5060904@gmail.com>
References: <1468235521-3163-1-git-send-email-p.zabel@pengutronix.de>
 <1468235521-3163-3-git-send-email-p.zabel@pengutronix.de>
 <5787C558.5060904@gmail.com>
Message-ID: <2499789.N9zTF3cNAV@diplodocus>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi again,

On Thursday, July 14, 2016 10:01:12 AM Joshua Clayton wrote:
> Hi Philipp,
> My team is testing this morning on a board that exhibits
> intermittent lvds failures that seem to match this problem.
> (black screen and a "dc stop timeout" message in the kernel log)
> With this patch set, the screen failed to come up on the second boot :(
> But...
> On 07/11/2016 04:12 AM, Philipp Zabel wrote:
> > +static void init_ldb_clks(struct device_node *np, void __iomem *ccm_base)
> > +{
> > +	unsigned int reg;
> > +	unsigned int sel[2][4];
> > +	int i;
> > +
> to feel confident the new code was running, one of our engineers added the line
>         pr_warn("ccm: In init_ldb_clks\n");
> right here.
Took the printk out and the patch set still works as expected.
...so the previous email was a false alarm. Mea culpa
Problem solved I think. Thanks Philipp!

for my hardware (imx6q-evi) using xorg and  lvds

Tested-by Joshua Clayton <stillcompiling@gmail.com>
> > +	reg = readl_relaxed(ccm_base + CCM_CS2CDR);
> > +	sel[0][0] = (reg >> CS2CDR_LDB_DI0_CLK_SEL_SHIFT) & 7;
> > +	sel[1][0] = (reg >> CS2CDR_LDB_DI1_CLK_SEL_SHIFT) & 7;
> > +
> > +	sel[0][3] = sel[0][2] = sel[0][1] = sel[0][0];
> > +	sel[1][3] = sel[1][2] = sel[1][1] = sel[1][0];
> > +
> > +	of_assigned_ldb_sels(np, &sel[0][3], &sel[1][3]);
> >
> ...
> 
> We have now booted that same board successfully about 30 times
> with your patches plus the extra printf .?!??
> 
> Not sure what that means in terms of delay and synchronization, so
> even though we are not finished testing I thought I should post that result.
> 
> Thanks,
> Joshua Clayton
