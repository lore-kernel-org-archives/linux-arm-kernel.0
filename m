From: shawn.guo@freescale.com (Shawn Guo)
Date: Thu, 25 Sep 2014 16:29:41 +0800
Subject: [PATCH v2] ARM: ls1021a: add gating clocks to IP blocks.
In-Reply-To: <e7a0fe3cbe4c4ed0bcc489853a392f35@BY2PR0301MB0613.namprd03.prod.outlook.com>
References: <1411366160-42685-1-git-send-email-Li.Xiubo@freescale.com>
 <20140922070037.GR3755@pengutronix.de>
 <e7a0fe3cbe4c4ed0bcc489853a392f35@BY2PR0301MB0613.namprd03.prod.outlook.com>
Message-ID: <20140925082940.GF6405@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 22, 2014 at 03:55:14PM +0800, Xiubo Li-B47053 wrote:
> > > +static void __init ls1021a_clocks_init(struct device_node *np)
> > > +{
> > > +	void __iomem *dcfg_base;
> > > +
> > > +#define DCFG_CCSR_DEVDISR1	(dcfg_base + 0x70)
> > > +#define DCFG_CCSR_DEVDISR2	(dcfg_base + 0x74)
> > > +#define DCFG_CCSR_DEVDISR3	(dcfg_base + 0x78)
> > > +#define DCFG_CCSR_DEVDISR4	(dcfg_base + 0x7c)
> > > +#define DCFG_CCSR_DEVDISR5	(dcfg_base + 0x80)
> > > +
> > > +	dcfg_base = of_iomap(np, 0);
> > > +
> > > +	BUG_ON(!dcfg_base);
> > Is this worth a BUG? 
> Yes, I do think so.
> 
> There is one story about my platform:
> We are using the imx2_wdt watchdog device, which cannot stop or suspend
> once it has started.
> And our platform will also support the Power Management, if the gating
> Clock initialized failed, so when the system enters sleep mode, we cannot
> Stop the imx2_wdt IP block, so it will reset the board after 180 seconds at
> most.
> 
> So using this gating clock, the watchdog IP block's clock could be disabled
> When the system enter sleep mode.
> 
> So I think BUG_ON here is make sense.
>  
> Doesn't it ?
> 
> > Or is it enough to do
> > 	if (!dcfg_base) {
> > 		pr_warn("failed to map fsl,ls1021a-gate device\n");
> > 		return
> > 	}
> > 
> > > +
> > > +	clk[LS1021A_CLK_PBL_EN] = ls1021a_clk_gate("pbl_en", "dummy",
> > > +						DCFG_CCSR_DEVDISR1, 0, true);
> > If the machine's device tree contains two (or more) nodes that are
> > compatible to "fsl,ls1021a-gate", you overwrite your static clk array. Is
> > it worth to add another check here?:
> > 
> On LS1021A SoC, I can make sure that there will only be one gate node. But for
> More compatibly using one dynamic clk array will be better.

I do not think it's really necessary to use dynamic allocation.  Making
dcfg_base a static variable and check if it's null at the beginning of
the function is probably enough.

Shawn
