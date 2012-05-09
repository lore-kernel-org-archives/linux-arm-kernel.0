From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 9 May 2012 13:45:34 +0000
Subject: [PATCH] mach-shmobile: Emma Mobile EV2 SMP prototype code
In-Reply-To: <4FAA6DE6.3040001@arm.com>
References: <20120509075407.5991.60556.sendpatchset@w520>
 <201205091212.08239.arnd@arndb.de> <4FAA6DE6.3040001@arm.com>
Message-ID: <201205091345.34404.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 09 May 2012, Marc Zyngier wrote:
> On 09/05/12 13:12, Arnd Bergmann wrote:
> > On Wednesday 09 May 2012, Magnus Damm wrote:
> >>  static unsigned int __init shmobile_smp_get_core_count(void)
> >>  {
> >> @@ -31,6 +32,9 @@ static unsigned int __init shmobile_smp_
> >>  	if (is_r8a7779())
> >>  		return r8a7779_get_core_count();
> >>  
> >> +	if (is_emev2())
> >> +		return emev2_get_core_count();
> >> +
> >>  	return 1;
> >>  }
> >>  
> >> @@ -41,6 +45,9 @@ static void __init shmobile_smp_prepare_
> >>  
> >>  	if (is_r8a7779())
> >>  		r8a7779_smp_prepare_cpus();
> >> +
> >> +	if (is_emev2())
> >> +		emev2_smp_prepare_cpus();
> >>  }
> >>  
> >>  int shmobile_platform_cpu_kill(unsigned int cpu)
> >> ...
> > 
> > This shows that we really want an abstraction for soc-specific SMP ops
> > even within one platform, and we'll need the same thing for multiplatform.
> > 
> > Marc Zyngier already proposed a solution for this last year, but I
> > think we couldn't agree on the details back then before he lost interest.
> > I think we should pick that up again and get it into 3.6 so the code above
> > can be simplified and we can do the multiplatform solution. We'll probably
> > discuss the details in Hong Kong in a couple of weeks, so there is no
> > point in changing it now, but I'd hope that you can migrate this to
> > whatever we come up with in the following merge window.
> 
> I'm happy to revive the series if there is an interest.

Ok, good. I think we were almost there the last time, but I don't
know if Russell still had any objections. Magnus, can you comment on
the "[PATCH v6 09/15] ARM: SoC: convert shmobile SMP to SoC descriptor"
patch from February to see if it fits your needs?

FWIW, I would actually prefer merging the 'struct arm_soc_desc', 'struct
arm_soc_smp_init_ops' and 'struct arm_soc_smp_ops' structures into a
single 'struct smp_ops' for simplicity. While that would no longer allow
us to put more stuff in there, I also don't see an urgent need to do so.
I also don't mind the code that we had in version 6.

	Arnd
