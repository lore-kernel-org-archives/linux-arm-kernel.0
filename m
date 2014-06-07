From: grant.likely@secretlab.ca (Grant Likely)
Date: Sat, 07 Jun 2014 06:59:53 +0100
Subject: [PATCH v7 1/7] of: Provide function to request and map memory
In-Reply-To: <CAL_Jsq+KS8W6kZpCSpd68Oku7neFxPVLct1j=AYaXnyvOD3tGA@mail.gmail.com>
References: <1401989181-4712-1-git-send-email-matthias.bgg@gmail.com>
 <1401989181-4712-2-git-send-email-matthias.bgg@gmail.com>
 <CAL_Jsq+KS8W6kZpCSpd68Oku7neFxPVLct1j=AYaXnyvOD3tGA@mail.gmail.com>
Message-ID: <20140607055953.569D6C4099E@trevor.secretlab.ca>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 6 Jun 2014 10:19:28 -0500, Rob Herring <robherring2@gmail.com> wrote:
> On Thu, Jun 5, 2014 at 12:26 PM, Matthias Brugger
> <matthias.bgg@gmail.com> wrote:
> > A call to of_iomap does not request the memory region.
> > This patch adds the function of_io_request_and_map which requests
> > the memory region before mapping it.
> >
> > Signed-off-by: Matthias Brugger <matthias.bgg@gmail.com>
> > ---
> >  drivers/of/address.c       |   28 ++++++++++++++++++++++++++++
> >  include/linux/of_address.h |    8 ++++++++
> >  2 files changed, 36 insertions(+)
> >
> > diff --git a/drivers/of/address.c b/drivers/of/address.c
> > index cb4242a..c55b107 100644
> > --- a/drivers/of/address.c
> > +++ b/drivers/of/address.c
> > @@ -721,3 +721,31 @@ void __iomem *of_iomap(struct device_node *np, int index)
> >         return ioremap(res.start, resource_size(&res));
> >  }
> >  EXPORT_SYMBOL(of_iomap);
> > +
> > +/**
> > + * of_io_request_and_map - Requests a resource and maps the memory mapped IO
> > + *                        for a given device_node
> 
> I believe docbook requires this to be 1 line.
> 
> > + * @device:    the device whose io range will be mapped
> > + * @index:     index of the io range
> > + * @name:      name of the resource
> > + *
> > + * Returns a pointer to the requested and mapped memory
> > + */
> > +void __iomem *of_io_request_and_map(struct device_node *np, int index, char *name)
> > +{
> > +       struct resource res;
> > +       void __iomem *mem;
> > +
> > +       if (of_address_to_resource(np, index, &res))
> > +               return NULL;
> > +
> > +       if (!request_mem_region(res.start, resource_size(&res), name))
> 
> Use the np->name here and drop the name parameter.

Name here would be the name of the owner (the driver), not the name of
the node. Passing the name separately is fine by me.

Acked-by: Grant Likely <grant.likely@linaro.org>

You can merge this with the rest of the series.

g.

> 
> > +               return NULL;
> > +
> > +       mem = ioremap(res.start, resource_size(&res));
> > +       if (!mem)
> > +               release_mem_region(res.start, resource_size(&res));
> > +
> > +       return mem;
> > +}
> > +EXPORT_SYMBOL(of_io_request_and_map);
> > diff --git a/include/linux/of_address.h b/include/linux/of_address.h
> > index 5f6ed6b..725b875 100644
> > --- a/include/linux/of_address.h
> > +++ b/include/linux/of_address.h
> > @@ -96,6 +96,8 @@ static inline struct of_pci_range *of_pci_range_parser_one(
> >  extern int of_address_to_resource(struct device_node *dev, int index,
> >                                   struct resource *r);
> >  void __iomem *of_iomap(struct device_node *node, int index);
> > +void __iomem *of_io_request_and_map(struct device_node *device,
> > +                                       int index, char *name);
> >  #else
> >  static inline int of_address_to_resource(struct device_node *dev, int index,
> >                                          struct resource *r)
> > @@ -107,6 +109,12 @@ static inline void __iomem *of_iomap(struct device_node *device, int index)
> >  {
> >         return NULL;
> >  }
> > +
> > +static inline void __iomem *of_io_request_and_map(struct device_node *device,
> > +                                       int index, char *name)
> > +{
> > +       return NULL;
> > +}
> >  #endif
> >
> >  #if defined(CONFIG_OF_ADDRESS) && defined(CONFIG_PCI)
> > --
> > 1.7.9.5
> >
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
