From: will.deacon@arm.com (Will Deacon)
Date: Wed, 16 Sep 2015 14:05:49 +0100
Subject: [RFC PATCH v2 3/7] arm64: alternative: Apply alternatives early
 in boot process
In-Reply-To: <1442237181-17064-4-git-send-email-daniel.thompson@linaro.org>
References: <1442237181-17064-1-git-send-email-daniel.thompson@linaro.org>
 <1442237181-17064-4-git-send-email-daniel.thompson@linaro.org>
Message-ID: <20150916130549.GJ28771@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 14, 2015 at 02:26:17PM +0100, Daniel Thompson wrote:
> Currently alternatives are applied very late in the boot process (and
> a long time after we enable scheduling). Some alternative sequences,
> such as those that alter the way CPU context is stored, must be applied
> much earlier in the boot sequence.
> 
> Introduce apply_alternatives_early() to allow some alternatives to be
> applied immediately after we detect the CPU features of the boot CPU.
> 
> Currently apply_alternatives_all() is not optimized and will re-patch
> code that has already been updated. This is harmless but could be
> removed by adding extra flags to the alternatives store.
> 
> Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
> ---
>  arch/arm64/include/asm/alternative.h |  1 +
>  arch/arm64/kernel/alternative.c      | 15 +++++++++++++++
>  arch/arm64/kernel/setup.c            |  7 +++++++
>  3 files changed, 23 insertions(+)
> 
> diff --git a/arch/arm64/include/asm/alternative.h b/arch/arm64/include/asm/alternative.h
> index d56ec0715157..f9dad1b7c651 100644
> --- a/arch/arm64/include/asm/alternative.h
> +++ b/arch/arm64/include/asm/alternative.h
> @@ -17,6 +17,7 @@ struct alt_instr {
>  	u8  alt_len;		/* size of new instruction(s), <= orig_len */
>  };
>  
> +void __init apply_alternatives_early(void);
>  void __init apply_alternatives_all(void);
>  void apply_alternatives(void *start, size_t length);
>  void free_alternatives_memory(void);
> diff --git a/arch/arm64/kernel/alternative.c b/arch/arm64/kernel/alternative.c
> index ab9db0e9818c..59989a4bed7c 100644
> --- a/arch/arm64/kernel/alternative.c
> +++ b/arch/arm64/kernel/alternative.c
> @@ -117,6 +117,21 @@ static void __apply_alternatives(void *alt_region)
>  }
>  
>  /*
> + * This is called very early in the boot process (directly after we run
> + * a feature detect on the boot CPU). No need to worry about other CPUs
> + * here.
> + */
> +void apply_alternatives_early(void)
> +{
> +	struct alt_region region = {
> +		.begin	= __alt_instructions,
> +		.end	= __alt_instructions_end,
> +	};
> +
> +	__apply_alternatives(&region);
> +}

How do you choose which alternatives are applied early and which are
applied later? AFAICT, this just applies everything before we've
established the capabilities of the CPUs in the system, which could cause
problems for big/little SoCs.

Also, why do we need this for the NMI?

Will
