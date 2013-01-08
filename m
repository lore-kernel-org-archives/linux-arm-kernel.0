From: steve.capper@arm.com (Steve Capper)
Date: Tue, 8 Jan 2013 17:56:30 +0000
Subject: [RFC PATCH 1/6] ARM: mm: correct pte_same behaviour for LPAE.
In-Reply-To: <CANM98qJEigKksbv5QdGLWzCdaSj9NipJ-RYrouzWPRn6XVCw0Q@mail.gmail.com>
References: <1350576942-25299-1-git-send-email-steve.capper@arm.com>
 <1350576942-25299-2-git-send-email-steve.capper@arm.com>
 <CANM98qJEigKksbv5QdGLWzCdaSj9NipJ-RYrouzWPRn6XVCw0Q@mail.gmail.com>
Message-ID: <20130108175630.GA18347@e103986-lin>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 04, 2013 at 05:03:26AM +0000, Christoffer Dall wrote:
> On Thu, Oct 18, 2012 at 12:15 PM, Steve Capper <steve.capper@arm.com> wrote:

> >
> >  /*
> > + * For 3 levels of paging the PTE_EXT_NG bit will be set for user address ptes
> > + * that are written to a page table but not for ptes created with mk_pte.
> > + *
> 
> Why is this not the case for 2 levels of paging as well?
> 
> Is that because it's always checked against the Linux version, or?
> 
> 

Yes that's the case, I'll update the comment to reflect that.

> > + * This can cause some comparison tests made by pte_same to fail spuriously and
> > + * lead to other problems.
> > + *
> > + * To correct this behaviour, we mask off PTE_EXT_NG for any pte that is
> > + * present before running the comparison.
> 
> nit: This comment doesn't really explain the rationale, I'm assuming
> that pte_same is used to compare only which page gets mapped, assuming
> the attributes etc. remain the same? or also the attributes should be
> the same, only mk_pte sets all of these except the NG bit.
> 

I'll expand the comment to include the actual case. Essentially hugetlb_nopage
calls mk_pte to give new_pte and passes this to hugetlb_cow which then performs
a pte_same test against a pte that has already been written out to a page
table; the test fails erroneously due to the mismatch in NG bit.

Unfortunately this then causes a memory leak. 

> > + */
> > +#define __HAVE_ARCH_PTE_SAME
> > +static inline int pte_same(pte_t pte_a, pte_t pte_b)
> > +{
> > +       pteval_t vala = pte_val(pte_a), valb = pte_val(pte_b);
> > +       if (pte_present(pte_a))
> > +               vala &= ~L_PTE_CMP_MASKOFF;
> > +
> > +       if (pte_present(pte_b))
> > +               valb &= ~L_PTE_CMP_MASKOFF;
> > +
> > +       return vala == valb;
> > +}
> > +
> > +/*
> >   * Encode and decode a swap entry.  Swap entries are stored in the Linux
> >   * page tables as follows:
> >   *
> > --
> > 1.7.9.5
> >
> >
> >
> > _______________________________________________
> > linux-arm-kernel mailing list
> > linux-arm-kernel at lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
