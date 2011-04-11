From: pratyush.anand@st.com (pratyush)
Date: Mon, 11 Apr 2011 17:56:20 +0530
Subject: [PATCH V7 02/17] SPEAr13xx: Add PCIe host controller base driver
	support.
In-Reply-To: <201103230928.18445.arnd@arndb.de>
References: <cover.1298977728.git.viresh.kumar@st.com>
	<6a4328fcb24af3fa28b2188864875cbecc6f533a.1298977728.git.viresh.kumar@st.com>
	<201103230928.18445.arnd@arndb.de>
Message-ID: <4DA2F36C.3010707@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Arnd,

Sorry for late response.
I was out of my office for some days.

On 3/23/2011 1:58 PM, Arnd Bergmann wrote:
> On Wednesday 23 March 2011, Viresh Kumar wrote:
>> From: Pratyush Anand <pratyush.anand@st.com>
>>
>> SPEAr13xx family contains Synopsys designware PCIe version 3.30a. This
>> patch adds support for this PCIe module for spear platform.
> 
> Looks almost good now, but I still have my doubts about the I/O space handling.
> Most importantly, I cannot even see where the I/O space is getting mapped to.
> This becomes rather interesting when you have multiple root ports that each
> have their own physical I/O space windows, and there are multiple ways it can
> be done.
> 
> The way I would recommend is to reserve a part of the system's virtual
> address space for all I/O windows, and using iotable_init() to map
> them contiguously. The first port will then be the only one that
> can hold ISA ranges (needed for legacy VGA mode, for instance).
> 

Sorry, may be I could not get this point correctly. Do you mean that,
I should create a static mapping for IN0_MEM_SIZE (200 MB) and 
IN_IO_SIZE (20 MB) during board initialization itself?

>> Changes since V6:
>> - Read request size in RC'c PCIE capability is forced to 128 bytes.
>> - Max payload is forced to the minimum value of max payload of any of the
>>   device in tree.
>> - Request_resource for IO Space is from ioport_resource now. Earlier it was from
>>   iomem_resource.
> 
> This seems like a mistake. The I/O space window resides inside of
> iomem_resource, so you have to register it from there.
> 
> The ioport_resource refers to ports in the range between 0x1000 and 0x2ffff
> that get mapped into that window, so you cannot register the window inside
> of itself.
> 
> You should probably register both -- add the physical address to iomem_resource,
> and register the I/O port range for each PCIe port to ioport_resource.
> 


Now I understood difference between I/O space and I/O port. Yes, I/O space should 
be allocated from iomem_resource window rather from ioport_resource. I will correct it.

>> diff --git a/arch/arm/mach-spear13xx/include/mach/hardware.h b/arch/arm/mach-spear13xx/include/mach/hardware.h
>> index fd8c2dc..6169d4f 100644
>> --- a/arch/arm/mach-spear13xx/include/mach/hardware.h
>> +++ b/arch/arm/mach-spear13xx/include/mach/hardware.h
>> @@ -28,4 +28,8 @@
>>  /* typesafe io address */
>>  #define __io_address(n)		__io(IO_ADDRESS(n))
> 
> Please reread my previous comments. You have to redefine __io() in order to make
> the I/O port accesses work. When you do that, you cannot define
> __io_address (which is used by non-PCI code) as using __io.
> 

__io_address is not used by PICe routines. Also, this is not part of 
this patch. Shiraz will reply for this issue.

>> +#define PCIBIOS_MIN_IO		0
> 
> PCIBIOS_MIN_IO should be 0x1000, to make sure that any ISA or PCMCIA
> devices behind a bridge cannot interfere with regular PCI or PCIe
> devices.
> 

I will modify this define.

>> +/*
>> + * In current implementation address translation is done using IN0 only. So IN1
>> + * start address and IN0 end address has been kept same
>> +*/
>> +#define IN1_MEM_SIZE	(0 * 1024 * 1024 - 1)
>> +#define IN_IO_SIZE	(20 * 1024 * 1024 - 1)
>> +#define IN_CFG0_SIZE	(1 * 1024 * 1024 - 1)
>> +#define IN_CFG1_SIZE	(1 * 1024 * 1024 - 1)
>> +#define IN_MSG_SIZE	(1 * 1024 * 1024 - 1)
> 
> Is IN_IO_SIZE per host, or this shared across all hosts?

This is per host. So is it not a practical size?
What should be a reasonable IO size?

Regards
Pratyush

> 
> 	Arnd
> .
> 
