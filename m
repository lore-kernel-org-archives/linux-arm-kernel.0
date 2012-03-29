From: viresh.kumar@st.com (Viresh Kumar)
Date: Thu, 29 Mar 2012 12:09:02 +0530
Subject: [PATCH V2 5/7] ARM: SPEAr3xx: Add device-tree support to SPEAr3xx
 architecture
In-Reply-To: <201203281227.32299.arnd@arndb.de>
References: <cover.1332926608.git.viresh.kumar@st.com>
 <f4ad79023c6155d4de7e87c3cd798aadd493454e.1332926608.git.viresh.kumar@st.com>
 <201203281227.32299.arnd@arndb.de>
Message-ID: <4F740386.2080509@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 3/28/2012 5:57 PM, Arnd Bergmann wrote:

Hi Arnd,

Thanks for reviewing. :)

All comments accepted.

> Does spear310-evb really connect all seven serial ports?

Yes, since it was an evaluation board, it contained all of them.

>> +/* Following will create static virtual/physical mappings */
>> > +struct map_desc spear3xx_io_desc[] __initdata = {
>> > +	{
>> > +		.virtual	= VA_SPEAR3XX_ICM1_UART_BASE,
>> > +		.pfn		= __phys_to_pfn(SPEAR3XX_ICM1_UART_BASE),
>> > +		.length		= SZ_4K,
>> > +		.type		= MT_DEVICE
>> > +	}, {
>> > +		.virtual	= VA_SPEAR3XX_ML1_VIC_BASE,
>> > +		.pfn		= __phys_to_pfn(SPEAR3XX_ML1_VIC_BASE),
>> > +		.length		= SZ_4K,
>> > +		.type		= MT_DEVICE
>> > +	}, {
>> > +		.virtual	= VA_SPEAR3XX_ICM3_SYS_CTRL_BASE,
>> > +		.pfn		= __phys_to_pfn(SPEAR3XX_ICM3_SYS_CTRL_BASE),
>> > +		.length		= SZ_4K,
>> > +		.type		= MT_DEVICE
>> > +	}, {
>> > +		.virtual	= VA_SPEAR3XX_ICM3_MISC_REG_BASE,
>> > +		.pfn		= __phys_to_pfn(SPEAR3XX_ICM3_MISC_REG_BASE),
>> > +		.length		= SZ_4K,
>> > +		.type		= MT_DEVICE
>> > +	},
>> > +};
> Note: there no real reason to just map 4K pages here, or to compute the
> virtual addresses using the IO_ADDRESS macro. Using larger mappings mean
> you have more efficient TLB lookup for any I/O windows that are located
> closely together.

Agreed.

> I would actually write this something like
> struct map_desc spear3xx_io_desc[] __initdata = {
> 	{
> 		.virtual = 0xf0000000,
> 		.pfn	 = __phys_to_pfn(SPEAR3XX_ICM1_2_BASE),
> 		.length	 = SZ_16M,
> 		.type	 = MT_DEVICE,
> 	}, {
> 		.virtual = 0xf1000000,
> 		.pfn	 = __phys_to_pfn(SPEAR3XX_ICM4_BASE),
> 		.length  = 3 * SZ_16M,
> 		.type	 = MT_DEVICE,
> 	}, {
> 		.virtual = 0xf4000000,
> 		.pfn	 = __phys_to_pfn(SPEAR3XX_ICM3_ML1_2_BASE),
> 		.length  = 2 * SZ_16M,
> 		.type	 = MT_DEVICE,
> 	}, {
> 		.virtual = 0xf6000000,
> 		.pfn	 = __phys_to_pfn(SPEAR3XX_ICM3_SMI_CTRL_BASE),
> 		.length  = SZ_16M,
> 		.type	 = MT_DEVICE,
> 	},
> };
> 
> This would cover almost all of your devices with just seven TLB entries,
> and ioremap can now find the right virtual addresses automatically.

But there are few concerns.
Firstly, i wasn't aware that ioremap will reuse these mappings.
I believed that it will create new mappings and this is what i
saw till 2-6.37. What will happen if iounmap is called?

Over that, board would not be using all the devices present in SoC. So,
we don't really need to map everything. And so above wouldn't be valid
there.

To avoid holes, that were created in my original mappings, i can pick your
idea of dropping IO_ADDRESS() in .virtual field and use tightly aligned
virtual address for all peripherals.

Like: UART - 4K - 0xf0000000 - 0xf0001000
      SPI - 4K -  0xf0001000 - 0xf0002000

      ...

-- 
viresh
