From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue, 06 Nov 2018 19:40:34 +0000
Subject: [PATCH 0/4] arm/efi: fix memblock reallocation crash due to
 persistent reservations
In-Reply-To: <CAKv+Gu9MNHy4MQ=vBd_4v50gx+TgrqUO7w4J+QLoAWEVrJiSDA@mail.gmail.com>
References: <20181106113732.16351-1-ard.biesheuvel@linaro.org>
 <326d242e-e51b-c11f-8364-390d991488a6@arm.com>
 <CAKv+Gu9MNHy4MQ=vBd_4v50gx+TgrqUO7w4J+QLoAWEVrJiSDA@mail.gmail.com>
Message-ID: <86wopqdmfh.wl-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 06 Nov 2018 19:01:51 +0000,
Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
> 
> On 6 November 2018 at 19:27, Marc Zyngier <marc.zyngier@arm.com> wrote:
> > Hi Ard,
> >
> > On 06/11/18 11:37, Ard Biesheuvel wrote:
> >> This series addresses the kexec/kdump crash on arm64 system with many CPUs
> >> that was reported by Bhupesh.
> >>
> >> Patches #1 and #2 fix the actual crash. Patches #3 and #4 optimize the
> >> EFI persistent memreserve infrastructure so that fewer memblock reservations
> >> are required.
> >>
> >> Ard Biesheuvel (4):
> >>   arm64: memblock: don't permit memblock resizing until linear mapping
> >>     is up
> >>   efi/arm: defer persistent reservations until after paging_init()
> >>   efi: permit multiple entries in persistent memreserve data structure
> >>   efi: reduce the amount of memblock reservations for persistent
> >>     allocations
> >>
> >>  arch/arm/kernel/setup.c                 |  1 +
> >>  arch/arm64/kernel/setup.c               |  1 +
> >>  arch/arm64/mm/init.c                    |  2 -
> >>  arch/arm64/mm/mmu.c                     |  2 +
> >>  drivers/firmware/efi/efi.c              | 59 ++++++++++++++------
> >>  drivers/firmware/efi/libstub/arm-stub.c |  2 +-
> >>  include/linux/efi.h                     | 23 +++++++-
> >>  7 files changed, 68 insertions(+), 22 deletions(-)
> >
> > I've just given these patches a go a a TX2 box (one of the 224 CPU
> > ones...), and kexec worked just fine (v4.20-rc1 vanilla didn't manage to
> > kexec on this box).
> >
> > There seem to be some additional userspace patches that are required for
> > the ACPI tables not to be corrupted in the secondary kernel, but that's
> > an orthogonal issue.
> >
> > Feel free to add
> >
> > Tested-by: Marc Zyngier <marc.zyngier@arm.com>
> >
> 
> Thanks Marc.
> 
> Any thoughts on whether patches #3 and #4 should be included as fixes?
> I'm leaning towards yes.

They certainly massively reduce the number of list entries, and
probably help reducing the overhead. I'd be inclined to merge them as
well.

Thanks,

	M.

-- 
Jazz is not dead, it just smell funny.
