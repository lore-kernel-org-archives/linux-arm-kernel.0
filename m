From: james.morse@arm.com (James Morse)
Date: Mon, 20 Jun 2016 16:36:52 +0100
Subject: [PATCH v19 03/13] arm64/kexec: Add core kexec support
In-Reply-To: <b5534d3ea3662d9f7fc5909b158ab36d135d8f6d.1466120418.git.geoff@infradead.org>
References: <cover.1466120418.git.geoff@infradead.org>
 <b5534d3ea3662d9f7fc5909b158ab36d135d8f6d.1466120418.git.geoff@infradead.org>
Message-ID: <57680D94.6080704@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Geoff,

On 17/06/16 00:48, Geoff Levand wrote:
> Add three new files, kexec.h, machine_kexec.c and relocate_kernel.S to the
> arm64 architecture that add support for the kexec re-boot mechanism
> (CONFIG_KEXEC) on arm64 platforms.

> diff --git a/arch/arm64/kernel/machine_kexec.c b/arch/arm64/kernel/machine_kexec.c
> new file mode 100644
> index 0000000..a6dcb9c
> --- /dev/null
> +++ b/arch/arm64/kernel/machine_kexec.c

[ ... ]

> +
> +/**
> + * kexec_list_flush - Helper to flush the kimage list and source pages to PoC.
> + */
> +static void kexec_list_flush(struct kimage *kimage)
> +{
> +	kimage_entry_t *entry;
> +
> +	for (entry = &kimage->head; ; entry++) {
> +		unsigned int flag;
> +		void *addr;
> +
> +		__flush_dcache_area(entry, sizeof(kimage_entry_t));
> +
> +		flag = *entry & IND_FLAGS;
> +		if (flag == IND_DONE)
> +			break;
> +
> +		addr = phys_to_virt(*entry & PAGE_MASK);
> +
> +		switch (flag) {
> +		case IND_INDIRECTION:
> +			/* Set entry point just before the new list page. */
> +			entry = (kimage_entry_t *)addr - 1;

Ah, after this restructuring we end up cleaning this page as we fall-through,
and one kimage_entry_t at a time as we walk the list.

			break;
?

> +		case IND_SOURCE:
> +			__flush_dcache_area(addr, PAGE_SIZE);
> +			break;
> +		case IND_DESTINATION:
> +			break;
> +		default:
> +			BUG();
> +		}
> +	}
> +}


> diff --git a/arch/arm64/kernel/relocate_kernel.S b/arch/arm64/kernel/relocate_kernel.S
> new file mode 100644
> index 0000000..51b73cd
> --- /dev/null
> +++ b/arch/arm64/kernel/relocate_kernel.S

[ ... ]

> +.ltorg
> +
> +.align 3	/* To keep the 64-bit values below naturally aligned. */
> +
> +.Lcopy_end:
> +.org	KEXEC_CONTROL_PAGE_SIZE


On 16/06/16 23:41, Geoff Levand wrote:
> This is to check if arm64_relocate_new_kernel gets too
> big.  The assembler should give an error if the location
> counter is set backwards.

Cunning. (probably worth a comment).

This looks like it is need because we hard-coded KEXEC_CONTROL_PAGE_SIZE in
kexec.h, so the code must be smaller than that size.
It looks like this value is only ever passed to get_order(), could we just pass
the actual size? It shouldn't matter if it grows >4K, as the core code will
allocate enough memory, and the memcpy() in machine_kexec() uses the size too.


Reviewed-by: James Morse <james.morse@arm.com>

Thanks,


James
