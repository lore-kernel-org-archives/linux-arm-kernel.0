From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 9 Aug 2016 13:48:03 +0100
Subject: [PATCH 4/9] remoteproc: core: New API to add new resources to
 the resource table
In-Reply-To: <57A88C1B.5090206@st.com>
References: <20160804092153.23032-1-lee.jones@linaro.org>
 <20160804092153.23032-5-lee.jones@linaro.org>
 <57A88C1B.5090206@st.com>
Message-ID: <20160809124803.GC5243@dell>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 08 Aug 2016, loic pallardy wrote:

> Hi Lee,
> 
> After splitting this patch in 2, it may be good to add a debugfs entry to
> display current rsc associated to one rproc.

Happy to take suggestions to add functionality, but I would like to
prevent *this* set from suffering from feature creep.  Thus, I would
like to code-up your suggestion in a subsequent submission if it's all
the same to you.

> On 08/04/2016 11:21 AM, Lee Jones wrote:
> > In order to amend or add a new resource table entry we need a method
> > for a platform-specific to submit them. rproc_request_resource() is a
> > new public API which provides this functionality.
> > 
> > It is to be called between rproc_alloc() and rproc_add().
> > 
> > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> > ---
> >   drivers/remoteproc/remoteproc_core.c | 125 +++++++++++++++++++++++++++++++++++
> >   include/linux/remoteproc.h           |  21 ++++++
> >   2 files changed, 146 insertions(+)
> > 
> > diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
> > index 4914482..0abfa2b 100644
> > --- a/drivers/remoteproc/remoteproc_core.c
> > +++ b/drivers/remoteproc/remoteproc_core.c
> > @@ -793,6 +793,130 @@ static void rproc_resource_cleanup(struct rproc *rproc)
> >   	}
> >   }
> > 
> > +static void rproc_dump_resource_table(struct rproc *rproc,
> > +				      struct resource_table *table, int size)
> > +{
> > +	const char *types[] = {"carveout", "devmem", "trace", "vdev"};
> > +	struct device *dev = &rproc->dev;
> > +	struct fw_rsc_carveout *c;
> > +	struct fw_rsc_devmem *d;
> > +	struct fw_rsc_trace *t;
> > +	struct fw_rsc_vdev *v;
> > +	int i, j;
> > +
> > +	if (!table) {
> > +		dev_dbg(dev, "No resource table found\n");
> > +		return;
> > +	}
> > +
> > +	dev_dbg(dev, "Resource Table: Version %d with %d entries [size: %x]\n",
> > +		table->ver, table->num, size);
> > +
> > +	for (i = 0; i < table->num; i++) {
> > +		int offset = table->offset[i];
> > +		struct fw_rsc_hdr *hdr = (void *)table + offset;
> > +		void *rsc = (void *)hdr + sizeof(*hdr);
> > +
> > +		switch (hdr->type) {
> > +		case RSC_CARVEOUT:
> > +			c = rsc;
> > +			dev_dbg(dev, "Entry %d is of type %s\n", i, types[hdr->type]);
> > +			dev_dbg(dev, "  Device Address 0x%x\n", c->da);
> > +			dev_dbg(dev, "  Physical Address 0x%x\n", c->pa);
> > +			dev_dbg(dev, "  Length 0x%x Bytes\n", c->len);
> > +			dev_dbg(dev, "  Flags 0x%x\n", c->flags);
> > +			dev_dbg(dev, "  Reserved (should be zero) [%d]\n", c->reserved);
> > +			dev_dbg(dev, "  Name %s\n\n", c->name);
> > +			break;
> > +		case RSC_DEVMEM:
> > +			d = rsc;
> > +			dev_dbg(dev, "Entry %d is of type %s\n", i, types[hdr->type]);
> > +			dev_dbg(dev, "  Device Address 0x%x\n", d->da);
> > +			dev_dbg(dev, "  Physical Address 0x%x\n", d->pa);
> > +			dev_dbg(dev, "  Length 0x%x Bytes\n", d->len);
> > +			dev_dbg(dev, "  Flags 0x%x\n", d->flags);
> > +			dev_dbg(dev, "  Reserved (should be zero) [%d]\n", d->reserved);
> > +			dev_dbg(dev, "  Name %s\n\n", d->name);
> > +			break;
> > +		case RSC_TRACE:
> > +			t = rsc;
> > +			dev_dbg(dev, "Entry %d is of type %s\n", i, types[hdr->type]);
> > +			dev_dbg(dev, "  Device Address 0x%x\n", t->da);
> > +			dev_dbg(dev, "  Length 0x%x Bytes\n", t->len);
> > +			dev_dbg(dev, "  Reserved (should be zero) [%d]\n", t->reserved);
> > +			dev_dbg(dev, "  Name %s\n\n", t->name);
> > +			break;
> > +		case RSC_VDEV:
> > +			v = rsc;
> > +			dev_dbg(dev, "Entry %d is of type %s\n", i, types[hdr->type]);
> > +
> > +			dev_dbg(dev, "  ID %d\n", v->id);
> > +			dev_dbg(dev, "  Notify ID %d\n", v->notifyid);
> > +			dev_dbg(dev, "  Device features 0x%x\n", v->dfeatures);
> > +			dev_dbg(dev, "  Guest features 0x%x\n", v->gfeatures);
> > +			dev_dbg(dev, "  Config length 0x%x\n", v->config_len);
> > +			dev_dbg(dev, "  Status 0x%x\n", v->status);
> > +			dev_dbg(dev, "  Number of vrings %d\n", v->num_of_vrings);
> > +			dev_dbg(dev, "  Reserved (should be zero) [%d][%d]\n\n",
> > +				v->reserved[0], v->reserved[1]);
> > +
> > +			for (j = 0; j < v->num_of_vrings; j++) {
> > +				dev_dbg(dev, "  Vring %d\n", j);
> > +				dev_dbg(dev, "    Device Address 0x%x\n", v->vring[j].da);
> > +				dev_dbg(dev, "    Alignment %d\n", v->vring[j].align);
> > +				dev_dbg(dev, "    Number of buffers %d\n", v->vring[j].num);
> > +				dev_dbg(dev, "    Notify ID %d\n", v->vring[j].notifyid);
> > +				dev_dbg(dev, "    Reserved (should be zero) [%d]\n\n",
> > +					v->vring[j].reserved);
> > +			}
> > +			break;
> > +		default:
> > +			dev_dbg(dev, "Invalid resource type found: %d [hdr: %p]\n",
> > +				hdr->type, hdr);
> > +			return;
> > +		}
> > +	}
> > +}
> > +
> > +int rproc_request_resource(struct rproc *rproc, u32 type, void *resource)
> > +{
> > +	struct device *dev = &rproc->dev;
> > +	struct rproc_request_resource *request;
> > +	int size;
> > +
> > +	request = devm_kzalloc(dev, sizeof(*request), GFP_KERNEL);
> > +	if (!request)
> > +		return -ENOMEM;
> > +
> > +	switch (type) {
> > +	case RSC_CARVEOUT:
> > +		size = sizeof(struct fw_rsc_carveout);
> > +		break;
> > +	case RSC_DEVMEM:
> > +		size = sizeof(struct fw_rsc_devmem);
> > +		break;
> > +	case RSC_TRACE:
> > +		size = sizeof(struct fw_rsc_trace);
> > +		break;
> > +	default:
> > +		dev_err(dev, "Unsupported resource type: %d\n", type);
> > +		return -EINVAL;
> > +	}
> > +
> > +	request->resource = devm_kzalloc(dev, size, GFP_KERNEL);
> > +	if (!request->resource)
> > +		return -ENOMEM;
> > +
> > +	memcpy(request->resource, resource, size);
> > +	request->type = type;
> > +	request->size = size;
> > +
> > +	list_add_tail(&request->node, &rproc->override_resources);
> > +
> > +	return 0;
> > +}
> > +EXPORT_SYMBOL(rproc_request_resource);
> > +
> >   /*
> >    * take a firmware and boot a remote processor with it.
> >    */
> > @@ -1452,6 +1576,7 @@ struct rproc *rproc_alloc(struct device *dev, const char *name,
> >   	INIT_LIST_HEAD(&rproc->mappings);
> >   	INIT_LIST_HEAD(&rproc->traces);
> >   	INIT_LIST_HEAD(&rproc->rvdevs);
> > +	INIT_LIST_HEAD(&rproc->override_resources);
> > 
> >   	INIT_WORK(&rproc->crash_handler, rproc_crash_handler_work);
> >   	init_completion(&rproc->crash_comp);
> > diff --git a/include/linux/remoteproc.h b/include/linux/remoteproc.h
> > index 3608d20..c620177 100644
> > --- a/include/linux/remoteproc.h
> > +++ b/include/linux/remoteproc.h
> > @@ -323,6 +323,25 @@ struct rproc_mem_entry {
> >   	struct list_head node;
> >   };
> > 
> > +/**
> > + * struct rproc_requested_resources - add a resource to the resource table
> > + *
> > + * @resource:	pointer to a 'struct fw_rsc_*' resource
> > + * @type:	'fw_resource_type' resource type
> > + * @size:	size of resource
> > + * @node:	list node
> > + *
> > + * Resources can be added by platform-specific rproc drivers calling
> > + * rproc_request_resource()
> > + *
> > + */
> > +struct rproc_request_resource {
> > +	void *resource;
> > +	u32 type;
> > +	u32 size;
> > +	struct list_head node;
> > +};
> > +
> >   struct rproc;
> > 
> >   /**
> > @@ -429,6 +448,7 @@ struct rproc {
> >   	int num_traces;
> >   	struct list_head carveouts;
> >   	struct list_head mappings;
> > +	struct list_head override_resources;
> >   	struct completion firmware_loading_complete;
> >   	u32 bootaddr;
> >   	struct list_head rvdevs;
> > @@ -487,6 +507,7 @@ struct rproc_vdev {
> >   	u32 rsc_offset;
> >   };
> > 
> > +int rproc_request_resource(struct rproc *rproc, u32 type, void *res);
> >   struct rproc *rproc_alloc(struct device *dev, const char *name,
> >   				const struct rproc_ops *ops,
> >   				const char *firmware, int len);
> > 

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
