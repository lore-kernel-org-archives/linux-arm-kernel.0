From: hoeun.ryu@gmail.com (Hoeun Ryu)
Date: Mon, 03 Jul 2017 17:18:09 +0900
Subject: [PATCH] arm:lpae: build TTB control register value from scratch
 in v7_ttb_setup
In-Reply-To: <1497232084-31907-1-git-send-email-hoeun.ryu@gmail.com>
References: <1497232084-31907-1-git-send-email-hoeun.ryu@gmail.com>
Message-ID: <1499069889.1734.38.camel@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello, Russell King.

Do you have a plan to include this patch in your tree ?

Thank you.

On Mon, 2017-06-12 at 10:47 +0900, Hoeun Ryu wrote:
> ?Reading TTBCR in early boot stage might return the value of the
> previous
> kernel's configuration, especially in case of kexec. For example, if
> normal kernel (first kernel) had run on a configuration of
> PHYS_OFFSET <=
> PAGE_OFFSET and crash kernel (second kernel) is running on a
> configuration
> PHYS_OFFSET > PAGE_OFFSET, which can happen because it depends on the
> reserved area for crash kernel, reading TTBCR and using the value to
> OR
> other bit fields might be risky because it doesn't have a reset value
> for
> TTBCR.
> 
> Acked-by: Russell King <rmk+kernel@armlinux.org.uk>
> Suggested-by: Robin Murphy <robin.murphy@arm.com>
> Signed-off-by: Hoeun Ryu <hoeun.ryu@gmail.com>
> 
> ---
> 
> ?* add Acked-by: Russell King <rmk+kernel@armlinux.org.uk>
> ?* v1: amended based on
> ?????- "[PATCHv2] arm: LPAE: kexec: clear TTBCR.T1SZ explicitly when
> ????????PHYS_OFFSET > PAGE_OFFSET"
> ?????- https://lkml.org/lkml/2017/6/5/239
> 
> ?arch/arm/mm/proc-v7-3level.S | 3 +--
> ?1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/arch/arm/mm/proc-v7-3level.S b/arch/arm/mm/proc-v7-
> 3level.S
> index 5e5720e..7d16bbc 100644
> --- a/arch/arm/mm/proc-v7-3level.S
> +++ b/arch/arm/mm/proc-v7-3level.S
> @@ -129,8 +129,7 @@ ENDPROC(cpu_v7_set_pte_ext)
> ?	.macro	v7_ttb_setup, zero, ttbr0l, ttbr0h, ttbr1, tmp
> ?	ldr	\tmp, =swapper_pg_dir		@
> swapper_pg_dir virtual address
> ?	cmp	\ttbr1, \tmp, lsr #12		@
> PHYS_OFFSET > PAGE_OFFSET?
> -	mrc	p15, 0, \tmp, c2, c0, 2		@ TTB
> control egister
> -	orr	\tmp, \tmp, #TTB_EAE
> +	mov	\tmp, #TTB_EAE			@ for TTB
> control egister
> ?	ALT_SMP(orr	\tmp, \tmp, #TTB_FLAGS_SMP)
> ?	ALT_UP(orr	\tmp, \tmp, #TTB_FLAGS_UP)
> ?	ALT_SMP(orr	\tmp, \tmp, #TTB_FLAGS_SMP << 16)
