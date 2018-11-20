From: sboyd@kernel.org (Stephen Boyd)
Date: Tue, 20 Nov 2018 10:55:45 -0800
Subject: [PATCH V6 6/6] clk: imx: add imx8qxp lpcg driver
In-Reply-To: <AM0PR04MB4211A7CA91D6188AB81BA6EA80DC0@AM0PR04MB4211.eurprd04.prod.outlook.com>
References: <1541862894-8209-1-git-send-email-aisheng.dong@nxp.com>
 <1541862894-8209-7-git-send-email-aisheng.dong@nxp.com>
 <154223811948.88331.8860718270277533070@swboyd.mtv.corp.google.com>
 <AM0PR04MB4211A7CA91D6188AB81BA6EA80DC0@AM0PR04MB4211.eurprd04.prod.outlook.com>
Message-ID: <154274014557.88331.17188709471206009766@swboyd.mtv.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting A.s. Dong (2018-11-14 17:28:05)
> > -----Original Message-----
> > From: Stephen Boyd [mailto:sboyd at kernel.org]
> 
> > 
> > > +
> > > +       ss_lpcg = of_device_get_match_data(dev);
> > > +       if (!ss_lpcg)
> > > +               return -ENODEV;
> > > +
> > > +       res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> > > +       base = devm_ioremap(dev, res->start, resource_size(res));
> > 
> > Why not devm_ioremap_resource()?
> 
> Because LPCGs are distributed in various subsystem memory space which
> may be overlapped with some IP modules. So we can't use devm_ioremap_resource
> which has a request_mem_region() in it.
> It's something like what we've done for drivers/mfd/syscon.c.

Ok. Any chance that the various subsystems that are combined with the
clk controller can be split up so that we can use
devm_ioremap_resource() here? It may be better to carve up the I/O space
of this SoC into device nodes that map to the hardware IP blocks, and
then have those device drivers generate sub-devices for the various
logical subsystems that the hardware IP spans. Or it could be a big
driver that registers with multiple subsytems/frameworks from one device
driver. This way, the logical structure of the linux kernel device
driver design doesn't leak into the DT description of the SoC.

> 
> > > +                               GFP_KERNEL);
> > > +       if (!clk_data)
> > > +               return -ENOMEM;
> > > +
> > > +       clk_data->num = ss_lpcg->num_max;
> > > +       clks = clk_data->hws;
> > > +
> > > +       for (i = 0; i < ss_lpcg->num_lpcg; i++) {
> > > +               lpcg = ss_lpcg->lpcg + i;
> > > +               clks[lpcg->id] = imx_clk_lpcg_scu(lpcg->name,
> > lpcg->parent,
> > > +                                                 lpcg->flags, base +
> > lpcg->offset,
> > > +                                                 lpcg->bit_idx,
> > lpcg->hw_gate);
> > > +       }
> > > +
> > > +       for (i = 0; i < clk_data->num; i++) {
> > > +               if (IS_ERR(clks[i]))
> > > +                       pr_err("i.MX clk %u: register failed with %ld\n",
> > > +                               i, PTR_ERR(clks[i]));
> > 
> > But we're OK to continue? Alright...
> > 
> 
> Yes, probably better to use pr_warn()?

Yes.

> 
> > > +       }
> > > +
> > > +       return of_clk_add_hw_provider(np, of_clk_hw_onecell_get,
> > > + clk_data);
> > 
> > Why not use devm_? Or can the driver never be unbound from sysfs?
> > 
> 
> We expect the driver to be never unbound from sysfs.
> Probably we'd better add .suppress_bind_attrs.

Ok. Please add it.
