From: slash.tmp@free.fr (Mason)
Date: Thu, 25 May 2017 00:15:31 +0200
Subject: User-space code aborts on some (but not all) misaligned accesses
In-Reply-To: <CAKv+Gu83Q1bKa7PhXrSqf3jWj-SDWGcEYW1KdXuBAKbckN4Bvw@mail.gmail.com>
References: <e80ee08d-e8ab-9eeb-9555-a743f8681d7d@free.fr>
 <b9060068-5b9b-89b4-851e-430ec02f9fd8@arm.com>
 <382740a0-7d3b-7109-085a-d0ee2cc75638@free.fr>
 <CAKv+Gu83Q1bKa7PhXrSqf3jWj-SDWGcEYW1KdXuBAKbckN4Bvw@mail.gmail.com>
Message-ID: <a09c99d4-10a0-dcf1-a4fe-9e284ac5275d@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[ Dropping gcc-help at this point ]

On 24/05/2017 19:27, Ard Biesheuvel wrote:

> It is really quite simple
> 1. add the memory to the /memory DT node
> 2. add it as a no-map region to the /reserved-memory DT node
> 
> This should result in pgprot_writecombine() attributes on your O_SYNC
> /dev/mem mapping, which should make the problem go away.

I think I see what you are referring to:

http://elixir.free-electrons.com/linux/latest/source/drivers/char/mem.c#L357

http://elixir.free-electrons.com/linux/latest/source/arch/arm/mm/mmu.c#L701

#ifdef CONFIG_ARM_DMA_MEM_BUFFERABLE
pgprot_t phys_mem_access_prot(struct file *file, unsigned long pfn,
			      unsigned long size, pgprot_t vma_prot)
{
	if (!pfn_valid(pfn))
		return pgprot_noncached(vma_prot);
	else if (file->f_flags & O_SYNC)
		return pgprot_writecombine(vma_prot);
	return vma_prot;
}
EXPORT_SYMBOL(phys_mem_access_prot);
#endif

Telling Linux about the RAM makes pfn_valid() return true,
and using O_SYNC means calling pgprot_writecombine.

Thanks for the pointers.

For my own reference:
https://www.kernel.org/doc/Documentation/unaligned-memory-access.txt
https://www.kernel.org/doc/Documentation/arm/mem_alignment

Regards.
