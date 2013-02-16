From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Sat, 16 Feb 2013 08:51:14 -0500 (EST)
Subject: [PATCH v6 3/3] ARM: mm: use static_vm for managing static mapped
 areas
In-Reply-To: <201302161249.08597.arnd@arndb.de>
References: <1360142010-10598-1-git-send-email-iamjoonsoo.kim@lge.com>
 <1360142010-10598-4-git-send-email-iamjoonsoo.kim@lge.com>
 <201302161249.08597.arnd@arndb.de>
Message-ID: <alpine.LFD.2.03.1302160850450.6419@syhkavp.arg>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, 16 Feb 2013, Arnd Bergmann wrote:

> On Wednesday 06 February 2013, Joonsoo Kim wrote:
> > @@ -859,17 +864,12 @@ static void __init pci_reserve_io(void)
> >  {
> >  	struct vm_struct *vm;
> >  	unsigned long addr;
> > +	struct static_vm *svm;
> >  
> > -	/* we're still single threaded hence no lock needed here */
> > -	for (vm = vmlist; vm; vm = vm->next) {
> > -		if (!(vm->flags & VM_ARM_STATIC_MAPPING))
> > -			continue;
> > -		addr = (unsigned long)vm->addr;
> > -		addr &= ~(SZ_2M - 1);
> > -		if (addr == PCI_IO_VIRT_BASE)
> > -			return;
> > +	svm = find_static_vm_vaddr((void *)PCI_IO_VIRT_BASE);
> > +	if (svm)
> > +		return;
> >  
> > -	}
> 
> This is causing build warnings in a bunch of configurations now,
> see patch below.
> 
> 	Arnd
> 
> 8<-----
> ARM: mm: remove unused variables in pci_reserve_io
> 
> Patch "ARM: 7646/1: mm: use static_vm for managing static mapped areas"
> removed code from pci_reserve_io but left variable declarations
> in place that are now unused, as gcc correctly warns.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Acked-by: Nicolas Pitre <nico@linaro.org>


> 
> diff --git a/arch/arm/mm/mmu.c b/arch/arm/mm/mmu.c
> index c6fe15a..c6d45c8 100644
> --- a/arch/arm/mm/mmu.c
> +++ b/arch/arm/mm/mmu.c
> @@ -901,8 +901,6 @@ static void __init fill_pmd_gaps(void)
>  #if defined(CONFIG_PCI) && !defined(CONFIG_NEED_MACH_IO_H)
>  static void __init pci_reserve_io(void)
>  {
> -	struct vm_struct *vm;
> -	unsigned long addr;
>  	struct static_vm *svm;
>  
>  	svm = find_static_vm_vaddr((void *)PCI_IO_VIRT_BASE);
> 
