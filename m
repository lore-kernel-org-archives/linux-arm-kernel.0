From: timur@codeaurora.org (Timur Tabi)
Date: Tue, 27 Oct 2015 16:15:45 -0500
Subject: [PATCH v2] arm64/efi: prefer AllocatePages() over efi_low_alloc()
 for vmlinux
In-Reply-To: <1437737907-10477-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1437737907-10477-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <CAOZdJXWgJKb7S0_3AJ4oT-gbgzMRYXydOoByh7chuervwJN1sw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 24, 2015 at 6:38 AM, Ard Biesheuvel
<ard.biesheuvel@linaro.org> wrote:
>
> +               /*
> +                * First, try a straight allocation at the preferred offset.
> +                * This will work around the issue where, if dram_base == 0x0,
> +                * efi_low_alloc() refuses to allocate at 0x0 (to prevent the
> +                * address of the allocation to be mistaken for a FAIL return
> +                * value or a NULL pointer). It will also ensure that, on
> +                * platforms where the [dram_base, dram_base + TEXT_OFFSET)
> +                * interval is partially occupied by the firmware (like on APM
> +                * Mustang), we can still place the kernel at the address
> +                * 'dram_base + TEXT_OFFSET'.
> +                */
> +               *image_addr = *reserve_addr = dram_base + TEXT_OFFSET;
> +               nr_pages = round_up(kernel_memsize, EFI_ALLOC_ALIGN) /
> +                          EFI_PAGE_SIZE;
> +               status = efi_call_early(allocate_pages, EFI_ALLOCATE_ADDRESS,
> +                                       EFI_LOADER_DATA, nr_pages,
> +                                       (efi_physical_addr_t *)reserve_addr);

This causes our kernel to crash, because on our system, dram_base is
not 2MB aligned.  I'll be posting a patch soon that fixes this.

-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project.
