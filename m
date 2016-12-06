From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 6 Dec 2016 16:08:00 +0000
Subject: [PATCHv4 05/10] arm64: Use __pa_symbol for kernel symbols
In-Reply-To: <584011CB.3050505@arm.com>
References: <1480445729-27130-1-git-send-email-labbott@redhat.com>
 <1480445729-27130-6-git-send-email-labbott@redhat.com>
 <584011CB.3050505@arm.com>
Message-ID: <20161206160800.GD24177@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 01, 2016 at 12:04:27PM +0000, James Morse wrote:
> On 29/11/16 18:55, Laura Abbott wrote:
> > diff --git a/arch/arm64/kernel/hibernate.c b/arch/arm64/kernel/hibernate.c
> > index d55a7b0..4f0c77d 100644
> > --- a/arch/arm64/kernel/hibernate.c
> > +++ b/arch/arm64/kernel/hibernate.c
> > @@ -484,7 +481,7 @@ int swsusp_arch_resume(void)
> >  	 * Since we only copied the linear map, we need to find restore_pblist's
> >  	 * linear map address.
> >  	 */
> > -	lm_restore_pblist = LMADDR(restore_pblist);
> > +	lm_restore_pblist = lm_alias(restore_pblist);
> >  
> >  	/*
> >  	 * We need a zero page that is zero before & after resume in order to
> 
> This change causes resume from hibernate to panic in:
> > VIRTUAL_BUG_ON(x < (unsigned long) KERNEL_START ||
> > 		x > (unsigned long) KERNEL_END);
> 
> It looks like kaslr's relocation code has already fixed restore_pblist, so your
> debug virtual check catches this doing the wrong thing. My bug.
> 
> readelf -s vmlinux | grep ...
> > 103495: ffff000008080000     0 NOTYPE  GLOBAL DEFAULT    1 _text
> >  92104: ffff000008e43860     8 OBJECT  GLOBAL DEFAULT   24 restore_pblist
> > 105442: ffff000008e85000     0 NOTYPE  GLOBAL DEFAULT   24 _end
> 
> But restore_pblist == 0xffff800971b7f998 when passed to __phys_addr_symbol().

I think KASLR's a red herring; it shouldn't change the distance between
the restore_pblist symbol and {_text,_end}.

Above, ffff000008e43860 is the location of the pointer in the kernel
image (i.e. it's &restore_pblist). 0xffff800971b7f998 is the pointer
that was assigned to restore_pblist. For KASLR, the low bits (at least
up to a page boundary) shouldn't change across relocation.

Assuming it's only ever assigned a dynamic allocation, which should fall
in the linear map, the LMADDR() dance doesn't appear to be necessary.

> This fixes the problem:
> ----------------%<----------------
> diff --git a/arch/arm64/kernel/hibernate.c b/arch/arm64/kernel/hibernate.c
> index 4f0c77d2ff7a..8bed26a2d558 100644
> --- a/arch/arm64/kernel/hibernate.c
> +++ b/arch/arm64/kernel/hibernate.c
> @@ -457,7 +457,6 @@ int swsusp_arch_resume(void)
>         void *zero_page;
>         size_t exit_size;
>         pgd_t *tmp_pg_dir;
> -       void *lm_restore_pblist;
>         phys_addr_t phys_hibernate_exit;
>         void __noreturn (*hibernate_exit)(phys_addr_t, phys_addr_t, void *,
>                                           void *, phys_addr_t, phys_addr_t);
> @@ -478,12 +477,6 @@ int swsusp_arch_resume(void)
>                 goto out;
> 
>         /*
> -        * Since we only copied the linear map, we need to find restore_pblist's
> -        * linear map address.
> -        */
> -       lm_restore_pblist = lm_alias(restore_pblist);
> -
> -       /*
>          * We need a zero page that is zero before & after resume in order to
>          * to break before make on the ttbr1 page tables.
>          */
> @@ -534,7 +527,7 @@ int swsusp_arch_resume(void)
>         }
> 
>         hibernate_exit(virt_to_phys(tmp_pg_dir), resume_hdr.ttbr1_el1,
> -                      resume_hdr.reenter_kernel, lm_restore_pblist,
> +                      resume_hdr.reenter_kernel, restore_pblist,
>                        resume_hdr.__hyp_stub_vectors, virt_to_phys(zero_page));
> 
>  out:
> ----------------%<----------------

Folding that in (or having it as a preparatory cleanup patch) makes
sense to me. AFAICT the logic was valid (albeit confused) until now, so
it's not strictly a fix.

Thanks,
Mark.
