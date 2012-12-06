From: jon-hunter@ti.com (Jon Hunter)
Date: Thu, 6 Dec 2012 12:11:02 -0600
Subject: [PATCH v7 5/5] ARM: OMAP: gpmc: add DT bindings for GPMC timings
 and NAND
In-Reply-To: <50C0CDB0.5050008@gmail.com>
References: <1354734571-10774-1-git-send-email-zonque@gmail.com>
 <1354734571-10774-6-git-send-email-zonque@gmail.com>
 <20121205222232.67B2B3E0E22@localhost> <50BFCBCC.6030706@ti.com>
 <20121205232426.BAD573E0E22@localhost> <20121206000302.GM21682@atomide.com>
 <50C0C646.9000802@ti.com> <50C0CDB0.5050008@gmail.com>
Message-ID: <50C0DFB6.9060501@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On 12/06/2012 10:54 AM, Daniel Mack wrote:
> On 06.12.2012 17:22, Jon Hunter wrote:
>>
>> On 12/05/2012 06:03 PM, Tony Lindgren wrote:
>>> * Grant Likely <grant.likely@secretlab.ca> [121205 15:26]:
>>>> On Wed, 5 Dec 2012 16:33:48 -0600, Jon Hunter <jon-hunter@ti.com> wrote:
>>>>> On 12/05/2012 04:22 PM, Grant Likely wrote:
>>>>>>
>>>>>> Please, be specific. Use something like "ti,am3340-gpmc" or
>>>>>> "ti,omap3430-gpmc". The compatible property is a list so that new
>>>>>> devices can claim compatibility with old. Compatible strings that are
>>>>>> overly generic are a pet-peave of mine.
>>>>>
>>>>> We aim to use the binding for omap2,3,4,5 as well as the am33xx devices
>>>>> (which are omap based). Would it be sufficient to have "ti,omap2-gpmc"
>>>>> implying all omap2+ based devices or should we have a compatible string
>>>>> for each device supported?
>>>>
>>>> Are they each register-level compatible with one another?
>>>>
>>>> The general recommended approach here is to make subsequent silicon
>>>> claim compatibility with the first compatible implementation.
>>>>
>>>> So, for an am3358 board:
>>>> 	compatible = "ti,am3358-gpmc", "ti,omap2420-gpmc";
>>>>
>>>> Essentially, what this means is that "ti,omap2420-gpmc" is the generic
>>>> value instead of "omap2-gpmc". The reason for this is so that the value
>>>> is anchored against a specific implementation, and not against something
>>>> completely imaginary or idealized. If a newer version isn't quite
>>>> compatible with the omap2420-gpmc, then it can drop the compatible claim
>>>> and the driver really should be told about the new device.
>>>
>>> The compatible property can also be used to figure out which ones
>>> need the workarounds in patch #4 of this series for the DT case.
>>> So we should be specific with the compatible.
>>
>> We should not merged patch #4. Daniel included this here because he is
>> using this on the current mainline, however, this is not needed for
>> linux-next and so we should drop it.
> 
> I think we're talking about different things here since awhile.
> 
> The patch I pointed you which is in mainline and which removes the
> reference to <plat/gpmc.h> from drivers/mtd/nand/omap2.c has nothing to
> do with my patch #4. It just solves Tony's concern that regarding the
> multi-arch zImages.
>
> My code in gpmc.c calls gpmc_nand_init() which in turn calls
> gpmc_hwecc_bch_capable(). Without path #4, gpmc_hwecc_bch_capable() will
> return 0, and the nand init will fail consequently, in mainline as well
> as in linux-next.

Ok, yes I see that now. I should have looked more closely at linux-next.

> I understood Tony that he wanted to remove the entiry function and do
> the check based on DT properties, which will then solve the problem on a
> different level. However, that change is planned for *after* the merge
> window.

Well now that it is only being called from within the platform code and
not from drivers, it is ok.

Cheers
Jon
