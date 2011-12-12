From: pawel.moll@arm.com (Pawel Moll)
Date: Mon, 12 Dec 2011 11:03:31 +0000
Subject: [PATCH v5 5/9] ARM: versatile: Map local timers using Device
 Tree when possible
In-Reply-To: <4EE37A4D.8060204@ru.mvista.com>
References: <1323457432-4800-1-git-send-email-pawel.moll@arm.com>
 <1323457432-4800-6-git-send-email-pawel.moll@arm.com>
 <4EE37A4D.8060204@ru.mvista.com>
Message-ID: <1323687811.2391.3.camel@hornet.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Morning,

On Sat, 2011-12-10 at 15:27 +0000, Sergei Shtylyov wrote:
> >   int __cpuinit local_timer_setup(struct clock_event_device *evt)
> >   {
> > +#if defined(CONFIG_OF)
> > +	if (!twd_base) {
> > +		struct device_node *np = of_find_compatible_node(NULL,
> > +				NULL, "arm,smp-twd");
> > +
> > +		twd_base = of_iomap(np, 0);
> > +		if (!twd_base)
> > +			return -ENXIO;
> 
>     -ENOMEM.

Hm. What I did simply mimics this ("arch/arm/include/asm/localtimer.h"):

#ifdef CONFIG_LOCAL_TIMERS
[...]
#else

static inline int local_timer_setup(struct clock_event_device *evt)
{
        return -ENXIO;
}

Now, I had a look at "include/asm-generic/errno-base.h":

#define ENXIO            6      /* No such device or address */
[...]
#define ENOMEM          12      /* Out of memory */

and to be honest, ENXIO makes more sense to me, but I really have no
strong feelings either way... Do you?

Thanks for your time!

Pawe?
