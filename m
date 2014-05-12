From: will.deacon@arm.com (Will Deacon)
Date: Mon, 12 May 2014 10:29:56 +0100
Subject: [PATCH v2] arm64: Support arch_irq_work_raise() via self IPIs
In-Reply-To: <1399760621-10954-1-git-send-email-larry.bassel@linaro.org>
References: <1399760621-10954-1-git-send-email-larry.bassel@linaro.org>
Message-ID: <20140512092956.GB914@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, May 10, 2014 at 11:23:41PM +0100, Larry Bassel wrote:
> Support for arch_irq_work_raise() was missing from
> arm64 (a prerequisite for FULL_NOHZ).

[...]

> @@ -455,6 +457,14 @@ void arch_send_call_function_single_ipi(int cpu)
>  	smp_cross_call(cpumask_of(cpu), IPI_CALL_FUNC_SINGLE);
>  }
>  
> +#ifdef CONFIG_IRQ_WORK
> +void arch_irq_work_raise(void)
> +{
> +	if (is_smp())
> +		smp_cross_call(cpumask_of(smp_processor_id()), IPI_IRQ_WORK);
> +}
> +#endif

Does this even compile? We're probably better off just checking whether or
not smp_cross_call is NULL.

Will
