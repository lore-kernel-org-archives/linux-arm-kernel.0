From: yanjiang.jin@hxt-semitech.com (Jin, Yanjiang)
Date: Tue, 19 Jun 2018 03:02:15 +0000
Subject: [PATCH] arm64/mm: Introduce a variable to hold base address of
 linear region
In-Reply-To: <92ff5220-f863-4edc-bc9f-bd802d2efa9c@arm.com>
References: <1528785361-24477-1-git-send-email-bhsharma@redhat.com>
 <CAKv+Gu8Hs+CArdkAWoBPbr_p-nq5+0oPwOPg0NsJDRMkE_bM9A@mail.gmail.com>
 <CACi5LpNdg=Enp66BybNNuj5tQOp3ggyX=tm_SVzr8v2qCRteDw@mail.gmail.com>
 <d801005a-5f7a-8fe4-a486-bc6443a406a3@arm.com>
 <CACi5LpOJ7Q7nbo9m_HGqr44+n_iEtreZt+Uxtf2PzcHSzTdKuA@mail.gmail.com>
 <3a05cd0e-466e-4fb6-a78a-4b363e21aaab@arm.com>
 <CACi5LpMJnFthKUJGfMWgDyMTM65oTtOvsRGCtMDjWP32qDptbQ@mail.gmail.com>
 <92ff5220-f863-4edc-bc9f-bd802d2efa9c@arm.com>
Message-ID: <d5e01f4bedc649ff8a2ee17b17c1c33d@HXTBJIDCEMVIW02.hxtcorp.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



> -----Original Message-----
> From: kexec [mailto:kexec-bounces at lists.infradead.org] On Behalf Of James
> Morse
> Sent: 2018?6?15? 0:17
> To: Bhupesh Sharma <bhsharma@redhat.com>
> Cc: Mark Rutland <mark.rutland@arm.com>; Ard Biesheuvel
> <ard.biesheuvel@linaro.org>; Catalin Marinas <catalin.marinas@arm.com>;
> Kexec Mailing List <kexec@lists.infradead.org>; Will Deacon
> <will.deacon@arm.com>; AKASHI Takahiro <takahiro.akashi@linaro.org>;
> Bhupesh SHARMA <bhupesh.linux@gmail.com>; linux-arm-kernel <linux-arm-
> kernel at lists.infradead.org>
> Subject: Re: [PATCH] arm64/mm: Introduce a variable to hold base address of
> linear region
>
> Hi Bhupesh,
>
> On 14/06/18 08:53, Bhupesh Sharma wrote:
> > On Wed, Jun 13, 2018 at 3:59 PM, James Morse <james.morse@arm.com>
> wrote:
> >> On 13/06/18 06:16, Bhupesh Sharma wrote:
> >>> On Tue, Jun 12, 2018 at 3:42 PM, James Morse <james.morse@arm.com>
> wrote:
> >>>> If I've followed this properly: the problem is that to generate the
> >>>> ELF headers in the post-kdump vmcore, at kdump-load-time
> >>>> kexec-tools has to guess the virtual addresses of the 'System RAM' regions
> it can see in /proc/iomem.
> >>>>
> >>>> The problem you are hitting is an invisible hole at the beginning
> >>>> of RAM, meaning user-space's guess_phys_to_virt() is off by the size of this
> hole.
> >>>>
> >>>> Isn't KASLR a special case for this? You must have to correct for
> >>>> that after kdump has happened, based on an elf-note in the vmcore. Can't
> we always do this?
> >>>
> >>> No, I hit this issue both for the KASLR and non-KASLR boot cases.
> >>
> >> Because in both cases there is a hole at the beginning of the
> >> linear-map. KASLR is a special-case of this as the kernel adds a
> >> variable sized hole to do the randomization.
> >>
> >> Surely treating this as one case makes your user-space code simpler.
> >
> > Ok.
> >
> >>> Fixing this in kernel space seems better to me as the definition of
> >>
> >> Is there a kernel bug? Changing the definitions of internal kernel
> >> variables for the benefit of code digging in /proc/kcore|/dev/mem isn't going
> to fly.
> >
> > Indeed, I am not advocating to change the kernel space code just to
> > suit the user-space tools. However in this particular case the
> > 'memstart_addr' and PHY_OFFSET value are computed as 0 which IMO
>
> (What is PHY_OFFSET? I assume you mean PHYS_OFFSET, which is the same as
> memstart_addr ... why do you quote them together?)
>
>
> > is
> > not the real representation of the start of System RAM as the 1st
> > memory block available in Linux starts from 2MB [as confirmed by the
> > 'memblock_start_of_DRAM()' value of 0x200000] and indicated by
> > '/proc/iomem':
> >
> > # head -1 /proc/iomem
> > 00200000-0021ffff : reserved
>
> You have assumptions about what memstart_addr is based on its name. Names
> of kernel variables get further from their actual use over time.
>
> The purpose of this variable isn't to store where a hypothetical-lowest-page of
> memory would be in the linear map. The kernel doesn't have a handy variable for
> this, because on-one needs to know.
>
>
> > I think reading the kernel code and finding 'memstart_addr' and
> > PHY_OFFSET as 0, one gets the notion
>
> notion -> assumption based on the name
>
> It's just a name. Anyone reading this should grep for how the value is used.
> It's added/subtracted from addresses as part of phys_to_virt()/virt_to_phs(). It
> must be some kind of offset. What does it mean on its own? Probably nothing.
>
>
> > that the base of System RAM starts from 0, which is incorrect in the
> > above case as it starts from 2MB as the 1st block is of the type
> > EfiReservedMemType
>
> What will they assume if the value is negative?
>
> [...]
>
> > So, either we should have a uniform way of representing the virtual
> > base of the linear range
>
> What needs to know this? RAM will be somewhere between PAGE_OFFSET and
> the top of the address space. Anyone who wants to know where has a specific
> page in mind, phys_to_virt() or page_address() tell them where their page is.
>
>
> > or  we should rather look at removing the PAGE_OFFSET usage from the
> > kernel (or atleast the confusing comment from 'memory.h')
>
> This?:
> | PAGE_OFFSET - the virtual address of the start of the linear map
>
> Nothing here says its the virtual address of any particular physical page. Its the
> start of the region of VA space that holds the 1:1 mapping of RAM. Its value is
> generated at compile time, we have no idea where RAM will be until we boot,
> how could this be the address of any particular page?
>
>
> > BTW adding 'p2v_offset' as an elf-note seems like a good idea. If this
> > seems suitable, I can try and spin patch(es) using this approach (both
> > for the kernel and user-space tools).
>
> You seem to be using this for user-space phys_to_virt() based on values found in
> /proc/iomem. This should give you what you want, and isolate your user-space
> from the kernel's unexpected naming of variables.

I don't know could I simplify this problem?
Let's ignore what memstart_addr represents here, we just want to implement phys_to_virt() in an userspace applications(kexec-tools or others).

ARM64 Kernel has a below definition:

#define __phys_to_virt(x)       ((unsigned long)((x) - PHYS_OFFSET) | PAGE_OFFSET)

So userspace app must know PHYS_OFFSET(equal to memstart_addr now). Seems this is very simple, but memstart_addr has gone through several operations in arm64_memblock_init() depends on different Kernel configurations, so userspace app needs to know many additional definitions as following:

memblock_start_of_DRAM(),  (ifdef CONFIG_SPARSEMEM_VMEMMAP),  ARM64_MEMSTART_SHIFT,  SECTION_SIZE_BITS,  PAGE_OFFSET, memblock_end_of_DRAM(),
IS_ENABLED(CONFIG_RANDOMIZE_BASE), memstart_offset_seed.

It is hard to know all above in kexec-tools now. Originally I planned to read memstart_addr's value from "/dev/mem", but someone thought not all Kernels enable "/dev/mem", we'd better find a more generic approach. So we want to get some suggestions from ARM kernel community.
Can we export this variable in Kernel side through sysconf() or other similar methods? Or someone can provide an effect way to get memstart_addr's value?

Thanks,
Yanjiang


>
> I'd suggest a 64bit offset that is added to a physical address to get where in the
> linear map this page would be, if its mapped.
>
>
> Thanks,
>
> James
>
> _______________________________________________
> kexec mailing list
> kexec at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec



This email is intended only for the named addressee. It may contain information that is confidential/private, legally privileged, or copyright-protected, and you should handle it accordingly. If you are not the intended recipient, you do not have legal rights to retain, copy, or distribute this email or its contents, and should promptly delete the email and all electronic copies in your system; do not retain copies in any media. If you have received this email in error, please notify the sender promptly. Thank you.
