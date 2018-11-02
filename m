From: aisheng.dong@nxp.com (A.s. Dong)
Date: Fri, 2 Nov 2018 08:54:11 +0000
Subject: [PATCH V3 07/10] ARM: imx: add initial support for imx7ulp
In-Reply-To: <CAOMZO5ACUBLBCNMAVJ=SCsFSQour1orLrHU6un=fFY0WYC+ZHw@mail.gmail.com>
References: <1540996688-23681-1-git-send-email-aisheng.dong@nxp.com>
 <1540996688-23681-8-git-send-email-aisheng.dong@nxp.com>
 <CAOMZO5ACUBLBCNMAVJ=SCsFSQour1orLrHU6un=fFY0WYC+ZHw@mail.gmail.com>
Message-ID: <AM0PR04MB4211CBFA992F60261683CEF580CF0@AM0PR04MB4211.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: Fabio Estevam [mailto:festevam at gmail.com]
> Sent: Friday, November 2, 2018 2:21 AM
[...]
> On Wed, Oct 31, 2018 at 12:13 PM A.s. Dong <aisheng.dong@nxp.com>
> wrote:
> 
> > +static void __init imx7ulp_init_machine(void) {
> > +       imx7ulp_pm_init();
> > +
> > +       mxc_set_cpu_type(MXC_CPU_IMX7ULP);
> > +       imx_print_silicon_rev("i.MX7ULP", IMX_CHIP_REVISION_1_0);
> 
> Why do you hardcode it as revision 1.0?
> 

Because so far there're still no way to restrieve SoC version as we did
via anatop before. So we encode it to 1.0 temporarily on which this code
was initially based.

I think I can change it to unknown directly to reflect the real situation.
e.g.
imx_print_silicon_rev("i.MX7ULP", IMX_CHIP_REVISION_UNKNOWN) 

> > +void __init imx7ulp_pm_init(void)
> > +{
> > +       struct device_node *np;
> > +       void __iomem *smc1_base;
> > +
> > +       np = of_find_compatible_node(NULL, NULL, "fsl,imx7ulp-smc1");
> > +       smc1_base = of_iomap(np, 0);
> > +       WARN_ON(!smc1_base);
> > +
> > +       /* Partial Stop mode 3 with system/bus clock enabled */
> > +       writel_relaxed(PSTOPO_PSTOP3 << BP_PMCTRL_PSTOPO,
> > +                      smc1_base + SMC_PMCTRL);
> 
> You should call  iounmap(smc1__base); after smc1__base is no longer used.

Good suggestion, will add it.

Regards
Dong Aisheng
