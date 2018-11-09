From: steve@steve-m.de (Steve Markgraf)
Date: Fri, 9 Nov 2018 21:58:12 +0100
Subject: usbfs zerocopy broken on ARM/ARM64
In-Reply-To: <20181107123111.GU30658@n2100.armlinux.org.uk>
References: <efda634a-ead8-2dfd-ffa1-1c94f970a0a5@steve-m.de>
 <20181107123111.GU30658@n2100.armlinux.org.uk>
Message-ID: <465978ed-6b26-d1cf-fb14-0cb7d5defcba@steve-m.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07.11.18 13:31, Russell King - ARM Linux wrote:
>> From what I read so far I got the impression that the 'proper' way would
>> be to use dma_mmap_coherent() with dma_addr instead of
>> remap_pfn_range(), however, I did not get it to work. Can anyone help
>> out?
> 
> That is correct.  Please show what you tried.  Thanks.

Thanks for the clarification. I now debugged it further and it turned
out I was using the wrong device pointer. Now it is working for both ARM
and x86 with:

> dma_mmap_coherent(ps->dev->bus->sysdev, vma, mem, dma_handle, size);

However, on x86 I get warnings in the Kernel log:

> x86/PAT: rtl_test:4018 map pfn RAM range req uncached-minus for
> [mem >0x34bc0000-0x34bfffff], got write-back

Another user of dma_mmap_coherent(), sound/core/pcm_native.c, only uses
it for arch != x86 for that reason:

> #ifndef CONFIG_X86 /* for avoiding warnings arch/x86/mm/pat.c */

Since the original code is working fine on x86, probably that would be
the way to go for the usbfs code as well.
And as the previous posters pointed out, hcd_buffer_alloc() can use
kmalloc() for PIO-based USB controllers, but in this case sets the
dma_handle to ~0, so we could check for this and only use
dma_mmap_coherent() if that's not the case.

If that's correct, I'll prepare a patch.

Regards,
Steve
