From: sshtylyov@ru.mvista.com (Sergei Shtylyov)
Date: Mon, 12 Dec 2011 15:18:26 +0400
Subject: [PATCH v5 5/9] ARM: versatile: Map local timers using Device
 Tree when possible
In-Reply-To: <1323687811.2391.3.camel@hornet.cambridge.arm.com>
References: <1323457432-4800-1-git-send-email-pawel.moll@arm.com>
 <1323457432-4800-6-git-send-email-pawel.moll@arm.com>
 <4EE37A4D.8060204@ru.mvista.com>
 <1323687811.2391.3.camel@hornet.cambridge.arm.com>
Message-ID: <4EE5E302.8070301@ru.mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 12-12-2011 15:03, Pawel Moll wrote:

>>>    int __cpuinit local_timer_setup(struct clock_event_device *evt)
>>>    {
>>> +#if defined(CONFIG_OF)
>>> +	if (!twd_base) {
>>> +		struct device_node *np = of_find_compatible_node(NULL,
>>> +				NULL, "arm,smp-twd");
>>> +
>>> +		twd_base = of_iomap(np, 0);
>>> +		if (!twd_base)
>>> +			return -ENXIO;

>>      -ENOMEM.

> Hm. What I did simply mimics this ("arch/arm/include/asm/localtimer.h"):

> #ifdef CONFIG_LOCAL_TIMERS
> [...]
> #else

> static inline int local_timer_setup(struct clock_event_device *evt)
> {
>          return -ENXIO;
> }

> Now, I had a look at "include/asm-generic/errno-base.h":

> #define ENXIO            6      /* No such device or address */
> [...]
> #define ENOMEM          12      /* Out of memory */

> and to be honest, ENXIO makes more sense to me, but I really have no
> strong feelings either way... Do you?

    I think if of_iomap() fails, it's because the system is out of memory, so 
-ENOMEM seems more proper error in this case. Although... it's not the only 
case when of_iomap() fails.

> Thanks for your time!

> Pawe?

WBR, Sergei
