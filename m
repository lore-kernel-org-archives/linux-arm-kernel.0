From: santosh.shilimkar@ti.com (Shilimkar, Santosh)
Date: Wed, 8 Sep 2010 13:00:38 +0530
Subject: [PATCH] ARM: Don't try to send IPI on UP systems with CONFIG_SMP
In-Reply-To: <20100908031404.GJ22507@atomide.com>
References: <20100817104414.19061.38999.stgit@baageli.muru.com>
	<20100906104413.GD20903@n2100.arm.linux.org.uk>
	<20100906180346.GC20849@atomide.com>
	<20100908030951.GH22507@atomide.com>
	<20100908031214.GI22507@atomide.com>
	<20100908031404.GJ22507@atomide.com>
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02CD0D309E@dbde02.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: linux-omap-owner at vger.kernel.org [mailto:linux-omap-
> owner at vger.kernel.org] On Behalf Of Tony Lindgren
> Sent: Wednesday, September 08, 2010 8:44 AM
> To: Russell King - ARM Linux
> Cc: linux-arm-kernel at lists.infradead.org; linux-omap at vger.kernel.org;
> bryan.wu at canonical.com
> Subject: [PATCH] ARM: Don't try to send IPI on UP systems with CONFIG_SMP
> 
> This is not needed on UP. Additionally with will cause issues when
> booting CONFIG_SMP_ON_UP kernel on earlier ARM cores.
> 
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> 
> diff --git a/arch/arm/kernel/process.c b/arch/arm/kernel/process.c
> index 401e38b..5facdbe 100644
> --- a/arch/arm/kernel/process.c
> +++ b/arch/arm/kernel/process.c
> @@ -207,9 +207,7 @@ __setup("reboot=", reboot_setup);
> 
>  void machine_shutdown(void)
>  {
> -#ifdef CONFIG_SMP
>  	smp_send_stop();
> -#endif
>  }
> 
>  void machine_halt(void)
> diff --git a/arch/arm/kernel/smp.c b/arch/arm/kernel/smp.c
> index 40dc74f..16ca27b 100644
> --- a/arch/arm/kernel/smp.c
> +++ b/arch/arm/kernel/smp.c
> @@ -560,12 +560,17 @@ asmlinkage void __exception do_IPI(struct pt_regs
> *regs)
> 
>  void smp_send_reschedule(int cpu)
>  {
> -	send_ipi_message(cpumask_of(cpu), IPI_RESCHEDULE);
> +	if (is_smp())
> +		send_ipi_message(cpumask_of(cpu), IPI_RESCHEDULE);
>  }
> 
>  void smp_send_stop(void)
>  {
>  	cpumask_t mask = cpu_online_map;
> +
> +	if (!is_smp())
> +		return;
> +
>  	cpu_clear(smp_processor_id(), mask);
>  	send_ipi_message(&mask, IPI_CPU_STOP);
>  }
The IPI is called too many times, and a check in this path
might be an overhead.

Can we runtime make " smp_send_reschedule" etc NULL based
on it's UP or SMP boot ?

Regards
Santosh 
