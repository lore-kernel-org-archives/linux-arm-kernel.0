From: will.deacon@arm.com (Will Deacon)
Date: Tue, 6 Nov 2018 21:46:03 +0000
Subject: [PATCH 0/4] arm/efi: fix memblock reallocation crash due to
 persistent reservations
In-Reply-To: <CAKv+Gu81L5Xxvz72r8C8cXE9hweA-90w47HG3tBHUUoPV-gZPQ@mail.gmail.com>
References: <20181106113732.16351-1-ard.biesheuvel@linaro.org>
 <20181106213406.GB31298@brain-police>
 <CAKv+Gu81L5Xxvz72r8C8cXE9hweA-90w47HG3tBHUUoPV-gZPQ@mail.gmail.com>
Message-ID: <20181106214602.GA31487@brain-police>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 06, 2018 at 10:39:47PM +0100, Ard Biesheuvel wrote:
> On 6 November 2018 at 22:34, Will Deacon <will.deacon@arm.com> wrote:
> > On Tue, Nov 06, 2018 at 12:37:28PM +0100, Ard Biesheuvel wrote:
> >> This series addresses the kexec/kdump crash on arm64 system with many CPUs
> >> that was reported by Bhupesh.
> >>
> >> Patches #1 and #2 fix the actual crash. Patches #3 and #4 optimize the
> >> EFI persistent memreserve infrastructure so that fewer memblock reservations
> >> are required.
> >
> > I acked the arm64 part and patches 3 and 4 look good afaict, so:
> >
> > Acked-by: Will Deacon <will.deacon@arm.com>
> >
> > for those as well.
> >
> > The only thing I was wondering is whether or not exhausting the page-sized
> > array in the first list entry is rare enough that we could just realloc the
> > thing and copy instead of chaining together new pages. That said, without
> > seeing the code it's hard to tell whether you save much complexity with such
> > a scheme so I'll leave it up to you.
> >
> 
> Well, the problem is that the page-sized array may have been allocated
> by a previous kernel, and so it may be memblock_reserve()d already, in
> which case reallocating does not actually free up the memory in a
> useful way.
> 
> Also, in the unlikely event that we race and allocate two new pages at
> the same time, the current scheme will not break (and we will
> ultimately fill up all the slots in both pages before allocating even
> more pages). This will become a lot trickier if we do reallocation.

Ah crap, yeah, the concurrency angle makes that really awful. Thanks.

> So if the current approach looks correct to you, then I'd prefer to
> stick with it.
> 
> Do you agree with applying #3 and #4 as fixes?

If Patch 1 alone is sufficient to solve the issue for Bhupesh, then I don't
think we have a need to treat 3 and 4 as fixes (and therefore we can avoid
having to backport them to stable kernels).

Will
