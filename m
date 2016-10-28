From: mark.rutland@arm.com (Mark Rutland)
Date: Fri, 28 Oct 2016 15:54:22 +0100
Subject: [PATCH 1/2] irqchip/gic-v3: Convert arm64 GIC accessors to
 {read, write}_sysreg_s
In-Reply-To: <1477653838-21569-1-git-send-email-will.deacon@arm.com>
References: <1477653838-21569-1-git-send-email-will.deacon@arm.com>
Message-ID: <20161028145422.GJ5806@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 28, 2016 at 12:23:57PM +0100, Will Deacon wrote:
> The GIC system registers are accessed using open-coded wrappers around
> the mrs_s/msr_s asm macros.
> 
> This patch moves the code over to the {read,wrote}_sysreg_s accessors
> instead, reducing the amount of explicit asm blocks in the arch headers.

It's nice to see more of this going away!

[...]

> @@ -134,10 +124,12 @@ static inline u64 gic_read_iar_cavium_thunderx(void)
>  
>  	asm volatile(
>  		"nop;nop;nop;nop\n\t"
> -		"nop;nop;nop;nop\n\t"
> -		"mrs_s %0, " __stringify(ICC_IAR1_EL1) "\n\t"
> -		"nop;nop;nop;nop"
> -		: "=r" (irqstat));
> +		"nop;nop;nop;nop");
> +
> +	irqstat = read_sysreg_s(ICC_IAR1_EL1);
> +
> +	asm volatile(
> +		"nop;nop;nop;nop");

This looks odd, but I see that it disappears in the next patch anyway,
and mirrors the above.

Otherwise, all the transformations look correct to me. FWIW:

Reviewed-by: Mark Rutland <mark.rutland@arm.com>

Thanks,
Mark.
