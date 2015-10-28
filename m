From: timur@codeaurora.org (Timur Tabi)
Date: Wed, 28 Oct 2015 12:11:57 -0500
Subject: [PATCH] arm64: efi: make sure vmlinux load address aligned on
 2MBytes
In-Reply-To: <CAKv+Gu_ivkemFva-Fu0E24mQqE-m0jPWBzo5OZAr7cyM08hqug@mail.gmail.com>
References: <1445981041-8774-1-git-send-email-timur@codeaurora.org>
 <CAKv+Gu_ivkemFva-Fu0E24mQqE-m0jPWBzo5OZAr7cyM08hqug@mail.gmail.com>
Message-ID: <563101DD.8080508@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/27/2015 09:06 PM, Ard Biesheuvel wrote:
>
> diff --git a/arch/arm64/kernel/efi-stub.c b/arch/arm64/kernel/efi-stub.c
> index 816120ece6bc..a60ce249cfc0 100644
> --- a/arch/arm64/kernel/efi-stub.c
> +++ b/arch/arm64/kernel/efi-stub.c
> @@ -42,7 +42,8 @@
>                   * Mustang), we can still place the kernel at the address
>                   * 'dram_base + TEXT_OFFSET'.
>                   */
> -               *image_addr = *reserve_addr = dram_base + TEXT_OFFSET;
> +               *image_addr = *reserve_addr = round_up(dram_base, SZ_2M) +
> +                                                      TEXT_OFFSET);
>                  nr_pages = round_up(kernel_memsize, EFI_ALLOC_ALIGN) /
>                             EFI_PAGE_SIZE;
>                  status = efi_call_early(allocate_pages, EFI_ALLOCATE_ADDRESS,

Tested-by: Timur Tabi <timur@codeaurora.org>
Tested-by: Shanker Donthineni <shankerd@codeaurora.org>

However, I think this formatting is easier to read:

		*image_addr = *reserve_addr =
			round_up(dram_base, SZ_2M) + TEXT_OFFSET;

This does make the kernel boot, but we suspect that there may be another 
problem.  We need to investigate it, but we have a suspicion that the 
EFI stub is trying to allocate from the Runtime Data block, and the 
alignment adjustment "fixes" the problem by moving the pointer to 
Conventional Memory.

Anyway, is there any chance we can get this fix into 4.3?  I'd hate to 
have 4.3 released knowing that it's broken on our hardware.

-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
