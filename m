From: will.deacon@arm.com (Will Deacon)
Date: Mon, 16 Jul 2012 12:22:22 +0100
Subject: [PATCH] [ARM] Unconditional call to smp_cross_call on UP crashes
 (take #2)
In-Reply-To: <20120713075937.GC10602@S2100-06.ap.freescale.net>
References: <1337975916-31167-1-git-send-email-panto@antoniou-consulting.com>
 <20120713075937.GC10602@S2100-06.ap.freescale.net>
Message-ID: <20120716112222.GF26723@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 13, 2012 at 08:59:39AM +0100, Shawn Guo wrote:
> > diff --git a/arch/arm/kernel/smp.c b/arch/arm/kernel/smp.c
> > index 8f46446..7babc3f 100644
> > --- a/arch/arm/kernel/smp.c
> > +++ b/arch/arm/kernel/smp.c
> > @@ -590,7 +590,8 @@ void smp_send_stop(void)
> >  
> >  	cpumask_copy(&mask, cpu_online_mask);
> >  	cpumask_clear_cpu(smp_processor_id(), &mask);
> > -	smp_cross_call(&mask, IPI_CPU_STOP);
> > +	if (!cpumask_empty(&mask))
> > +		smp_cross_call(&mask, IPI_CPU_STOP);

I wonder whether we shouldn't have a default smp_cross_call implementation
with BUG_ON(!cpumask_empty(&mask)). It's marginally nicer than an explicit NULL
deference and it would also fix your problem.

Will
