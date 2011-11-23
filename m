From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 23 Nov 2011 14:32:31 +0000
Subject: Porting the 2.6.38 linux kernel to ARM11 MPcore
In-Reply-To: <CAK-0apbxgJj6JHXOCaLf0tPgw3nPrBRnkYB23-brsRmdbBLz5g@mail.gmail.com>
References: <CAK-0apYKjvxXasEfYCocjqEan5dKoXJgMON2gC-nMenKQaU9UQ@mail.gmail.com>
 <CAHkRjk491+H9Wh-uV8807VSkZ4Mk+UK3Jv6EThtOsRb7ULpUjg@mail.gmail.com>
 <CAK-0apaX6gPrHPWiE6zDCey7NvnMU2J5fOR0OXr_ZQCc+TUmyA@mail.gmail.com>
 <CAK-0apbxgJj6JHXOCaLf0tPgw3nPrBRnkYB23-brsRmdbBLz5g@mail.gmail.com>
Message-ID: <20111123143231.GA9148@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 23, 2011 at 02:14:06PM +0000, Moln?r G?bor wrote:
> > Does your physical RAM start at 0xc0000000 and it is all ignored?
> > Setting highmem would fix as all your lowmem (including the kernel
> > code) would be unmapped, hence the fault. What's the VMALLOC_END
> > defined to?
> 
> #define VMALLOC_END             0xf8000000
> 
> For the platform i use. The size of vmalloc is the default (128MB).
> 
> If HIGHMEM is not set, this area is executed:
> 
> >/*
> >792                  * Check whether this memory bank would entirely overlap
> >793                  * the vmalloc area.
> >794                  */
> >795                 if (__va(bank->start) >= vmalloc_min ||
> >796                     __va(bank->start) < (void *)PAGE_OFFSET) {
> >797                         printk(KERN_NOTICE "Ignoring RAM at %.8lx-%.8lx "
> >798                                "(vmalloc region overlap).\n",
> >799                                bank->start, bank->start + bank->size - 1);
> >800                         continue;
> >801                 }
> 
> static void * __initdata vmalloc_min = (void *)(VMALLOC_END - SZ_128M);
> 
> The kernel is loaded on the phisical address: 0xc0000000-0xc05000000.
> (This region is given as atag_mem as well).
> 
> At the current configuration i believe vmalloc should be at
> 0xF0000000-0xF8000000.
> 
> Why does this overlap with 0xC0000000-0xC0500000?

So it doesn't, in which case you may want to place some printk's in the
kernel around the message reporting that your block of RAM is ignored.

-- 
Catalin
