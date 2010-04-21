From: jamie@shareable.org (Jamie Lokier)
Date: Wed, 21 Apr 2010 20:45:40 +0100
Subject: kernel virtual memory access (from app) does not generate segfault
In-Reply-To: <20100421131149.GB9408@desktop>
References: <4BCD7076.9030802@browserseal.com>
	<20100420093441.GD6684@trinity.fluff.org>
	<000001cae074$1b564ff0$4044010a@Emea.Arm.com>
	<20100420142047.GA7398@desktop>
	<20100420170944.GE2234@trinity.fluff.org>
	<20100420192813.GA29831@n2100.arm.linux.org.uk>
	<20100421131149.GB9408@desktop>
Message-ID: <20100421194540.GR27575@shareable.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

anfei wrote:
> ARM: Proper prefetch abort handling on pre-ARMv6
> 
> Instruction faults on pre-ARMv6 CPUs are interpreted as
> a 'translation fault', but do_translation_fault doesn't
> handle well if user mode trying to run instruction above
> TASK_SIZE, and result in the infinite retry of that
> instruction.
> 
> Signed-off-by: Anfei Zhou <anfei.zhou@gmail.com>
> ---
>  arch/arm/mm/fault.c |    3 +++
>  1 files changed, 3 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mm/fault.c b/arch/arm/mm/fault.c
> index 9d40c34..8ad75e9 100644
> --- a/arch/arm/mm/fault.c
> +++ b/arch/arm/mm/fault.c
> @@ -393,6 +393,9 @@ do_translation_fault(unsigned long addr, unsigned int fsr,
>  	if (addr < TASK_SIZE)
>  		return do_page_fault(addr, fsr, regs);
>  
> +	if (user_mode(regs))
> +		goto bad_area;
> +
>  	index = pgd_index(addr);
>  
>  	/*

Looks good to me.

Reviewed-by: Jamie Lokier <jamie@shareable.org>

-- Jamie
