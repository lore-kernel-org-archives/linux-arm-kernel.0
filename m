From: nsekhar@ti.com (Sekhar Nori)
Date: Sat, 1 Oct 2016 14:54:07 +0530
Subject: [PATCH 6/6] ARM: da850: adjust memory settings for tilcdc
In-Reply-To: <91db8934-bfd6-8fc4-74e3-4844ef3bd3e7@ti.com>
References: <1475166715-7857-1-git-send-email-bgolaszewski@baylibre.com>
 <1475166715-7857-7-git-send-email-bgolaszewski@baylibre.com>
 <4e089d20-d00f-ff54-7c54-85aa061e23c2@ti.com>
 <CAMpxmJXafyT5G8ZyD8RBAtzD6R9HmvyS0NBpz5i2fJ0SwOhXBA@mail.gmail.com>
 <91db8934-bfd6-8fc4-74e3-4844ef3bd3e7@ti.com>
Message-ID: <948c3f9e-f11b-092c-e002-e2ef4436197f@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday 01 October 2016 12:49 AM, Peter Ujfalusi wrote:
> On 09/30/2016 06:06 PM, Bartosz Golaszewski wrote:
>> 2016-09-30 14:59 GMT+02:00 Peter Ujfalusi <peter.ujfalusi@ti.com>:
>>> On 09/29/16 19:31, Bartosz Golaszewski wrote:
>>>> Default memory settings of da850 do not meet the throughput/latency
>>>> requirements of tilcdc. This results in the image displayed being
>>>> incorrect and the following warning being displayed by the LCDC
>>>> drm driver:
>>>>
>>>>   tilcdc da8xx_lcdc.0: tilcdc_crtc_irq(0x00000020): FIFO underfow
>>>>
>>>> Reconfigure the LCDC priority to the highest. This is a workaround
>>>> for the da850-lcdk board which has the LCD controller enabled in
>>>> the device tree, but a long-term, system-wide fix is needed for
>>>> all davinci boards.
>>>>
>>>> This patch has been modified for mainline linux. It comes from a
>>>> downstream TI release for da850[1].
>>>>
>>>> Original author: Vishwanathrao Badarkhe, Manish <manishv.b@ti.com>
>>>>
>>
>> [snip]
>>
>>>
>>> Is this safe to do for all da850 boards (to change PR_OLD_COUNT from 0xff to
>>> 0x20)? Most probably it is, but this setting has nothing to do with LCDC.
>>>
>>> The whole priority configuration has nothing to do with the LCDC, it is a
>>> system level priority.
>>>
>>> Now you have lowered the eDMA3_0-TPTC0/1 priority. Audio is serviced by
>>> eDMA3_0-TPTC1. So are we going to see issues in audio if LCDC is taking the
>>> highest priority?
>>>
>>
>> Just ran a quick test with speaker-test -c2 -twav. Besides the fact
>> that the left and right channels are inverted (I'm looking into that),
>> I didn't notice any problems. Even at 1024x768 resolution, playing
>> audio at the same time seems to work fine.
> 
> That's good to hear, but I think the priorities should be set:
> LCDC and EDMA30TC1 to highest priority
> EDMA30TC0 to priority 2
> 
> The 0TC0 is used by MMC and if you want to play a video you might need the
> servicing TC to be higher priority then other masters.
> 
> If audio playback would trigger sync losts in lcdc then we might need to move
> 0TC1 to priority 1.
> 
> I agree that LCDC priority needs to be higher, but I do wonder why the default
> (5) is not working and if it is not working why it is 5...
> 
> My guess is that the change in the PBBPR register is the one actually helping
> here.

Good point, Peter. If you are booting off NFS and not playing any audio,
then there is pretty much no EDMA generated traffic on the interconnect.

I would guess too that its the PBBPR setting that is making a
difference. The EDMA vs LCDC priority adjustment might be needed in
particular situations too, but specific experiments should be done to
narrow down on that being the cause.

In any case, to configure the PBBR, you will have to introduce a driver
for it in drivers/memory. Then you can set it up per board using a DT
parameter.

Thanks,
Sekhar
