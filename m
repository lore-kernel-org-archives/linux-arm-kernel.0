From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 3 Dec 2013 15:09:25 +0000
Subject: [PATCH 0/3] Simplify set_huge_pte_at, pte_same for LPAE
In-Reply-To: <20131203134623.GA24994@linaro.org>
References: <1384882529-28104-1-git-send-email-steve.capper@linaro.org>
 <20131203134623.GA24994@linaro.org>
Message-ID: <20131203150924.GE12370@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 03, 2013 at 01:46:24PM +0000, Steve Capper wrote:
> On Tue, Nov 19, 2013 at 05:35:26PM +0000, Steve Capper wrote:
> > The following patch series is my attempt at fixing a rather nasty bug
> > which became visible in 3.12-rc1 when running the libhugetlbfs test
> > suite. (This problem only just came to my attention yesterday).
> > 
> > For LPAE, set_huge_pte_at calls set_pte_at which then calls
> > set_pte_ext, which in turn is wired up to call cpu_v7_set_pte_ext,
> > which is defined in proc-v7-3level.S.
> > 
> > For huge pages, given newprot a pgprot_t value for a shared writable
> > VMA, and ptep a pointer to a pte belonging to this VMA; the following
> > behaviour is assumed by core code:
> >    hugetlb_change_protection(vma, address, end, newprot);
> >    ...
> > 
> >    huge_pte_write(huge_ptep_get(ptep)); /* should be true! */
> > 
> > Unfortunately, cpu_v7_set_pte_ext will change the bit layout of the
> > resultant pte, and will set the read only bit if the dirty bit is not
> > also enabled.
> 
> A question has been raised for the arm64 analogue of this series as to
> whether or not this is the best approach:
> http://lists.infradead.org/pipermail/linux-arm-kernel/2013-November/215155.html
> 
> I am having a think about this, and will send out a V2 once my brain
> has caught up. :-)

I think we first need to check we don't actually do a CoW for any clean
anonymous small page just because pte_dirty and pte_write use the same
PTE_RDONLY bit (both arm+LPAE and arm64). Once that's fixed, I don't
think you need any hugetlb changes.

Basically we need to encode these states:

				PTE_DIRTY	PTE_RDONLY
!pte_dirty && !pte_write	0		1
!pte_dirty && pte_write		0		1
pte_dirty && !pte_write		1		1
pte_dirty && pte_write		1		0

So we can't distinguish between the first two with just two bits since
PTE_RDONLY is a hardware bit.

My proposal would be for PTE_WRITE bit with PTE_RDONLY only set in the
set_pte() function (if !pte_dirty || !pte_write).

-- 
Catalin
