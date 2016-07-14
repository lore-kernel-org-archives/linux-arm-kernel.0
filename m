From: stillcompiling@gmail.com (Joshua Clayton)
Date: Thu, 14 Jul 2016 10:01:12 -0700
Subject: [PATCH v5 3/3] clk: imx6: Fix procedure to switch the parent of
 LDB_DI_CLK
In-Reply-To: <1468235521-3163-3-git-send-email-p.zabel@pengutronix.de>
References: <1468235521-3163-1-git-send-email-p.zabel@pengutronix.de>
 <1468235521-3163-3-git-send-email-p.zabel@pengutronix.de>
Message-ID: <5787C558.5060904@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Philipp,
My team is testing this morning on a board that exhibits
intermittent lvds failures that seem to match this problem.
(black screen and a "dc stop timeout" message in the kernel log)
With this patch set, the screen failed to come up on the second boot :(
But...
On 07/11/2016 04:12 AM, Philipp Zabel wrote:
> +static void init_ldb_clks(struct device_node *np, void __iomem *ccm_base)
> +{
> +	unsigned int reg;
> +	unsigned int sel[2][4];
> +	int i;
> +
to feel confident the new code was running, one of our engineers added the line
        pr_warn("ccm: In init_ldb_clks\n");
right here.
> +	reg = readl_relaxed(ccm_base + CCM_CS2CDR);
> +	sel[0][0] = (reg >> CS2CDR_LDB_DI0_CLK_SEL_SHIFT) & 7;
> +	sel[1][0] = (reg >> CS2CDR_LDB_DI1_CLK_SEL_SHIFT) & 7;
> +
> +	sel[0][3] = sel[0][2] = sel[0][1] = sel[0][0];
> +	sel[1][3] = sel[1][2] = sel[1][1] = sel[1][0];
> +
> +	of_assigned_ldb_sels(np, &sel[0][3], &sel[1][3]);
>
...

We have now booted that same board successfully about 30 times
with your patches plus the extra printf .?!??

Not sure what that means in terms of delay and synchronization, so
even though we are not finished testing I thought I should post that result.

Thanks,
Joshua Clayton
