From: haojian.zhuang@linaro.org (Haojian Zhuang)
Date: Tue, 20 May 2014 21:34:35 +0800
Subject: [PATCH v9 14/14] virt: arm: support hip04 gic
In-Reply-To: <1400591427-21922-15-git-send-email-haojian.zhuang@linaro.org>
References: <1400591427-21922-1-git-send-email-haojian.zhuang@linaro.org>
 <1400591427-21922-15-git-send-email-haojian.zhuang@linaro.org>
Message-ID: <CAD6h2NQw6VC5HhUtUWGCDk_P_UQpTMVpKk8Jpe_LUH=vr530HQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 20 May 2014 21:10, Haojian Zhuang <haojian.zhuang@linaro.org> wrote:
> In ARM standard GIC, GICH_APR offset is 0xf0 & GICH_LR0 offset is 0x100.
> In HiP04 GIC, GICH_APR offset is 0x70 & GICH_LR0 offset is 0x80.
>
> Now reuse the nr_lr field in struct vgic_cpu. Bit[31:16] is used to store
> GICH_APR offset in HiP04, and bit[15:0] is used to store real nr_lr
> variable. In ARM standard GIC, don't set bit[31:16]. So we could avoid
> to change the VGIC implementation in arm64.
>
> Signed-off-by: Haojian Zhuang <haojian.zhuang@linaro.org>
> ---
>  arch/arm/kernel/asm-offsets.c   |  2 +-
>  arch/arm/kvm/interrupts_head.S  | 29 +++++++++++++++++++------
>  arch/arm64/kernel/asm-offsets.c |  2 +-
>  arch/arm64/kvm/hyp.S            | 28 ++++++++++++++++++------
>  include/kvm/arm_vgic.h          |  7 ++++--
>  include/linux/irqchip/arm-gic.h |  6 ++++++
>  virt/kvm/arm/vgic.c             | 48 +++++++++++++++++++++++++++++------------
>  7 files changed, 92 insertions(+), 30 deletions(-)
>
> diff --git a/arch/arm/kernel/asm-offsets.c b/arch/arm/kernel/asm-offsets.c
> index 85598b5..166cc98 100644
> diff --git a/arch/arm64/kvm/hyp.S b/arch/arm64/kvm/hyp.S
> index 2c56012..a4a8b3d 100644
> --- a/arch/arm64/kvm/hyp.S
> +++ b/arch/arm64/kvm/hyp.S
> @@ -402,7 +402,9 @@ __kvm_hyp_code_start:
>         ldr     w8, [x2, #GICH_EISR1]
>         ldr     w9, [x2, #GICH_ELRSR0]
>         ldr     w10, [x2, #GICH_ELRSR1]
> -       ldr     w11, [x2, #GICH_APR]
> +       ldr     w11, [x3, #VGIC_CPU_HW_CFG]
> +       mov     w11, w11, lsr #HWCFG_APR_SHIFT
> +       ldr     w11, [x2, w10]
>  CPU_BE(        rev     w4,  w4  )
>  CPU_BE(        rev     w5,  w5  )
>  CPU_BE(        rev     w6,  w6  )
> @@ -425,8 +427,13 @@ CPU_BE(    rev     w11, w11 )
>         str     wzr, [x2, #GICH_HCR]
>
>         /* Save list registers */
> -       add     x2, x2, #GICH_LR0
> -       ldr     w4, [x3, #VGIC_CPU_NR_LR]
> +       ldr     w4, [x3, #VGIC_CPU_HW_CFG]
> +       mov     w6, w4, lsr #HWCFG_APR_SHIFT
> +       ldr     w7, =HWCFG_NR_LR_MASK
> +       and     w4, w4, w7
> +       /* the offset between GICH_APR and GICH_LR0 is 0x10 */
> +       add     w6, w6, 0x10
> +       add     x2, x2, w6
>         add     x3, x3, #VGIC_CPU_LR
>  1:     ldr     w5, [x2], #4
>  CPU_BE(        rev     w5, w5 )
> @@ -461,11 +468,20 @@ CPU_BE(   rev     w6, w6 )
>
>         str     w4, [x2, #GICH_HCR]
>         str     w5, [x2, #GICH_VMCR]
> -       str     w6, [x2, #GICH_APR]
> +       ldr     w4, [x3, #VGIC_CPU_HW_CFG]
> +       mov     w4, w4, #HWCFG_APR_SHIFT
> +       str     w6, [x2, w4]

Oh, I just found it's wrong.

Marc,

How to handle this case? Do I need to use another x{n} register at here?
If so, how to convert data from 32-bit register to 64-bit register?

Regards
Haojian
