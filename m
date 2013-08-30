From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Fri, 30 Aug 2013 12:42:23 +0200
Subject: [PATCH v7 2/4] drivers: of: add function to scan fdt nodes given
 by path
In-Reply-To: <20130829214007.CDB813E1222@localhost>
References: <1377527959-5080-1-git-send-email-m.szyprowski@samsung.com>
 <1377527959-5080-3-git-send-email-m.szyprowski@samsung.com>
 <20130829214007.CDB813E1222@localhost>
Message-ID: <5220770F.9080806@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On 8/29/2013 11:40 PM, Grant Likely wrote:
> On Mon, 26 Aug 2013 16:39:17 +0200, Marek Szyprowski <m.szyprowski@samsung.com> wrote:
> > Add a function to scan the flattened device-tree starting from the
> > node given by the path. It is used to extract information (like reserved
> > memory), which is required on early boot before we can unflatten the tree.
> >
> > Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> > Acked-by: Michal Nazarewicz <mina86@mina86.com>
> > Acked-by: Tomasz Figa <t.figa@samsung.com>
> > Reviewed-by: Rob Herring <rob.herring@calxeda.com>
>
> Some nits below, but otherwise:
>
> Acked-by: Grant Likely <grant.likely@secretlab.ca>

Thanks!

> I'm happy to take this through the DT tree, or have you take it via the
> CMA tree.

I have already put the whole patchset in linux-next via my 
dma-mapping/cma tree,
so I would like to keep it there to avoid further confusion.

I only wonder how to handle the patches to get them merged to v3.12-rc1.
After your review there will be some changes to the binding, its 
documentation
and the code itself. Would you mind if I send pull request with the current
version and then provide incremental patches to fix the issues you have
reported? Or should we delay this patchset till v3.13-rc1?

> > ---
> >  drivers/of/fdt.c       |   76 ++++++++++++++++++++++++++++++++++++++++++++++++
> >  include/linux/of_fdt.h |    3 ++
> >  2 files changed, 79 insertions(+)
> >
> > diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
> > index b10ba00..4fb06f3 100644
> > --- a/drivers/of/fdt.c
> > +++ b/drivers/of/fdt.c
> > @@ -545,6 +545,82 @@ int __init of_flat_dt_match(unsigned long node, const char *const *compat)
> >  	return of_fdt_match(initial_boot_params, node, compat);
> >  }
> >
> > +struct fdt_scan_status {
> > +	const char *name;
> > +	int namelen;
> > +	int depth;
> > +	int found;
> > +	int (*iterator)(unsigned long node, const char *uname, int depth, void *data);
> > +	void *data;
> > +};
> > +
> > +/**
> > + * fdt_scan_node_by_path - iterator for of_scan_flat_dt_by_path function
> > + */
> > +static int __init fdt_scan_node_by_path(unsigned long node, const char *uname,
> > +					int depth, void *data)
>
> Nit: since this is an iterator, I'd like to see "iter" in the function
> name.
>
> > +{
> > +	struct fdt_scan_status *st = data;
> > +
> > +	/*
> > +	 * if scan at the requested fdt node has been completed,
> > +	 * return -ENXIO to abort further scanning
> > +	 */
> > +	if (depth <= st->depth)
> > +		return -ENXIO;
> > +
> > +	/* requested fdt node has been found, so call iterator function */
> > +	if (st->found)
> > +		return st->iterator(node, uname, depth, st->data);
> > +
> > +	/* check if scanning automata is entering next level of fdt nodes */
> > +	if (depth == st->depth + 1 &&
> > +	    strncmp(st->name, uname, st->namelen) == 0 &&
> > +	    uname[st->namelen] == 0) {
> > +		st->depth += 1;
> > +		if (st->name[st->namelen] == 0) {
> > +			st->found = 1;
> > +		} else {
> > +			const char *next = st->name + st->namelen + 1;
> > +			st->name = next;
> > +			st->namelen = strcspn(next, "/");
> > +		}
> > +		return 0;
>
> The above return statement is redundant.
>
> > +	}
> > +
> > +	/* scan next fdt node */
> > +	return 0;
> > +}
> > +
> > +/**
> > + * of_scan_flat_dt_by_path - scan flattened tree blob and call callback on each
> > + *			     child of the given path.
> > + * @path: path to start searching for children
> > + * @it: callback function
> > + * @data: context data pointer
> > + *
> > + * This function is used to scan the flattened device-tree starting from the
> > + * node given by path. It is used to extract information (like reserved
> > + * memory), which is required on ealy boot before we can unflatten the tree.
> > + */
> > +int __init of_scan_flat_dt_by_path(const char *path,
> > +	int (*it)(unsigned long node, const char *name, int depth, void *data),
> > +	void *data)
>
> Nit: Please match the indentation convention used by of_scan_flat_dt().
> This current version is really hard to read.
>
> > +{
> > +	struct fdt_scan_status st = {path, 0, -1, 0, it, data};
>
> This is a little fragile. If the structure gets modified, this line
> will break. I know it results in more text, but please use explicit data
> member assignments in initializers.
>
> > +	int ret = 0;
> > +
> > +	if (initial_boot_params)
>
> Nit:
> 	if (!initial_boot_params)
> 		return 0;
>
> > +                ret = of_scan_flat_dt(fdt_scan_node_by_path, &st);
>
> Nit: inconsitent indentation (tabs vs. spaces)
>
> > +
> > +	if (!st.found)
> > +		return -ENOENT;
> > +	else if (ret == -ENXIO)	/* scan has been completed */
> > +		return 0;
> > +	else
> > +		return ret;
>
> Both uses of 'else' above are redundant. The only way the execution will
> pass that point is if it was the else case!
>
> > +}
> > +
> >  #ifdef CONFIG_BLK_DEV_INITRD
> >  /**
> >   * early_init_dt_check_for_initrd - Decode initrd location from flat tree
> > diff --git a/include/linux/of_fdt.h b/include/linux/of_fdt.h
> > index ed136ad..19f26f8 100644
> > --- a/include/linux/of_fdt.h
> > +++ b/include/linux/of_fdt.h
> > @@ -90,6 +90,9 @@ extern void *of_get_flat_dt_prop(unsigned long node, const char *name,
> >  extern int of_flat_dt_is_compatible(unsigned long node, const char *name);
> >  extern int of_flat_dt_match(unsigned long node, const char *const *matches);
> >  extern unsigned long of_get_flat_dt_root(void);
> > +extern int of_scan_flat_dt_by_path(const char *path,
> > +	int (*it)(unsigned long node, const char *name, int depth, void *data),
> > +	void *data);
> >
> >  extern int early_init_dt_scan_chosen(unsigned long node, const char *uname,
> >  				     int depth, void *data);
> > --
> > 1.7.9.5
> >
>
>

Best regards
-- 
Marek Szyprowski
Samsung R&D Institute Poland
