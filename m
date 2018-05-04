From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Fri, 4 May 2018 17:44:01 +0100
Subject: [PATCH v2 07/10] PCI: Convert of_pci_get_host_bridge_resources()
 users to devm variant
In-Reply-To: <dbfa80fb-5fe8-3ccd-6886-4604ef9e058b@mentor.com>
References: <cover.1525067324.git.jan.kiszka@siemens.com>
 <ed3e6df4feca5febefa14716d62aaddd5b4a39d1.1525067324.git.jan.kiszka@siemens.com>
 <dbfa80fb-5fe8-3ccd-6886-4604ef9e058b@mentor.com>
Message-ID: <20180504164401.GA17043@e107981-ln.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 03, 2018 at 10:18:24AM +0300, Vladimir Zapolskiy wrote:
> Hi Jan,
> 
> On 04/30/2018 08:48 AM, Jan Kiszka wrote:
> > From: Jan Kiszka <jan.kiszka@siemens.com>
> > 
> > Straightforward for all of them, no more leaks afterwards.
> > 
> > CC: Jingoo Han <jingoohan1@gmail.com>
> > CC: Joao Pinto <Joao.Pinto@synopsys.com>
> > CC: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> > Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> > Acked-by: Jingoo Han <jingoo1han@gmail.com>
> 
> [snip]
> 
> > diff --git a/drivers/pci/host/pcie-rcar.c b/drivers/pci/host/pcie-rcar.c
> > index 6ab28f29ac6a..6eb36c924983 100644
> > --- a/drivers/pci/host/pcie-rcar.c
> > +++ b/drivers/pci/host/pcie-rcar.c
> > @@ -1067,12 +1067,11 @@ static int rcar_pcie_parse_request_of_pci_ranges(struct rcar_pcie *pci)
> >  {
> >  	int err;
> >  	struct device *dev = pci->dev;
> > -	struct device_node *np = dev->of_node;
> >  	resource_size_t iobase;
> >  	struct resource_entry *win, *tmp;
> >  
> > -	err = of_pci_get_host_bridge_resources(np, 0, 0xff, &pci->resources,
> > -					       &iobase);
> > +	err = devm_of_pci_get_host_bridge_resources(dev, 0, 0xff,
> > +						    &pci->resources, &iobase);
> >  	if (err)
> >  		return err;
> >  
> 
> this one snippet is obsoleted by https://patchwork.ozlabs.org/patch/904326/
> 
> If 08/10 remains a deprecation, then it is sufficient to exclude the R-Car change,
> otherwise I hope maintainers can deal with the proper ordering.

Isn't applying your patch:

https://patchwork.ozlabs.org/patch/904326/

and dropping the rcar hunk from this patch enough ?

Lorenzo
