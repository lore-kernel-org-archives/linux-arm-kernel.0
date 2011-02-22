From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Tue, 22 Feb 2011 15:03:46 -0500 (EST)
Subject: [PATCH] ARM: Thumb-2: Reflect ARM/Thumb-2 configuration in module
	vermagic
In-Reply-To: <1298382538-15682-1-git-send-email-dave.martin@linaro.org>
References: <1298382538-15682-1-git-send-email-dave.martin@linaro.org>
Message-ID: <alpine.LFD.2.00.1102221502160.14920@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 22 Feb 2011, Dave Martin wrote:

> Loading Thumb-2 modules into an ARM kernel or vice-versa isn't
> guaranteed to work safely, since the kernel is not interworking-
> aware everywhere.

Too bad.

> This patch adds "thumb2" to the module vermagic when
> CONFIG_THUMB2_KERNEL is enabled, to help avoid accidental loading
> of modules into the wrong kernel.
> 
> Signed-off-by: Dave Martin <dave.martin@linaro.org>

Acked-by: Nicolas Pitre <nicolas.pitre@linaro.org>



> ---
>  arch/arm/include/asm/module.h |   11 +++++++++--
>  1 files changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/include/asm/module.h b/arch/arm/include/asm/module.h
> index 12c8e68..09fcaa0 100644
> --- a/arch/arm/include/asm/module.h
> +++ b/arch/arm/include/asm/module.h
> @@ -25,8 +25,15 @@ struct mod_arch_specific {
>  };
>  
>  /*
> - * Include the ARM architecture version.
> + * Include the ARM architecture version and instruction set architecture.
>   */
> -#define MODULE_ARCH_VERMAGIC	"ARMv" __stringify(__LINUX_ARM_ARCH__) " "
> +#ifdef CONFIG_THUMB2_KERNEL
> +#define ARM_ARCH_VERMAGIC_ISAFAMILY " thumb2"
> +#else
> +#define ARM_ARCH_VERMAGIC_ISAFAMILY ""
> +#endif
> +
> +#define MODULE_ARCH_VERMAGIC	"ARMv" __stringify(__LINUX_ARM_ARCH__) \
> +	ARM_ARCH_VERMAGIC_ISAFAMILY " "
>  
>  #endif /* _ASM_ARM_MODULE_H */
> -- 
> 1.7.1
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
