From: zhiqiang.hou@nxp.com (Z.q. Hou)
Date: Thu, 3 Aug 2017 03:35:46 +0000
Subject: [PATCH] PCI: layerscape: Add support for ls2088a and ls1088a
In-Reply-To: <20170802212942.GA7667@bhelgaas-glaptop.roam.corp.google.com>
References: <1499333984-17668-1-git-send-email-Zhiqiang.Hou@nxp.com>
 <20170802212942.GA7667@bhelgaas-glaptop.roam.corp.google.com>
Message-ID: <AM5PR0402MB2771BBF476E6A3DEFADE43F484B10@AM5PR0402MB2771.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Bjorn,

Thanks a lot for your comments!

> -----Original Message-----
> From: Bjorn Helgaas [mailto:helgaas at kernel.org]
> Sent: 2017?8?3? 5:30
> To: Z.q. Hou <zhiqiang.hou@nxp.com>
> Cc: linux-pci at vger.kernel.org; linux-arm-kernel at lists.infradead.org;
> bhelgaas at google.com; robh+dt at kernel.org; Minghuan Lian
> <minghuan.Lian@freescale.com>; Mingkai Hu <mingkai.hu@freescale.com>;
> Roy Zang <tie-fei.zang@freescale.com>
> Subject: Re: [PATCH] PCI: layerscape: Add support for ls2088a and ls1088a
> 
> [+cc Minghuan, Mingkai, Roy]
> 
> On Thu, Jul 06, 2017 at 05:39:44PM +0800, Zhiqiang Hou wrote:
> > From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> >
> > The ls1088a and ls2088a has the same PCIe controller, so the ls1088a
> > will reuse the ls2088a's pcie compatible.
> >
> > Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> > ---
> >  Documentation/devicetree/bindings/pci/layerscape-pci.txt | 1 +
> >  drivers/pci/dwc/pci-layerscape.c                         | 9
> +++++++++
> >  2 files changed, 10 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/pci/layerscape-pci.txt
> > b/Documentation/devicetree/bindings/pci/layerscape-pci.txt
> > index ee1c72d5..cb735e1 100644
> > --- a/Documentation/devicetree/bindings/pci/layerscape-pci.txt
> > +++ b/Documentation/devicetree/bindings/pci/layerscape-pci.txt
> > @@ -15,6 +15,7 @@ Required properties:
> >  - compatible: should contain the platform identifier such as:
> >          "fsl,ls1021a-pcie", "snps,dw-pcie"
> >          "fsl,ls2080a-pcie", "fsl,ls2085a-pcie", "snps,dw-pcie"
> > +        "fsl,ls2088a-pcie", "fsl,ls1088a-pcie"
> 
> You add "fsl,ls1088a-pcie" here, but not in the ls_pcie_of_match[] table in the
> driver, so I don't think this will actually make the driver claim ls1088a devices,
> will it?

I mean the ls1088a pcie DT nodes will use the "fsl,ls2088a-pcie" too, so I didn't add an entry for ls1088a pcie to ls_pcie_of_match[].
Is it reasonable? Or it's better to add "fsl,ls1088a-pcie" to ls_pcie_of_match[], then ls1088a pcie DT nodes use the compatible string "fsl,ls1088a-pcie"?

> I'm also waiting for an ack from the layerscape maintainers (added to cc list).
> 
> >          "fsl,ls1046a-pcie"
> >  - reg: base addresses and lengths of the PCIe controller
> >  - interrupts: A list of interrupt outputs of the controller. Must
> > contain an diff --git a/drivers/pci/dwc/pci-layerscape.c
> > b/drivers/pci/dwc/pci-layerscape.c
> > index 9bed3cd..0df8189 100644
> > --- a/drivers/pci/dwc/pci-layerscape.c
> > +++ b/drivers/pci/dwc/pci-layerscape.c
> > @@ -239,12 +239,21 @@ static struct ls_pcie_drvdata ls2080_drvdata = {
> >  	.dw_pcie_ops = &dw_ls_pcie_ops,
> >  };
> >
> > +static struct ls_pcie_drvdata ls2088_drvdata = {
> > +	.lut_offset = 0x80000,
> > +	.ltssm_shift = 0,
> > +	.lut_dbg = 0x407fc,
> > +	.ops = &ls_pcie_host_ops,
> > +	.dw_pcie_ops = &dw_ls_pcie_ops,
> > +};
> > +
> >  static const struct of_device_id ls_pcie_of_match[] = {
> >  	{ .compatible = "fsl,ls1021a-pcie", .data = &ls1021_drvdata },
> >  	{ .compatible = "fsl,ls1043a-pcie", .data = &ls1043_drvdata },
> >  	{ .compatible = "fsl,ls1046a-pcie", .data = &ls1046_drvdata },
> >  	{ .compatible = "fsl,ls2080a-pcie", .data = &ls2080_drvdata },
> >  	{ .compatible = "fsl,ls2085a-pcie", .data = &ls2080_drvdata },
> > +	{ .compatible = "fsl,ls2088a-pcie", .data = &ls2088_drvdata },
> >  	{ },
> >  };
> >
> > --
> > 2.1.0.27.g96db324
> >
> >
> > _______________________________________________
> > linux-arm-kernel mailing list
> > linux-arm-kernel at lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

Thanks,
Zhiqiang
