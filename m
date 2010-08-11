From: viresh.kumar@st.com (viresh kumar)
Date: Wed, 11 Aug 2010 14:44:24 +0530
Subject: [PATCH 2/5] SPEAR3xx: Rename register/irq defines to remove naming
	conflicts
In-Reply-To: <4C61BB85.5050406@bluewatersys.com>
References: <1275717955-14545-1-git-send-email-ryan@bluewatersys.com>
	<1275717955-14545-3-git-send-email-ryan@bluewatersys.com>
	<4C60DFB8.20608@st.com> <4C61BB85.5050406@bluewatersys.com>
Message-ID: <4C6269F0.8060109@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 8/11/2010 2:20 AM, Ryan Mallon wrote:
>>> >>  
>>> >> +/*
>>> >> + * GPIO pins virtual irqs
>>> >> + * Use the lowest number for the GPIO virtual IRQs base on which subarchs
>>> >> + * we have compiled in
>>> >> + */
>>> >> +#if defined(CONFIG_MACH_SPEAR310)
>>> >> +#define SPEAR_GPIO_INT_BASE			(SPEAR3XX_VIRQ_START + 18)
>>> >> +#elif defined(CONFIG_MACH_SPEAR320)
>>> >> +#define SPEAR_GPIO_INT_BASE			(SPEAR3XX_VIRQ_START + 17)
>>> >> +#else
>>> >> +#define SPEAR_GPIO_INT_BASE			(SPEAR3XX_VIRQ_START + 9)
>>> >>  #endif
>> > 
>> > If we have all three machines enabled, then SPEAR_GPIO_INT_BASE will start from
>> > VIRQ_START + 18, which will work for spear310 and spear320, but will not be
>> > correct as we will skip 9 irq no.s.
> Do the virtual irqs map directly to the hardware in some way? I thought
> that since they were virtual there offset would be somewhat arbitrary?

No. Virtual irqs are not fixed with hardware. What i wanted to say is
NR_IRQS will have a higher value, which will make irq_desc[NR_IRQS]
array have more size.

> 
>> > It would be better to have three different base addresses
>> > SPEAR300_GPIO_INT_BASE, etc.
> This is possible. We can either do this by making SPEAR3XX_GPIO_INT_BASE
> a variable, or by having some ifdef/machine_is code in the board
> initialisation.

Not sure! We need to have single value of NR_IRQS for all spear3xx variants.
This will always waste some memory. I don't know if any other solution can
be there.

So SPEAR_GPIO_INT_BASE can be kept common with a single value without
these #ifdefs, i.e. we can have
#define SPEAR_GPIO_INT_BASE			(SPEAR3XX_VIRQ_START + 18)

and now we can have different macros per machine, i.e. 300,310,320.

viresh.
