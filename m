From: Chris.Packham@alliedtelesis.co.nz (Chris Packham)
Date: Mon, 17 Nov 2014 20:14:12 +0000
Subject: mvebu: tclk detection for armada-xp and marvell packet
 processor with integrated CPU
In-Reply-To: <20141117093437.0ca5a3ef@free-electrons.com>
References: <546959A3.9040206@alliedtelesis.co.nz>
 <20141117093437.0ca5a3ef@free-electrons.com>
Message-ID: <546A5714.2090100@alliedtelesis.co.nz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Thomas,

On 11/17/2014 09:34 PM, Thomas Petazzoni wrote:
> Dear Chris Packham,
>
> On Mon, 17 Nov 2014 02:12:51 +0000, Chris Packham wrote:
>
>> One of the first problems I encountered looking at the Marvell Packet
>> Processor with integrated CPU (I'll refer to that as 'the PP' throughout
>> the rest of this email) was that it has a different TCLK to the armada-xp.
>>
>> It appears that for both the PP and the armada-xp the TCLK is hard-coded
>> (to 200MHz and 250MHz respectively) and cannot be detected as far as I
>> can see from the various data-sheets. I was hoping to re-use
>> drivers/clk/mvebu/armada-xp.c but I need to figure out how to make
>> axp_get_tclk_freq() give me an appropriate answer depending on the SoC.
>> If this were in the mach-mvebu code I could just use mvebu_get_soc_id()
>> to fetch the device id. Is there an equivalent I could use in generic code?
>>
>> One option would be to use a different compatible string in the dts.
>> That would also give me a way of handling other differences (the
>> clock-gating is a subset of what's available on the armada-xp). How
>> different would things have to be before it's worth spinning the PP code
>> out into a file of it's own?
>
> To me, it indeed seems like you need a different compatible string
> here.

That's what I've done so far (patch to follow).

> Whether a separate file from drivers/clk/mvebu/armada-xp.c is
> needed or not will depend on whether only the tclk frequency differs,
> or whether also the ratios with other clocks differ.

Yeah I'm still trying to wrestle that information out of Marvell. What I 
do know is for the eval board I've got the armada register SAR (offset 
0x18230) is all zeros. I'm not sure if this is because everything really 
strapped low or because this register is unused on the PP.

The PP datasheet does have a table of differences with the armada. One 
of the major ones is the CPU frequency. The armada runs at up to 1.6GHz 
but the PP runs at up to 800MHz which probably does mean that 
axp_get_cpu_freq isn't giving the right answer.

I'm not sure how much this matters. For a packet processor with embedded 
CPU it's not like we need to support power management. The CPU is always 
on because it's always got something to do. We're not powering CPU 
peripherals to reduce power consumption, even if we did the power 
consumed by the packet processing side would eclipse any savings made by 
the CPU.

>
> Best regards,
>
> Thomas
>
