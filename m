From: will.deacon@arm.com (Will Deacon)
Date: Fri, 15 Jun 2018 17:52:26 +0100
Subject: [PATCH] arm64/mm: Introduce a variable to hold base address of
 linear region
In-Reply-To: <CACi5LpMV7_+tHH-OnMC1R59ZrhOGPXz5qy9MN2O7MVTmGnK33Q@mail.gmail.com>
References: <1528785361-24477-1-git-send-email-bhsharma@redhat.com>
 <CAKv+Gu8Hs+CArdkAWoBPbr_p-nq5+0oPwOPg0NsJDRMkE_bM9A@mail.gmail.com>
 <CACi5LpNdg=Enp66BybNNuj5tQOp3ggyX=tm_SVzr8v2qCRteDw@mail.gmail.com>
 <d801005a-5f7a-8fe4-a486-bc6443a406a3@arm.com>
 <CACi5LpOJ7Q7nbo9m_HGqr44+n_iEtreZt+Uxtf2PzcHSzTdKuA@mail.gmail.com>
 <20180613101124.GB26280@arm.com>
 <CACi5LpMV7_+tHH-OnMC1R59ZrhOGPXz5qy9MN2O7MVTmGnK33Q@mail.gmail.com>
Message-ID: <20180615165225.GD2202@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Bhupesh,

On Thu, Jun 14, 2018 at 11:53:53AM +0530, Bhupesh Sharma wrote:
> On Wed, Jun 13, 2018 at 3:41 PM, Will Deacon <will.deacon@arm.com> wrote:
> > On Wed, Jun 13, 2018 at 10:46:56AM +0530, Bhupesh Sharma wrote:
> >> On Tue, Jun 12, 2018 at 3:42 PM, James Morse <james.morse@arm.com> wrote:
> >> > On 12/06/18 09:25, Bhupesh Sharma wrote:
> >> >> 2b. Now if we use kexec-tools to obtain a crash vmcore we can see that
> >> >> if we use 'readelf' to get the last program Header from vmcore (logs
> >> >> below are for the non-kaslr case):
> >> >>
> >> >> # readelf -l vmcore
> >> >>
> >> >> ELF Header:
> >> >> ........................
> >> >>
> >> >> Program Headers:
> >> >>   Type           Offset             VirtAddr           PhysAddr
> >> >>          FileSiz            MemSiz              Flags  Align
> >> >> ..............................................................................................................................................................
> >> >>   LOAD        0x0000000076d40000 0xffff80017fe00000 0x0000000180000000
> >> >>                 0x0000001680000000 0x0000001680000000  RWE    0
> >> >>
> >> >> 3. So if we do a simple calculation:
> >> >>
> >> >> (VirtAddr + MemSiz) = 0xffff80017fe00000 + 0x0000001680000000 =
> >> >> 0xFFFF8017FFE00000 != 0xffff801800000000.
> >> >>
> >> >> which indicates that the end virtual memory nodes are not the same
> >> >> between vmlinux and vmcore.
> >> >
> >> > If I've followed this properly: the problem is that to generate the ELF headers
> >> > in the post-kdump vmcore, at kdump-load-time kexec-tools has to guess the
> >> > virtual addresses of the 'System RAM' regions it can see in /proc/iomem.
> >> >
> >> > The problem you are hitting is an invisible hole at the beginning of RAM,
> >> > meaning user-space's guess_phys_to_virt() is off by the size of this hole.
> >> >
> >> > Isn't KASLR a special case for this? You must have to correct for that after
> >> > kdump has happened, based on an elf-note in the vmcore. Can't we always do this?
> >>
> >> No, I hit this issue both for the KASLR and non-KASLR boot cases. We
> >> can fix this either in kernel or user-space.
> >>
> >> Fixing this in kernel space seems better to me as the definition of
> >> 'memstart_addr' is that it indicates the start of the physical ram,
> >> but since in this case there is a hole at the start of the system ram
> >> visible in Linux (and thus to user-space), but 'memstart_addr' is
> >> still 0 which seems contradictory at the least. This causes PHY_OFFSET
> >> to be 0 as well, which is again contradictory.
> >
> > Contradictory to who?
> 
> I meant that the 'memstart_addr' and PHY_OFFSET value are computed as
> 0 in the above particular case, which is not the real representation
> of the start of System RAM as the 1st memory block available in Linux
> starts from 2MB [as confirmed by the 'memblock_start_of_DRAM()' value
> of 0x200000] and indicated by '/proc/iomem':
> 
> # head -1 /proc/iomem
> 00200000-0021ffff : reserved

Who said it's supposed to be the "real representation of the start of System
RAM"? The kernel is fine with this being 0 in the case you describe. How
about we rename the variable to 'memstart_addr_sometimes_zero'? Does that
help?

> > Userspace has no business messing around with this
> > stuff and I'm reluctant to make this an ABI by adding a symbol with a
> > special name. Why can't the various constants needed by these tools be
> > exported in the ELF headers for kcore/vmcore, or as a NOTE as James
> > suggests? That sounds a lot less fragile to me.
> 
> But we already add the 'memstart_addr' variable to kallsyms in the
> kernel, don't we? And so user-space tools do use the same - so we
> already have a precedent available.

Whoa, whoa -- hold up! The implication here is that variables exposed via
kallsyms are ABI. That's simply not true, otherwise we'd be breaking the
ABI every kernel release.

Will
