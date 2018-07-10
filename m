From: olof@lixom.net (Olof Johansson)
Date: Tue, 10 Jul 2018 10:03:33 -0700
Subject: [PATCH net-next 13/13] ARM: net: bpf: use double-word load/stores
 where available
In-Reply-To: <E1fcrtG-0005Vh-DK@rmk-PC.armlinux.org.uk>
References: <20180710123340.GK17271@n2100.armlinux.org.uk>
 <E1fcrtG-0005Vh-DK@rmk-PC.armlinux.org.uk>
Message-ID: <CAOesGMio4JTzAPQ3Bkx8LxhkhJStzOGC6t2U8aC6m4TiBtaunQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

On Tue, Jul 10, 2018 at 5:37 AM, Russell King
<rmk+kernel@armlinux.org.uk> wrote:
> Use double-word load and stores where support for this instruction is
> supported by the CPU architecture.
>
> Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
> ---
>  arch/arm/net/bpf_jit_32.c | 55 ++++++++++++++++++++++++++++++++++++-----------
>  arch/arm/net/bpf_jit_32.h |  2 ++
>  2 files changed, 45 insertions(+), 12 deletions(-)
>
> diff --git a/arch/arm/net/bpf_jit_32.c b/arch/arm/net/bpf_jit_32.c
> index ca6534cabfa9..7e1d1635c65b 100644
> --- a/arch/arm/net/bpf_jit_32.c
> +++ b/arch/arm/net/bpf_jit_32.c
> @@ -485,10 +489,16 @@ static const s8 *arm_bpf_get_reg64(const s8 *reg, const s8 *tmp,
>                                    struct jit_ctx *ctx)
>  {
>         if (is_stacked(reg[1])) {
> -               emit(ARM_LDR_I(tmp[1], ARM_FP, EBPF_SCRATCH_TO_ARM_FP(reg[1])),
> -                    ctx);
> -               emit(ARM_LDR_I(tmp[0], ARM_FP, EBPF_SCRATCH_TO_ARM_FP(reg[0])),
> -                    ctx);
> +               if (__LINUX_ARM_ARCH__ >= 6 ||
> +                   ctx->cpu_architecture >= CPU_ARCH_ARMv5TE) {
> +                       emit(ARM_LDRD_I(tmp[1], ARM_FP,
> +                                       EBPF_SCRATCH_TO_ARM_FP(reg[1])), ctx);
> +               } else {
> +                       emit(ARM_LDR_I(tmp[1], ARM_FP,
> +                                      EBPF_SCRATCH_TO_ARM_FP(reg[1])), ctx);
> +                       emit(ARM_LDR_I(tmp[0], ARM_FP,
> +                                      EBPF_SCRATCH_TO_ARM_FP(reg[0])), ctx);
> +               }
>                 reg = tmp;
>         }
>         return reg;
> @@ -510,10 +520,16 @@ static void arm_bpf_put_reg64(const s8 *reg, const s8 *src,
>                               struct jit_ctx *ctx)
>  {
>         if (is_stacked(reg[1])) {
> -               emit(ARM_STR_I(src[1], ARM_FP, EBPF_SCRATCH_TO_ARM_FP(reg[1])),
> -                    ctx);
> -               emit(ARM_STR_I(src[0], ARM_FP, EBPF_SCRATCH_TO_ARM_FP(reg[0])),
> -                    ctx);
> +               if (__LINUX_ARM_ARCH__ >= 6 ||
> +                   ctx->cpu_architecture >= CPU_ARCH_ARMv5TE) {
> +                       emit(ARM_STRD_I(src[1], ARM_FP,
> +                                      EBPF_SCRATCH_TO_ARM_FP(reg[1])), ctx);
> +               } else {
> +                       emit(ARM_STR_I(src[1], ARM_FP,
> +                                      EBPF_SCRATCH_TO_ARM_FP(reg[1])), ctx);
> +                       emit(ARM_STR_I(src[0], ARM_FP,
> +                                      EBPF_SCRATCH_TO_ARM_FP(reg[0])), ctx);
> +               }
>         } else {
>                 if (reg[1] != src[1])
>                         emit(ARM_MOV_R(reg[1], src[1]), ctx);
> @@ -663,13 +679,27 @@ static inline void emit_a32_mov_r(const s8 dst, const s8 src,
>  static inline void emit_a32_mov_r64(const bool is64, const s8 dst[],
>                                   const s8 src[],
>                                   struct jit_ctx *ctx) {
> -       emit_a32_mov_r(dst_lo, src_lo, ctx);
> -       if (is64) {
> +       if (!is64) {
> +               emit_a32_mov_r(dst_lo, src_lo, ctx);
> +               /* Zero out high 4 bytes */
> +               emit_a32_mov_i(dst_hi, 0, ctx);
> +       } else if (__LINUX_ARM_ARCH__ < 6 &&
> +                  ctx->cpu_architecture < CPU_ARCH_ARMv5) {
>                 /* complete 8 byte move */
> +               emit_a32_mov_r(dst_lo, src_lo, ctx);
>                 emit_a32_mov_r(dst_hi, src_hi, ctx);


Tiny nit: Looks like you compare for >= ARMv5TE above and <ARMv5 here.

I'm not aware of any vanilla v5 implementations (all I can find are
v5TE or <=v4T), so it doesn't seem like something actually causing
problems. Mostly pointing it out for consistency's sake.


-Olof
