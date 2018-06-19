From: will.deacon@arm.com (Will Deacon)
Date: Tue, 19 Jun 2018 09:55:41 +0100
Subject: [PATCH] arm64/mm: Introduce a variable to hold base address of
 linear region
In-Reply-To: <d5e01f4bedc649ff8a2ee17b17c1c33d@HXTBJIDCEMVIW02.hxtcorp.net>
References: <1528785361-24477-1-git-send-email-bhsharma@redhat.com>
 <CAKv+Gu8Hs+CArdkAWoBPbr_p-nq5+0oPwOPg0NsJDRMkE_bM9A@mail.gmail.com>
 <CACi5LpNdg=Enp66BybNNuj5tQOp3ggyX=tm_SVzr8v2qCRteDw@mail.gmail.com>
 <d801005a-5f7a-8fe4-a486-bc6443a406a3@arm.com>
 <CACi5LpOJ7Q7nbo9m_HGqr44+n_iEtreZt+Uxtf2PzcHSzTdKuA@mail.gmail.com>
 <3a05cd0e-466e-4fb6-a78a-4b363e21aaab@arm.com>
 <CACi5LpMJnFthKUJGfMWgDyMTM65oTtOvsRGCtMDjWP32qDptbQ@mail.gmail.com>
 <92ff5220-f863-4edc-bc9f-bd802d2efa9c@arm.com>
 <d5e01f4bedc649ff8a2ee17b17c1c33d@HXTBJIDCEMVIW02.hxtcorp.net>
Message-ID: <20180619085541.GB13984@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 19, 2018 at 03:02:15AM +0000, Jin, Yanjiang wrote:
> > You seem to be using this for user-space phys_to_virt() based on values found in
> > /proc/iomem. This should give you what you want, and isolate your user-space
> > from the kernel's unexpected naming of variables.
> 
> I don't know could I simplify this problem?
> Let's ignore what memstart_addr represents here, we just want to implement
> phys_to_virt() in an userspace applications(kexec-tools or others).
> 
> ARM64 Kernel has a below definition:
> 
> #define __phys_to_virt(x)       ((unsigned long)((x) - PHYS_OFFSET) | PAGE_OFFSET)
> 
> So userspace app must know PHYS_OFFSET(equal to memstart_addr now). Seems
> this is very simple, but memstart_addr has gone through several operations
> in arm64_memblock_init() depends on different Kernel configurations, so
> userspace app needs to know many additional definitions as following:
> 
> memblock_start_of_DRAM(),  (ifdef CONFIG_SPARSEMEM_VMEMMAP),
> ARM64_MEMSTART_SHIFT,  SECTION_SIZE_BITS,  PAGE_OFFSET,
> memblock_end_of_DRAM(), IS_ENABLED(CONFIG_RANDOMIZE_BASE),
> memstart_offset_seed.
> 
> It is hard to know all above in kexec-tools now. Originally I planned to
> read memstart_addr's value from "/dev/mem", but someone thought not all
> Kernels enable "/dev/mem", we'd better find a more generic approach. So we
> want to get some suggestions from ARM kernel community.
> Can we export this variable in Kernel side through sysconf() or other
> similar methods? Or someone can provide an effect way to get
> memstart_addr's value?

I thought the suggestion from James was to expose this via an ELF NOTE
in kcore and vmcore (or in the header directly if that's possible, but
I'm not sure about it)?

Will
