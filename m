From: nsekhar@ti.com (Sekhar Nori)
Date: Thu, 6 Oct 2016 23:27:02 +0530
Subject: [PATCH 6/6] ARM: da850: adjust memory settings for tilcdc
In-Reply-To: <eff0e150-e8d2-3859-1abe-c5f70f576fad@ti.com>
References: <1475166715-7857-1-git-send-email-bgolaszewski@baylibre.com>
 <1475166715-7857-7-git-send-email-bgolaszewski@baylibre.com>
 <4e089d20-d00f-ff54-7c54-85aa061e23c2@ti.com>
 <CAMpxmJXafyT5G8ZyD8RBAtzD6R9HmvyS0NBpz5i2fJ0SwOhXBA@mail.gmail.com>
 <91db8934-bfd6-8fc4-74e3-4844ef3bd3e7@ti.com>
 <948c3f9e-f11b-092c-e002-e2ef4436197f@ti.com>
 <0125defa-5c34-85d0-f62a-133235c5094c@ti.com> <7hvax8ferr.fsf@baylibre.com>
 <eff0e150-e8d2-3859-1abe-c5f70f576fad@ti.com>
Message-ID: <3dfc112b-ba14-6c49-b707-730cfc3dae97@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 05 October 2016 01:52 PM, Peter Ujfalusi wrote:
> On 10/04/16 16:02, Kevin Hilman wrote:
>> Peter Ujfalusi <peter.ujfalusi@ti.com> writes:
>>
>>> On 10/01/16 12:24, Sekhar Nori wrote:
>>
>> [...]
>>
>>>> In any case, to configure the PBBR, you will have to introduce a driver
>>>> for it in drivers/memory. Then you can set it up per board using a DT
>>>> parameter.
>>>
>>> and we can reuse the introduced bindings for am335x and OMAP1/2 as well. On
>>> OMAP the legacy DMA API provided a call to raise the priority of the sDMA in
>>> EMIF :o That needs to be removed and replaced.
>>
>> Can you point us to the bindings you're referring to?
> 
> We don't have one atm.
> 
> And the DMA priority hack in legacy sDMA code is for OMAP1:
> omap_set_dma_priority(). Basically it can change the sDMA priority in
> OCPT1_PRIOR, OCPT2_PRIOR, EMIFF_PRIOR and EMIFS_PRIOR registers.
> 
>> Also, a new driver in drivers/memory is fine for setting the PBBR, but
>> what about the SYSCFG0 registers.  Are you OK with leaving those in the
>> init code as proposed in $SUBJECT patch?
> 
> My problem is - as I described it in reply to Bartosz - is that for example I
> don't want the LCDC to get high priority on OMAP-L138 EVM from Logic as it
> does not have LCD/VGA by default. ifdef for LCDC is not good either since my
> kernel have LCDC compiled in, but it is disabled.
> 
> The easiest way would be to have pdata quirk to handle the LCDK until we have
> proper handling of the priority configuration.

We don't have pdata quirks handling in mach-davinci. And I think instead
of investing time in adding pdata quirks which are anyway a short term
solution, it is better to work on a drivers/bus/ based driver which can
help adjust master priorities via DT.

Although as Peter asked, it is indeed intriguing as to why LCDC priority
has to be raised even in supposed absence of any competing traffic.

Thanks,
Sekhar
