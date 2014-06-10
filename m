From: grant.likely@secretlab.ca (Grant Likely)
Date: Tue, 10 Jun 2014 13:31:06 +0100
Subject: [PATCH v7 1/7] of: Provide function to request and map memory
In-Reply-To: <CAL_Jsq+yi+fdN1vHK6Wwx7Jzmvz3qd6z=8sO8+q==YRmBCGdww@mail.gmail.com>
References: <1401989181-4712-1-git-send-email-matthias.bgg@gmail.com>
 <1401989181-4712-2-git-send-email-matthias.bgg@gmail.com>
 <CAL_Jsq+KS8W6kZpCSpd68Oku7neFxPVLct1j=AYaXnyvOD3tGA@mail.gmail.com>
 <20140607055953.569D6C4099E@trevor.secretlab.ca>
 <CAL_Jsq+yi+fdN1vHK6Wwx7Jzmvz3qd6z=8sO8+q==YRmBCGdww@mail.gmail.com>
Message-ID: <CACxGe6uthx3hzgDjEbHs+9itjLSVX1fWX=F7Y2S0z2F=s56G5A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 9, 2014 at 3:36 PM, Rob Herring <robherring2@gmail.com> wrote:
> On Sat, Jun 7, 2014 at 12:59 AM, Grant Likely <grant.likely@secretlab.ca> wrote:
>> On Fri, 6 Jun 2014 10:19:28 -0500, Rob Herring <robherring2@gmail.com> wrote:
>>> On Thu, Jun 5, 2014 at 12:26 PM, Matthias Brugger
>>> <matthias.bgg@gmail.com> wrote:
>>> > A call to of_iomap does not request the memory region.
>>> > This patch adds the function of_io_request_and_map which requests
>>> > the memory region before mapping it.
>>> >
>>> > Signed-off-by: Matthias Brugger <matthias.bgg@gmail.com>
>>> > ---
>>> >  drivers/of/address.c       |   28 ++++++++++++++++++++++++++++
>>> >  include/linux/of_address.h |    8 ++++++++
>>> >  2 files changed, 36 insertions(+)
>>> >
>>> > diff --git a/drivers/of/address.c b/drivers/of/address.c
>>> > index cb4242a..c55b107 100644
>>> > --- a/drivers/of/address.c
>>> > +++ b/drivers/of/address.c
>>> > @@ -721,3 +721,31 @@ void __iomem *of_iomap(struct device_node *np, int index)
>>> >         return ioremap(res.start, resource_size(&res));
>>> >  }
>>> >  EXPORT_SYMBOL(of_iomap);
>>> > +
>>> > +/**
>>> > + * of_io_request_and_map - Requests a resource and maps the memory mapped IO
>>> > + *                        for a given device_node
>>>
>>> I believe docbook requires this to be 1 line.
>>>
>>> > + * @device:    the device whose io range will be mapped
>>> > + * @index:     index of the io range
>>> > + * @name:      name of the resource
>>> > + *
>>> > + * Returns a pointer to the requested and mapped memory
>>> > + */
>>> > +void __iomem *of_io_request_and_map(struct device_node *np, int index, char *name)
>>> > +{
>>> > +       struct resource res;
>>> > +       void __iomem *mem;
>>> > +
>>> > +       if (of_address_to_resource(np, index, &res))
>>> > +               return NULL;
>>> > +
>>> > +       if (!request_mem_region(res.start, resource_size(&res), name))
>>>
>>> Use the np->name here and drop the name parameter.
>>
>> Name here would be the name of the owner (the driver), not the name of
>> the node. Passing the name separately is fine by me.
>
> This function is for when there is no driver. If there is a driver,
> the devm_* functions should be used. I would like to see some standard
> naming and consistency here rather than allowing random strings or
> NULL to be passed by the caller.

The node name doesn't provide a whole lot of help here though because
we want to identify the code creating the resource, not the node. I'm
not going to make a big deal about it. I've told Matthias on IRC that
he can go ahead and merge it because it is a very minor issue. If you
feel strongly about it, then we'll get him to change it or do a
follow-up patch to change the function signature.

g.
