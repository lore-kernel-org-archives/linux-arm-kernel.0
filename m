From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Tue, 19 Jan 2016 09:41:50 +0000
Subject: [PATCH v9 5/6] PCI: generic: Make pci-host-generic driver numa
 aware
In-Reply-To: <CAFpQJXXESn1EA5kotVOH2oLbRUSpOLf6+MeWG1pY_GhUP+4vVQ@mail.gmail.com>
References: <1453134965-6125-1-git-send-email-gkulkarni@caviumnetworks.com>
 <1453134965-6125-6-git-send-email-gkulkarni@caviumnetworks.com>
 <569D23AF.9050503@gmail.com>
 <CAFpQJXXESn1EA5kotVOH2oLbRUSpOLf6+MeWG1pY_GhUP+4vVQ@mail.gmail.com>
Message-ID: <20160119094150.GA4991@red-moon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 19, 2016 at 11:28:56AM +0530, Ganapatrao Kulkarni wrote:
> On Mon, Jan 18, 2016 at 11:11 PM, David Daney <ddaney.cavm@gmail.com> wrote:
> > On 01/18/2016 08:36 AM, Ganapatrao Kulkarni wrote:
> >>
> >> update numa_node of device associated with pci bus.
> >> moved down devm_kzalloc to allocate from node memory.
> >>
> >> Signed-off-by: Ganapatrao Kulkarni <gkulkarni@caviumnetworks.com>
> >> ---
> >>   drivers/pci/host/pci-host-generic.c | 9 ++++++---
> >>   1 file changed, 6 insertions(+), 3 deletions(-)
> >>
> >> diff --git a/drivers/pci/host/pci-host-generic.c
> >> b/drivers/pci/host/pci-host-generic.c
> >> index 5434c90..0e1ce06 100644
> >> --- a/drivers/pci/host/pci-host-generic.c
> >> +++ b/drivers/pci/host/pci-host-generic.c
> >> @@ -215,11 +215,9 @@ static int gen_pci_probe(struct platform_device
> >> *pdev)
> >>         const struct of_device_id *of_id;
> >>         struct device *dev = &pdev->dev;
> >>         struct device_node *np = dev->of_node;
> >> -       struct gen_pci *pci = devm_kzalloc(dev, sizeof(*pci), GFP_KERNEL);
> >> +       struct gen_pci *pci;
> >>         struct pci_bus *bus, *child;
> >>
> >> -       if (!pci)
> >> -               return -ENOMEM;
> >>
> >>         type = of_get_property(np, "device_type", NULL);
> >>         if (!type || strcmp(type, "pci")) {
> >> @@ -230,6 +228,11 @@ static int gen_pci_probe(struct platform_device
> >> *pdev)
> >>         of_pci_check_probe_only();
> >>
> >>         of_id = of_match_node(gen_pci_of_match, np);
> >> +       set_dev_node(dev, of_node_to_nid(np));
> >
> >
> > This shouldn't be done in individual platform_drivers, but instead in the
> > device probing code.
> >
> > There is code that does this in drivers/of/platform.c and
> > drivers/of/device.c  Is that not being called for the pci-host-gweneric
> > devices?  If not, we should figure out why, and perhaps attempt to fix it
> > rather than doing it here.
> is it more appropriate to call of_platform_device_create ?

That's already done to create the platform device by OF core when
populating devices from DT, what David suggested is that you should
add set_dev_node() to core OF code instead of adding it specifically
to the PCI host generic code.

Lorenzo
