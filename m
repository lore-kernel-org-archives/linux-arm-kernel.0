From: james.morse@arm.com (James Morse)
Date: Fri, 6 Jul 2018 09:57:14 +0100
Subject: [PATCH v3 2/5] arm64/mm: Make __enable_mmu() take the ttbr1 page
 as an argument
In-Reply-To: <20180702111659.25570-3-yaojun8558363@gmail.com>
References: <20180702111659.25570-1-yaojun8558363@gmail.com>
 <20180702111659.25570-3-yaojun8558363@gmail.com>
Message-ID: <faf6dcaf-6f52-6bdf-c66d-0bfe1a1dc181@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jun,

On 02/07/18 12:16, Jun Yao wrote:
> Make __enable_mmu() take the physical address of the ttbr1 page as
> an argument.

> diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
> index 3f99c59ba193..a1c7a4d3b9f3 100644
> --- a/arch/arm64/kernel/head.S
> +++ b/arch/arm64/kernel/head.S
> @@ -760,6 +761,7 @@ ENDPROC(__secondary_switched)
>   * Enable the MMU.
>   *
>   *  x0  = SCTLR_EL1 value for turning on the MMU.
> + *  x26 = TTBR1_EL1 value for turning on the MMU.

This works, but I'd really like as many assembly functions as possible to follow
the PCS [0]. We don't want the assembly code to become a maze of register-usage,
sticking to the existing conventions makes it predictable.

Passing arguments in callee-saved registers looks weird, and its just to avoid
shuffling the existing users of x1/x2 up.

e.g. something like movign the existing use of {x1, x2} -> {x5, x6}:
----------%<----------
-       mrs     x1, ID_AA64MMFR0_EL1
-       ubfx    x2, x1, #ID_AA64MMFR0_TGRAN_SHIFT, 4
-       cmp     x2, #ID_AA64MMFR0_TGRAN_SUPPORTED
+       mrs     x5, ID_AA64MMFR0_EL1
+       ubfx    x6, x5, #ID_AA64MMFR0_TGRAN_SHIFT, 4
+       cmp     x6, #ID_AA64MMFR0_TGRAN_SUPPORTED
        b.ne    __no_granule_support
-       update_early_cpu_boot_status 0, x1, x2
-       adrp    x1, idmap_pg_dir
-       adrp    x2, swapper_pg_dir
-       phys_to_ttbr x3, x1
-       phys_to_ttbr x4, x2
+       update_early_cpu_boot_status 0, x5, x6
+
+       adrp    x5, idmap_pg_dir
+       phys_to_ttbr x3, x5
+       phys_to_ttbr x4, x1
----------%<----------


Thanks,

James

[0] http://infocenter.arm.com/help/topic/com.arm.doc.ihi0055b/IHI0055B_aapcs64.pdf
