From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Wed, 26 Mar 2014 12:52:40 +0100
Subject: [PATCH v5 03/14] ARM: mvebu: ll_set_cpu_coherent always uses
 the current CPU
In-Reply-To: <1395787705-31061-4-git-send-email-gregory.clement@free-electrons.com>
References: <1395787705-31061-1-git-send-email-gregory.clement@free-electrons.com>
 <1395787705-31061-4-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <5332BF88.5020401@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/25/2014 11:48 PM, Gregory CLEMENT wrote:
> ll_set_cpu_coherent is always used on the current CPU, so instead of
> passing the CPU id as argument, ll_set_cpu_coherent() can find it by
> itself.
>
> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
> Acked-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> ---
[...]
> diff --git a/arch/arm/mach-mvebu/coherency_ll.S b/arch/arm/mach-mvebu/coherency_ll.S
> index 1f2bcd4b5424..6cb26b919787 100644
> --- a/arch/arm/mach-mvebu/coherency_ll.S
> +++ b/arch/arm/mach-mvebu/coherency_ll.S
> @@ -24,9 +24,7 @@
>   #include <asm/cp15.h>
>
>   	.text
> -/*
> - * r0: HW CPU id
> - */
> +
>   ENTRY(ll_set_cpu_coherent)
>   	mrc	p15, 0, r1, c1, c0, 0
>   	tst	r1, #CR_M @ Check MMU bit enabled
> @@ -43,9 +41,11 @@ ENTRY(ll_set_cpu_coherent)
>   	ldr	r0, [r0]
>   2:
>   	/* Create bit by cpu index */
> -	mov	r3, #(1 << 24)
> -	lsl	r1, r3, r1
> -ARM_BE8(rev	r1, r1)
> +	mrc	15, 0, r1, cr0, cr0, 5
> +	and	r1, r1, #15
> +	mov	r2, #(1 << 24)
> +	lsl	r1, r2, r1
> +	ARM_BE8(rev	r1, r1)

nit: re-indent ARM_BE8 to the beginning of the line?

Sebastian
