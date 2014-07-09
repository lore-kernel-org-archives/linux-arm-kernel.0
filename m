From: dave.hansen@intel.com (Dave Hansen)
Date: Wed, 09 Jul 2014 13:37:34 -0700
Subject: [RFC/PATCH RESEND -next 01/21] Add kernel address sanitizer
 infrastructure.
In-Reply-To: <1404905415-9046-2-git-send-email-a.ryabinin@samsung.com>
References: <1404905415-9046-1-git-send-email-a.ryabinin@samsung.com>
 <1404905415-9046-2-git-send-email-a.ryabinin@samsung.com>
Message-ID: <53BDA80E.9060602@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/09/2014 04:29 AM, Andrey Ryabinin wrote:
> +void __init kasan_alloc_shadow(void)
> +{
> +	unsigned long lowmem_size = (unsigned long)high_memory - PAGE_OFFSET;
> +	unsigned long shadow_size;
> +	phys_addr_t shadow_phys_start;
> +
> +	shadow_size = lowmem_size >> KASAN_SHADOW_SCALE_SHIFT;

This calculation is essentially meaningless, and it's going to break
when we have sparse memory situations like having big holes.  This code
attempts to allocate non-sparse data for backing what might be very
sparse memory ranges.

It's quite OK for us to handle configurations today where we have 2GB of
RAM with 1GB at 0x0 and 1GB at 0x10000000000.  This code would attempt
to allocate a 128GB shadow area for this configuration with 2GB of RAM. :)

You're probably going to get stuck doing something similar to the
sparsemem-vmemmap code does.  You could handle this for normal sparsemem
by adding a shadow area pointer to the memory section.
Or, just vmalloc() (get_vm_area() really) the virtual space and then
make sure to allocate the backing store before you need it (handling the
faults would probably get too tricky).
