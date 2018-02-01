From: robin.murphy@arm.com (Robin Murphy)
Date: Thu, 1 Feb 2018 12:40:14 +0000
Subject: [PATCH v3 15/18] arm/arm64: smccc: Make function identifiers an
 unsigned quantity
In-Reply-To: <20180201114657.7323-16-marc.zyngier@arm.com>
References: <20180201114657.7323-1-marc.zyngier@arm.com>
 <20180201114657.7323-16-marc.zyngier@arm.com>
Message-ID: <1c07ecaa-0a60-284d-1b85-0b4ea4522c48@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/02/18 11:46, Marc Zyngier wrote:
> Function identifiers are a 32bit, unsigned quantity. But we never
> tell so to the compiler, resulting in the following:
> 
>   4ac:   b26187e0        mov     x0, #0xffffffff80000001
> 
> We thus rely on the firmware narrowing it for us, which is not
> always a reasonable expectation.

I think technically it might be OK, since SMCCC states "A Function 
Identifier is passed in register W0.", which implies that a conforming 
implementation should also read w0, not x0, but it's certainly far 
easier to be completely right than to justify being possibly wrong.

Reviewed-by: Robin Murphy <robin.murphy@arm.com>

> Cc: stable at vger.kernel.org
> Reported-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> Acked-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> Tested-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> ---
>   include/linux/arm-smccc.h | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/arm-smccc.h b/include/linux/arm-smccc.h
> index e1ef944ef1da..dd44d8458c04 100644
> --- a/include/linux/arm-smccc.h
> +++ b/include/linux/arm-smccc.h
> @@ -14,14 +14,16 @@
>   #ifndef __LINUX_ARM_SMCCC_H
>   #define __LINUX_ARM_SMCCC_H
>   
> +#include <uapi/linux/const.h>
> +
>   /*
>    * This file provides common defines for ARM SMC Calling Convention as
>    * specified in
>    * http://infocenter.arm.com/help/topic/com.arm.doc.den0028a/index.html
>    */
>   
> -#define ARM_SMCCC_STD_CALL		0
> -#define ARM_SMCCC_FAST_CALL		1
> +#define ARM_SMCCC_STD_CALL	        _AC(0,U)
> +#define ARM_SMCCC_FAST_CALL	        _AC(1,U)
>   #define ARM_SMCCC_TYPE_SHIFT		31
>   
>   #define ARM_SMCCC_SMC_32		0
> 
