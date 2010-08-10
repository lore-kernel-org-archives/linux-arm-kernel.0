From: ryan@bluewatersys.com (Ryan Mallon)
Date: Wed, 11 Aug 2010 08:50:13 +1200
Subject: [PATCH 2/5] SPEAR3xx: Rename register/irq defines to remove naming
	conflicts
In-Reply-To: <4C60DFB8.20608@st.com>
References: <1275717955-14545-1-git-send-email-ryan@bluewatersys.com>
	<1275717955-14545-3-git-send-email-ryan@bluewatersys.com>
	<4C60DFB8.20608@st.com>
Message-ID: <4C61BB85.5050406@bluewatersys.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/10/2010 05:12 PM, viresh kumar wrote:
> 
> Ryan,
> 
> Sorry for testing this set of patches so late. Patch is working fine.
> I have few comments:

Thanks for looking at this.

> 
>> -#define SPEAR_GPIO_INT_END			(SPEAR_GPIO1_INT_BASE + 8)
>> +//#define SPEAR_GPIO_INT_END			(SPEAR_GPIO1_INT_BASE + 8)
> 
> wrong comment sytle. Also we can move above definition with rest of GPIO
> virtual irq no.s.

Oops, that looks like it should have been removed. Moving the definition
is fine.

>>  
> 
> [snip...]
> 
>>  
>> +/*
>> + * GPIO pins virtual irqs
>> + * Use the lowest number for the GPIO virtual IRQs base on which subarchs
>> + * we have compiled in
>> + */
>> +#if defined(CONFIG_MACH_SPEAR310)
>> +#define SPEAR_GPIO_INT_BASE			(SPEAR3XX_VIRQ_START + 18)
>> +#elif defined(CONFIG_MACH_SPEAR320)
>> +#define SPEAR_GPIO_INT_BASE			(SPEAR3XX_VIRQ_START + 17)
>> +#else
>> +#define SPEAR_GPIO_INT_BASE			(SPEAR3XX_VIRQ_START + 9)
>>  #endif
> 
> If we have all three machines enabled, then SPEAR_GPIO_INT_BASE will start from
> VIRQ_START + 18, which will work for spear310 and spear320, but will not be
> correct as we will skip 9 irq no.s.

Do the virtual irqs map directly to the hardware in some way? I thought
that since they were virtual there offset would be somewhat arbitrary?

> It would be better to have three different base addresses
> SPEAR300_GPIO_INT_BASE, etc.

This is possible. We can either do this by making SPEAR3XX_GPIO_INT_BASE
a variable, or by having some ifdef/machine_is code in the board
initialisation.

~Ryan

-- 
Bluewater Systems Ltd - ARM Technology Solution Centre

Ryan Mallon         		5 Amuri Park, 404 Barbadoes St
ryan at bluewatersys.com         	PO Box 13 889, Christchurch 8013
http://www.bluewatersys.com	New Zealand
Phone: +64 3 3779127		Freecall: Australia 1800 148 751
Fax:   +64 3 3779135			  USA 1800 261 2934
