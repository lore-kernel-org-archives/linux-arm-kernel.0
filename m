From: will.deacon@arm.com (Will Deacon)
Date: Wed, 6 Aug 2014 17:32:38 +0100
Subject: [RFC PATCH] arm64/efi: use id mapping for Runtime Services
In-Reply-To: <CAKv+Gu9xtGRTbhzzyCbGt7CEL=ORkpEnuipweedzDbBJZGGxuw@mail.gmail.com>
References: <1406815909-26825-1-git-send-email-ard.biesheuvel@linaro.org>
 <20140806143632.GV25953@arm.com>
 <CAKv+Gu9xtGRTbhzzyCbGt7CEL=ORkpEnuipweedzDbBJZGGxuw@mail.gmail.com>
Message-ID: <20140806163238.GA25953@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 06, 2014 at 04:15:23PM +0100, Ard Biesheuvel wrote:
> On 6 August 2014 16:36, Will Deacon <will.deacon@arm.com> wrote:
> > On Thu, Jul 31, 2014 at 03:11:49PM +0100, Ard Biesheuvel wrote:
> >>  #define efi_call_virt(f, ...)                                                \
> >>  ({                                                                   \
> >> -     efi_##f##_t *__f = efi.systab->runtime->f;                      \
> >> +     efi_##f##_t *__f;                                               \
> >>       efi_status_t __s;                                               \
> >>                                                                       \
> >> -     kernel_neon_begin();                                            \
> >> +     kernel_neon_begin(); /* disables preemption */                  \
> >> +     switch_pgd(idmap_pg_dir, &init_mm);                             \
> >> +     __f =  efi.systab->runtime->f;                                  \
> >>       __s = __f(__VA_ARGS__);                                         \
> >> +     switch_pgd(current->active_mm->pgd, current->active_mm);        \
> >>       kernel_neon_end();                                              \
> >>       __s;                                                            \
> >>  })
> >
> > This scares the bejesus out of me, but I can't put my finger on exactly why.
> > I think it does what you intend and I can't break it myself, so it would be
> > really good if the EFI folks could confirm that this looks good to them.
> >
> 
> There is something similar in the x86 code (arch/x86/platform/efi/efi.c)
> """
>  * The new method does a pagetable switch in a preemption-safe manner
>  * so that we're in a different address space when calling a runtime
>  * function. For function arguments passing we do copy the PGDs of the
>  * kernel page table into ->trampoline_pgd prior to each call.
> """
> 
> How exactly this will turn out for arm64 (and ARM) is still under
> discussion, though. My position is that if you are going to switch
> pgd's anyway, why not just use the id mapping? And even if you feel it
> is mandatory to install a virtual address mapping into UEFI (which I
> think is /not/ the case), you could install an id mapping as well,
> which means all the related machinery still gets invoked.
> The alternative to using a TTBR0 mapping would be to reserve a slice
> of kernel virtual memory so that the Runtime Services are guaranteed
> to live at the same virtual address after a kexec, ideally the same
> region on 4k and 64k pages ...
> 
> We are planning to discuss this further at Linaro Connect next month.

Ok, thanks for the update. I'll hold off on this until you've discussed it
some more.

Cheers,

Will
