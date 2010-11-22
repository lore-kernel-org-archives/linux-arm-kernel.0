From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Mon, 22 Nov 2010 18:37:09 +0530
Subject: [PATCH] Add call to non-crashing cores through IPI
In-Reply-To: <20101122112759.GA31227@n2100.arm.linux.org.uk>
References: <1290161310-22808-1-git-send-email-per.xx.fransson@stericsson.com>
	<20101122072420.GC14080@gw.healthdatacare.com>
	<AANLkTikJiXFG_kGV4=wTKOzViy-h9VtGRHKVBuh76fE2@mail.gmail.com>
	<20101122104740.GA30744@n2100.arm.linux.org.uk>
	<20101122112759.GA31227@n2100.arm.linux.org.uk>
Message-ID: <9d90879f08b3141aa5ce4a0887018de9@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: Russell King - ARM Linux [mailto:linux at arm.linux.org.uk]
> Sent: Monday, November 22, 2010 4:58 PM
> To: Per Fransson; Shilimkar, Santosh
> Cc: Mika Westerberg; kexec at lists.infradead.org; linux-arm-
> kernel at lists.infradead.org
> Subject: Re: [PATCH] Add call to non-crashing cores through IPI
>
> On Mon, Nov 22, 2010 at 10:47:40AM +0000, Russell King - ARM Linux
wrote:
> > However, we do need smp_send_stop() to wait for a limited time for the
> > other CPUs to respond to the request.
>
> ARM: smp: make smp_send_stop() wait for secondary CPUs to stop
>
> Wait up to one second for secondary CPUs to respond to a request to
> stop.  This avoids the sender CPU continuing and possibly destroying
> state before the recipients have had a chance to respond to the stop.
> However, if the recipients have crashed, we won't hang the sender
> CPU indefinitely.
>
Just tried this patch thinking it might fix the reboot issue
reported earlier. But it doesn't help.

> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> ---
>  arch/arm/kernel/smp.c |    6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/arch/arm/kernel/smp.c b/arch/arm/kernel/smp.c
> index 5d0dc16..32a2158 100644
> --- a/arch/arm/kernel/smp.c
> +++ b/arch/arm/kernel/smp.c
> @@ -589,10 +589,16 @@ void smp_send_reschedule(int cpu)
>
>  void smp_send_stop(void)
>  {
> +	unsigned long timeout;
>  	cpumask_t mask = cpu_online_map;
>  	cpu_clear(smp_processor_id(), mask);
>  	if (!cpus_empty(mask))
>  		send_ipi_message(&mask, IPI_CPU_STOP);
> +
> +	/* Wait up to one second for other CPUs to stop */
> +	timeout = USEC_PER_SEC;
> +	while (num_online_cpus() > 1 && timeout--)
> +		udelay(1);
>  }
>
>  /*
