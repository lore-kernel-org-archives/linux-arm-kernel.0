From: stefano.stabellini@eu.citrix.com (Stefano Stabellini)
Date: Fri, 27 Nov 2015 15:16:18 +0000
Subject: [Xen-devel] [PATCH v3 62/62] xen/arm64: Add ACPI support
In-Reply-To: <1447753261-7552-63-git-send-email-shannon.zhao@linaro.org>
References: <1447753261-7552-1-git-send-email-shannon.zhao@linaro.org>
 <1447753261-7552-63-git-send-email-shannon.zhao@linaro.org>
Message-ID: <alpine.DEB.2.02.1511271515480.8984@kaball.uk.xensource.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 17 Nov 2015, shannon.zhao at linaro.org wrote:
> From: Naresh Bhat <naresh.bhat@linaro.org>
> 
> Add ACPI support on arm64 xen hypervisor. Enable EFI support on ARM.
> 
> Signed-off-by: Naresh Bhat <naresh.bhat@linaro.org>
> Signed-off-by: Shannon Zhao <shannon.zhao@linaro.org>
> ---
>  config/arm64.mk              | 1 +
>  xen/common/efi/runtime.c     | 2 +-
>  xen/include/asm-arm/config.h | 5 +++++
>  3 files changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/config/arm64.mk b/config/arm64.mk
> index c5deb4e..c6a040b 100644
> --- a/config/arm64.mk
> +++ b/config/arm64.mk
> @@ -11,6 +11,7 @@ HAS_CADENCE_UART := y
>  HAS_NS16550 := y
>  HAS_MEM_ACCESS := y
>  HAS_GICV3 := y
> +HAS_ACPI := y
>  
>  # Use only if calling $(LD) directly.
>  LDFLAGS_DIRECT += -EL
> diff --git a/xen/common/efi/runtime.c b/xen/common/efi/runtime.c
> index ae87557..7748056 100644
> --- a/xen/common/efi/runtime.c
> +++ b/xen/common/efi/runtime.c
> @@ -11,7 +11,7 @@ DEFINE_XEN_GUEST_HANDLE(CHAR16);
>  #ifndef COMPAT
>  
>  #ifdef CONFIG_ARM  /* Disabled until runtime services implemented */
> -const bool_t efi_enabled = 0;
> +const bool_t efi_enabled = 1;

Don't we want to remove the comment at least?
We should also document under docs/ what is the supported interface to
access runtime services.


>  #else
>  # include <asm/i387.h>
>  # include <asm/xstate.h>
> diff --git a/xen/include/asm-arm/config.h b/xen/include/asm-arm/config.h
> index 817c216..e87fd27 100644
> --- a/xen/include/asm-arm/config.h
> +++ b/xen/include/asm-arm/config.h
> @@ -33,6 +33,11 @@
>  
>  #define CONFIG_ARM_L1_CACHE_SHIFT 7 /* XXX */
>  
> +#if defined(CONFIG_ARM_64)
> +#define CONFIG_ACPI 1
> +#define CONFIG_ACPI_BOOT 1
> +#endif
> +
>  #define CONFIG_SMP 1
>  
>  #define CONFIG_VIDEO 1
> -- 
> 2.1.0
> 
> 
> _______________________________________________
> Xen-devel mailing list
> Xen-devel at lists.xen.org
> http://lists.xen.org/xen-devel
> 
