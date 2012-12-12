From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Wed, 12 Dec 2012 11:10:15 +0100
Subject: [PATCH] ARM: decompressor: Flush tlb before swiching domain 0
 to client mode
In-Reply-To: <1355276466-18295-1-git-send-email-arve@android.com>
References: <1355276466-18295-1-git-send-email-arve@android.com>
Message-ID: <50C85807.2000609@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 12 December 2012 02:41 AM, Arve Hj?nnev?g wrote:
> If the bootloader used a page table that is incompatible with domain 0
> in client mode, then swithing domain 0 to client mode causes a fault
> if we don't flush the tlb after updating the page table pointer.
>
> Signed-off-by: Arve Hj?nnev?g <arve@android.com>
> ---
>   arch/arm/boot/compressed/head.S |    1 +
>   1 files changed, 1 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/boot/compressed/head.S b/arch/arm/boot/compressed/head.S
> index 90275f0..9c8034c 100644
> --- a/arch/arm/boot/compressed/head.S
> +++ b/arch/arm/boot/compressed/head.S
> @@ -704,6 +704,7 @@ __armv7_mmu_cache_on:
>   		bic     r6, r6, #1 << 31        @ 32-bit translation system
>   		bic     r6, r6, #3 << 0         @ use only ttbr0
>   		mcrne	p15, 0, r3, c2, c0, 0	@ load page table pointer
> +		mcrne	p15, 0, r0, c8, c7, 0	@ flush I,D TLBs
>   		mcrne	p15, 0, r1, c3, c0, 0	@ load domain access control
>   		mcrne   p15, 0, r6, c2, c0, 2   @ load ttb control
>   #endif
>
The TLB's are already flushed few lines above so above patching
shouldn't help if it was really dirty TLB entry issue. I suspect that
your boot-loader clean-up [1] function may not be taking care of
flushing caches which could potetially lead to the issue.

Have you checked that ?

Regards
Santosh

[1] http://www.arm.linux.org.uk/developer/noboot-checklist/
