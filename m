From: Chris.Packham@alliedtelesis.co.nz (Chris Packham)
Date: Thu, 20 Nov 2014 21:14:56 +0000
Subject: [RFC PATCH] clk: mvebu: armada-xp: Support for MSYS SoC
In-Reply-To: <20141120155630.743ee6de@free-electrons.com>
References: <1416459679-30944-1-git-send-email-chris.packham@alliedtelesis.co.nz>
 <20141120155630.743ee6de@free-electrons.com>
Message-ID: <546E59D0.7000706@alliedtelesis.co.nz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 11/21/2014 03:56 AM, Thomas Petazzoni wrote:
> Dear Chris Packham,
>
> On Thu, 20 Nov 2014 18:01:19 +1300, Chris Packham wrote:
>> The MSYS SoCs are a range of packet processors with integrated CPUs based
>> on armada-xp. One difference is that the TCLK frequency is fixed at 200MHz
>> as opposed to the fixed 250MHz used on armada-xp. The clock-gating options
>> are a subset of what's available on the armada-xp so this code should be
>> compatible.
>
> Well, if you have only a subset of what's available, then I would also
> suggest to introduce a separate compatible string for the gatable
> clocks.

I could do that. Based on the datasheet I thought it would be 
unnecessary because the other bits are ignored on write. As Andrew has 
said for the 98DX4122 the peripherals that aren't present are just not 
listed, which would be the same for msys (or 98DX4251 or whatever we end 
up calling it).

>
>> This patch is enough to get the uart clock dividers correct so I get some
>> output. As far as I've been able to tell there is no way of dynamically
>> detecting the TCLK frequency.
>>
>> The core clock frequency and ratio calculations are probably not correct but
>> for these CPU inside a packet processor systems I'm not sure how much that
>> actually matter since these systems aren't likely to do any kind of dynamic
>> frequency scaling.
>
> Knowing the frequency is not only about dynamic frequency scaling. Some
> drivers (i2c, spi, probably sdio) use the input clock frequency, look
> at the requested output frequency, and calculate some dividers to reach
> the desired output frequency from the input frequency. If your input
> frequency is wrong, then your divider calculation will be wrong, and
> therefore your output frequency will be wrong. This could lead to
> having an incorrect I2C or SPI bus frequency, for example. As you can
> see, nothing to do with dynamic frequency scaling.
>
> But indeed, those concerns are more around peripheral clocks, which
> normally derive from tclk. Still, it'd be better to not have the core
> clocks defined at all rather than having incorrect core clock
> frequencies.

As you say most of the peripherals use the TCLK as an input to their 
dividers. That's the thing that needs to be correct. I must admit I 
don't really understand how get_cpu_freq() is actually used (I 
incorrectly guessed frequency scaling). My system seems to be happy 
(depending on your definition of happy) with whatever information it's 
getting.

As an alternative what about making the TCLK frequency something 
configurable by the dts? That way it could default to 250MHz but be 
overridden if a chip has a different frequency (in lieu of some way of 
actually detecting it).

>
> Best regards,
>
> Thomas
>
