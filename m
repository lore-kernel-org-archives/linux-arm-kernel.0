From: narmstrong@baylibre.com (Neil Armstrong)
Date: Fri, 17 Mar 2017 16:51:32 +0100
Subject: [PATCH 3/5] i2c: i2c-stm32f7: add driver
In-Reply-To: <CAOAejn0ScANyMEWnBfe0G8xQ5TbR-XYwEdXLkNexqC=AigBNJA@mail.gmail.com>
References: <1489744738-21632-1-git-send-email-cedric.madianga@gmail.com>
 <1489744738-21632-4-git-send-email-cedric.madianga@gmail.com>
 <6ae90186-0e8d-654b-c9e3-2d1b4daf6198@baylibre.com>
 <CAOAejn0Hs7QOgcrHM2t3NsFQeD9dyvThDK-8iM1Lvb7Qv4fGGQ@mail.gmail.com>
 <971895d3-2fe6-ecb6-9dc3-ee71193b34ee@baylibre.com>
 <CAOAejn0ScANyMEWnBfe0G8xQ5TbR-XYwEdXLkNexqC=AigBNJA@mail.gmail.com>
Message-ID: <5539f058-f2a1-ff78-6dd8-aa2119ce8c49@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Cedric,

On 03/17/2017 04:35 PM, M'boumba Cedric Madianga wrote:
>> Sorry I don't understand.
>> The value you use from the DT and the one calculated from the setup/hold/high/low value
>> with the algorithm I developed will set the same values.
> 
> With the ST tool, I could set the following values:
> I2C speed mode (Master, Fast Mode, Fast Mode Plus)
> I2C speed frequency
> I2C clock source frequency
> I2C rise time
> I2C fall time
> 
> The values set in the DT in this patchset is 0x40202537 for the
> following input values:
> I2C speed mode  = Master mode
> I2C speed frequency= 100 kHz
> I2C clock source frequency = 48 MHz
> I2C rise time = 25 ns
> I2C fall time = 10 ns
> 
> If I keep all the above values and just change I2C rise time with 100
> ns, I will have TIMINGR value at 0x10805E89
>
>>
>> The main difference is that you won't need the ST tool to calculate these, and even better
>> you can provide generic binding for whatever APB frequency the I2C peripheral is running
>> on.
> 
> As, I2C rise/fall time have some impacts in I2C timings value, the
> question is: it is very relevant to let customer control these
> parameters ?

Actually, you could specify a different rise time in DT if it's relevant for
a specific design, this is why you have the following DT attributes :
- i2c-scl-falling-time-ns
- i2c-scl-internal-delay-ns
- i2c-scl-rising-time-ns
- i2c-sda-falling-time-ns

> If the answer is NO, I agree with you, it is better to use your
> formula and remove this property from DT.
> If the answer is YES, I think we should keep ST tool.

Note that the ST tool calculations are tied to the clock source frequency, so either
you provide a table for all the possible clock source frequencies or calculate dynamically.
Having a single parameter for a single frequency is, from my point of view, not acceptable.

And, I don't think it's a military secret to have (at least) a simplified algorithm from ST...
since you have very detailed explanations in the public manuals !

> 
>> Having the STM32L4 running mainline won't be hard, maybe useless, but not hard.
>> My point is that you can somehow consider the STM32F0/F1/F4 I2C IP to be "v1" or "gen1",
>> and the L0/L4/F6 (and H7 ?) to be "v2" or "gen2" then prepend a generic compatible to
>> have something like :
>> compatible = "st,stm32-i2c-v2", "st,stm32f7-i2c"
> 
> This is not the strategy chosen by the company.
> They decided to push all driver with ip_name-stm32.c if the driver is
> common for all Soc.
> If it not the case, the suffix to be used is the name of the first
> supported SoC that introduced the IP in the mainline kernel.

OK, but I think the I2C and DT maintainers are also involved in these kind of decisions.
They should also give their advice.

Neil

> 
> BR,
> Cedric
> 
