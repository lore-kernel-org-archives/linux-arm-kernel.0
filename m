From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Tue, 30 Aug 2016 11:50:46 +0100
Subject: [RFC PATCH 2/3] arm64: cpufeature: constify arm64_ftr_regs array
In-Reply-To: <1472231742-13387-3-git-send-email-ard.biesheuvel@linaro.org>
References: <1472231742-13387-1-git-send-email-ard.biesheuvel@linaro.org>
 <1472231742-13387-3-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <CAKv+Gu-uX0gdpV7KkvzwPZqAV_8RR+8sKfzeu_LUgMsuC=qCtQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 26 August 2016 at 18:15, Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
> Constify the arm64_ftr_regs array, by moving the mutable arm64_ftr_reg
> fields out of the array itself. This also streamlines the bsearch, since
> the entire array can be covered by fewer cachelines. Moving the payload
> out of the array also allows us to have special explicitly defined
> struct instance in case other code needs to refer to it directly.
>
> Note that this replaces the runtime sorting of the array with a runtime
> BUG() check whether the array is sorted correctly in the code.
>
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> ---
>  arch/arm64/include/asm/cpufeature.h |  1 -
>  arch/arm64/kernel/cpufeature.c      | 45 +++++++++-----------
>  2 files changed, 19 insertions(+), 27 deletions(-)
>
> diff --git a/arch/arm64/include/asm/cpufeature.h b/arch/arm64/include/asm/cpufeature.h
> index 7c0b7cff17df..8bb4f1527b26 100644
> --- a/arch/arm64/include/asm/cpufeature.h
> +++ b/arch/arm64/include/asm/cpufeature.h
> @@ -72,7 +72,6 @@ struct arm64_ftr_bits {
>   * @sys_val            Safe value across the CPUs (system view)
>   */
>  struct arm64_ftr_reg {
> -       u32                             sys_id;
>         const char                      *name;
>         u64                             strict_mask;
>         u64                             sys_val;
> diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
> index eac76cb3a206..35a17487ffb9 100644
> --- a/arch/arm64/kernel/cpufeature.c
> +++ b/arch/arm64/kernel/cpufeature.c
> @@ -265,14 +265,17 @@ static const struct arm64_ftr_bits ftr_aa64raz[] = {
>         ARM64_FTR_END,
>  };
>
> -#define ARM64_FTR_REG(id, table)               \
> -       {                                       \
> -               .sys_id = id,                   \
> +#define ARM64_FTR_REG(id, table) {             \
> +       .sys_id = id,                           \
> +       .reg =  &(struct arm64_ftr_reg){        \
>                 .name = #id,                    \
>                 .ftr_bits = &((table)[0]),      \
> -       }
> +       }}
>
> -static struct arm64_ftr_reg arm64_ftr_regs[] = {
> +static const struct __ftr_reg_entry {
> +       u32                     sys_id;
> +       struct arm64_ftr_reg    *reg;
> +} arm64_ftr_regs[] = {
>
>         /* Op1 = 0, CRn = 0, CRm = 1 */
>         ARM64_FTR_REG(SYS_ID_PFR0_EL1, ftr_id_pfr0),
> @@ -324,7 +327,7 @@ static struct arm64_ftr_reg arm64_ftr_regs[] = {
>
>  static int search_cmp_ftr_reg(const void *id, const void *regp)
>  {
> -       return (int)(unsigned long)id - (int)((const struct arm64_ftr_reg *)regp)->sys_id;
> +       return (int)(unsigned long)id - (int)((const struct __ftr_reg_entry *)regp)->sys_id;
>  }
>
>  /*
> @@ -339,11 +342,14 @@ static int search_cmp_ftr_reg(const void *id, const void *regp)
>   */
>  static struct arm64_ftr_reg *get_arm64_ftr_reg(u32 sys_id)
>  {
> -       return bsearch((const void *)(unsigned long)sys_id,
> +       const struct __ftr_reg_entry *ret;
> +
> +       ret = bsearch((const void *)(unsigned long)sys_id,
>                         arm64_ftr_regs,
>                         ARRAY_SIZE(arm64_ftr_regs),
>                         sizeof(arm64_ftr_regs[0]),
>                         search_cmp_ftr_reg);
> +       return ret->reg;

Actually, this should be

return ret ? ret->reg : NULL;


>  }
>
>  static u64 arm64_ftr_set_value(const struct arm64_ftr_bits *ftrp, s64 reg,
> @@ -378,27 +384,14 @@ static s64 arm64_ftr_safe_value(const struct arm64_ftr_bits *ftrp, s64 new,
>         return ret;
>  }
>
> -static int __init sort_cmp_ftr_regs(const void *a, const void *b)
> -{
> -       return ((const struct arm64_ftr_reg *)a)->sys_id -
> -                ((const struct arm64_ftr_reg *)b)->sys_id;
> -}
> -
> -static void __init swap_ftr_regs(void *a, void *b, int size)
> -{
> -       struct arm64_ftr_reg tmp = *(struct arm64_ftr_reg *)a;
> -       *(struct arm64_ftr_reg *)a = *(struct arm64_ftr_reg *)b;
> -       *(struct arm64_ftr_reg *)b = tmp;
> -}
> -
>  static void __init sort_ftr_regs(void)
>  {
> -       /* Keep the array sorted so that we can do the binary search */
> -       sort(arm64_ftr_regs,
> -               ARRAY_SIZE(arm64_ftr_regs),
> -               sizeof(arm64_ftr_regs[0]),
> -               sort_cmp_ftr_regs,
> -               swap_ftr_regs);
> +       int i;
> +
> +       /* Check that the array is sorted so that we can do the binary search */
> +       for (i = 1; i < ARRAY_SIZE(arm64_ftr_regs); i++)
> +               if (arm64_ftr_regs[i].sys_id < arm64_ftr_regs[i - 1].sys_id)
> +                       BUG();
>  }
>
>  /*
> --
> 2.7.4
>
