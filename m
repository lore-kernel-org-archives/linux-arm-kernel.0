From: shijie.huang@arm.com (Huang Shijie)
Date: Tue, 15 Nov 2016 16:20:16 +0800
Subject: [PATCH v2 4/6] mm: mempolicy: intruduce a helper huge_nodemask()
In-Reply-To: <87oa1hb7tp.fsf@linux.vnet.ibm.com>
References: <1479107259-2011-1-git-send-email-shijie.huang@arm.com>
 <1479107259-2011-5-git-send-email-shijie.huang@arm.com>
 <87oa1hb7tp.fsf@linux.vnet.ibm.com>
Message-ID: <20161115082014.GA8672@sha-win-210.asiapac.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 15, 2016 at 11:31:06AM +0530, Aneesh Kumar K.V wrote:
> Huang Shijie <shijie.huang@arm.com> writes:
> >  #ifdef CONFIG_HUGETLBFS
> >  /*
> > + * huge_nodemask(@vma, @addr)
> > + * @vma: virtual memory area whose policy is sought
> > + * @addr: address in @vma for shared policy lookup and interleave policy
> > + *
> > + * If the effective policy is BIND, returns a pointer to the mempolicy's
> > + * @nodemask.
> > + */
> > +nodemask_t *huge_nodemask(struct vm_area_struct *vma, unsigned long addr)
> > +{
> > +	nodemask_t *nodes_mask = NULL;
> > +	struct mempolicy *mpol = get_vma_policy(vma, addr);
> > +
> > +	if (mpol->mode == MPOL_BIND)
> > +		nodes_mask = &mpol->v.nodes;
> > +	mpol_cond_put(mpol);
> 
> What if it is MPOL_PREFERED or MPOL_INTERLEAVE ? we don't honor node
> mask in that case ?
I wrote this code by following the logic in the huge_zonelist().
So I ignored the support for MPOL_PREFERED/MPOL_INTERLEAVE.

IMHO, it is okay to allocate a gigantic page with MPOL_PREFERED/MPOL_BIND.
But I am not sure if we can allocate a gigantic page with MPOL_INTERLEAVE, since
since the gigantic page's order is bigger then MAX_ORDER.

Could you give me some advice about this?

Thanks
Huang Shijie
