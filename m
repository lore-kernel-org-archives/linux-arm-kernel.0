From: stefano.stabellini@eu.citrix.com (Stefano Stabellini)
Date: Mon, 10 Aug 2015 13:55:37 +0100
Subject: [PATCH v3 12/20] xen/balloon: Don't rely on the page granularity
 is the same for Xen and Linux
In-Reply-To: <55C88B77.8030700@citrix.com>
References: <1438966019-19322-1-git-send-email-julien.grall@citrix.com>
 <1438966019-19322-13-git-send-email-julien.grall@citrix.com>
 <alpine.DEB.2.02.1508101207071.11337@kaball.uk.xensource.com>
 <55C88B77.8030700@citrix.com>
Message-ID: <alpine.DEB.2.02.1508101352370.11337@kaball.uk.xensource.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 10 Aug 2015, Julien Grall wrote:
> Hi Stefano,
> 
> On 10/08/15 12:18, Stefano Stabellini wrote:
> >>  			/* Link back into the page tables if not highmem. */
> >> @@ -396,14 +413,15 @@ static enum bp_state increase_reservation(unsigned long nr_pages)
> >>  static enum bp_state decrease_reservation(unsigned long nr_pages, gfp_t gfp)
> >>  {
> >>  	enum bp_state state = BP_DONE;
> >> -	unsigned long  pfn, i;
> >> +	unsigned long i;
> >>  	struct page   *page;
> >>  	int ret;
> >>  	struct xen_memory_reservation reservation = {
> >>  		.address_bits = 0,
> >> -		.extent_order = 0,
> >> +		.extent_order = EXTENT_ORDER,
> >>  		.domid        = DOMID_SELF
> >>  	};
> >> +	static struct page *pages[ARRAY_SIZE(frame_list)];
> > 
> > This array can be rather large: I would try to avoid it, see below.
> 
> [..]
> 
> > 
> > I would simply and avoid introducing a new array:
> >     pfn = (frame_list[i] << XEN_PAGE_SHIFT) >> PAGE_SHIFT;
> >     page = pfn_to_page(pfn);
> 
> Which won't work because the frame_list contains a gfn and not a pfn.
> We need to translate back the gfn into a pfn and the into a page.
> 
> The cost of the translation may be big and I wanted to avoid anymore
> XEN_PAGE_SHIFT in the code. In general we should avoid to deal with 4KB
> PFN when it's not necessary, it make the code more confusing to read.

That is true


> If your only concern is the size of the array, we could decrease the
> number of frames by batch. Or allocation the variable once a boot time.

Yes, that is my only concern. Allocating only nr_pages new struct page*
would be good enough I guess.
