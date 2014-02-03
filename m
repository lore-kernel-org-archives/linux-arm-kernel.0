From: fabrice.gasnier@st.com (Fabrice Gasnier)
Date: Mon, 3 Feb 2014 10:12:46 +0100
Subject: Why are imprecise external aborts masked on recent kernel while
 booting ?
In-Reply-To: <20140131170827.GH15937@n2100.arm.linux.org.uk>
References: <52EBC86D.1010509@st.com>
 <20140131170827.GH15937@n2100.arm.linux.org.uk>
Message-ID: <52EF5D8E.4050600@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

Thank you for your help.
I just tried following patch on both 3.10 and above vanilla 3.13.1.
Unfortunately, these instructions have no effect on the arm cpsr.
I dumped regs right after msr instruction have been executed. It remains 
untouched :

Here is assembly from gdb:

    0xc064a400 <+128>:    mov    r3, #256    ; 0x100
    0xc064a404 <+132>:    mrs    r2, CPSR
    0xc064a408 <+136>:    bic    r2, r2, r3
    0xc064a40c <+140>:    msr    CPSR_c, r2

CPSR.A bit is still set after these instructions : 0x600001d3
Although, I see it has been cleared in r2: 0x600000d3

Please advise.
Thanks,
BR,
Fabrice
On 01/31/2014 06:08 PM, Russell King - ARM Linux wrote:
>> Is it possible to unmask imprecise data aborts earlier in the boot
>> >process (e.g. before PCIe bus enumeration, when drivers are being probed)
>> >?
> How about this patch?
>
> diff --git a/arch/arm/kernel/traps.c b/arch/arm/kernel/traps.c
> index 172ee18ff124..b0ff06f49cd0 100644
> --- a/arch/arm/kernel/traps.c
> +++ b/arch/arm/kernel/traps.c
> @@ -900,6 +900,15 @@ void __init early_trap_init(void *vectors_base)
>   
>   	flush_icache_range(vectors, vectors + PAGE_SIZE * 2);
>   	modify_domain(DOMAIN_USER, DOMAIN_CLIENT);
> +
> +	/* Enable imprecise aborts */
> +	asm volatile(
> +		"mrs	%0, cpsr\n"
> +	"	bic	%0, %0, %1\n"
> +	"	msr	cpsr_c, %0"
> +		: "=&r" (i)
> +		: "r" (PSR_A_BIT));
> +
>   #else /* ifndef CONFIG_CPU_V7M */
>   	/*
>   	 * on V7-M there is no need to copy the vector table to a dedicated
