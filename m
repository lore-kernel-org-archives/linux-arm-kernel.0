From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Tue, 28 Feb 2017 10:54:28 +0000
Subject: [PATCH 13/20] PCI: iproc-platform: update PCI config space remap
 function
In-Reply-To: <84a0b24b-3c88-b750-dd9e-1607bc67a0a8@broadcom.com>
References: <20170227151436.18698-1-lorenzo.pieralisi@arm.com>
 <20170227151436.18698-14-lorenzo.pieralisi@arm.com>
 <84a0b24b-3c88-b750-dd9e-1607bc67a0a8@broadcom.com>
Message-ID: <20170228105428.GD7439@red-moon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ray,

On Mon, Feb 27, 2017 at 01:21:39PM -0800, Ray Jui wrote:
> Hi Lorenzo,
> 
> On 2/27/2017 7:14 AM, Lorenzo Pieralisi wrote:
> > PCI configuration space should be mapped with a memory region type that
> > generates on the CPU host bus non-posted write transations. Update the
> > driver to use the devm_pci_remap_cfg* interface to make sure the correct
> > memory mappings for PCI configuration space are used.
> > 
> > Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> > Cc: Bjorn Helgaas <bhelgaas@google.com>
> > Cc: Ray Jui <rjui@broadcom.com>
> > Cc: Jon Mason <jonmason@broadcom.com>
> > ---
> >  drivers/pci/host/pcie-iproc-platform.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/pci/host/pcie-iproc-platform.c b/drivers/pci/host/pcie-iproc-platform.c
> > index f4909bb..b48d0db 100644
> > --- a/drivers/pci/host/pcie-iproc-platform.c
> > +++ b/drivers/pci/host/pcie-iproc-platform.c
> > @@ -67,7 +67,8 @@ static int iproc_pcie_pltfm_probe(struct platform_device *pdev)
> >  		return ret;
> >  	}
> >  
> > -	pcie->base = devm_ioremap(dev, reg.start, resource_size(&reg));
> > +	pcie->base = devm_pci_remap_cfgspace(dev, reg.start,
> > +					     resource_size(&reg));
> 
> Note these are NOT config space registers; instead, they are host
> controller registers. iProc PCIe controller access config space
> registers indirectly through two of the controller registers instead of
> directly mapped.

Yes but IIUC those registers that allow indirection live in the address
space pointed at by pcie->base, right ? Question is whether it is fine
to access those registers through mappings resulting on posted writes
and that's a question I need your help to answer as I said in the cover
letter.

Thanks a lot for flagging this up, that's exactly the feedback I need.

Lorenzo

> 
> Thanks,
> 
> Ray
> 
> >  	if (!pcie->base) {
> >  		dev_err(dev, "unable to map controller registers\n");
> >  		return -ENOMEM;
> > 
