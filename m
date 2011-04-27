From: ryan@bluewatersys.com (Ryan Mallon)
Date: Wed, 27 Apr 2011 12:13:28 +1200
Subject: [PATCH 05/14] at91: use structure to store the current soc
In-Reply-To: <20110426234514.GC29103@game.jcrosoft.org>
References: <20110425180847.GA12904@game.jcrosoft.org>
	<1303756284-26529-5-git-send-email-plagnioj@jcrosoft.com>
	<4DB5F0C7.2070903@bluewatersys.com>
	<20110426042131.GD12904@game.jcrosoft.org>
	<4DB64DC3.70609@bluewatersys.com>
	<20110426064216.GJ12904@game.jcrosoft.org>
	<4DB7299D.80308@bluewatersys.com>
	<20110426234514.GC29103@game.jcrosoft.org>
Message-ID: <4DB75FA8.10207@bluewatersys.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/27/2011 11:45 AM, Jean-Christophe PLAGNIOL-VILLARD wrote:
>>> yes it's for now we can use one soc at a time I'm working to remove those
>>> issue and make then soc specific
>>> before doint this I need to fix pm, interrupt, earlyprintk, ll_debug, etc...
>>>
>>> for gpio and timers it's already fix so one by one and it will be clean
>>> in those 2 we can now specify on the soc the resource so we do not need to
>>> have the same AT91_PIOx, AT91_ST and AT91_PIT for all soc
>>> they can have their own.
>>>
>>> When this cleanup will be finished we will have
>>> AT91SAM9263_PIOx AT91SAM9263_PIT etc...
>>> and only common define when they are really common
>>>>> all of this work is in preparation to allow multiple soc in the same kernel
>>>>> that's also why I map the system controller the same way on all at91 arm9
>>>> If the __cpu_is macros, which read the registers directly, remain then I
>>>> don't see how this can be generic between the various SoCs?
>>> because they will be use only at the begenning before any drivers or other ip
>>> enable so we can use them later it will not be the case anymore
>>>
>>> Best Regards,
>>> J.
>> I think that a better approach is to have only the cpu_is_ macros which
>> read the shadow value and then have at91_initialize (or some other
>> function which is init called before anything needs the cpu_is_ macros)
>> which just directly reads the cpu id registers and fills in the
>> structure. You won't need a structure that way either, just an id.
>> Something like:
>>
>> /* include/mach/cpu.h */
>>
>> /* Base SoC types */
>>
>> #define AT91_SOC_AT91RM9200	0x1
>> #define AT91_SOC_AT91SAM9260	0x2
>>
>> /* Extended SoC types */
>> #define AT91_SOC_AT91SAM9XE	(0x1 << 16)
>>
>> /* Accessor macros */
>> #define AT91_SOC_TYPE(x)	((x) & 0xffff)
>> #define AT91_SOC_EXT_TYPE(x)	(((x) >> 16) & 0xffff)
>>
>> extern unsigned long at91_soc_id;
>>
>> #define cpu_is_at91rm9200()	(AT91_SOC_TYPE(at91_soc_id) == AT91_SOC_AT91RM9200)
>> #define cpu_is_at91sam9260()	(AT91_SOC_TYPE(at91_soc_id) == AT91_SOC_AT91SAM9260)
>> #define cpu_is_at91sam9xe()	(AT91_SOC_EXT_TYPE(at91_soc_id) == AT91_SOC_AT91SAM9XE)
>>
>> /* soc.c */
>> unsigned long at91_soc_id = 0;
>>
>> static void at91_detect_cpu(void)
>> {
>> 	unsigned long cpu_id, full_id, arch_id, exid;
>>
>>
>> 	full_id = at91_sys_read(AT91_DBGU_CIDR);
>> 	cpu_id  = full_id & !AT91_CIDR_VERSION);
>> 	arch_id = full_id & AT91_CIDR_ARCH;
>> 	exid    = at91_sys_read(AT91_DBGU_EXID);
>>
>> 	switch (cpu_id) {
>> 	case ARCH_ID_AT91RM9200:
>> 		at91_soc_id = AT91_SOC_AT91RM9200;
>> 		current_soc = at91rm9200_soc;
>> 		break;
>>
>> 	case ARCH_ID_AT91SAM9260:
>> 		at91_soc_id = AT91_SOC_AT91SAM9260;
>> 		if (arch_id == ARCH_FAMILY_AT91SAM9XE)
>> 			at91_soc_id |= AT91_SOC_AT91SAM9XE;
>> 		current_soc = at91sam9260_soc;
>> 		break;
>> 	...
>> 	
>> 	default:
>> 		panic("Unknown AT91 SoC type\n");
>> 	}
>> } 
>>
>>
>> This way the cpu detection code is much clearer and easier to read and
>> only one set of __cpu_is macros are needed. The values for
>> ARCH_ID_AT91RM9200, etc can be moved into soc.c since they are not
>> needed elsewhere.
> This will never work you do not listen
>
> the DBUG is at DIFFERENT base address on the AT91
> you need to check them one by one
>
> I keep the structure to keep more imformation inside and do not want to be
> limited by a 32bit and complex encoding to maintain
>
> Best Regards,
> J.
You can only be running one machine at a time. Are you implying that
this change breaks at91_sys_read in such a way that it reads the wrong
registers? If so, then its definitely a NAK.

Your patch does this:

static inline unsigned long at91_cpu_identify(void)
{
	return (at91_sys_read(AT91_DBGU_CIDR) & ~AT91_CIDR_VERSION);
}

...

#ifdef CONFIG_ARCH_AT91RM9200
#define __cpu_is_at91rm9200()	(at91_cpu_identify() == ARCH_ID_AT91RM9200)
#else
#define __cpu_is_at91rm9200()	(0)
#endif

...

void __init at91_initialize(unsigned long main_clock)
{
	...
	if (__cpu_is_at91rm9200()) {
		cpu_id.is_at91rm9200_soc;
		current_soc = at91rm9200_soc;
	}
	...
}


So at91_initialize calls the __cpu_is macros, which in turn read the
AT91_DBGU registers via at91_sys_read. What I am proposing above is to
replace the massive collection of if statements with a simpler switch
statement and replacing the __cpu_is macros with direct register reads
via at91_sys_read, which results in far less code and more readable
code. If your version works, then how can mine not?

~Ryan

-- 
Bluewater Systems Ltd - ARM Technology Solution Centre

Ryan Mallon         		5 Amuri Park, 404 Barbadoes St
ryan at bluewatersys.com         	PO Box 13 889, Christchurch 8013
http://www.bluewatersys.com	New Zealand
Phone: +64 3 3779127		Freecall: Australia 1800 148 751 
Fax:   +64 3 3779135			  USA 1800 261 2934
