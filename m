From: helgaas@kernel.org (Bjorn Helgaas)
Date: Thu, 3 Aug 2017 13:19:15 -0500
Subject: [PATCH] PCI: layerscape: Add support for ls2088a and ls1088a
In-Reply-To: <AM5PR0402MB2771BBF476E6A3DEFADE43F484B10@AM5PR0402MB2771.eurprd04.prod.outlook.com>
References: <1499333984-17668-1-git-send-email-Zhiqiang.Hou@nxp.com>
 <20170802212942.GA7667@bhelgaas-glaptop.roam.corp.google.com>
 <AM5PR0402MB2771BBF476E6A3DEFADE43F484B10@AM5PR0402MB2771.eurprd04.prod.outlook.com>
Message-ID: <20170803181915.GU20308@bhelgaas-glaptop.roam.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 03, 2017 at 03:35:46AM +0000, Z.q. Hou wrote:
> Hi Bjorn,
> 
> Thanks a lot for your comments!
> 
> > -----Original Message-----
> > From: Bjorn Helgaas [mailto:helgaas at kernel.org]
> > Sent: 2017?8?3? 5:30
> > To: Z.q. Hou <zhiqiang.hou@nxp.com>
> > Cc: linux-pci at vger.kernel.org; linux-arm-kernel at lists.infradead.org;
> > bhelgaas at google.com; robh+dt at kernel.org; Minghuan Lian
> > <minghuan.Lian@freescale.com>; Mingkai Hu <mingkai.hu@freescale.com>;
> > Roy Zang <tie-fei.zang@freescale.com>
> > Subject: Re: [PATCH] PCI: layerscape: Add support for ls2088a and ls1088a
> > 
> > [+cc Minghuan, Mingkai, Roy]
> > 
> > On Thu, Jul 06, 2017 at 05:39:44PM +0800, Zhiqiang Hou wrote:
> > > From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> > >
> > > The ls1088a and ls2088a has the same PCIe controller, so the ls1088a
> > > will reuse the ls2088a's pcie compatible.
> > >
> > > Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> > > ---
> > >  Documentation/devicetree/bindings/pci/layerscape-pci.txt | 1 +
> > >  drivers/pci/dwc/pci-layerscape.c                         | 9
> > +++++++++
> > >  2 files changed, 10 insertions(+)
> > >
> > > diff --git a/Documentation/devicetree/bindings/pci/layerscape-pci.txt
> > > b/Documentation/devicetree/bindings/pci/layerscape-pci.txt
> > > index ee1c72d5..cb735e1 100644
> > > --- a/Documentation/devicetree/bindings/pci/layerscape-pci.txt
> > > +++ b/Documentation/devicetree/bindings/pci/layerscape-pci.txt
> > > @@ -15,6 +15,7 @@ Required properties:
> > >  - compatible: should contain the platform identifier such as:
> > >          "fsl,ls1021a-pcie", "snps,dw-pcie"
> > >          "fsl,ls2080a-pcie", "fsl,ls2085a-pcie", "snps,dw-pcie"
> > > +        "fsl,ls2088a-pcie", "fsl,ls1088a-pcie"
> > 
> > You add "fsl,ls1088a-pcie" here, but not in the ls_pcie_of_match[]
> > table in the driver, so I don't think this will actually make the
> > driver claim ls1088a devices, will it?
> 
> I mean the ls1088a pcie DT nodes will use the "fsl,ls2088a-pcie"
> too, so I didn't add an entry for ls1088a pcie to
> ls_pcie_of_match[].  Is it reasonable? Or it's better to add
> "fsl,ls1088a-pcie" to ls_pcie_of_match[], then ls1088a pcie DT nodes
> use the compatible string "fsl,ls1088a-pcie"?

Your binding says "fsl,ls1088a-pcie" is a valid value for
"compatible".  But if a DT actually *uses* that, I don't think the
driver will claim it.

If you want to describe ls1088a devices with "fsl,ls2088a-pcie", I
think you could do that, but then why would you even mention
"fsl,ls1088a-pcie" in the binding?

Personally, if ls1088a and ls2088a are different in any way, I would
think you should use different identifiers for them (and add them both
to the binding and to the driver).  That way if a future feature
depends on the difference, you'll have a way to test for it.

But I'm not a DT guy.  Maybe Rob has a better recommendation?

Bjorn
