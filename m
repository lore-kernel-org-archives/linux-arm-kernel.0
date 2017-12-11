From: HartleyS@visionengravers.com (Hartley Sweeten)
Date: Mon, 11 Dec 2017 22:28:12 +0000
Subject: [PATCH v4 5/5] ARM: ep93xx: ts72xx: Add support for BK3 board -
 ts72xx derivative
In-Reply-To: <20171211223941.744be82f@jawa>
References: <20171116232239.16823-1-lukma@denx.de>
 <20171130235140.12243-1-lukma@denx.de>	<20171130235140.12243-6-lukma@denx.de>
 <SN1PR0101MB156532C13ABBAE280B3754CED0370@SN1PR0101MB1565.prod.exchangelabs.com>
 <20171211223941.744be82f@jawa>
Message-ID: <SN1PR0101MB156535B0FBBAF51FE274F0A7D0370@SN1PR0101MB1565.prod.exchangelabs.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday, December 11, 2017 2:40 PM, Lukasz Majewski wrote:
> Hi Hartley,
>
>> On Thursday, November 30, 2017 4:52 PM, Lukasz Majewski wrote:
>>>
>>> The BK3 board is a derivative of the ts72xx reference design.  
>> 
>> Lukasz,
>> 
>> I was just reviewing the other TS-72xx boards and noticed this:
>> 
>> <snip>
>> 
>>> +/* BK3 specific defines */
>>> +#define BK3_CPLDVER_PHYS_BASE		0x23400000
>>> +#define BK3_CPLDVER_VIRT_BASE		0xfebfd000
>>> +#define BK3_CPLDVER_SIZE		0x00001000
>>> +  
>> 
>> <snip>
>> 
>>> +static struct map_desc bk3_io_desc[] __initdata = {
>>> +	{
>>> +		.virtual	= BK3_CPLDVER_VIRT_BASE,
>>> +		.pfn		=
>>> __phys_to_pfn(BK3_CPLDVER_PHYS_BASE),
>>> +		.length	= BK3_CPLDVER_SIZE,
>>> +		.type		= MT_DEVICE,
>>> +	}
>>> +};
>>> +  
>> 
>> This register appears to be common to all the TS-72xx boards.
>
> The CPLD was used on the reference ts-72xx boards, but support for it seems
> to not be present in the mainline kernel.

The CPLD is not directly called out but some parts of it are supported in the mainline
kernel.

The RTC index and data registers are chip selected by the CPLD and Watchdog is in
the CPLD. Also, the model number, options, and options2 registers are in the CPLD.

There are a couple other registers in the CPLD that are not currently present in
mainline. Some aren't because I haven't figured a good way to utilize them (the
COM2 RS485 registers and the PC/104 memory/IO spaces) or they simply have not
been necessary yet (the two status registers). There are a couple listed in the manuals
that are specific to the TS-7260 that also have not been added.

Basically, anything in the EP93xx CS1 or CS2 memory region is in or controlled by the CPLD.

> Do you have a ts72xx board with CPLD embedded? Is any of your design using it?

I have a stock TS-7300 board.

> My another concern - is it safe to perform IO mapping on memory regions which are
> not used / specified?

The mapping is safe. If there is nothing at the address you just read back the static state
(noise) of the bus and writing doesn't do anything.

>  When I do a single ts72xx mapping - for all boards - then we may end up with some
> mappings which are not needed.

True, but it's harmless and it keeps the platform init code cleaner.

> With the code as it is - I only map regions which are already used on relevant boards.

Yes, but this register in particular exists in the CPLD on all the TS-72xx boards.

>> I don't think Arnd has pulled the series yet. Would you mind renaming 
>> the defines and rebasing this patch?
>
> If needed I can resend the patch series, or prepare a single fix patch.
> No problem.

Fixing it after Arnd merges your series is fine. I just wanted to make sure it was
pointed out.

BTW, is there a reason the BK3 board needs this register mapped? It was mapped
in the Technologic Systems 2.4, 2.6, and 3.x kernels but I never found anything that
used it. Of course the stock boards probably always had the same revision in the CPLD,
the BK3 board might have multiple revisions...

Hartley
