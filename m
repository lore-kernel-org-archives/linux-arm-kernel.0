From: cdall@cs.columbia.edu (Christoffer Dall)
Date: Tue, 23 Apr 2013 15:57:33 -0700
Subject: [PATCH v3 03/32] arm64: KVM: HYP mode idmap support
In-Reply-To: <1365437854-30214-4-git-send-email-marc.zyngier@arm.com>
References: <1365437854-30214-1-git-send-email-marc.zyngier@arm.com>
 <1365437854-30214-4-git-send-email-marc.zyngier@arm.com>
Message-ID: <20130423225733.GA20569@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On Mon, Apr 8, 2013 at 9:17 AM, Marc Zyngier <marc.zyngier@arm.com> wrote:
> Add the necessary infrastructure for identity-mapped HYP page
> tables. Idmap-ed code must be in the ".hyp.idmap.text" linker
> section.
>
> The rest of the HYP ends up in ".hyp.text".
>
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> ---
>  arch/arm64/kernel/vmlinux.lds.S | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
>
> diff --git a/arch/arm64/kernel/vmlinux.lds.S b/arch/arm64/kernel/vmlinux.lds.S
> index 3fae2be..855d43d 100644
> --- a/arch/arm64/kernel/vmlinux.lds.S
> +++ b/arch/arm64/kernel/vmlinux.lds.S
> @@ -17,6 +17,15 @@ ENTRY(stext)
>
>  jiffies = jiffies_64;
>
> +#define HYPERVISOR_TEXT                                        \
> +       . = ALIGN(2048);                                \

why align to 2048?  Comment?

are you changing this to the same idea as for the 32-bit code to reduce the kernel size?

> +       VMLINUX_SYMBOL(__hyp_idmap_text_start) = .;     \
> +       *(.hyp.idmap.text)                              \
> +       VMLINUX_SYMBOL(__hyp_idmap_text_end) = .;       \
> +       VMLINUX_SYMBOL(__hyp_text_start) = .;           \
> +       *(.hyp.text)                                    \
> +       VMLINUX_SYMBOL(__hyp_text_end) = .;
> +
>  SECTIONS
>  {
>         /*
> @@ -49,6 +58,7 @@ SECTIONS
>                         TEXT_TEXT
>                         SCHED_TEXT
>                         LOCK_TEXT
> +                       HYPERVISOR_TEXT
>                         *(.fixup)
>                         *(.gnu.warning)
>                 . = ALIGN(16);
> @@ -124,3 +134,9 @@ SECTIONS
>         STABS_DEBUG
>         .comment 0 : { *(.comment) }
>  }
> +
> +/*
> + * The HYP init code can't be more than a page long.
> + */
> +ASSERT(((__hyp_idmap_text_start + PAGE_SIZE) >= __hyp_idmap_text_end),
> +       "HYP init code too big")
> --
> 1.8.1.4
>
>
>
> _______________________________________________
> kvmarm mailing list
> kvmarm at lists.cs.columbia.edu
> https://lists.cs.columbia.edu/cucslists/listinfo/kvmarm
