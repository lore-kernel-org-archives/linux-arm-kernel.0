From: will.deacon@arm.com (Will Deacon)
Date: Wed, 13 Jun 2018 11:11:25 +0100
Subject: [PATCH] arm64/mm: Introduce a variable to hold base address of
 linear region
In-Reply-To: <CACi5LpOJ7Q7nbo9m_HGqr44+n_iEtreZt+Uxtf2PzcHSzTdKuA@mail.gmail.com>
References: <1528785361-24477-1-git-send-email-bhsharma@redhat.com>
 <CAKv+Gu8Hs+CArdkAWoBPbr_p-nq5+0oPwOPg0NsJDRMkE_bM9A@mail.gmail.com>
 <CACi5LpNdg=Enp66BybNNuj5tQOp3ggyX=tm_SVzr8v2qCRteDw@mail.gmail.com>
 <d801005a-5f7a-8fe4-a486-bc6443a406a3@arm.com>
 <CACi5LpOJ7Q7nbo9m_HGqr44+n_iEtreZt+Uxtf2PzcHSzTdKuA@mail.gmail.com>
Message-ID: <20180613101124.GB26280@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 13, 2018 at 10:46:56AM +0530, Bhupesh Sharma wrote:
> On Tue, Jun 12, 2018 at 3:42 PM, James Morse <james.morse@arm.com> wrote:
> > On 12/06/18 09:25, Bhupesh Sharma wrote:
> >> On Tue, Jun 12, 2018 at 12:23 PM, Ard Biesheuvel
> >> <ard.biesheuvel@linaro.org> wrote:
> >>> On 12 June 2018 at 08:36, Bhupesh Sharma <bhsharma@redhat.com> wrote:
> >>>> The start of the linear region map on a KASLR enabled ARM64 machine -
> >>>> which supports a compatible EFI firmware (with EFI_RNG_PROTOCOL
> >>>> support), is no longer correctly represented by the PAGE_OFFSET macro,
> >>>> since it is defined as:
> >>>>
> >>>>     (UL(1) << (VA_BITS - 1)) + 1)
> >
> >>> PAGE_OFFSET is the VA of the start of the linear map. The linear map
> >>> can be sparsely populated with actual memory, regardless of whether
> >>> KASLR is in effect or not. The only difference in the presence of
> >>> KASLR is that there may be such a hole at the beginning, but that does
> >>> not mean the linear map has moved, or that the value of PAGE_OFFSET is
> >>> now wrong.
> >
> >>>> So taking an example of a platform with VA_BITS=48, this gives a static
> >>>> value of:
> >>>> PAGE_OFFSET = 0xffff800000000000
> >>>>
> >>>> However, for the KASLR case, we use the 'memstart_offset_seed'
> >>>> to randomize the linear region - since 'memstart_addr' indicates the
> >>>> start of physical RAM, we randomize the same on basis
> >>>> of 'memstart_offset_seed' value.
> >>>>
> >>>> As the PAGE_OFFSET value is used presently by several user space
> >>>> tools (for e.g. makedumpfile and crash tools) to determine the start
> >>>> of linear region and hence to read addresses (like PT_NOTE fields) from
> >>>> '/proc/kcore' for the non-KASLR boot cases, so it would be better to
> >>>> use 'memblock_start_of_DRAM()' value (converted to virtual) as
> >>>> the start of linear region for the KASLR cases and default to
> >>>> the PAGE_OFFSET value for non-KASLR cases to indicate the start of
> >>>> linear region.
> >
> >>> Userland code that assumes that the linear map cannot have a hole at
> >>> the beginning should be fixed.
> >
> >> That is a separate case (although that needs fixing as well via a
> >> kernel patch probably as the user-space tools rely on '/proc/iomem'
> >> contents to determine the first System RAM/reserved range).
> >
> > This is for kexec-tools generating the kdump vmcore ELF headers in user-space?
> 
> Yes, but again, I would like to reiterate that the case where I see a
> hole at the start of the System RAM range (as I listed above) is just
> a specific case, which probably deserves a separate patch. The current
> patch though is for a generic issue (please see more details below).
> 
> >> 1. In that particular case (see [1]) the EFI firmware sets the first
> >> EFI block as EfiReservedMemType:
> >>
> >> Region1: 0x000000000000-0x000000200000 [EfiReservedMemType]
> >> Region2: 0x000000200000-0x00000021fffff [EfiRuntimeServiceData]
> >>
> >> Since EFI firmware won't return the "EfiReservedMemType" memory to
> >> Linux kernel,
> >
> > (Its linux that makes this choice in
> > drivers/firmware/efi/arm-init.c::is_usable_memory())
> >
> >
> >> so the kernel can't get any info about the first mem
> >> block, and kernel can only see region2 as below:
> >>
> >> efi: Processing EFI memory map:
> >> efi:   0x000000200000-0x00000021ffff [Runtime Data       |RUN|  |  |
> >> |  |  |  |   |WB|WT|WC|UC]
> >>
> >> # head -1 /proc/iomem
> >> 00200000-0021ffff : reserved
> >>
> >> 2a. If we add debug prints to 'arch/arm64/mm/init.c' to print the
> >> kernel Virtual map we can see that the memory node is set to:
> >>
> >> # dmesg | grep memory
> >> ..........
> >> memory  : 0xffff800000200000 - 0xffff801800000000
> >>
> >> 2b. Now if we use kexec-tools to obtain a crash vmcore we can see that
> >> if we use 'readelf' to get the last program Header from vmcore (logs
> >> below are for the non-kaslr case):
> >>
> >> # readelf -l vmcore
> >>
> >> ELF Header:
> >> ........................
> >>
> >> Program Headers:
> >>   Type           Offset             VirtAddr           PhysAddr
> >>          FileSiz            MemSiz              Flags  Align
> >> ..............................................................................................................................................................
> >>   LOAD        0x0000000076d40000 0xffff80017fe00000 0x0000000180000000
> >>                 0x0000001680000000 0x0000001680000000  RWE    0
> >>
> >> 3. So if we do a simple calculation:
> >>
> >> (VirtAddr + MemSiz) = 0xffff80017fe00000 + 0x0000001680000000 =
> >> 0xFFFF8017FFE00000 != 0xffff801800000000.
> >>
> >> which indicates that the end virtual memory nodes are not the same
> >> between vmlinux and vmcore.
> >
> > If I've followed this properly: the problem is that to generate the ELF headers
> > in the post-kdump vmcore, at kdump-load-time kexec-tools has to guess the
> > virtual addresses of the 'System RAM' regions it can see in /proc/iomem.
> >
> > The problem you are hitting is an invisible hole at the beginning of RAM,
> > meaning user-space's guess_phys_to_virt() is off by the size of this hole.
> >
> > Isn't KASLR a special case for this? You must have to correct for that after
> > kdump has happened, based on an elf-note in the vmcore. Can't we always do this?
> 
> No, I hit this issue both for the KASLR and non-KASLR boot cases. We
> can fix this either in kernel or user-space.
> 
> Fixing this in kernel space seems better to me as the definition of
> 'memstart_addr' is that it indicates the start of the physical ram,
> but since in this case there is a hole at the start of the system ram
> visible in Linux (and thus to user-space), but 'memstart_addr' is
> still 0 which seems contradictory at the least. This causes PHY_OFFSET
> to be 0 as well, which is again contradictory.

Contradictory to who? Userspace has no business messing around with this
stuff and I'm reluctant to make this an ABI by adding a symbol with a
special name. Why can't the various constants needed by these tools be
exported in the ELF headers for kcore/vmcore, or as a NOTE as James
suggests? That sounds a lot less fragile to me.

Will
