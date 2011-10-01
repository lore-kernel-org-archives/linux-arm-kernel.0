From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 1 Oct 2011 17:23:57 +0100
Subject: nr_cpus cmdline parameter not working
In-Reply-To: <1317224117.2580.84.camel@deneb.redhat.com>
References: <1317224117.2580.84.camel@deneb.redhat.com>
Message-ID: <20111001162357.GH11710@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 28, 2011 at 11:35:16AM -0400, Mark Salter wrote:
> I noticed that nr_cpus=1 doesn't appear to have any effect on a
> pandaboard (and probably others from the looks of things). This
> changes seems to be needed, but I'm not really sure if this is
> the right thing or not.
> 
> diff --git a/arch/arm/mach-omap2/omap-smp.c b/arch/arm/mach-omap2/omap-smp.c
> index ce65e93..a1198ac 100644
> --- a/arch/arm/mach-omap2/omap-smp.c
> +++ b/arch/arm/mach-omap2/omap-smp.c
> @@ -117,6 +117,9 @@ void __init smp_init_cpus(void)
>  		ncores = NR_CPUS;
>  	}
>  
> +	if (ncores > nr_cpu_ids)
> +		ncores = nr_cpu_ids;
> +

This potentially affects all SMP platforms, so the patch needs to be
bigger than this.

Also, I think the test above should be modified to use nr_cpu_ids
rather than NR_CPUS, to be inline with what x86 does:

        /* nr_cpu_ids could be reduced via nr_cpus= */
        if (possible > nr_cpu_ids) {
                printk(KERN_WARNING
                        "%d Processors exceeds NR_CPUS limit of %d\n",
                        possible, nr_cpu_ids);
                possible = nr_cpu_ids;
        }

(This is essentially the same check that we're doing.)

Could you have a look at this and cook up another patch covering the
other SMP platforms please?

Thanks.
