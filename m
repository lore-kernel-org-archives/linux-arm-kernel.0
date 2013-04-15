From: cdall@cs.columbia.edu (Christoffer Dall)
Date: Sun, 14 Apr 2013 21:52:55 -0700
Subject: [PATCH] ARM: KVM: fix L_PTE_S2_RDWR to actually be Read/Write
In-Reply-To: <1365771616-7380-1-git-send-email-marc.zyngier@arm.com>
References: <1365771616-7380-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <CAEDV+g+eMFOX4GepsLtNe0JGxqQ1pnFDOs8y7_iaUgppTFouvQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 12, 2013 at 6:00 AM, Marc Zyngier <marc.zyngier@arm.com> wrote:
> Looks like our L_PTE_S2_RDWR definition is slightly wrong,
> and is actually write only (see ARM ARM Table B3-9, Stage 2 control
> of access permissions). Didn't make a difference for normal pages,
> as we OR the flags together, but I'm still wondering how it worked
> for Stage-2 mapped devices, such as the GIC.

PAGE_S2_DEVICE uses L_PTE_USER which sets bit 6, so that's why it works.

The define used to be called _WRITE, which is how this creeped in. We
should probably change this to be completely independent of
L_PTE_USER, I'll cook up a patch.

>
> Brown paper bag time, again.

thanks

>
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> ---
>  arch/arm/include/asm/pgtable-3level.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm/include/asm/pgtable-3level.h b/arch/arm/include/asm/pgtable-3level.h
> index 6ef8afd..86b8fe3 100644
> --- a/arch/arm/include/asm/pgtable-3level.h
> +++ b/arch/arm/include/asm/pgtable-3level.h
> @@ -111,7 +111,7 @@
>  #define L_PTE_S2_MT_WRITETHROUGH (_AT(pteval_t, 0xa) << 2) /* MemAttr[3:0] */
>  #define L_PTE_S2_MT_WRITEBACK   (_AT(pteval_t, 0xf) << 2) /* MemAttr[3:0] */
>  #define L_PTE_S2_RDONLY                 (_AT(pteval_t, 1) << 6)   /* HAP[1]   */
> -#define L_PTE_S2_RDWR           (_AT(pteval_t, 2) << 6)   /* HAP[2:1] */
> +#define L_PTE_S2_RDWR           (_AT(pteval_t, 3) << 6)   /* HAP[2:1] */
>
>  /*
>   * Hyp-mode PL2 PTE definitions for LPAE.
> --
> 1.8.1.4
>
>
>
> _______________________________________________
> kvmarm mailing list
> kvmarm at lists.cs.columbia.edu
> https://lists.cs.columbia.edu/cucslists/listinfo/kvmarm
