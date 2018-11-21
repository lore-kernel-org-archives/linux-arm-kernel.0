From: alex.bennee@linaro.org (Alex =?utf-8?Q?Benn=C3=A9e?=)
Date: Wed, 21 Nov 2018 16:16:42 +0000
Subject: [RFC PATCH v2 17/23] arm64/sve: In-kernel vector length
 availability query interface
In-Reply-To: <1538141967-15375-18-git-send-email-Dave.Martin@arm.com>
References: <1538141967-15375-1-git-send-email-Dave.Martin@arm.com>
 <1538141967-15375-18-git-send-email-Dave.Martin@arm.com>
Message-ID: <87in0qiexh.fsf@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Dave Martin <Dave.Martin@arm.com> writes:

> KVM will need to interrogate the set of SVE vector lengths
> available on the system.
>
> This patch exposes the relevant bits to the kernel, along with a
> sve_vq_available() helper to check whether a particular vector
> length is supported.
>
> vq_to_bit() and bit_to_vq() are not intended for use outside these
> functions, so they are given a __ prefix to warn people not to use
> them unless they really know what they are doing.

Personally I wouldn't have bothered with the __ but whatever:

Reviewed-by: Alex Benn?e <alex.bennee@linaro.org>

>
> Signed-off-by: Dave Martin <Dave.Martin@arm.com>
> ---
>  arch/arm64/include/asm/fpsimd.h | 29 +++++++++++++++++++++++++++++
>  arch/arm64/kernel/fpsimd.c      | 35 ++++++++---------------------------
>  2 files changed, 37 insertions(+), 27 deletions(-)
>
> diff --git a/arch/arm64/include/asm/fpsimd.h b/arch/arm64/include/asm/fpsimd.h
> index df7a143..ad6d2e4 100644
> --- a/arch/arm64/include/asm/fpsimd.h
> +++ b/arch/arm64/include/asm/fpsimd.h
> @@ -24,10 +24,13 @@
>
>  #ifndef __ASSEMBLY__
>
> +#include <linux/bitmap.h>
>  #include <linux/build_bug.h>
> +#include <linux/bug.h>
>  #include <linux/cache.h>
>  #include <linux/init.h>
>  #include <linux/stddef.h>
> +#include <linux/types.h>
>
>  #if defined(__KERNEL__) && defined(CONFIG_COMPAT)
>  /* Masks for extracting the FPSR and FPCR from the FPSCR */
> @@ -89,6 +92,32 @@ extern u64 read_zcr_features(void);
>
>  extern int __ro_after_init sve_max_vl;
>  extern int __ro_after_init sve_max_virtualisable_vl;
> +/* Set of available vector lengths, as vq_to_bit(vq): */
> +extern __ro_after_init DECLARE_BITMAP(sve_vq_map, SVE_VQ_MAX);
> +
> +/*
> + * Helpers to translate bit indices in sve_vq_map to VQ values (and
> + * vice versa).  This allows find_next_bit() to be used to find the
> + * _maximum_ VQ not exceeding a certain value.
> + */
> +static inline unsigned int __vq_to_bit(unsigned int vq)
> +{
> +	return SVE_VQ_MAX - vq;
> +}
> +
> +static inline unsigned int __bit_to_vq(unsigned int bit)
> +{
> +	if (WARN_ON(bit >= SVE_VQ_MAX))
> +		bit = SVE_VQ_MAX - 1;
> +
> +	return SVE_VQ_MAX - bit;
> +}
> +
> +/* Ensure vq >= SVE_VQ_MIN && vq <= SVE_VQ_MAX before calling this function */
> +static inline bool sve_vq_available(unsigned int vq)
> +{
> +	return test_bit(__vq_to_bit(vq), sve_vq_map);
> +}
>
>  #ifdef CONFIG_ARM64_SVE
>
> diff --git a/arch/arm64/kernel/fpsimd.c b/arch/arm64/kernel/fpsimd.c
> index 60c5e28..cc5a495 100644
> --- a/arch/arm64/kernel/fpsimd.c
> +++ b/arch/arm64/kernel/fpsimd.c
> @@ -136,7 +136,7 @@ static int sve_default_vl = -1;
>  int __ro_after_init sve_max_vl = SVE_VL_MIN;
>  int __ro_after_init sve_max_virtualisable_vl = SVE_VL_MIN;
>  /* Set of available vector lengths, as vq_to_bit(vq): */
> -static __ro_after_init DECLARE_BITMAP(sve_vq_map, SVE_VQ_MAX);
> +__ro_after_init DECLARE_BITMAP(sve_vq_map, SVE_VQ_MAX);
>  /* Set of vector lengths present on at least one cpu: */
>  static __ro_after_init DECLARE_BITMAP(sve_vq_partial_map, SVE_VQ_MAX);
>  static void __percpu *efi_sve_state;
> @@ -270,25 +270,6 @@ void fpsimd_save(void)
>  }
>
>  /*
> - * Helpers to translate bit indices in sve_vq_map to VQ values (and
> - * vice versa).  This allows find_next_bit() to be used to find the
> - * _maximum_ VQ not exceeding a certain value.
> - */
> -
> -static unsigned int vq_to_bit(unsigned int vq)
> -{
> -	return SVE_VQ_MAX - vq;
> -}
> -
> -static unsigned int bit_to_vq(unsigned int bit)
> -{
> -	if (WARN_ON(bit >= SVE_VQ_MAX))
> -		bit = SVE_VQ_MAX - 1;
> -
> -	return SVE_VQ_MAX - bit;
> -}
> -
> -/*
>   * All vector length selection from userspace comes through here.
>   * We're on a slow path, so some sanity-checks are included.
>   * If things go wrong there's a bug somewhere, but try to fall back to a
> @@ -309,8 +290,8 @@ static unsigned int find_supported_vector_length(unsigned int vl)
>  		vl = max_vl;
>
>  	bit = find_next_bit(sve_vq_map, SVE_VQ_MAX,
> -			    vq_to_bit(sve_vq_from_vl(vl)));
> -	return sve_vl_from_vq(bit_to_vq(bit));
> +			    __vq_to_bit(sve_vq_from_vl(vl)));
> +	return sve_vl_from_vq(__bit_to_vq(bit));
>  }
>
>  #ifdef CONFIG_SYSCTL
> @@ -651,7 +632,7 @@ static void sve_probe_vqs(DECLARE_BITMAP(map, SVE_VQ_MAX))
>  		write_sysreg_s(zcr | (vq - 1), SYS_ZCR_EL1); /* self-syncing */
>  		vl = sve_get_vl();
>  		vq = sve_vq_from_vl(vl); /* skip intervening lengths */
> -		set_bit(vq_to_bit(vq), map);
> +		set_bit(__vq_to_bit(vq), map);
>  	}
>  }
>
> @@ -712,7 +693,7 @@ int sve_verify_vq_map(void)
>  	 * Mismatches above sve_max_virtualisable_vl are fine, since
>  	 * no guest is allowed to configure ZCR_EL2.LEN to exceed this:
>  	 */
> -	if (sve_vl_from_vq(bit_to_vq(b)) <= sve_max_virtualisable_vl) {
> +	if (sve_vl_from_vq(__bit_to_vq(b)) <= sve_max_virtualisable_vl) {
>  		pr_warn("SVE: cpu%d: Unsupported vector length(s) present\n",
>  			smp_processor_id());
>  		goto error;
> @@ -798,8 +779,8 @@ void __init sve_setup(void)
>  	 * so sve_vq_map must have at least SVE_VQ_MIN set.
>  	 * If something went wrong, at least try to patch it up:
>  	 */
> -	if (WARN_ON(!test_bit(vq_to_bit(SVE_VQ_MIN), sve_vq_map)))
> -		set_bit(vq_to_bit(SVE_VQ_MIN), sve_vq_map);
> +	if (WARN_ON(!test_bit(__vq_to_bit(SVE_VQ_MIN), sve_vq_map)))
> +		set_bit(__vq_to_bit(SVE_VQ_MIN), sve_vq_map);
>
>  	zcr = read_sanitised_ftr_reg(SYS_ZCR_EL1);
>  	sve_max_vl = sve_vl_from_vq((zcr & ZCR_ELx_LEN_MASK) + 1);
> @@ -828,7 +809,7 @@ void __init sve_setup(void)
>  		/* No virtualisable VLs?  This is architecturally forbidden. */
>  		sve_max_virtualisable_vl = SVE_VQ_MIN;
>  	else /* b + 1 < SVE_VQ_MAX */
> -		sve_max_virtualisable_vl = sve_vl_from_vq(bit_to_vq(b + 1));
> +		sve_max_virtualisable_vl = sve_vl_from_vq(__bit_to_vq(b + 1));
>
>  	if (sve_max_virtualisable_vl > sve_max_vl)
>  		sve_max_virtualisable_vl = sve_max_vl;


--
Alex Benn?e
