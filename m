From: will.deacon@arm.com (Will Deacon)
Date: Fri, 6 Jul 2018 14:37:59 +0100
Subject: [PATCH v2 3/4] efi/arm: map UEFI memory map earlier on boot
In-Reply-To: <20180706013311.GP28220@linaro.org>
References: <20180619064424.6642-1-takahiro.akashi@linaro.org>
 <20180619064424.6642-4-takahiro.akashi@linaro.org>
 <20180704170655.GD8370@arm.com>
 <CAKv+Gu9_rYYyQ+t89otz46DR0D4GDj-cCjhx9q=p+D8LWFRkgQ@mail.gmail.com>
 <20180705094313.GL28220@linaro.org>
 <ec1a5f0f-99e3-fda1-9a64-5c2539817190@arm.com>
 <20180705164824.GA7445@arm.com>
 <CAKv+Gu-c0wcscUZzRqOTAHg-L70jFf80T=7x6pVPe7iK8-wykw@mail.gmail.com>
 <20180706004226.GO28220@linaro.org>
 <20180706013311.GP28220@linaro.org>
Message-ID: <20180706133758.GB11172@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Akashi,

On Fri, Jul 06, 2018 at 10:33:13AM +0900, AKASHI Takahiro wrote:
> On Fri, Jul 06, 2018 at 09:42:28AM +0900, AKASHI Takahiro wrote:
> > I almost believed that my patch#2 was just a preparatory one for patch#3
> > where arm_enable_runtime_services() is moved aggressively forward.
> > But acpi_os_ioremap() is not a __init function and I can now agree to
> > keeping patch#2.
> > 
> > Meanwhile, the consequent code with Ard's patch would look like:
> > ---8<---
> > static int __init arm_enable_runtime_services(void)
> > {
> >         ...
> >         efi_memmap_unmap();
> > 
> >         mapsize = efi.memmap.desc_size * efi.memmap.nr_map;
> > 
> >         if (efi_memmap_init_late(efi.memmap.phys_map, mapsize)) {
> >                 pr_err("Failed to remap EFI memory map\n");
> >                 return 0;
> >         }
> >         ...
> > }
> > --->8---
> > It seems to me that it makes no sense.
> 
> Oops, it does. Comments at efi_memmap_init_late() say:
> ---8<---
>  * The reason there are two EFI memmap initialisation
>  * (efi_memmap_init_early() and this late version) is because the
>  * early EFI memmap should be explicitly unmapped once EFI
>  * initialisation is complete as the fixmap space used to map the EFI
>  * memmap (via early_memremap()) is a scarce resource.
> --->8---
> 
> > Is it okay to take them out?
> 
> Never mind.

I'm struggling with your monologue...

Please can you send a v3 of the series, containing the patches that you
think are necessary, along with the Acks you've collected?

Thanks,

Will
