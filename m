From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Tue, 10 Jan 2017 14:57:41 +0000
Subject: [PATCH v6 05/14] ACPI: platform-msi: retrieve dev id from IORT
In-Reply-To: <237ca4dc-07ce-0104-27f2-5437b7c7718e@linaro.org>
References: <1483363905-2806-1-git-send-email-hanjun.guo@linaro.org>
 <1483363905-2806-6-git-send-email-hanjun.guo@linaro.org>
 <20170104191805.GE8604@red-moon>
 <eb1a8149-7c46-39bc-f655-58ca6345f40a@linaro.org>
 <20170105151530.GA30852@red-moon>
 <237ca4dc-07ce-0104-27f2-5437b7c7718e@linaro.org>
Message-ID: <20170110145741.GA17967@red-moon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 10, 2017 at 09:39:39PM +0800, Hanjun Guo wrote:

[...]

> >What you can do is create a wrapper, say iort_node_map_platform_id()
> >(whose signature is equivalent to iort_node_map_rid() minus rid_in)
> >that carries out the two steps outlined above.
> >
> >To do that I suggest the following:
> >
> >(1) I send a patch to "fix" iort_node_get_id() (ie index issue you
> >    reported)
> 
> I prepared two simple patches, one is for fix the indentation and
> the other is adding the missing kernel-doc comment, how about
> sending the out for 4.10-rcx?

For me it is fine depending on how Rafael wants to handle them,
ie if he can batch those with the eg iort_node_get_id() fix I have
just sent:

https://patchwork.kernel.org/patch/9507041/

> >(2) We remove type_mask handling from iort_node_get_id()
> 
> iort_node_get_id() for now only supports id single mappings,
> Do we need to extend it for multi id mappings? seems Sinan's
> platform have such cases.

I am not really sure I understand what you mean here.

> >(3) We create iort_node_map_platform_id() that (pseudo-code, I can
> >    write the patch if it is clearer):
> >
> >struct acpi_iort_node *iort_node_map_platform_id(u8 type_mask, int index,
> >						 ...)
> >{
> >	u32 id, id_out;
> >	struct acpi_iort_node *parent = iort_node_get_id(&id, index);
> >
> >	if (!parent)
> >		return NULL;
> >
> >	/* we should probably rename iort_node_map_rid() too */
> >	if (!(IORT_TYPE_MASK(parent->type) & type_mask)
> >		parent = iort_node_map_rid(parent, id, &id_out, type_mask);
> >
> >	return parent;
> >}
> >
> >(4) we update current iort_node_get_id() users and move them over
> >    to iort_node_map_platform_id()
> 
> I think we need to prepare one patch for the above steps, or it
> have functional changes for iort_node_get_id(), for example we
> removed the type_mask handling from iort_node_get_id() and it
> will break the case for SMMU if we only have requester id entries.

If the question is "should we apply this change as a single logical
patch" the answer is yes, it looks a simple one to me (basically
it implies writing the function above and update the iort_node_get_id()
existing callers with it). Does this answer your question ?

Thanks !
Lorenzo
