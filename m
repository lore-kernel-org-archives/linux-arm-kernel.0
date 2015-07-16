From: stefano.stabellini@eu.citrix.com (Stefano Stabellini)
Date: Thu, 16 Jul 2015 18:16:32 +0100
Subject: [PATCH v2 19/20] xen/privcmd: Add support for Linux 64KB page
 granularity
In-Reply-To: <alpine.DEB.2.02.1507161707300.17378@kaball.uk.xensource.com>
References: <1436474552-31789-1-git-send-email-julien.grall@citrix.com>
 <1436474552-31789-20-git-send-email-julien.grall@citrix.com>
 <alpine.DEB.2.02.1507161707300.17378@kaball.uk.xensource.com>
Message-ID: <alpine.DEB.2.02.1507161815350.17378@kaball.uk.xensource.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 16 Jul 2015, Stefano Stabellini wrote:
> > +	/* setup_hparams guarantees ret == 0 */
> > +	BUG_ON(xen_apply_to_page(page, setup_hparams, info));
> > +
> > +	set_xen_guest_handle(xatp.idxs, info->h_idxs);
> > +	set_xen_guest_handle(xatp.gpfns, info->h_gpfns);
> > +	set_xen_guest_handle(xatp.errs, info->h_errs);
> > +	xatp.size = info->h_iter;
> > +
> > +	rc = HYPERVISOR_memory_op(XENMEM_add_to_physmap_range, &xatp);
> 
> I would have thought that XENMEM_add_to_physmap_range operates at 4K
> granularity, regardless of how the guest decides to layout its
> pagetables. If so, the call to XENMEM_add_to_physmap_range needs to be
> moved within the function passed to xen_apply_to_page.

Sorry, this comment is wrong, please ignore it. The others are OK.
