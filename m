From: sstabellini@kernel.org (Stefano Stabellini)
Date: Mon, 25 Apr 2016 11:15:29 +0100 (BST)
Subject: [PATCH v11 12/17] ARM64: ACPI: Check if it runs on Xen to enable
 or disable ACPI
In-Reply-To: <20160422103250.GC10606@leverpostej>
References: <1460030614-16112-1-git-send-email-zhaoshenglong@huawei.com>
 <1460030614-16112-13-git-send-email-zhaoshenglong@huawei.com>
 <alpine.DEB.2.10.1604201033140.25611@sstabellini-ThinkPad-X260>
 <20160422103250.GC10606@leverpostej>
Message-ID: <alpine.DEB.2.10.1604251111290.4855@sstabellini-ThinkPad-X260>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 22 Apr 2016, Mark Rutland wrote:
> On Wed, Apr 20, 2016 at 10:34:41AM +0100, Stefano Stabellini wrote:
> > Hello Mark,
> > 
> > do you think that this patch addresses your previous comments
> > (http://marc.info/?l=devicetree&m=145926913008544&w=2) appropriately?
> > 
> > Thanks,
> > 
> > Stefano
> > 
> > On Thu, 7 Apr 2016, Shannon Zhao wrote:
> > > From: Shannon Zhao <shannon.zhao@linaro.org>
> > > 
> > > When it's a Xen domain0 booting with ACPI, it will supply a /chosen and
> > > a /hypervisor node in DT. So check if it needs to enable ACPI.
> > > 
> > > Signed-off-by: Shannon Zhao <shannon.zhao@linaro.org>
> > > Reviewed-by: Stefano Stabellini <stefano.stabellini@eu.citrix.com>
> > > Acked-by: Hanjun Guo <hanjun.guo@linaro.org>
> > > ---
> > >  arch/arm64/kernel/acpi.c | 14 ++++++++++----
> > >  1 file changed, 10 insertions(+), 4 deletions(-)
> > > 
> > > diff --git a/arch/arm64/kernel/acpi.c b/arch/arm64/kernel/acpi.c
> > > index d1ce8e2..57ee317 100644
> > > --- a/arch/arm64/kernel/acpi.c
> > > +++ b/arch/arm64/kernel/acpi.c
> > > @@ -67,10 +67,15 @@ static int __init dt_scan_depth1_nodes(unsigned long node,
> > >  {
> > >  	/*
> > >  	 * Return 1 as soon as we encounter a node at depth 1 that is
> > > -	 * not the /chosen node.
> > > +	 * not the /chosen node, or /hypervisor node with compatible
> > > +	 * string "xen,xen".
> > >  	 */
> > > -	if (depth == 1 && (strcmp(uname, "chosen") != 0))
> > > -		return 1;
> > > +	if (depth == 1 && (strcmp(uname, "chosen") != 0)) {
> > > +		if (strcmp(uname, "hypervisor") != 0 ||
> > > +		    !of_flat_dt_is_compatible(node, "xen,xen"))
> > > +			return 1;
> > > +	}
> > > +
> > >  	return 0;
> > >  }
> 
> Is the duplicate node checking logic I mentioned in that review gone?
> i.e. do we not need an is_xen_node() helper?

Given the simplicity of just calling of_flat_dt_is_compatible(node,
"xen,xen"), I think we can do without the helper. Also the function in
the previous patch also checks for the Xen version which is not needed
here.


> Additionally, IMO, this would be easier to follow without the nested
> conditionals, e.g.
> 
> static int __init dt_scan_depth1_nodes(unsigned long node,
> 				       const char *uname, int depth,
> 				       void *data)
> {
> 	/*
> 	 * Ignore anything not directly under the root node; we'll
> 	 * catch its parent instead.
> 	 */
> 	if (depth != 1)
> 		return 0;
> 
> 	if (strcmp(uname, "chosen") == 0)
> 		return 0;
> 
> 	if (strcmp(uname, "hypervisor") == 0 &&
> 	    of_flat_dt_is_compatible(node, "xen,xen"))
> 		return 0;
> 
> 	/*
> 	 * This node at depth 1 is neither a chosen node nor a xen node,
> 	 * which we do not expect.
> 	 */
> 	return 1;
> }
> 
> Otherwise, this looks fine to me. FWIW, either way:
> 
> Acked-by: Mark Rutland <mark.rutland@arm.com>

That is easier to read. For simplicity, I'll submit a patch with you as
author, on top of the existing, to make this change. I'll use your
Signed-off-by, if that's OK.
