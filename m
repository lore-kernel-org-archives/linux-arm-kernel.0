From: robert.richter@cavium.com (Robert Richter)
Date: Fri, 16 Dec 2016 18:10:16 +0100
Subject: [PATCH 2/2] arm64: mm: enable CONFIG_HOLES_IN_ZONE for NUMA
In-Reply-To: <CAKv+Gu8K+mokbjzM8EpTJoCp3XAKK1_Doq1Zx=A2CCWTT6FbYg@mail.gmail.com>
References: <1481706707-6211-1-git-send-email-ard.biesheuvel@linaro.org>
 <1481706707-6211-3-git-send-email-ard.biesheuvel@linaro.org>
 <20161215153930.GA8111@rric.localdomain>
 <CAKv+Gu8K+mokbjzM8EpTJoCp3XAKK1_Doq1Zx=A2CCWTT6FbYg@mail.gmail.com>
Message-ID: <20161216170947.GD4930@rric.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 15.12.16 16:07:26, Ard Biesheuvel wrote:
> On 15 December 2016 at 15:39, Robert Richter <robert.richter@cavium.com> wrote:
> > I was going to do some measurements but my kernel crashes now with a
> > page fault in efi_rtc_probe():
> >
> > [   21.663393] Unable to handle kernel paging request at virtual address 20251000
> > [   21.663396] pgd = ffff000009090000
> > [   21.663401] [20251000] *pgd=0000010ffff90003
> > [   21.663402] , *pud=0000010ffff90003
> > [   21.663404] , *pmd=0000000fdc030003
> > [   21.663405] , *pte=00e8832000250707
> >
> > The sparsemem config requires the whole section to be initialized.
> > Your patches do not address this.
> >
> 
> 96000047 is a third level translation fault, and the PTE address has
> RES0 bits set. I don't see how this is related to sparsemem, could you
> explain?

When initializing the whole section it works. Maybe it uncovers
another bug. Did not yet start debugging this.

> 
> > On 14.12.16 09:11:47, Ard Biesheuvel wrote:
> >> +config HOLES_IN_ZONE
> >> +     def_bool y
> >> +     depends on NUMA
> >
> > This enables pfn_valid_within() for arm64 and causes the check for
> > each page of a section. The arm64 implementation of pfn_valid() is
> > already expensive (traversing memblock areas). Now, this is increased
> > by a factor of 2^18 for 4k page size (16384 for 64k). We need to
> > initialize the whole section to avoid that.
> >
> 
> I know that. But if you want something for -stable, we should have
> something that is correct first, and only then care about the
> performance hit (if there is one)

I would prefer to check for a performance penalty *before* we put it
into stable. There is nor risk at all with the patch I am proposing.
See: https://lkml.org/lkml/2016/12/16/412

-Robert
