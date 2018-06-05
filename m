From: helgaas@kernel.org (Bjorn Helgaas)
Date: Tue, 5 Jun 2018 15:44:07 -0500
Subject: [PATCH] PCI: Clean up resource allocation in
 devm_of_pci_get_host_bridge_resources()
In-Reply-To: <CAHp75VdWhCDYt3jvii92g222WeHTvwX5e8Sthr0pknXvCgwHDA@mail.gmail.com>
References: <cover.1526375226.git.jan.kiszka@siemens.com>
 <3aeb2ed038cbce8fe744b614dc19d414555a7e8f.1526375226.git.jan.kiszka@siemens.com>
 <CAHp75VeUbjobse6uLeM4h_xXRUw+YUQUN+EOye67AJy77a5euQ@mail.gmail.com>
 <CAHp75VeM7_8+9QJjOypXaiBhpWP4B5KACdUQ-p3frbS3jPh=OQ@mail.gmail.com>
 <f35b2972-aa40-5397-facb-765cafe7c315@siemens.com>
 <CAHp75VdWhCDYt3jvii92g222WeHTvwX5e8Sthr0pknXvCgwHDA@mail.gmail.com>
Message-ID: <20180605204407.GA226399@bhelgaas-glaptop.roam.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 05, 2018 at 07:26:57PM +0300, Andy Shevchenko wrote:
> On Wed, May 16, 2018 at 3:31 PM, Jan Kiszka <jan.kiszka@siemens.com> wrote:
> > Instead of first allocating and then freeing memory for struct resource
> > in case we cannot parse a PCI resource from the device tree, work
> > against a local struct and kmemdup it when we decide to go with it.
> >
> 
> Bjorn, any comments on this?

I'm trying to finish up the v4.18 changes now, but I'll look at this later.
If it's urgent, let me know and I can look sooner.

> > Suggested-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> > Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> > ---
> >  drivers/pci/of.c | 14 ++++++--------
> >  1 file changed, 6 insertions(+), 8 deletions(-)
> >
> > diff --git a/drivers/pci/of.c b/drivers/pci/of.c
> > index b06585a1da75..fc0f906c5c25 100644
> > --- a/drivers/pci/of.c
> > +++ b/drivers/pci/of.c
> > @@ -266,7 +266,7 @@ int devm_of_pci_get_host_bridge_resources(struct device *dev,
> >                         struct list_head *resources, resource_size_t *io_base)
> >  {
> >         struct device_node *dev_node = dev->of_node;
> > -       struct resource *res;
> > +       struct resource *res, tmp_res;
> >         struct resource *bus_range;
> >         struct of_pci_range range;
> >         struct of_pci_range_parser parser;
> > @@ -320,18 +320,16 @@ int devm_of_pci_get_host_bridge_resources(struct device *dev,
> >                 if (range.cpu_addr == OF_BAD_ADDR || range.size == 0)
> >                         continue;
> >
> > -               res = devm_kzalloc(dev, sizeof(struct resource), GFP_KERNEL);
> > +               err = of_pci_range_to_resource(&range, dev_node, &tmp_res);
> > +               if (err)
> > +                       continue;
> > +
> > +               res = devm_kmemdup(dev, &tmp_res, sizeof(tmp_res), GFP_KERNEL);
> >                 if (!res) {
> >                         err = -ENOMEM;
> >                         goto failed;
> >                 }
> >
> > -               err = of_pci_range_to_resource(&range, dev_node, res);
> > -               if (err) {
> > -                       devm_kfree(dev, res);
> > -                       continue;
> > -               }
> > -
> >                 if (resource_type(res) == IORESOURCE_IO) {
> >                         if (!io_base) {
> >                                 dev_err(dev,
> > --
> > 2.13.6
> 
> 
> 
> -- 
> With Best Regards,
> Andy Shevchenko
