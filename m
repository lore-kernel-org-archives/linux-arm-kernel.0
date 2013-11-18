From: andriy.shevchenko@intel.com (Shevchenko, Andriy)
Date: Mon, 18 Nov 2013 09:18:19 +0000
Subject: [PATCH 11/31] dma: add channel request API that supports
 deferred probe
In-Reply-To: <CAPcyv4heN3PFc+n2RDBviA0zvyU4jfi5VLOcQVR6oRPi1woPTA@mail.gmail.com>
References: <1384548866-13141-1-git-send-email-swarren@wwwdotorg.org>
 <1384548866-13141-12-git-send-email-swarren@wwwdotorg.org>
 <CAPcyv4heN3PFc+n2RDBviA0zvyU4jfi5VLOcQVR6oRPi1woPTA@mail.gmail.com>
Message-ID: <1384766276.14845.155.camel@smile>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2013-11-15 at 13:01 -0800, Dan Williams wrote:
> On Fri, Nov 15, 2013 at 12:54 PM, Stephen Warren <swarren@wwwdotorg.org> wrote:

> > Eventually, all drivers should be converted to this new API, the old API
> > removed, and the new API renamed to the more desirable name. 

I really would like to see more sensible and shorter names for the API
functions.

[]

> > acpi_dma_request_slave_chan_by_index() doesn't actually implement
> > deferred probe. Perhaps it should?

Yes it should, though I propose we will add this a bit later since we
will survive w/o it.

My comments regarding acpi-dma.c below.

[]

> > --- a/drivers/dma/acpi-dma.c
> > +++ b/drivers/dma/acpi-dma.c
> > @@ -334,7 +334,7 @@ static int acpi_dma_parse_fixed_dma(struct acpi_resource *res, void *data)
> >   * @dev:       struct device to get DMA request from
> >   * @index:     index of FixedDMA descriptor for @dev
> >   *
> > - * Returns pointer to appropriate dma channel on success or NULL on error.
> > + * Returns pointer to appropriate dma channel on success or an error pointer.
> >   */
> >  struct dma_chan *acpi_dma_request_slave_chan_by_index(struct device *dev,
> >                 size_t index)
> > @@ -349,10 +349,10 @@ struct dma_chan *acpi_dma_request_slave_chan_by_index(struct device *dev,

We use default value of chan if it's not found. Perhaps you have to
change it as well to something like ERR_PTR(-ENOENT).

[]

> > @@ -367,7 +367,7 @@ struct dma_chan *acpi_dma_request_slave_chan_by_index(struct device *dev,
> >         acpi_dev_free_resource_list(&resource_list);
> >
> >         if (dma_spec->slave_id < 0 || dma_spec->chan_id < 0)
> > -               return NULL;
> > +               return ERR_PTR(-ENODEV);

In this case I would rather use -ENODATA, since it means we have no
FixedDMA descriptor for the device under question.

[]

> >  struct dma_chan *acpi_dma_request_slave_chan_by_name(struct device *dev,
> >                 const char *name)
> > @@ -415,7 +415,7 @@ struct dma_chan *acpi_dma_request_slave_chan_by_name(struct device *dev,
> >         else if (!strcmp(name, "rx"))
> >                 index = 1;
> >         else
> > -               return NULL;
> > +               return ERR_PTR(-ENODEV);

Perhaps -EINVAL, since it means the input parameter kinda wrong.


-- 
Andy Shevchenko <andriy.shevchenko@intel.com>
Intel Finland Oy
---------------------------------------------------------------------
Intel Finland Oy
Registered Address: PL 281, 00181 Helsinki 
Business Identity Code: 0357606 - 4 
Domiciled in Helsinki 

This e-mail and any attachments may contain confidential material for
the sole use of the intended recipient(s). Any review or distribution
by others is strictly prohibited. If you are not the intended
recipient, please contact the sender and delete all copies.
