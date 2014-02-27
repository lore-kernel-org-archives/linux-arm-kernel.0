From: florian.vaussard@epfl.ch (Florian Vaussard)
Date: Thu, 27 Feb 2014 16:24:15 +0100
Subject: TWL6040 fails to initialize
In-Reply-To: <530F29ED.9020706@ti.com>
References: <530C70B3.4010103@epfl.ch> <530CA8DA.8050806@ti.com>
 <530CB9C6.60806@epfl.ch> <530D972F.805@ti.com> <530DB97E.80309@epfl.ch>
 <530DC1D3.8040800@ti.com> <530DC291.2060708@epfl.ch>
 <530F29ED.9020706@ti.com>
Message-ID: <530F589F.5060503@epfl.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On 02/27/2014 01:05 PM, Peter Ujfalusi wrote:
> On 02/26/2014 12:31 PM, Florian Vaussard wrote:
>>>> I statistically checked that the sleep should be placed after the GPIO
>>>> request, so indeed this seems to be the problem, and your explanation is
>>>> plausible. Can you send a proper patch?
>>>>
>>>> Now, related to this, I managed to found a part of the datasheet on the
>>>> Great Internet. Looking at the "Power-Up Sequence" section, it is written:
>>>>
>>>> - NRESPWRON goes high -> plug detect and GPO are available
>>>> - V2V1 goes high -> hook-detect available by I2C programming (sleep mode)
>>>> - AUDPWRON goes high && READYINT -> ready to communicate through I2C and PDM
>>>>
>>>> So, although there seems to be some contradictions on when it is
>>>> possible to access the I2C, shouldn't we enable the AUDPWRON GPIO
>>>> _before_ making any I2C access?
>>>>
>>>> For the twl6040_probe, the following path would seem more correct to me:
>>>>
>>>> 1) enable regulators
>>>> 2) request AUDPWRON
>>>> 3) twl6040_power(ON) && regcache_cache_only(false)
>>>> 4) wait for READYINT (or sleep if deterministic)
>>>> 5) perform all required I2C accesses (read revision, etc.)
>>>> 6) twl6040_power(OFF) && regcache_cache_only(true)
>>>>
>>>> What do you think?
>>>
>>> Even when the AUDPWRON signal is low we can access to registers in VIO domain,
>>> plug detect and GPO functions. So there's no need to power on the codec just
>>> to power it down later.
>>>
>>
>> Ok, if it is safe to do so, I am fine with the current probe. I let you
>> post a patch to add a delay after requesting the GPIO.
> 
> 
> There's something else going on on your board.
> I did some experiments on PandaBoards: in u-boot I set the GPIO127 (audpwron)
> high and boot the kernel.
> During the boot I see all sorts of errors, mcpdm fails to reset, i2c timeouts
> towards twl6040.
> For this the solution is to read the INTID register just after I request the
> gpio - to clear any no longer valid interrupts before we request the IRQ. This
> works fine on my boards.
> 

As I said in the other thread, reading INTID is solving the issue, but
it could be a side effect.

> The issue you have with your board is something totally different.
> One thing might be that the i2c bus is set to 400KHz while the twl6040 by
> default is set for normal mode (100KHz). On all of the boards I have access
> this works fine but there might be some electrical issue on your board which
> causes i2c to fail.
> 

I should probe the I2C bus to dig the issue further, but I don't have
access to the pins. So apart drilling into the PCB, this will remain a
kind of mystery.

Your patches are somehow solving this, so I will stop my investigations
for now.

> There's also another thing I just noticed: the regmap patch
> regmap_register_patch() when it is applied will not update the regcache by
> design. I do not like that too much. On the other hand it is handy to set the
> ACCCTL register as early as possible.
> 
> So, I'm not sure about the delay and why it helps on your board.
> 

Not sure neither.

Thanks for your help on this.

Regards,
Florian
