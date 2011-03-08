From: saeed.bishara@gmail.com (saeed bishara)
Date: Tue, 8 Mar 2011 17:28:35 +0200
Subject: SMP soft lockup on smp_call_function_many when doing
	flush_tlb_page
In-Reply-To: <1299591229.19820.91.camel@e102109-lin.cambridge.arm.com>
References: <AANLkTimk6zmQNdZaVaxDbd5Ff+75RERhrxgmsbM55vs1@mail.gmail.com>
	<1299591229.19820.91.camel@e102109-lin.cambridge.arm.com>
Message-ID: <AANLkTinX+1wwxcSPf0HfyE1pG1TJv7zf0cQ9aP+DWCCD@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> It looks like smp_call_function_many() does all the checks on the mask
> argument that it received and decides that there are CPUs to call (fair
> enough). But in the meantime reset_context() via IPI clears this mask
> leaving only the current CPU. Once the IPI was handled,
> smp_call_function_many() copies this mask to data->cpumask and clears
> the current CPU leaving an empty mask. It then waits for the other
> (none) CPUs to clear the csd lock which would never happen as data->refs
> is 0.
>
> There are probably a few ways to fix this. My preferred method is to
> modify the generic code (I'll add a proper commit log later and post it
> on LKML if it works):
>
>
> diff --git a/kernel/smp.c b/kernel/smp.c
> index 9910744..a79454f 100644
> --- a/kernel/smp.c
> +++ b/kernel/smp.c
> @@ -499,6 +499,10 @@ void smp_call_function_many(const struct cpumask *mask,
> ? ? ? ?smp_wmb();
>
> ? ? ? ?atomic_set(&data->refs, cpumask_weight(data->cpumask));
> + ? ? ? if (unlikely(!atomic_read(&data->refs))) {
> + ? ? ? ? ? ? ? csd_unlock(&data->csd);
> + ? ? ? ? ? ? ? return;
> + ? ? ? }
I don't think this is save, if the mask get cleaned after having cpu
set to valid value and before calculating the next_cpu, the code with
go to the fast path (smp_call_function_single)
>
> ? ? ? ?raw_spin_lock_irqsave(&call_function.lock, flags);
> ? ? ? ?/*
>
>
> An alternative would be to copy the cpumask to a local variable in
> on_each_cpu_mask(), though the workaround above would cover other cases
> that we haven't spotted yet. Also, the smp_call_function_many()
> description doesn't state that the cpumask should not be modified.
>
>
> diff --git a/arch/arm/kernel/smp_tlb.c b/arch/arm/kernel/smp_tlb.c
> index 8f57f32..1717dec 100644
> --- a/arch/arm/kernel/smp_tlb.c
> +++ b/arch/arm/kernel/smp_tlb.c
> @@ -16,10 +16,13 @@
> ?static void on_each_cpu_mask(void (*func)(void *), void *info, int wait,
> ? ? ? ?const struct cpumask *mask)
> ?{
> + ? ? ? struct cpumask call_mask;
> +
> ? ? ? ?preempt_disable();
>
> + ? ? ? cpumask_copy(&call_mask, mask);
> ? ? ? ?smp_call_function_many(mask, func, info, wait);
 I'll check this one, but the mask here should be call_mask.
> - ? ? ? if (cpumask_test_cpu(smp_processor_id(), mask))
> + ? ? ? if (cpumask_test_cpu(smp_processor_id(), &call_mask))
> ? ? ? ? ? ? ? ?func(info);
>
> ? ? ? ?preempt_enable();
>
>
> --
> Catalin
>
>
>
