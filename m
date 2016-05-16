From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 16 May 2016 16:27:58 +0000
Subject: [PATCH] ARM: Fix A15 798181 errata initialization
In-Reply-To: <5734FA64.6040501@nokia.com>
References: <5734FA64.6040501@nokia.com>
Message-ID: <20160516162757.GA29346@localhost.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 12, 2016 at 11:49:24PM +0200, Matija Glavinic Pecotic wrote:
> And here is proposed handling from the same documents [1,2]:
> 
> * In r3p2 and earlier versions with REVIDR[4]= 0,the full workaround is
>   required.
> * In r3p2 and earlier versions with REVIDR[4]=1, REVIDR[9]=0, only the
>   portion of the workaround up to the end of step 6 is required.
> * In r3p2 and earlier versions with REVIDR[4]=1, REVIDR[9]=1, no
>   workaround is required.
> * In r3p3, if REVIDR[9]=0, only the portion of the workaround up
>   to the end of step 6 is required.
> * In r3p3, if REVIDR[9]=1, no workaround is required.
> 
> These imply following:
> 
> REVIDR[9] set -> No WA

The errata documents haven't been updated yet but my reading of the
corresponding ARM support case is that the "REVIDR[9] set" case only
refers to r2p4. It should be a safe assumption for r3pX as well since
REVIDR[9] is an update to the previous REVIDR[4] ECO. Anyway, I asked
ARM support for clarification and get back to you.

> REVIDR[4] set, REVIDR[9] cleared -> Partial WA
> Both cleared -> Full WA

[...]

> diff --git a/arch/arm/kernel/smp_tlb.c b/arch/arm/kernel/smp_tlb.c
> index 2e72be4..b624758 100644
> --- a/arch/arm/kernel/smp_tlb.c
> +++ b/arch/arm/kernel/smp_tlb.c
> @@ -93,17 +93,30 @@ void erratum_a15_798181_init(void)
>  	unsigned int revidr = read_cpuid(CPUID_REVIDR);
>  
>  	/* Brahma-B15 r0p0..r0p2 affected
> -	 * Cortex-A15 r0p0..r3p2 w/o ECO fix affected */
> -	if ((midr & 0xff0ffff0) == 0x420f00f0 && midr <= 0x420f00f2)
> +	 * Cortex-A15 r0p0..r3p3 w/o ECO fix affected
> +	 */

Please add the rXpY ranges and corresponding REVIDR combinations to the
comment above. It makes it easier to read the code later without having
to dig into the commit logs.

> +	if ((midr & 0xff0ffff0) == 0x420f00f0 && midr <= 0x420f00f2) {
>  		erratum_a15_798181_handler = erratum_a15_798181_broadcast;
> -	else if ((midr & 0xff0ffff0) == 0x410fc0f0 && midr <= 0x413fc0f2 &&
> -		 (revidr & 0x210) != 0x210) {
> +	} else if ((midr & 0xff0ffff0) == 0x410fc0f0 && midr < 0x412fc0f2) {
> +		erratum_a15_798181_handler = erratum_a15_798181_broadcast;
> +	} else if ((midr & 0xff0ffff0) == 0x410fc0f0 && midr < 0x412fc0f4) {
>  		if (revidr & 0x10)
>  			erratum_a15_798181_handler =
>  				erratum_a15_798181_partial;
>  		else
>  			erratum_a15_798181_handler =
>  				erratum_a15_798181_broadcast;
> +	} else if ((midr & 0xff0ffff0) == 0x410fc0f0 && midr < 0x413fc0f3) {
> +		if ((revidr & 0x210) == 0)
> +			erratum_a15_798181_handler =
> +				erratum_a15_798181_broadcast;
> +		else if (revidr & 0x10)
> +			erratum_a15_798181_handler =
> +				erratum_a15_798181_partial;
> +	} else if ((midr & 0xff0ffff0) == 0x410fc0f0 && midr < 0x414fc0f0) {
> +		if ((revidr & 0x200) == 0)
> +			erratum_a15_798181_handler =
> +				erratum_a15_798181_partial;

This looks fine (once ARM support confirms the REVIDR[9] assumption
above.

-- 
Catalin
