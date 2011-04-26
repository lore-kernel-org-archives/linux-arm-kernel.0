From: ryan@bluewatersys.com (Ryan Mallon)
Date: Wed, 27 Apr 2011 08:22:53 +1200
Subject: [PATCH 05/14] at91: use structure to store the current soc
In-Reply-To: <20110426064216.GJ12904@game.jcrosoft.org>
References: <20110425180847.GA12904@game.jcrosoft.org>
	<1303756284-26529-5-git-send-email-plagnioj@jcrosoft.com>
	<4DB5F0C7.2070903@bluewatersys.com>
	<20110426042131.GD12904@game.jcrosoft.org>
	<4DB64DC3.70609@bluewatersys.com>
	<20110426064216.GJ12904@game.jcrosoft.org>
Message-ID: <4DB7299D.80308@bluewatersys.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/26/2011 06:42 PM, Jean-Christophe PLAGNIOL-VILLARD wrote:
>>>> I haven't looked at the subsequent patches yet to see if this patch
>>>> simplifies things later but it seems that this just adds more lines of
>>>> code by having two copies of the each of the cpu_is_xxx macros (the
>>>> __cpu_is_xxx version which reads the register, and the cpu_is_xxx
>>>> version which reads the shadow value)?
>>>>
>>>> What is the reasoning behind shadowing the cpu type rather than reading
>>>> the registers? The cpu detection macros are mostly used at
>>>> initialisation and device probe time, so they don't necessarily need to
>>>> be fast.
>>>>
>>>> If this eventually reduces code size then I think it is useful, but
>>>> otherwise I'm not sure I see the point?
>>> It's on purpose as the dbgu physical address is not at the same place
>>> so read the other register really does not impact the chip but if we do it
>>> later duting the boot or the life to the kernel it's an other story
>>>
>>> so the split between __cpu_is and cpu_is is necessarly
>> I don't understand. The at91_initialize function sets cpu_id using the
>> __cpu_is macros, and the cpu_is macros check cpu_id to determine the cpu
>> type. So the __cpu_is and cpu_is macros are functionally equivalent
>> except that the former uses register reads and the latter reads a shadow
>> value. i.e. the cpu_is macros are just indirectly using the __cpu_is macros.
>>
>> If the register offsets are different between the various platforms then
>> this won't work anyway since the __cpu_is macros cannot be generic.
> yes it's for now we can use one soc at a time I'm working to remove those
> issue and make then soc specific
> before doint this I need to fix pm, interrupt, earlyprintk, ll_debug, etc...
>
> for gpio and timers it's already fix so one by one and it will be clean
> in those 2 we can now specify on the soc the resource so we do not need to
> have the same AT91_PIOx, AT91_ST and AT91_PIT for all soc
> they can have their own.
>
> When this cleanup will be finished we will have
> AT91SAM9263_PIOx AT91SAM9263_PIT etc...
> and only common define when they are really common
>>> all of this work is in preparation to allow multiple soc in the same kernel
>>> that's also why I map the system controller the same way on all at91 arm9
>> If the __cpu_is macros, which read the registers directly, remain then I
>> don't see how this can be generic between the various SoCs?
> because they will be use only at the begenning before any drivers or other ip
> enable so we can use them later it will not be the case anymore
>
> Best Regards,
> J.
I think that a better approach is to have only the cpu_is_ macros which
read the shadow value and then have at91_initialize (or some other
function which is init called before anything needs the cpu_is_ macros)
which just directly reads the cpu id registers and fills in the
structure. You won't need a structure that way either, just an id.
Something like:

/* include/mach/cpu.h */

/* Base SoC types */

#define AT91_SOC_AT91RM9200	0x1
#define AT91_SOC_AT91SAM9260	0x2

/* Extended SoC types */
#define AT91_SOC_AT91SAM9XE	(0x1 << 16)

/* Accessor macros */
#define AT91_SOC_TYPE(x)	((x) & 0xffff)
#define AT91_SOC_EXT_TYPE(x)	(((x) >> 16) & 0xffff)

extern unsigned long at91_soc_id;

#define cpu_is_at91rm9200()	(AT91_SOC_TYPE(at91_soc_id) == AT91_SOC_AT91RM9200)
#define cpu_is_at91sam9260()	(AT91_SOC_TYPE(at91_soc_id) == AT91_SOC_AT91SAM9260)
#define cpu_is_at91sam9xe()	(AT91_SOC_EXT_TYPE(at91_soc_id) == AT91_SOC_AT91SAM9XE)

/* soc.c */
unsigned long at91_soc_id = 0;

static void at91_detect_cpu(void)
{
	unsigned long cpu_id, full_id, arch_id, exid;


	full_id = at91_sys_read(AT91_DBGU_CIDR);
	cpu_id  = full_id & !AT91_CIDR_VERSION);
	arch_id = full_id & AT91_CIDR_ARCH;
	exid    = at91_sys_read(AT91_DBGU_EXID);

	switch (cpu_id) {
	case ARCH_ID_AT91RM9200:
		at91_soc_id = AT91_SOC_AT91RM9200;
		current_soc = at91rm9200_soc;
		break;

	case ARCH_ID_AT91SAM9260:
		at91_soc_id = AT91_SOC_AT91SAM9260;
		if (arch_id == ARCH_FAMILY_AT91SAM9XE)
			at91_soc_id |= AT91_SOC_AT91SAM9XE;
		current_soc = at91sam9260_soc;
		break;
	...
	
	default:
		panic("Unknown AT91 SoC type\n");
	}
} 


This way the cpu detection code is much clearer and easier to read and
only one set of __cpu_is macros are needed. The values for
ARCH_ID_AT91RM9200, etc can be moved into soc.c since they are not
needed elsewhere.

~Ryan

-- 
Bluewater Systems Ltd - ARM Technology Solution Centre

Ryan Mallon         		5 Amuri Park, 404 Barbadoes St
ryan at bluewatersys.com         	PO Box 13 889, Christchurch 8013
http://www.bluewatersys.com	New Zealand
Phone: +64 3 3779127		Freecall: Australia 1800 148 751 
Fax:   +64 3 3779135			  USA 1800 261 2934
