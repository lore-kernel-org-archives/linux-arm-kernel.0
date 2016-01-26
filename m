From: zhaoshenglong@huawei.com (Shannon Zhao)
Date: Tue, 26 Jan 2016 20:27:29 +0800
Subject: [PATCH v3 16/17] FDT: Add a helper to get specified name subnode
In-Reply-To: <alpine.DEB.2.02.1601261156340.3619@kaball.uk.xensource.com>
References: <1453519184-11908-1-git-send-email-zhaoshenglong@huawei.com>
 <1453519184-11908-17-git-send-email-zhaoshenglong@huawei.com>
 <alpine.DEB.2.02.1601261156340.3619@kaball.uk.xensource.com>
Message-ID: <56A76631.2070802@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 2016/1/26 20:11, Stefano Stabellini wrote:
> On Sat, 23 Jan 2016, Shannon Zhao wrote:
>> > From: Shannon Zhao <shannon.zhao@linaro.org>
>> > 
>> > Sometimes it needs to check if there is a node in FDT by full path.
>> > Introduce this helper to get the specified name subnode if it exists.
>> > 
>> > Signed-off-by: Shannon Zhao <shannon.zhao@linaro.org>
>> > ---
>> > CC: Rob Herring <robh@kernel.org>
>> > ---
>> >  drivers/of/fdt.c       | 35 +++++++++++++++++++++++++++++++++++
>> >  include/linux/of_fdt.h |  2 ++
>> >  2 files changed, 37 insertions(+)
>> > 
>> > diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
>> > index 655f79d..112ec16 100644
>> > --- a/drivers/of/fdt.c
>> > +++ b/drivers/of/fdt.c
>> > @@ -645,6 +645,41 @@ int __init of_scan_flat_dt(int (*it)(unsigned long node,
>> >  }
>> >  
>> >  /**
>> > + * of_get_flat_dt_subnode_by_name - get subnode of specified node by name
>> > + *
>> > + * @node: the parent node
>> > + * @uname: the name of subnode
>> > + * @return offset of the subnode, or -FDT_ERR_NOTFOUND if there is none
>> > + */
>> > +
>> > +int of_get_flat_dt_subnode_by_name(unsigned long node, const char *uname)
>> > +{
>> > +	const void *blob = initial_boot_params;
>> > +	int offset;
>> > +	const char *pathp;
>> > +
>> > +	/* Find first subnode if it exists */
>> > +	offset = fdt_first_subnode(blob, node);
>> > +	if (offset < 0)
>> > +		return -FDT_ERR_NOTFOUND;
>> > +	pathp = fdt_get_name(blob, offset, NULL);
>> > +	if (strncmp(pathp, uname, strlen(uname)) == 0)
>> > +		return offset;
> Wouldn't this check succeed even if uname is "uefi" and the node
> name is actually "uefiiiii"?  You might have to use strcmp.
> 
Ah, yes. Will fix this.

> 
>> > +	/* Find other subnodes */
>> > +	do {
>> > +		offset = fdt_next_subnode(blob, offset);
>> > +		if (offset < 0)
>> > +			return -FDT_ERR_NOTFOUND;
>> > +		pathp = fdt_get_name(blob, offset, NULL);
>> > +		if (strncmp(pathp, uname, strlen(uname)) == 0)
>> > +			return offset;
>> > +	} while (offset >= 0);
> Rather than writing the name check twice, I think it would be best to
> code this loop as:
> 
>     for (offset = fdt_first_subnode(blob, offset);
>          offset >= 0;
>          offset = fdt_next_subnode(blob, offset)) {
> 
>          /* do name check */
> 
> 
> 
Thanks for your suggestion. Will change this.

-- 
Shannon
