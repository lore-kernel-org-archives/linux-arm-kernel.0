From: michal.simek@xilinx.com (Michal Simek)
Date: Wed, 24 May 2017 15:06:13 +0200
Subject: [PATCH 1/1] xilinx ps uart: Adding a kernel parameter for the
 number of xilinx ps uarts
In-Reply-To: <20170523210710.4e84dd2d@alans-desktop>
References: <20170520022154.6766-1-kernel.development@povil.us>
 <20170520172008.5a979e8a@alans-desktop>
 <517d864d-d230-3abc-eb3c-4b628dc4625f@xilinx.com>
 <20170522192636.5b578d89@alans-desktop>
 <1668f36e-f9be-7008-004a-e467a6813e0f@xilinx.com>
 <20170523210710.4e84dd2d@alans-desktop>
Message-ID: <924433a1-7e27-6eb6-71ca-ed7baceb427f@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 23.5.2017 22:07, Alan Cox wrote:
>> yep hardcoded max 4 where in probe first free space is found and used
>> (range 0-3) but still max3100s statically allocated.
>> Shouldn't be this also dynamically allocated?
> 
> The code to do the dynamic allocation would be larger than the array of
> pointers for the sane worst case.
> 
>> I am not quite sure how exactly you want to do this via DT.
> 
> Count the number of DT entries for this kind of port and allocate that
> many ?

:-) I think there is no doubt how to calculate that number for
static/fixed system. But where do you want to put it? And who should
read it?

A lot of drivers are calling uart_register_driver in module_init.
Others are calling it in probe(pl011 for example).

In module init you probably don't have a pointer to DT to read this and
this should be in generic location not in node itself.
If all drivers should call it from probe then we should change that -
then reading property is easy and only location should be cleared.

That's why I am curious how exactly you would do it because I haven't
seen this before.

> 
>>
>> Also what do you think is a safe maximum number? This is fpga - hundreds
>> of pins which can do just uart.
>>
>>> There are lots of options better than breaking the "one kernel many
>>> platforms" model.  
>>
>> Another options is also module parameter and dynamically allocated array
>> in cdns_uart_init.
> 
> For a given platform the number is constant and they need to be
> described, so it seems to make no sense to put it anywhere other than the
> DT for that platform.

Also I don't think this is really constant in all cases. Especially in
connection to fpga where you can put others IPs to PL. You never know
what it is present in partial region and how many of these are there.
It means having truly dynamic behavior would be welcome.

Can you call uart_register_driver() from probe for every instance? It
means nr is 1 all the time.

> 
> Why should users have to pass magic config options not use DT as
> intended ?

I am not saying that config option is perfect solution. It is at least
aligned with 5 others serial drivers in the tree.

Thanks,
Michal
