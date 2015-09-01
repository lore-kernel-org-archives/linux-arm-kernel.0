From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 1 Sep 2015 17:02:58 +0100
Subject: [PATCH 1/2] arm64: cpufeature.h: resolve hidden header
 dependencies
In-Reply-To: <1441118472-3513-2-git-send-email-ynorov@caviumnetworks.com>
References: <1441118472-3513-1-git-send-email-ynorov@caviumnetworks.com>
 <1441118472-3513-2-git-send-email-ynorov@caviumnetworks.com>
Message-ID: <20150901160258.GA16430@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 01, 2015 at 03:41:11PM +0100, Yury Norov wrote:
> Functions implemented in cpufeature.h depend on some headers, but
> cpufeature.h does not include them. This may cause build failure if
> cpufeature.h user does not include that headers by itself. (Like it
> happens in next patch of this series.)
> 
> Signed-off-by: Yury Norov <ynorov@caviumnetworks.com>
> ---
>  arch/arm64/include/asm/cpufeature.h | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/arch/arm64/include/asm/cpufeature.h b/arch/arm64/include/asm/cpufeature.h
> index c104421..20cdc26 100644
> --- a/arch/arm64/include/asm/cpufeature.h
> +++ b/arch/arm64/include/asm/cpufeature.h
> @@ -30,6 +30,11 @@
>  
>  #ifndef __ASSEMBLY__
>  
> +#include <linux/bitmap.h>

We're also missing <linux/compiler.h> for the __attribute_const__ on
cpuid_feature_extract_field.

> +#include <linux/log2.h>

The cpu_feature macro using ilog2 is prior to the __ASSEMBLY__ guard.
Given it cannot be used by assembly, I think it should also be pulled
under the guard, or removed as it doesn't appear to be used anyway
(which would remove the need for this include).

Otherwise this looks good to me.

Thanks,
Mark.

> +#include <linux/printk.h>
> +#include <linux/types.h>
> +
>  struct arm64_cpu_capabilities {
>  	const char *desc;
>  	u16 capability;
> -- 
> 2.1.4
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
