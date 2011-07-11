From: marc.zyngier@arm.com (Marc Zyngier)
Date: Mon, 11 Jul 2011 10:52:05 +0100
Subject: [PATCH v8 14/14] ARM: gic: add gic_ppi_map_on_cpu()
In-Reply-To: <20110710183039.GJ4812@n2100.arm.linux.org.uk>
References: <1309855755-6261-1-git-send-email-marc.zyngier@arm.com>
	<1309855755-6261-15-git-send-email-marc.zyngier@arm.com>
	<20110708195708.GR4812@n2100.arm.linux.org.uk>
	<20110710161038.46770f08@taxman.wild-wind.fr.eu.org>
	<20110710153759.GI4812@n2100.arm.linux.org.uk>
	<20110710183039.GJ4812@n2100.arm.linux.org.uk>
Message-ID: <4E1AC7C5.9020909@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/07/11 19:30, Russell King - ARM Linux wrote:
> On Sun, Jul 10, 2011 at 04:37:59PM +0100, Russell King - ARM Linux wrote:
>> And to ensure that drivers do that safely, that would _have_ to be a
>> separate function which takes care of all that.  The code would look
>> something like this:
>>
>>         cpumask_t cpus_allowed = current->cpus_allowed;
>>         set_cpus_allowed(current, cpumask_of_cpu(cpu));
>>         BUG_ON(cpu != smp_processor_id());
>>       irq = gic_ppi_map(ppi);
>>       ret = request_irq(irq, ...);
>>       set_cpus_allowed(current, cpus_allowed);
>>
>> (But not this: this depends on CPUMASK_OFFSTACK not being set.)
> 
> So, we can either do something like this:
> 
> int gic_request_ppi(unsigned int ppi, irq_handler_t handler,
>         unsigned long flags, const char *name, void *data)
> {
>         cpumask_var_t cpus_allowed;
>         unsigned int irq, cpu = get_cpu();
>         int ret;
> 
>         /* Allocate cpus_allowed mask */
>         if (!alloc_cpumask_var(&cpus_allowed, GFP_KERNEL)) {
>                 ret = -ENOMEM;
>                 goto err;
>         }
> 
>         /* Copy current thread affinity */
>         cpumask_copy(cups_allowed, &current->cpus_allowed);
> 
>         /* Bind to the current CPU */
>         set_cpus_allowed_ptr(current, cpumask_of(cpu));
>         irq = gic_ppi_map(ppi);
>         ret = request_irq(irq, handler, flags, name, data);
>         set_cpus_allowed_ptr(current, cpus_allowed);
> 
>         free_cpumask_var(cpus_allowed);
> 
> err:
>         put_cpu();
>         return ret;
> }
> 
> void gic_free_ppi(unsigned int ppi, void *data)
> {
>         cpumask_var_t cpus_allowed;
>         unsigned int irq, cpu = get_cpu();
> 
>         /* Allocate cpus_allowed mask */
>         if (!alloc_cpumask_var(&cpus_allowed, GFP_KERNEL))
>                 goto err; /* BUG */
> 
>         /* Copy current thread affinity */
>         cpumask_copy(cups_allowed, &current->cpus_allowed);
> 
>         /* Bind to the current CPU */
>         set_cpus_allowed_ptr(current, cpumask_of(cpu));
>         irq = gic_ppi_map(ppi);
>         free_irq(irq, data);
>         set_cpus_allowed_ptr(current, cpus_allowed);
> 
>         free_cpumask_var(cpus_allowed);
> 
> err:
>         put_cpu();
> }
> 
> Or the below, which will need platform people to tweak their entry-macro
> stuff to allow through IRQs 16-31.

You won't be surprised if I say that I prefer your first version. The
second one, while much simpler, keeps the additional low level entry
point (gic_call_ppi), and has to do its own accounting.

But more than that. MSM timers are implemented using the same code on
both UP and SMP, with or without GIC. which means we have to request the
interrupt using the same API. Your first version would work in that case
(gic_ppi_map() on a non-PPI should return the same number).

> There's also the question about whether we should pass in the desired CPU
> number to these too, in case we have a requirement to ensure that we get
> the PPI on a specific CPU, or whether we only care about the _current_
> CPU we happen to be running on.

As long as we tie mapping and interrupt request together, there is no
reason to offer that functionality. But DT may need to resolve the
mappings independently (while creating the platform devices), and the
driver would then request the mapped PPI. In that case, we need to
ensure we're running on the right CPU.

> That depends on what else PPIs get used for other than TWD.

The MSM code suggests that PPIs are used for more than just timers
(though apparently by out of tree drivers).

	M.
-- 
Jazz is not dead. It just smells funny...
