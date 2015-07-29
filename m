From: Shenwei.Wang@freescale.com (Shenwei Wang)
Date: Wed, 29 Jul 2015 21:41:00 +0000
Subject: [PATCH v3 1/1] Serial: imx: add dev_pm_ops to support suspend to
 ram/disk
In-Reply-To: <CAOMZO5Aj5PASPKRq47vmenDBSPMPHdLgSbJZXkhZu3MNYprqXA@mail.gmail.com>
References: <1438203535-38028-1-git-send-email-shenwei.wang@freescale.com>
 <CAOMZO5Aj5PASPKRq47vmenDBSPMPHdLgSbJZXkhZu3MNYprqXA@mail.gmail.com>
Message-ID: <CY1PR0301MB0843BEF6A40A0A28018E0D5D838C0@CY1PR0301MB0843.namprd03.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: Fabio Estevam [mailto:festevam at gmail.com]
> Sent: 2015?7?29? 16:21
> To: Wang Shenwei-B38339
> Cc: Greg Kroah-Hartman; linux-arm-kernel at lists.infradead.org;
> linux-serial at vger.kernel.org
> Subject: Re: [PATCH v3 1/1] Serial: imx: add dev_pm_ops to support suspend to
> ram/disk
> 
> On Wed, Jul 29, 2015 at 5:58 PM, Shenwei Wang <shenwei.wang@freescale.com>
> wrote:
> 
> > +static int imx_serial_port_suspend_noirq(struct device *dev) {
> > +       struct platform_device *pdev = to_platform_device(dev);
> > +       struct imx_port *sport = platform_get_drvdata(pdev);
> > +
> > +       /* Save necessary regs */
> > +       clk_enable(sport->clk_ipg);
> 
> clk_enable() may fail, so you should check its return value.

The check seems a little superfluous because the failure condition for clk_enable is 
(clk == NULL || IS_ERR(clk))
Once this function is called which means the initialization of the driver is successful.

> > +       sport->saved_reg[0] = readl(sport->port.membase + UCR1);
> > +       sport->saved_reg[1] = readl(sport->port.membase + UCR2);
> > +       sport->saved_reg[2] = readl(sport->port.membase + UCR3);
> > +       sport->saved_reg[3] = readl(sport->port.membase + UCR4);
> > +       sport->saved_reg[4] = readl(sport->port.membase + UFCR);
> > +       sport->saved_reg[5] = readl(sport->port.membase + UESC);
> > +       sport->saved_reg[6] = readl(sport->port.membase + UTIM);
> > +       sport->saved_reg[7] = readl(sport->port.membase + UBIR);
> > +       sport->saved_reg[8] = readl(sport->port.membase + UBMR);
> > +       sport->saved_reg[9] = readl(sport->port.membase + IMX21_UTS);
> > +       clk_disable(sport->clk_ipg);
> > +
> > +       dev_dbg(dev, "0x%p (%d)\r\n", sport->port.membase,
> > + sport->port.line);
> > +
> > +       return 0;
> > +}
> > +
> > +static int imx_serial_port_resume_noirq(struct device *dev) {
> > +       struct platform_device *pdev = to_platform_device(dev);
> > +       struct imx_port *sport = platform_get_drvdata(pdev);
> > +
> > +       clk_enable(sport->clk_ipg);
> 
> Same here.
> 
> > +       writel(sport->saved_reg[4], sport->port.membase + UFCR);
> > +       writel(sport->saved_reg[5], sport->port.membase + UESC);
> > +       writel(sport->saved_reg[6], sport->port.membase + UTIM);
> > +       writel(sport->saved_reg[7], sport->port.membase + UBIR);
> > +       writel(sport->saved_reg[8], sport->port.membase + UBMR);
> > +       writel(sport->saved_reg[9], sport->port.membase + IMX21_UTS);
> > +       writel(sport->saved_reg[0], sport->port.membase + UCR1);
> > +       writel(sport->saved_reg[1] | 0x1, sport->port.membase + UCR2);
> 
> Why this magic '| 0x1'? Can't you use a define instead?

Yes, should be a macro.

Thanks,
Shenwei
