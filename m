From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Mon, 3 Oct 2016 10:13:25 +0300
Subject: [PATCH 6/6] ARM: da850: adjust memory settings for tilcdc
In-Reply-To: <948c3f9e-f11b-092c-e002-e2ef4436197f@ti.com>
References: <1475166715-7857-1-git-send-email-bgolaszewski@baylibre.com>
 <1475166715-7857-7-git-send-email-bgolaszewski@baylibre.com>
 <4e089d20-d00f-ff54-7c54-85aa061e23c2@ti.com>
 <CAMpxmJXafyT5G8ZyD8RBAtzD6R9HmvyS0NBpz5i2fJ0SwOhXBA@mail.gmail.com>
 <91db8934-bfd6-8fc4-74e3-4844ef3bd3e7@ti.com>
 <948c3f9e-f11b-092c-e002-e2ef4436197f@ti.com>
Message-ID: <0125defa-5c34-85d0-f62a-133235c5094c@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/01/16 12:24, Sekhar Nori wrote:
>> That's good to hear, but I think the priorities should be set:
>> LCDC and EDMA30TC1 to highest priority
>> EDMA30TC0 to priority 2
>>
>> The 0TC0 is used by MMC and if you want to play a video you might need the
>> servicing TC to be higher priority then other masters.
>>
>> If audio playback would trigger sync losts in lcdc then we might need to move
>> 0TC1 to priority 1.
>>
>> I agree that LCDC priority needs to be higher, but I do wonder why the default
>> (5) is not working and if it is not working why it is 5...
>>
>> My guess is that the change in the PBBPR register is the one actually helping
>> here.
> 
> Good point, Peter. If you are booting off NFS and not playing any audio,
> then there is pretty much no EDMA generated traffic on the interconnect.

Yes, this is my understanding as well.

> I would guess too that its the PBBPR setting that is making a
> difference. The EDMA vs LCDC priority adjustment might be needed in
> particular situations too, but specific experiments should be done to
> narrow down on that being the cause.

True, we can use some conservative values for the priority, but the PBBPR
register for sure needs to be updated.

> In any case, to configure the PBBR, you will have to introduce a driver
> for it in drivers/memory. Then you can set it up per board using a DT
> parameter.

and we can reuse the introduced bindings for am335x and OMAP1/2 as well. On
OMAP the legacy DMA API provided a call to raise the priority of the sDMA in
EMIF :o That needs to be removed and replaced.

-- 
P?ter
