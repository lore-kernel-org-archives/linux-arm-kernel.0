From: tixy@linaro.org (Jon Medhurst (Tixy))
Date: Tue, 09 Apr 2013 07:00:46 +0100
Subject: [PATCH v4 15/15] ARM: vexpress: Select multi-cluster SMP
 operation if required
In-Reply-To: <alpine.LFD.2.03.1304090135590.1171@syhkavp.arg>
References: <1360041732-17936-1-git-send-email-nicolas.pitre@linaro.org>
 <1360041732-17936-16-git-send-email-nicolas.pitre@linaro.org>
 <20130405224819.GB14308@quad.lixom.net>
 <alpine.LFD.2.03.1304060943370.1171@syhkavp.arg>
 <1365412211.3384.16.camel@linaro1.home>
 <alpine.LFD.2.03.1304090135590.1171@syhkavp.arg>
Message-ID: <1365487246.3292.3.camel@computer5.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2013-04-09 at 01:41 -0400, Nicolas Pitre wrote:
> > Do the changes to the above mcpm files want to be in a separate patch as
> > it's generic ARM code, not vexpress specific?
> 
> Well, since it was so trivial I didn't do it, but the split might be a 
> good idea nevertheless.  So I inserted the following patch in the 
> series, and corresponding changes are now removed from the patch above.  
> What do you think?

Looks fine. Did you miss my other comment about smp_ops not looking like
they were getting set in the case of mcpm_smp_set_ops not getting
called?


> Author: Nicolas Pitre <nicolas.pitre@linaro.org>
> Date:   Tue Apr 9 01:29:17 2013 -0400
> 
>     ARM: mcpm: provide an interface to set the SMP ops at run time
>     
>     This is cleaner than exporting the mcpm_smp_ops structure.
>     
>     Signed-off-by: Nicolas Pitre <nico@linaro.org>
> 
> diff --git a/arch/arm/common/mcpm_platsmp.c b/arch/arm/common/mcpm_platsmp.c
> index 34f236af09..79ed70d846 100644
> --- a/arch/arm/common/mcpm_platsmp.c
> +++ b/arch/arm/common/mcpm_platsmp.c
> @@ -76,7 +76,7 @@ static void mcpm_cpu_die(unsigned int cpu)
>  
>  #endif
>  
> -struct smp_operations __initdata mcpm_smp_ops = {
> +static struct smp_operations __initdata mcpm_smp_ops = {
>  	.smp_init_cpus		= simple_smp_init_cpus,
>  	.smp_boot_secondary	= mcpm_boot_secondary,
>  	.smp_secondary_init	= mcpm_secondary_init,
> @@ -85,3 +85,8 @@ struct smp_operations __initdata mcpm_smp_ops = {
>  	.cpu_die		= mcpm_cpu_die,
>  #endif
>  };
> +
> +void __init mcpm_smp_set_ops(void)
> +{
> +	smp_set_ops(&mcpm_smp_ops);
> +}
> diff --git a/arch/arm/include/asm/mcpm_entry.h b/arch/arm/include/asm/mcpm_entry.h
> index 814623e6a1..34dfb86ff5 100644
> --- a/arch/arm/include/asm/mcpm_entry.h
> +++ b/arch/arm/include/asm/mcpm_entry.h
> @@ -190,5 +190,7 @@ int __mcpm_cluster_state(unsigned int cluster);
>  int __init mcpm_sync_init(
>  	void (*power_up_setup)(unsigned int affinity_level));
>  
> +void __init mcpm_smp_set_ops(void);
> +
>  #endif /* ! __ASSEMBLY__ */
>  #endif
> 

-- 
Tixy
