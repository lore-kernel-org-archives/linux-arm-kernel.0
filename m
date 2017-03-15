From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 15 Mar 2017 16:42:58 +0000
Subject: [PATCH V2] arm64: hwpoison: add VM_FAULT_HWPOISON[_LARGE] handling
In-Reply-To: <CAPvkgC3AsiQB6nQz05m0PaUkmDn3BBoEa8sD0k=3h+4CCiEe7w@mail.gmail.com>
References: <1487720205-14594-1-git-send-email-tbaicar@codeaurora.org>
 <87wpc7o7mo.fsf@e105922-lin.cambridge.arm.com>
 <874lz4oo80.fsf@e105922-lin.cambridge.arm.com>
 <fae5fa32-687b-4ebd-2d0c-b9df5837ba89@codeaurora.org>
 <87efy6mjgj.fsf@e105922-lin.cambridge.arm.com>
 <20170315111955.GA29014@e104818-lin.cambridge.arm.com>
 <CAPvkgC3AsiQB6nQz05m0PaUkmDn3BBoEa8sD0k=3h+4CCiEe7w@mail.gmail.com>
Message-ID: <20170315164257.GA30866@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 15, 2017 at 04:07:20PM +0000, Steve Capper wrote:
> On 15 March 2017 at 11:19, Catalin Marinas <catalin.marinas@arm.com> wrote:
> > On Thu, Mar 09, 2017 at 05:46:36PM +0000, Punit Agrawal wrote:
> >> From d5ad3f428e629c80b0f93f2bbdf99b4cae28c9bc Mon Sep 17 00:00:00 2001
> >> From: Punit Agrawal <punit.agrawal@arm.com>
> >> Date: Thu, 9 Mar 2017 16:16:29 +0000
> >> Subject: [PATCH] arm64: hugetlb: Fix huge_pte_offset to return poisoned pmd
> >>
> >> When memory failure is enabled, a poisoned hugepage PMD is marked as a
> >> swap entry. As pmd_present() only checks for VALID and PROT_NONE
> >> bits (turned off for swap entries), it causues huge_pte_offset() to
> >> return NULL for poisoned PMDs.
[...]
> > Given that we can have huge pages at the pud level, we should address
> > that as well. The generic huge_pte_offset() doesn't need to since it
> > assumes huge pages at the pmd level only. If a pud is not present, you
> > can't dereference it to find the pmd, hence returning NULL.
> >
> > Apart from hw poisoning, I think another use-case for non-present
> > pmd/pud entries is is_hugetlb_entry_migration() (see hugetlb_fault()),
> > so we need to fix this either way.
> >
> > We have a discrepancy between the pud_present and pmd_present. The
> > latter was modified to fall back on pte_present because of THP which
> > does not support puds (last time I checked). So if a pud is poisoned,
> > huge_pte_offset thinks it is present and will try to get the pmd it
> > points to.
> >
> > I think we can leave the pud_present() unchanged but fix the
> > huge_pte_offset() to check for pud_table() before dereferencing,
> > otherwise returning the actual value. And we need to figure out which
> > huge page size we have when the pud/pmd is 0.
> 
> I don't understand the suggestions for puds, as they won't be contiguous?

I wasn't thinking of the contiguous bit for pud but rather what to
return early based on present/huge/table. I think we have the cases
below:

1. pud_present() && pud_huge():
	return pud

2. pud_present() && pud_table():
	continue to pmd

3. pud_present() && !pud_huge() && !pud_table():
	return pud (huge pte poison at the pud level)

4. !pud_present() (a.k.a. pud_none()):
	a) return pud (if we have huge pages at the pud level)
	b) return NULL

At 3 I assumed that we don't poison table entries, therefore it is safe
to assume that the pud is an invalid huge page entry (poisoned,
migration).

At 4, I don't think we can currently distinguished between an empty huge
page pud and an empty table pointing further to a pmd. We could go for
NULL and assume that huge_pte_alloc() handles it properly.

-- 
Catalin
