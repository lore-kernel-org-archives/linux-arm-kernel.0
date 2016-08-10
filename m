From: panand@redhat.com (Pratyush Anand)
Date: Wed, 10 Aug 2016 09:27:43 +0530
Subject: [PATCH v3 2/3] arm64: Add arm64 kexec support
In-Reply-To: <177affa377979b1f10d5bd39107b96fe506eb683.1470693832.git.geoff@infradead.org>
References: <cover.1470693832.git.geoff@infradead.org>
 <177affa377979b1f10d5bd39107b96fe506eb683.1470693832.git.geoff@infradead.org>
Message-ID: <20160810035743.GA27500@localhost.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Geoff,

On 08/08/2016:10:19:33 PM, Geoff Levand wrote:
> Add kexec reboot support for ARM64 platforms.
> 
> Signed-off-by: Geoff Levand <geoff@infradead.org>
> ---

> +
> +		arm64_mem.page_offset = ehdr.e_entry - arm64_mem.text_offset;
> +
> +		dbgprintf("%s: e_entry:       %016llx -> %016lx\n", __func__,
> +			ehdr.e_entry,
> +			virt_to_phys(ehdr.e_entry));
> +		dbgprintf("%s: p_vaddr:       %016llx -> %016lx\n", __func__,
> +			phdr->p_vaddr,
> +			virt_to_phys(phdr->p_vaddr));
> +		dbgprintf("%s: header_offset: %016lx\n", __func__,
> +			header_offset);
> +		dbgprintf("%s: text_offset:   %016lx\n", __func__,
> +			arm64_mem.text_offset);
> +		dbgprintf("%s: image_size:    %016lx\n", __func__,
> +			arm64_mem.image_size);
> +		dbgprintf("%s: phys_offset:   %016lx\n", __func__,
> +			arm64_mem.phys_offset);
> +		dbgprintf("%s: page_offset:   %016lx\n", __func__,
> +			arm64_mem.page_offset);

Although it works on mustang, I would like to understand few things:

This is what is being printed by kexec-tools:

elf_arm64_load: e_entry:       fffffc0008080000 -> 0000004000080000
elf_arm64_load: p_vaddr:       fffffc0008080000 -> 0000004000080000
elf_arm64_load: header_offset: 0000000000000000
elf_arm64_load: text_offset:   0000000000080000
elf_arm64_load: image_size:    00000000013a0000
elf_arm64_load: phys_offset:   0000004000000000
elf_arm64_load: page_offset:   fffffc0008000000

kernel is having 42 VA Bits, so a debug print in kernel says that
PAGE_OFFSET=fffffe0000000000. Notice the difference between the values
calculated by kernel and kexec-tools. Isn't it confusing? I think kexec-tools
page_offset is text_page_offset and not the one which kernel uses. So, probably
we can rename it accordingly. Otherwise, we may sync kexec-tools's
virt_to_phys() and vice-versa definitions with that of kernel definitions.

In my case, kernel has kimage_voffset=fffffbc008000000. So kernel translate
virtual address fffffc0008080000 as fffffc0008080000 - fffffbc008000000 =
0000004000080000 which is matching to the one calculated by kexec-tools (for
e_entry).

~Pratyush
