From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 9 Aug 2016 13:46:31 +0100
Subject: [PATCH 7/9] remoteproc: core: Add function to over-ride current
 resource table
In-Reply-To: <57A88D65.3060104@st.com>
References: <20160804092153.23032-1-lee.jones@linaro.org>
 <20160804092153.23032-8-lee.jones@linaro.org>
 <57A88D65.3060104@st.com>
Message-ID: <20160809124631.GB5243@dell>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 08 Aug 2016, loic pallardy wrote:

> Hi Lee
> 
> On 08/04/2016 11:21 AM, Lee Jones wrote:
> > Most of the new resource table handling function are now in place, so
> > it's time to put it all together.  Once new resource table information
> > has been requested, the structures will be held in a holding pen until
> > boot-time.  During boot-time rproc_apply_resource_overrides() will be
> > invoked which in turn will pull the new information out of the holding
> > pen and edit the table accordingly.
> > 
> > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> > ---
> >   drivers/remoteproc/remoteproc_core.c | 65 ++++++++++++++++++++++++++++++++++++
> >   1 file changed, 65 insertions(+)
> > 
> > diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
> > index 111350e..6b4e29a 100644
> > --- a/drivers/remoteproc/remoteproc_core.c
> > +++ b/drivers/remoteproc/remoteproc_core.c
> > @@ -1035,6 +1035,65 @@ rproc_add_resource_table_entry(struct rproc *rproc,
> >   	return table;
> >   }
> > 
> > +static struct resource_table*
> > +rproc_apply_resource_overrides(struct rproc *rproc,
> > +			       struct resource_table **orig_table,
> > +			       int *tablesz)
> > +{
> > +	struct rproc_request_resource *resource;
> > +	struct resource_table *table = *orig_table;
> > +	int size = *tablesz;
> > +
> > +	if (!table && size != 0) {
> > +		dev_err(&rproc->dev, "No table present but table size is set\n");
> > +		return ERR_PTR(-EINVAL);
> > +	}
> > +
> > +	mutex_lock(&rproc->lock);
> > +
> > +	rproc_dump_resource_table(rproc, table, size);
> It will be good to find a way to not dump resource table if debug is not
> activated. For the same reason as you mentioned in your patch 8, resource
> table parsing will waste CPUS cycles.

+1

I've been meaning to fix this, thanks.

> > +
> > +	if (!table) {
> > +		size = sizeof(*table);
> > +		table = devm_kzalloc(&rproc->dev, size, GFP_KERNEL);
> > +		if (!table) {
> > +			table = ERR_PTR(-ENOMEM);
> > +			goto out;
> > +		}
> > +		table->ver = 1;
> > +	}
> > +
> > +	list_for_each_entry(resource, &rproc->override_resources, node) {
> > +		int updated = 0;
> > +
> > +		/* If we already have a table, update it with the new values. */
> > +		updated = rproc_update_resource_table_entry(rproc, resource,
> > +							    table, size);
> > +		if (updated < 0) {
> > +			table = ERR_PTR(updated);
> > +			goto out;
> > +		}
> > +		if (updated)
> > +			continue;
> > +
> > +		/* Didn't find matching resource entry -- creating a new one. */
> > +		table = rproc_add_resource_table_entry(rproc, resource,
> > +						       table, &size);
> > +		if (IS_ERR(table))
> > +			goto out;
> > +
> > +		*orig_table = table;
> > +	}
> > +
> > +	rproc_dump_resource_table(rproc, table, size);
> ditto

Ditto

> > +
> > +	*tablesz = size;
> > +
> > + out:
> > +	mutex_unlock(&rproc->lock);
> > +	return table;
> > +}
> > +
> >   /*
> >    * take a firmware and boot a remote processor with it.
> >    */
> > @@ -1153,6 +1212,12 @@ static void rproc_fw_config_virtio(const struct firmware *fw, void *context)
> >   	if (!table)
> >   		goto out;
> > 
> > +	if (!list_empty(&rproc->override_resources)) {
> > +		table = rproc_apply_resource_overrides(rproc, &table, &tablesz);
> > +		if (IS_ERR(table))
> > +			goto out;
> > +	}
> > +
> >   	rproc->table_csum = crc32(0, table, tablesz);
> > 
> >   	/*
> > 

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
