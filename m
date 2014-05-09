From: mark.rutland@arm.com (Mark Rutland)
Date: Fri, 9 May 2014 09:54:41 +0100
Subject: [PATCH 3/8] arm64: Add spin-table cpu_die
In-Reply-To: <56b0c0f2834cba63db1f75966f2ee756ab347205.1399594544.git.geoff@infradead.org>
References: <cover.1399594544.git.geoff@infradead.org>
 <56b0c0f2834cba63db1f75966f2ee756ab347205.1399594544.git.geoff@infradead.org>
Message-ID: <20140509085441.GE4757@e106331-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 09, 2014 at 01:48:17AM +0100, Geoff Levand wrote:
> Add two new minimal routines smp_spin_table_cpu_disable() and
> smp_spin_table_cpu_die() and hook them up to the smp_spin_table_ops instance.
> 
> Kexec support will use smp_spin_table_cpu_die() for re-boot of spin table CPUs,
> but also needs a compatible smp_spin_table_cpu_disable() to allow
> execution to reach smp_spin_table_cpu_die().
> 
> Signed-off-by: Geoff Levand <geoff@infradead.org>
> ---
>  arch/arm64/kernel/smp_spin_table.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/arch/arm64/kernel/smp_spin_table.c b/arch/arm64/kernel/smp_spin_table.c
> index 7a530d2..26c780b 100644
> --- a/arch/arm64/kernel/smp_spin_table.c
> +++ b/arch/arm64/kernel/smp_spin_table.c
> @@ -142,10 +142,23 @@ static void smp_spin_table_cpu_postboot(void)
>  	raw_spin_unlock(&boot_lock);
>  }
>  
> +static int smp_spin_table_cpu_disable(unsigned int cpu)
> +{
> +	return 0;

If we cannot kill the CPU then we need to fail here. cpu_disable is
called early enough that the cpu hotplug infrastructure can recover if
we cannot disable the CPU.

> +}
> +
> +static void smp_spin_table_cpu_die(unsigned int cpu)
> +{
> +	while (1)
> +		cpu_relax();

This does not kill the CPU -- it's stuck spinning on some instructions
that might get clobbered upon a kexec. So this is insufficient for
kexec.

This also doesn't allow the CPU to be brought back, so it's completely
useless as-is.

NAK for pseudo-hotplug. If we cannot place the CPU somewhere out of the
way of the kernel then we _must_ fail.

Thanks,
Mark.

> +}
> +
>  const struct cpu_operations smp_spin_table_ops = {
>  	.name		= "spin-table",
>  	.cpu_init	= smp_spin_table_cpu_init,
>  	.cpu_prepare	= smp_spin_table_cpu_prepare,
>  	.cpu_boot	= smp_spin_table_cpu_boot,
>  	.cpu_postboot	= smp_spin_table_cpu_postboot,
> +	.cpu_disable	= smp_spin_table_cpu_disable,
> +	.cpu_die	= smp_spin_table_cpu_die,
>  };
> -- 
> 1.9.1
> 
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
