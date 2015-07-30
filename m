From: Shenwei.Wang@freescale.com (Shenwei Wang)
Date: Thu, 30 Jul 2015 15:19:48 +0000
Subject: [PATCH v4 1/1] Serial: imx: add dev_pm_ops to support suspend to
 ram/disk
In-Reply-To: <CAOMZO5DN3vARpY0ZQ7nEv+jbf-kcQQF4jrXqddGi81wvaxLPMg@mail.gmail.com>
References: <1438266762-4397-1-git-send-email-shenwei.wang@freescale.com>
 <CAOMZO5DN3vARpY0ZQ7nEv+jbf-kcQQF4jrXqddGi81wvaxLPMg@mail.gmail.com>
Message-ID: <CY1PR0301MB08437A8C708E5C550F10EDD2838B0@CY1PR0301MB0843.namprd03.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



> -----Original Message-----
> From: Fabio Estevam [mailto:festevam at gmail.com]
> Sent: 2015?7?30? 10:16
> To: Wang Shenwei-B38339
> Cc: Greg Kroah-Hartman; linux-serial at vger.kernel.org;
> linux-arm-kernel at lists.infradead.org
> Subject: Re: [PATCH v4 1/1] Serial: imx: add dev_pm_ops to support suspend to
> ram/disk
> 
> In case of error you should propagate it:
> 
> ret = clk_enable(sport->clk_ipg);
> if (ret)
>     return ret;

Okay.

 
> > +
> > +       /* Save necessary regs */
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
> > +
> > +       if (ret == 0)
> > +               clk_disable(sport->clk_ipg);
> 
> then you don't need to check ret here. Just call clk_disable unconditionally.
> 
> > +
> > +       return 0;
> > +}
> > +
> > +static int imx_serial_port_resume_noirq(struct device *dev) {
> > +       struct platform_device *pdev = to_platform_device(dev);
> > +       struct imx_port *sport = platform_get_drvdata(pdev);
> > +       int ret;
> > +
> > +       ret = clk_enable(sport->clk_ipg);
> > +       if (ret)
> > +               dev_err(dev, "UART%d resume error!\r\n",
> > + sport->port.line);
> 
> Same here.
