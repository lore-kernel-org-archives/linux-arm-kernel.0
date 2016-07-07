From: maitysanchayan@gmail.com (maitysanchayan at gmail.com)
Date: Thu, 7 Jul 2016 19:18:11 +0530
Subject: [PATCH v4 3/5] nvmem: core: Add consumer API to get nvmem cell
 from node
In-Reply-To: <577E5634.7020805@linaro.org>
References: <cover.1467872014.git.maitysanchayan@gmail.com>
 <0e6294d931bf181376a6f4e1a86df3f6c6a5d575.1467872014.git.maitysanchayan@gmail.com>
 <577E1E79.4090809@linaro.org>
 <20160707123350.GA18563@Sanchayan-Arch.localdomain>
 <577E5634.7020805@linaro.org>
Message-ID: <20160707134811.GA2692@Sanchayan-Arch.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Srinivas,

On 16-07-07 14:16:36, Srinivas Kandagatla wrote:
> 
> 
> On 07/07/16 13:33, maitysanchayan at gmail.com wrote:
> > Hello Srinivas,
> > 
> > On 16-07-07 10:18:49, Srinivas Kandagatla wrote:
> > > 
> > > 
> > > On 07/07/16 07:39, Sanchayan Maity wrote:
> > > > From: Stefan Agner <stefan@agner.ch>
> > > > 
> > > > The existing NVMEM consumer API's do not allow to get a
> > > > NVMEM cell directly given a device tree node. This patch
> > > > adds a function to provide this functionality.
> > > > 
> > > > Assuming the nvmem cell id name is known, this can be used
> > > > as follows
> > > > 
> > > > struct device_node *cell_np;
> > > > struct nvmem_cell *foo_cell;
> > > > 
> > > > cell_np = of_find_node_by_name(parent, "foo");
> > > > foo_cell = of_nvmem_cell_get_direct(cell_np);
> > > 
> > > I don't see a real gain in adding this new api,
> > > This will encourage people to use non-standard nvmem bindings.
> > > 
> > > why not just use standard nvmem bindings.. and use
> > > 
> > > of_nvmem_cell_get(np, "foo");
> > > 
> > > which should work in your case.
> > 
> > It will not work in our case. I believe what you are referring to will
> > work if I were to pass the device node pointer which was a NVMEM consumer
> > containing the nvmem-cells property. In our case, we pass the device node
> > pointer pointing to /soc which is not a nvmem consumer. In this case it
> > will not have nvmem-cells property causing of_nvmem_cell_get to return
> > EINVAL when it calls of_parse_phandle with "nvmem-cells".
> 
> I could not see any bindings/ dt patches or dt examples for this this
> series.. so Am guessing your node would look like:
> 
> soc {
> 	cfg0: cfg0 {
> 		...
> 	};
> 	cfg1: cfg1 {
> 		...
> 	};
> };
> 
> If this is not how it looks, can you share the details.
> 
> What Am saying is that why not have:
> 
> soc {
> 	nvmem-cells = <&cfg0>, <&cfg1>;
> 	nvmem-cell-names = "cfg0", "cfg1";
> 
> 	cfg0: cfg0 {
> 		...
> 	};
> 
> 	cfg1: cfg1 {
> 		...
> 	};
> };
> 
> > 
> > Our requirement is to be able to pass the soc node pointer and then
> > be able to get a nvmem cell by specifying it's name. So for our case
> 
> Why?

Sorry for not providing the background directly. The patches before this
series used that approach. In the previous discussions it has been pointed
out that it is not acceptable to have additional device tree bindings for
providing data that the driver wants at the SoC node level or to have bindings
just for the SoC bus driver alone since we aren't really describing the
hardware.

For the discussion,
https://lkml.org/lkml/2016/5/23/573
https://lkml.org/lkml/2016/5/2/71

Regards,
Sanchayan.


> 
> > ocotp node has cfg0 and cfg1 which we want but we cannot use existing
> > nvmem consumer API since that requires having the nvmem consumer properties
> > in the node we are binding to viz. is a direct nvmem consumer.
> > 
> > Regards,
> > Sanchayan.
> > 
> > > 
> > > thanks,
> > > srini
> > > > 
> > > > Parent node can also be the of_node of the main SoC device
> > > > node.
> > > > 
> > > > Signed-off-by: Sanchayan Maity <maitysanchayan@gmail.com>
> > > > ---
> > > >    drivers/nvmem/core.c           | 44 +++++++++++++++++++++++++++++-------------
> > > >    include/linux/nvmem-consumer.h |  1 +
> > > >    2 files changed, 32 insertions(+), 13 deletions(-)
> > > > 
> > > > diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
> > > > index 965911d..470abee 100644
> > > > --- a/drivers/nvmem/core.c
> > > > +++ b/drivers/nvmem/core.c
> > > > @@ -743,29 +743,21 @@ static struct nvmem_cell *nvmem_cell_get_from_list(const char *cell_id)
> > > > 
> > > >    #if IS_ENABLED(CONFIG_NVMEM) && IS_ENABLED(CONFIG_OF)
> > > >    /**
> > > > - * of_nvmem_cell_get() - Get a nvmem cell from given device node and cell id
> > > > + * of_nvmem_cell_get_direct() - Get a nvmem cell from given device node
> > > >     *
> > > > - * @dev node: Device tree node that uses the nvmem cell
> > > > - * @id: nvmem cell name from nvmem-cell-names property.
> > > > + * @dev node: Device tree node that uses nvmem cell
> > > >     *
> > > >     * Return: Will be an ERR_PTR() on error or a valid pointer
> > > >     * to a struct nvmem_cell.  The nvmem_cell will be freed by the
> > > >     * nvmem_cell_put().
> > > >     */
> > > > -struct nvmem_cell *of_nvmem_cell_get(struct device_node *np,
> > > > -					    const char *name)
> > > > +struct nvmem_cell *of_nvmem_cell_get_direct(struct device_node *cell_np)
> > > >    {
> > > > -	struct device_node *cell_np, *nvmem_np;
> > > > +	struct device_node *nvmem_np;
> > > >    	struct nvmem_cell *cell;
> > > >    	struct nvmem_device *nvmem;
> > > >    	const __be32 *addr;
> > > > -	int rval, len, index;
> > > > -
> > > > -	index = of_property_match_string(np, "nvmem-cell-names", name);
> > > > -
> > > > -	cell_np = of_parse_phandle(np, "nvmem-cells", index);
> > > > -	if (!cell_np)
> > > > -		return ERR_PTR(-EINVAL);
> > > > +	int rval, len;
> > > > 
> > > >    	nvmem_np = of_get_next_parent(cell_np);
> > > >    	if (!nvmem_np)
> > > > @@ -824,6 +816,32 @@ err_mem:
> > > > 
> > > >    	return ERR_PTR(rval);
> > > >    }
> > > > +EXPORT_SYMBOL_GPL(of_nvmem_cell_get_direct);
> > > > +
> > > > +/**
> > > > + * of_nvmem_cell_get() - Get a nvmem cell from given device node and cell id
> > > > + *
> > > > + * @dev node: Device tree node that uses the nvmem cell
> > > > + * @id: nvmem cell name from nvmem-cell-names property.
> > > > + *
> > > > + * Return: Will be an ERR_PTR() on error or a valid pointer
> > > > + * to a struct nvmem_cell.  The nvmem_cell will be freed by the
> > > > + * nvmem_cell_put().
> > > > + */
> > > > +struct nvmem_cell *of_nvmem_cell_get(struct device_node *np,
> > > > +					    const char *name)
> > > > +{
> > > > +	struct device_node *cell_np;
> > > > +	int index;
> > > > +
> > > > +	index = of_property_match_string(np, "nvmem-cell-names", name);
> > > > +
> > > > +	cell_np = of_parse_phandle(np, "nvmem-cells", index);
> > > > +	if (!cell_np)
> > > > +		return ERR_PTR(-EINVAL);
> > > > +
> > > > +	return of_nvmem_cell_get_direct(cell_np);
> > > > +}
> > > >    EXPORT_SYMBOL_GPL(of_nvmem_cell_get);
> > > >    #endif
> > > > 
> > > > diff --git a/include/linux/nvmem-consumer.h b/include/linux/nvmem-consumer.h
> > > > index 9bb77d3..bf879fc 100644
> > > > --- a/include/linux/nvmem-consumer.h
> > > > +++ b/include/linux/nvmem-consumer.h
> > > > @@ -136,6 +136,7 @@ static inline int nvmem_device_write(struct nvmem_device *nvmem,
> > > >    #endif /* CONFIG_NVMEM */
> > > > 
> > > >    #if IS_ENABLED(CONFIG_NVMEM) && IS_ENABLED(CONFIG_OF)
> > > > +struct nvmem_cell *of_nvmem_cell_get_direct(struct device_node *cell_np);
> > > >    struct nvmem_cell *of_nvmem_cell_get(struct device_node *np,
> > > >    				     const char *name);
> > > >    struct nvmem_device *of_nvmem_device_get(struct device_node *np,
> > > > 
