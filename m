From: dongas86@gmail.com (Dong Aisheng)
Date: Tue, 20 Jun 2017 17:42:56 +0800
Subject: [PATCH 9/9] clk: imx: add imx7ulp clk driver
In-Reply-To: <20170620020119.GQ4493@codeaurora.org>
References: <1494856763-6543-1-git-send-email-aisheng.dong@nxp.com>
 <1494856763-6543-10-git-send-email-aisheng.dong@nxp.com>
 <20170620020119.GQ4493@codeaurora.org>
Message-ID: <20170620094256.GF6805@b29396-OptiPlex-7040>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 19, 2017 at 07:01:19PM -0700, Stephen Boyd wrote:
> On 05/15, Dong Aisheng wrote:
> > +
> > +	clks[IMX7ULP_CLK_VIU]		= imx_clk_gate("viu",	"nic1_clk",	base + 0xA0, 30);
> > +	clks[IMX7ULP_CLK_PCTLC]		= imx_clk_gate("pctlc", "nic1_bus_clk", base + 0xB8, 30);
> > +	clks[IMX7ULP_CLK_PCTLD]		= imx_clk_gate("pctld", "nic1_bus_clk", base + 0xBC, 30);
> > +	clks[IMX7ULP_CLK_PCTLE]		= imx_clk_gate("pctle", "nic1_bus_clk", base + 0xc0, 30);
> > +	clks[IMX7ULP_CLK_PCTLF]		= imx_clk_gate("pctlf", "nic1_bus_clk", base + 0xc4, 30);
> > +
> > +	clks[IMX7ULP_CLK_GPU3D]		= imx_clk_composite("gpu3d",   periph_plat_sels, ARRAY_SIZE(periph_plat_sels), true, false, true, base + 0x140);
> > +	clks[IMX7ULP_CLK_GPU2D]		= imx_clk_composite("gpu2d",   periph_plat_sels, ARRAY_SIZE(periph_plat_sels), true, false, true, base + 0x144);
> > +
> > +	imx_check_clocks(clks, ARRAY_SIZE(clks));
> > +
> > +	clk_data.clks = clks;
> > +	clk_data.clk_num = ARRAY_SIZE(clks);
> > +	of_clk_add_provider(scg_node, of_clk_src_onecell_get, &clk_data);
> 
> Please use of_clk_add_hw_provider() instead, and the associated
> clk_hw registration APIs.
> 

Sure, will do it.

> > +
> > +	pr_info("i.MX7ULP clock tree init done.\n");
> 
> pr_debug?
> 

Yes

> > +}
> > +
> > +CLK_OF_DECLARE(imx7ulp, "fsl,imx7ulp-clock", imx7ulp_clocks_init);
> > 
> 
> Any reason why it can't be a platform driver? If not, please add
> some comment explaining why.
> 

Timer is using it at early stage. GIC seems not although standard
binding claim possible clock requirement.
Others still not sure.

What your suggestion?
Convert timer to platform driver and make clock as platform driver as well?

Regards
Dong Aisheng

> -- 
> Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
> a Linux Foundation Collaborative Project
> --
> To unsubscribe from this list: send the line "unsubscribe linux-clk" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
