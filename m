From: marc_gonzalez@sigmadesigns.com (Marc Gonzalez)
Date: Wed, 1 Nov 2017 20:03:20 +0100
Subject: [RFC] Improving udelay/ndelay on platforms where that is possible
In-Reply-To: <20171101175325.2557ce85@alans-desktop>
References: <d3f42f35-8175-58f6-78b7-3331efe64da2@sigmadesigns.com>
 <20171101175325.2557ce85@alans-desktop>
Message-ID: <4b707ce0-6067-ab36-e167-1acf348d26bf@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/11/2017 18:53, Alan Cox wrote:

> On Tue, 31 Oct 2017 17:15:34 +0100
>
>> Therefore, users are accustomed to having delays be longer (within a reasonable margin).
>> However, very few users would expect delays to be *shorter* than requested.
> 
> If your udelay can be under by 10% then just bump the number by 10%.

Except it's not *quite* that simple.
Error has both an absolute and a relative component.
So the actual value matters, and it's not always a constant.

For example:
http://elixir.free-electrons.com/linux/latest/source/drivers/mtd/nand/nand_base.c#L814

> However at that level most hardware isn't that predictable anyway because
> the fabric between the CPU core and the device isn't some clunky
> serialized link. Writes get delayed, they can bunch together, busses do
> posting and queueing.

Are you talking about the actual delay operation, or the pokes around it?

> Then there is virtualisation 8)
> 
>> A typical driver writer has some HW spec in front of them, which e.g. states:
>>
>> * poke register A
>> * wait 1 microsecond for the dust to settle
>> * poke register B
> 
> Rarely because of posting. It's usually
> 
> 	write
> 	while(read() != READY);
> 	write
> 
> and even when you've got a legacy device with timeouts its
> 
> 	write
> 	read
> 	delay
> 	write
> 
> and for sub 1ms delays I suspect the read and bus latency actually add a
> randomization sufficient that it's not much of an optimization to worry
> about an accurate ndelay().

I don't think "accurate" is the proper term.
Over-delays are fine, under-delays are problematic.

>> This "off-by-one" error is systematic over the entire range of allowed
>> delay_us input (1 to 2000), so it is easy to fix, by adding 1 to the result.
> 
> And that + 1 might be worth adding but really there isn't a lot of
> modern hardware that has a bus that behaves like software folks imagine
> and everything has percentage errors factored into published numbers.

I guess I'm a software folk, but the designer of the system bus sits
across my desk, and we do talk often.

>> 3) Why does all this even matter?
>>
>> At boot, the NAND framework scans the NAND chips for bad blocks;
>> this operation generates approximately 10^5 calls to ndelay(100);
>> which cause a 100 ms delay, because ndelay is implemented as a
>> call to the nearest udelay (rounded up).
> 
> So why aren't you doing that on both NANDs in parallel and asynchronous
> to other parts of boot ? If you start scanning at early boot time do you
> need the bad block list before mounting / - or are you stuck with a
> single threaded CPU and PIO ?

There might be some low(ish) hanging fruit to improve the performance
of the NAND framework, such as multi-page reads/writes. But the NAND
controller on my SoC muxes access to the two NAND chips, so no parallel
access, and this requires PIO.

> For that matter given the bad blocks don't randomly change why not cache
> them ?

That's a good question, I'll ask the NAND framework maintainer.
Store them where, by the way? On the NAND chip itself?

>> My current NAND chips are tiny (2 x 512 MB) but with larger chips,
>> the number of calls to ndelay would climb to 10^6 and the delay
>> increase to 1 second, with is starting to be a problem.
>>
>> One solution is to implement ndelay, but ndelay is more prone to
>> under-delays, and thus a prerequisite is fixing under-delays.
> 
> For ndelay you probably have to make it platform specific or just use
> udelay if not. We do have a few cases we wanted 400ns delays in the PC
> world (ATA) but not many.

By default, ndelay is implemented in terms of udelay.

Regards.
