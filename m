From: maitysanchayan@gmail.com (maitysanchayan at gmail.com)
Date: Tue, 2 Aug 2016 11:04:28 +0530
Subject: [PATCH v4 3/5] nvmem: core: Add consumer API to get nvmem cell
 from node
In-Reply-To: <577FE19E.4000100@linaro.org>
References: <cover.1467872014.git.maitysanchayan@gmail.com>
 <0e6294d931bf181376a6f4e1a86df3f6c6a5d575.1467872014.git.maitysanchayan@gmail.com>
 <577E1E79.4090809@linaro.org>
 <20160707123350.GA18563@Sanchayan-Arch.localdomain>
 <577E5634.7020805@linaro.org>
 <20160707134811.GA2692@Sanchayan-Arch.localdomain>
 <577FC9BA.2020402@linaro.org>
 <951a63bf305d7df6486b652974cdb3c0@agner.ch>
 <577FE19E.4000100@linaro.org>
Message-ID: <20160802053428.GA1554@Sanchayan-Arch.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 16-07-08 18:23:42, Srinivas Kandagatla wrote:
> 
> 
> On 08/07/16 17:42, Stefan Agner wrote:
> > On 2016-07-08 08:41, Srinivas Kandagatla wrote:
> > > On 07/07/16 14:48, maitysanchayan at gmail.com wrote:
> > > > Hello Srinivas,
> > > > 
> > > > On 16-07-07 1
> 
> ...
> 
> > > > > > 
> > > > > > Our requirement is to be able to pass the soc node pointer and then
> > > > > > be able to get a nvmem cell by specifying it's name. So for our case
> > > > > 
> > > > > Why?
> > > > 
> > > > Sorry for not providing the background directly. The patches before this
> > > > series used that approach. In the previous discussions it has been pointed
> > > > out that it is not acceptable to have additional device tree bindings for
> > > > providing data that the driver wants at the SoC node level or to have bindings
> > > > just for the SoC bus driver alone since we aren't really describing the
> > > > hardware.
> > > > 
> > > SOC driver seems to search for an arbitrary node by its name, which is
> > > not a binding and can break anytime in cases If the scope of nvmem
> > > provider is out of soc node or if the nvmem cells are not named as
> > > expected. That looks very fragile.
> > 
> > In that case, that just "won't happen" because the soc driver is a very
> > soc specific driver only used for this device tree. We it will always
> > bind to that high level soc node.
> > 
> > > 
> > > If the soc node is actual consumer of nvmem cells, I see no reason why
> > > we should not use proper nvmem bindings?
> > 
> > There is a reason: We don't describe the hardware with it...
> > 
> > The cfg0/cfg1 register which Sanchayan needs to read in the soc bus
> > driver are just two register with a unique ID of the SoC. In whatever
> 
> "Unique ID of the SOC" doesn't this mean that its a part of soc hw
> description/configuration/setup?
> 
> Am still not clear why this setup any different to other use cases like mac
> address/calibration data?
> 
> I still feel that this should be described in the DT.
> 
> Rob,
>  What do you think?

Hello Rob,

Can you please comment?

Regards,
Sanchayan.

> 
> 
> > driver throughout the system we use that ID (e.g. in a random generator
> > for initialization) we never describe an actual hardware relation... Its
> > just software and how we use that unique ID. The device tree is ment to
> > describe hardware. Hence the NVMEM consumer binding is not suited for
> > such NVMEM cells...
> > 
> > By describing the NVMEM cells location in device tree (producer API, the
> > NVMEM cells are in hardware at that location, so using the device tree
> > for that part is fine) and hard coding the NVMEM cell we need in the
> > driver code we don't violate the device tree matra "describe the
> > hardware"...
> 
> IMHO, We should indeed describe the SOC hardware and its relationship w.r.t
> to nvmem provider in device tree. Reasoning being these both are some form
> of IP blocks/hw which depend on each other.
> 
> > 
> > Looking-up the nodes direcly is what Rob suggested here:
> > https://lkml.org/lkml/2016/5/23/573
> 
> I did read this, I was not convinced that we should do a direct lookup for
> nvmem cells.
> 
> thanks,
> srini
> > 
> > > 
> > > Given the fact that the patch is potentially bypassing the nvmem
> > > bindings, am not happy to take it!
> > 
> > If you can provide a solution acceptable by the device tree folks and
> > works without this patch, I am happy to do it...
> 
> 
> > 
> > Btw, I am not entirely happy with the API name, but did not had a better
> > idea... And we we should probably add a note that the device tree
> > consumer binding is the preferred way to do it.
> > 
> > --
> > Stefan
> > 
> > 
> > > 
> > > thanks,
> > > srini
> > > 
> > > > For the discussion,
> > > > https://lkml.org/lkml/2016/5/23/573
> > > > https://lkml.org/lkml/2016/5/2/71
> > > > 
> > > > Regards,
> > > > Sanchayan.
> > > > 
> > > > 
> > > > > 
> > > > > > ocotp node has cfg0 and cfg1 which we want but we cannot use existing
> > > > > > nvmem consumer API since that requires having the nvmem consumer properties
> > > > > > in the node we are binding to viz. is a direct nvmem consumer.
> > > > > > 
> > > > > > Regards,
> > > > > > Sanchayan.
> > > > > > 
> > > > > > > 
> > > > > > > thanks,
> > > > > > > srini
> > > > > > > > 
> > > > > > > > Parent node can also be the of_node of the main SoC device
> > > > > > > > node.
> > > > > > > > 
> > > > > > > > Signed-off-by: Sanchayan Maity <maitysanchayan@gmail.com>
> > > > > > > > ---
> > > > > > > >      drivers/nvmem/core.c           | 44 +++++++++++++++++++++++++++++-------------
> > > > > > > >      include/linux/nvmem-consumer.h |  1 +
> > > > > > > >      2 files changed, 32 insertions(+), 13 deletions(-)
> > > > > > > > 
> > > > > > > > diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
> > > > > > > > index 965911d..470abee 100644
> > > > > > > > --- a/drivers/nvmem/core.c
> > > > > > > > +++ b/drivers/nvmem/core.c
> > > > > > > > @@ -743,29 +743,21 @@ static struct nvmem_cell *nvmem_cell_get_from_list(const char *cell_id)
> > > > > > > > 
> > > > > > > >      #if IS_ENABLED(CONFIG_NVMEM) && IS_ENABLED(CONFIG_OF)
> > > > > > > >      /**
> > > > > > > > - * of_nvmem_cell_get() - Get a nvmem cell from given device node and cell id
> > > > > > > > + * of_nvmem_cell_get_direct() - Get a nvmem cell from given device node
> > > > > > > >       *
> > > > > > > > - * @dev node: Device tree node that uses the nvmem cell
> > > > > > > > - * @id: nvmem cell name from nvmem-cell-names property.
> > > > > > > > + * @dev node: Device tree node that uses nvmem cell
> > > > > > > >       *
> > > > > > > >       * Return: Will be an ERR_PTR() on error or a valid pointer
> > > > > > > >       * to a struct nvmem_cell.  The nvmem_cell will be freed by the
> > > > > > > >       * nvmem_cell_put().
> > > > > > > >       */
> > > > > > > > -struct nvmem_cell *of_nvmem_cell_get(struct device_node *np,
> > > > > > > > -					    const char *name)
> > > > > > > > +struct nvmem_cell *of_nvmem_cell_get_direct(struct device_node *cell_np)
> > > > > > > >      {
> > > > > > > > -	struct device_node *cell_np, *nvmem_np;
> > > > > > > > +	struct device_node *nvmem_np;
> > > > > > > >      	struct nvmem_cell *cell;
> > > > > > > >      	struct nvmem_device *nvmem;
> > > > > > > >      	const __be32 *addr;
> > > > > > > > -	int rval, len, index;
> > > > > > > > -
> > > > > > > > -	index = of_property_match_string(np, "nvmem-cell-names", name);
> > > > > > > > -
> > > > > > > > -	cell_np = of_parse_phandle(np, "nvmem-cells", index);
> > > > > > > > -	if (!cell_np)
> > > > > > > > -		return ERR_PTR(-EINVAL);
> > > > > > > > +	int rval, len;
> > > > > > > > 
> > > > > > > >      	nvmem_np = of_get_next_parent(cell_np);
> > > > > > > >      	if (!nvmem_np)
> > > > > > > > @@ -824,6 +816,32 @@ err_mem:
> > > > > > > > 
> > > > > > > >      	return ERR_PTR(rval);
> > > > > > > >      }
> > > > > > > > +EXPORT_SYMBOL_GPL(of_nvmem_cell_get_direct);
> > > > > > > > +
> > > > > > > > +/**
> > > > > > > > + * of_nvmem_cell_get() - Get a nvmem cell from given device node and cell id
> > > > > > > > + *
> > > > > > > > + * @dev node: Device tree node that uses the nvmem cell
> > > > > > > > + * @id: nvmem cell name from nvmem-cell-names property.
> > > > > > > > + *
> > > > > > > > + * Return: Will be an ERR_PTR() on error or a valid pointer
> > > > > > > > + * to a struct nvmem_cell.  The nvmem_cell will be freed by the
> > > > > > > > + * nvmem_cell_put().
> > > > > > > > + */
> > > > > > > > +struct nvmem_cell *of_nvmem_cell_get(struct device_node *np,
> > > > > > > > +					    const char *name)
> > > > > > > > +{
> > > > > > > > +	struct device_node *cell_np;
> > > > > > > > +	int index;
> > > > > > > > +
> > > > > > > > +	index = of_property_match_string(np, "nvmem-cell-names", name);
> > > > > > > > +
> > > > > > > > +	cell_np = of_parse_phandle(np, "nvmem-cells", index);
> > > > > > > > +	if (!cell_np)
> > > > > > > > +		return ERR_PTR(-EINVAL);
> > > > > > > > +
> > > > > > > > +	return of_nvmem_cell_get_direct(cell_np);
> > > > > > > > +}
> > > > > > > >      EXPORT_SYMBOL_GPL(of_nvmem_cell_get);
> > > > > > > >      #endif
> > > > > > > > 
> > > > > > > > diff --git a/include/linux/nvmem-consumer.h b/include/linux/nvmem-consumer.h
> > > > > > > > index 9bb77d3..bf879fc 100644
> > > > > > > > --- a/include/linux/nvmem-consumer.h
> > > > > > > > +++ b/include/linux/nvmem-consumer.h
> > > > > > > > @@ -136,6 +136,7 @@ static inline int nvmem_device_write(struct nvmem_device *nvmem,
> > > > > > > >      #endif /* CONFIG_NVMEM */
> > > > > > > > 
> > > > > > > >      #if IS_ENABLED(CONFIG_NVMEM) && IS_ENABLED(CONFIG_OF)
> > > > > > > > +struct nvmem_cell *of_nvmem_cell_get_direct(struct device_node *cell_np);
> > > > > > > >      struct nvmem_cell *of_nvmem_cell_get(struct device_node *np,
> > > > > > > >      				     const char *name);
> > > > > > > >      struct nvmem_device *of_nvmem_device_get(struct device_node *np,
> > > > > > > > 
