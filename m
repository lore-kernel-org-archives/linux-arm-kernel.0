From: yanjiang.jin@hxt-semitech.com (Jin, Yanjiang)
Date: Wed, 20 Jun 2018 02:16:59 +0000
Subject: [PATCH] arm64/mm: Introduce a variable to hold base address of
 linear region
In-Reply-To: <CACi5LpM2GV-vwcEGeCE20QW0PVmDcKnjz017sYBAwYRfZ24AzA@mail.gmail.com>
References: <CAKv+Gu8Hs+CArdkAWoBPbr_p-nq5+0oPwOPg0NsJDRMkE_bM9A@mail.gmail.com>
 <CACi5LpNdg=Enp66BybNNuj5tQOp3ggyX=tm_SVzr8v2qCRteDw@mail.gmail.com>
 <d801005a-5f7a-8fe4-a486-bc6443a406a3@arm.com>
 <CACi5LpOJ7Q7nbo9m_HGqr44+n_iEtreZt+Uxtf2PzcHSzTdKuA@mail.gmail.com>
 <3a05cd0e-466e-4fb6-a78a-4b363e21aaab@arm.com>
 <CACi5LpMJnFthKUJGfMWgDyMTM65oTtOvsRGCtMDjWP32qDptbQ@mail.gmail.com>
 <92ff5220-f863-4edc-bc9f-bd802d2efa9c@arm.com>
 <d5e01f4bedc649ff8a2ee17b17c1c33d@HXTBJIDCEMVIW02.hxtcorp.net>
 <20180619085541.GB13984@arm.com>
 <6860c284f1c74faa95edd6cf866ec80d@HXTBJIDCEMVIW02.hxtcorp.net>
 <20180619094045.GD13984@arm.com>
 <a720d91be20844cd9ed84728268300d9@HXTBJIDCEMVIW02.hxtcorp.net>
 <09260c7e-8b9d-bc3c-5bca-0fd75417f552@arm.com>
 <CACi5LpMoKP4eG5XhYe5hf5VC9MOY8KuHK=j0ujb8GFpyjAuAww@mail.gmail.com>
 <b0d40351-8d78-fd69-cc87-d5ea5eaabd2a@arm.com>
 <CACi5LpM2GV-vwcEGeCE20QW0PVmDcKnjz017sYBAwYRfZ24AzA@mail.gmail.com>
Message-ID: <51cf54d6a19f4837b74218b000cc23bc@HXTBJIDCEMVIW02.hxtcorp.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi James, Bhupesh,

If /proc/kcore always exists in kexec/kdump, I think this issue can be fixed easily. But it requires  that Kexec/kdump have to rely on " CONFIG_PROC_KCORE=y".
I am not sure if we can persuade Kexec-tools community to accept this.

Thanks,
Yanjiang

> -----Original Message-----
> From: Bhupesh Sharma [mailto:bhsharma at redhat.com]
> Sent: 2018?6?19? 19:58
> To: James Morse <james.morse@arm.com>
> Cc: Jin, Yanjiang <yanjiang.jin@hxt-semitech.com>; Will Deacon
> <will.deacon@arm.com>; Mark Rutland <mark.rutland@arm.com>; Ard
> Biesheuvel <ard.biesheuvel@linaro.org>; Catalin Marinas
> <catalin.marinas@arm.com>; Kexec Mailing List <kexec@lists.infradead.org>;
> AKASHI Takahiro <takahiro.akashi@linaro.org>; Bhupesh SHARMA
> <bhupesh.linux@gmail.com>; linux-arm-kernel <linux-arm-
> kernel at lists.infradead.org>
> Subject: Re: [PATCH] arm64/mm: Introduce a variable to hold base address of
> linear region
>
> Hi James,
>
> On Tue, Jun 19, 2018 at 4:56 PM, James Morse <james.morse@arm.com> wrote:
> > Hi Bhupesh,
> >
> > On 19/06/18 11:37, Bhupesh Sharma wrote:
> >> On Tue, Jun 19, 2018 at 3:46 PM, James Morse <james.morse@arm.com>
> wrote:
> >>> On 19/06/18 10:57, Jin, Yanjiang wrote:
> >>>>> -----Original Message-----
> >>>>> From: Will Deacon [mailto:will.deacon at arm.com]
> >>>>> Sent: 2018?6?19? 17:41
> >>>>> To: Jin, Yanjiang <yanjiang.jin@hxt-semitech.com>
> >>>>> Cc: James Morse <james.morse@arm.com>; Bhupesh Sharma
> >>>>> <bhsharma@redhat.com>; Mark Rutland <mark.rutland@arm.com>; Ard
> >>>>> Biesheuvel <ard.biesheuvel@linaro.org>; Catalin Marinas
> >>>>> <catalin.marinas@arm.com>; Kexec Mailing List
> >>>>> <kexec@lists.infradead.org>; AKASHI Takahiro
> >>>>> <takahiro.akashi@linaro.org>; Bhupesh SHARMA
> >>>>> <bhupesh.linux@gmail.com>; linux-arm-kernel <linux-arm-
> >>>>> kernel at lists.infradead.org>
> >>>>> Subject: Re: [PATCH] arm64/mm: Introduce a variable to hold base
> >>>>> address of linear region
> >
> >>>>>>>> It is hard to know all above in kexec-tools now. Originally I
> >>>>>>>> planned to read memstart_addr's value from "/dev/mem", but
> >>>>>>>> someone thought not all Kernels enable "/dev/mem", we'd better
> >>>>>>>> find a more generic approach. So we want to get some
> >>>>>>>> suggestions from ARM kernel
> >>>>> community.
> >>>>>>>> Can we export this variable in Kernel side through sysconf() or
> >>>>>>>> other similar methods? Or someone can provide an effect way to
> >>>>>>>> get memstart_addr's value?
> >>>>>>>
> >>>>>>> I thought the suggestion from James was to expose this via an
> >>>>>>> ELF NOTE in kcore and vmcore (or in the header directly if
> >>>>>>> that's possible, but I'm
> >>>>> not sure about it)?
> >>>>>>
> >>>>>> Thanks for your reply firstly. But same as DEVMEM, kcore is not a
> >>>>>> must-have, so we can't depend on it.
> >>>>>
> >>>>> Neither is KEXEC. We can select PROC_KCORE from KEXEC if it helps.
> >>>>>
> >>>>>> On the other hand, phys_to_virt() is called during generating
> >>>>>> vmcore in Kexec-tools, vmcore also can't help this issue.
> >>>>>
> >>>>> I don't understand this part. If you have the vmcore in your hand,
> >>>>> why can't you grok the pv offset from the note and use that in
> phys_to_virt()?
> >>>>
> >>>> It is a chicken-and-egg issue.
> >>>> phys_to virt() is for crashdump setup. To generate vmcore, we must
> >>>> call phys_to_virt(). At this point, no vmcore exists.
> >>>
> >>> Its needed for the parts of the ELF header that kexec-tools
> >>> generates at kdump load time?
> >>>
> >>> So adding this pv_offset to the key=value data
> >>> crash_save_vmcoreinfo_init() saves isn't available early enough?
> >
> >> Yes, one case where it is not actually available early enough for
> >> makedumpfile usage is if we are determining the PT_NOTE contents from
> >> the '/proc/kcore' on a 'live' system
> >
> >> int set_kcore_vmcoreinfo(uint64_t vmcoreinfo_addr, uint64_t
> >> vmcoreinfo_len)
> >>
> >> {
> >>
> >> <snip..>
> >> kvaddr = (ulong)vmcoreinfo_addr + PAGE_OFFSET;
> >>
> >> }
> >
> > You are trying to read the vmcoreinfo through /proc/kcore given
> > knowledge of its physical address.
> >
> > I'm suggesting adding the contents of vmcoreinfo as a PT_NOTE section
> > of /proc/kcore's ELF header. No special knowledge necessary, any
> > elf-parser should be able to dump the values.
> >
> >
> >> Now the problem at hand is to determine the offset at which the
> >> pv_offset (key=value data pair) lies in the '/proc/kcore' (I assume
> >> that when you mentioned above and earlier about adding this pair to
> >> the elfnotes you meant both the vmcoreinfo and 'proc/kcore'), as we
> >> can have 'n' number of PT_LOAD segments.
> >
> > It looks like there is already a NOTE section with core info in there:
> > | # readelf -l /proc/kcore
> > |
> > | Elf file type is CORE (Core file)
> > | Entry point 0x0
> > | There are 16 program headers, starting at offset 64
> > |
> > | Program Headers:
> > |  Type           Offset             VirtAddr           PhysAddr
> > |                 FileSiz            MemSiz              Flags  Align
> > |   NOTE           0x00000000000003c0 0x0000000000000000 0x0000000000000000
> > |                  0x0000000000001114 0x0000000000000000         0x0
> >
> > I assume we can add more notes without breaking the existing user...
> >
> > (and it looks like there are some broken __pa(kernel symbol) users in there.
>
> Thanks for your inputs.
>
> I am working on fixes on the above lines for kernel and user-space tools (like
> makedumpfile, crash-utility and kexec-tools).
>
> I will post some RFC patches on the same lines (or come back in case I get stuck
> somewhere) shortly.
>
> Thanks,
> Bhupesh



This email is intended only for the named addressee. It may contain information that is confidential/private, legally privileged, or copyright-protected, and you should handle it accordingly. If you are not the intended recipient, you do not have legal rights to retain, copy, or distribute this email or its contents, and should promptly delete the email and all electronic copies in your system; do not retain copies in any media. If you have received this email in error, please notify the sender promptly. Thank you.
