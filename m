From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 24 Jan 2013 17:13:49 +0000
Subject: [PATCH v6 01/15] ARM: Add page table and page defines needed
 by KVM
In-Reply-To: <CANM98q+mmU4R1yQ7mnp_QynhX4mbBiViP96FMjSob=fzAHLp6Q@mail.gmail.com>
References: <20130116175716.29147.15348.stgit@ubuntu>
 <20130116175726.29147.57548.stgit@ubuntu>
 <20130124113935.GA1658@localhost.cambridge.arm.com>
 <CANM98qKYhvb6YVUr_jF0iYrgcmoMqtom+9tsZw1PkWFabRKVNQ@mail.gmail.com>
 <20130124170220.GF18233@arm.com>
 <CANM98q+mmU4R1yQ7mnp_QynhX4mbBiViP96FMjSob=fzAHLp6Q@mail.gmail.com>
Message-ID: <20130124171349.GH18233@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 24, 2013 at 05:04:32PM +0000, Christoffer Dall wrote:
> On Thu, Jan 24, 2013 at 12:02 PM, Catalin Marinas
> <catalin.marinas@arm.com> wrote:
> > On Thu, Jan 24, 2013 at 04:05:33PM +0000, Christoffer Dall wrote:
> >> On Thu, Jan 24, 2013 at 6:39 AM, Catalin Marinas
> >> <catalin.marinas@arm.com> wrote:
> >> > On Wed, Jan 16, 2013 at 05:57:26PM +0000, Christoffer Dall wrote:
> >> >> @@ -82,6 +85,10 @@ extern pgprot_t            pgprot_kernel;
> >> >>  #define PAGE_READONLY_EXEC   _MOD_PROT(pgprot_user, L_PTE_USER | L_PTE_RDONLY)
> >> >>  #define PAGE_KERNEL          _MOD_PROT(pgprot_kernel, L_PTE_XN)
> >> >>  #define PAGE_KERNEL_EXEC     pgprot_kernel
> >> >> +#define PAGE_HYP             _MOD_PROT(pgprot_kernel, L_PTE_HYP)
> >> >> +#define PAGE_HYP_DEVICE              _MOD_PROT(pgprot_hyp_device, L_PTE_HYP)
> >> >> +#define PAGE_S2                      _MOD_PROT(pgprot_s2, L_PTE_S2_RDONLY)
> >> >> +#define PAGE_S2_DEVICE               _MOD_PROT(pgprot_s2_device, L_PTE_USER | L_PTE_S2_RDONLY)
> >> >
> >> > Are these S2 read-only by default?
> >>
> >> not sure I understand what you're asking here?
> >
> > Why do you pass L_PTE_S2_RDONLY? Do you need to restrict guest writes
> > via the stage 2 attributes?
> >
> yes, for example when KSM merges two pages, then it must be mapped
> read-only to the guest so that we catch writes and perform COW.

OK, so you want the default to be read-only unless write access is
required and you perform an 'or' with L_PTE_S2_RDWR. Sounds fine.

-- 
Catalin
