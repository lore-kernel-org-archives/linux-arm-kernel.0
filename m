From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 30 Nov 2010 23:27:23 +0000
Subject: [PATCH 3/8] ARM: VExpress: Switch to generic SCU routines
In-Reply-To: <20101130171701.GC24034@oksana.dev.rtsoft.ru>
References: <20101130171626.GA6165@oksana.dev.rtsoft.ru>
	<20101130171701.GC24034@oksana.dev.rtsoft.ru>
Message-ID: <20101130232723.GA14383@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 30, 2010 at 08:17:01PM +0300, Anton Vorontsov wrote:
> +/* If there are more than one CPU let them know where to start. */
> +static void __init smp_point_cpus(void)
> +{
> +	if (num_present_cpus() <= 1)
> +		return;
>  
> -	for (i = 0; i < ncores; i++)
> -		set_cpu_possible(i, true);
> +	writel(~0, MMIO_P2V(V2M_SYS_FLAGSCLR));
> +	writel(BSYM(virt_to_phys(scu_secondary_startup)),
> +	       MMIO_P2V(V2M_SYS_FLAGSSET));
>  }

I don't see the point of separating this code from the code below.  It
doesn't seem to bring any benefit.  Could you explain why it's necessary
to separate this?

>  void __init smp_prepare_cpus(unsigned int max_cpus)
>  {
...
