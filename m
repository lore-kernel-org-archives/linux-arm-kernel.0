From: giulio.benetti@micronovasrl.com (Giulio Benetti)
Date: Sat, 27 Jan 2018 23:07:09 +0100
Subject: [PATCH 2/2] drm/sun4i: Handle DRM_MODE_FLAG_**SYNC_POSITIVE
 correctly
In-Reply-To: <18ec71dc-a785-a771-76d4-176d95032c97@micronovasrl.com>
References: <1516474221-114596-1-git-send-email-giulio.benetti@micronovasrl.com>
 <1516474221-114596-2-git-send-email-giulio.benetti@micronovasrl.com>
 <20180122085112.7xo2t3x5ag4k2kpl@flea.lan>
 <aa724bd5-cfb1-128c-af32-db29253f32aa@micronovasrl.com>
 <59f7b542-3b1d-ff62-e290-37c47f4075ff@micronovasrl.com>
 <9929d894-53c3-a7e9-a328-a00cfc1ef546@micronovasrl.com>
 <20180125152117.qikemrwl7f35ssjg@flea.lan>
 <d79602b9-8e04-8250-fd7f-f52b8e16c575@micronovasrl.com>
 <20180126145608.5s6c6ltpvrko7iyv@flea.lan>
 <18ec71dc-a785-a771-76d4-176d95032c97@micronovasrl.com>
Message-ID: <e3a8682c-7524-ee99-8d4f-c492709e6e49@micronovasrl.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Il 26/01/2018 16:55, Giulio Benetti ha scritto:
> Hi,
> 
> Il 26/01/2018 15:56, Maxime Ripard ha scritto:
>> On Thu, Jan 25, 2018 at 05:50:18PM +0100, Giulio Benetti wrote:
>>>>>>>> On Sat, Jan 20, 2018 at 07:50:21PM +0100, Giulio Benetti wrote:
>>>>>>>>> On previous handling, if specified DRM_MODE_FLAG_N*SYNC,
>>>>>>>>> it was ignored,
>>>>>>>>> because only PHSYNC and PVSYNC were taken into account.
>>>>>>>>> DRM_MODE_FLAG_P*SYNC and DRM_MODE_FLAG_N*SYNC are not exclusive.
>>>>>>>>>
>>>>>>>>> If flags contains PVSYNC, it doesn't mean it is NVSYNC.
>>>>>>>>> And it's true also the contrary.
>>>>>>>>> Also, as I've checked with scope on A20,
>>>>>>>>> if (flags & PVSYNC) then SUN4I_TCON0_IO_POL_VSYNC_POSITIVE
>>>>>>>>> must be set, as name suggests.
>>>>>>>>> It seems all display io polarities starts inverted if 0.
>>>>>>>>>
>>>>>>>>> Signed-off-by: Giulio Benetti <giulio.benetti@micronovasrl.com>
>>>>>>>>>
>>>>>>>>> PVSYNC and PHSYNC only
>>>>>>>>>
>>>>>>>>> Signed-off-by: Giulio Benetti <giulio.benetti@micronovasrl.com>
>>>>>>>>
>>>>>>>> Checkpatch:
>>>>>>>> WARNING: Duplicate signature
>>>>>>>
>>>>>>> Sorry I didn't use ./scripts/checkpatch.pl
>>>>>>>
>>>>>>>>
>>>>>>>>> ---
>>>>>>>>> ? ? drivers/gpu/drm/sun4i/sun4i_tcon.c | 4 ++--
>>>>>>>>> ? ? 1 file changed, 2 insertions(+), 2 deletions(-)
>>>>>>>>>
>>>>>>>>> diff --git a/drivers/gpu/drm/sun4i/sun4i_tcon.c
>>>>>>>>> b/drivers/gpu/drm/sun4i/sun4i_tcon.c
>>>>>>>>> index 6121210..e873a37 100644
>>>>>>>>> --- a/drivers/gpu/drm/sun4i/sun4i_tcon.c
>>>>>>>>> +++ b/drivers/gpu/drm/sun4i/sun4i_tcon.c
>>>>>>>>> @@ -224,10 +224,10 @@ static void
>>>>>>>>> sun4i_tcon0_mode_set_rgb(struct sun4i_tcon *tcon,
>>>>>>>>> ? ?????????????? SUN4I_TCON0_BASIC3_H_SYNC(hsync));
>>>>>>>>> ? ????? /* Setup the polarity of the various signals */
>>>>>>>>> -??? if (!(mode->flags & DRM_MODE_FLAG_PHSYNC))
>>>>>>>>> +??? if (mode->flags & DRM_MODE_FLAG_PHSYNC)
>>>>>>>>> ? ????????? val |= SUN4I_TCON0_IO_POL_HSYNC_POSITIVE;
>>>>>>>>> -??? if (!(mode->flags & DRM_MODE_FLAG_PVSYNC))
>>>>>>>>> +??? if (mode->flags & DRM_MODE_FLAG_PVSYNC)
>>>>>>>>> ? ????????? val |= SUN4I_TCON0_IO_POL_VSYNC_POSITIVE;
>>>>>>>>
>>>>>>>> I'm not sure why you were talking of the differences between NVSYNC
>>>>>>>> and PVSYNC if you're not making use of any of it here?
>>>>>>>
>>>>>>> Thinking about it more now, the point is that all Lcd IOs seem to be
>>>>>>> inverted by default(at least on A20).
>>>>>>> With inverted, I mean that if for example PVSYNC,
>>>>>>> I should see vsync line low and when asserted to give VSync,
>>>>>>> it goes high.
>>>>>>> This is what I've checked with oscilloscope on A20.
>>>>>>> Can someone give a try on A33? Otherwise I will,
>>>>>>> but I will take some time.
>>>>>>> On uboot, everything is treated equal to kernel,
>>>>>>> but to have my falling edge dclk and low h/vsync I had to specify:
>>>>>>> CONFIG_VIDEO_LCD_DCLK_PHASE=0 (giving me falling edge on dclk)
>>>>>>> and
>>>>>>> CONFIG_VIDEO_LCD_MODE="....,sync:3,..."
>>>>>>> but digging into code, I see "sync:3" means H/VSYNC HIGH,
>>>>>>> but I experience both LOW during their pulse.
>>>>>>>
>>>>>>>>
>>>>>>>> Also, how was it tested? This seems quite weird that we haven't 
>>>>>>>> caught
>>>>>>>> that one sooner, and I'm a bit worried about the possible 
>>>>>>>> regressions
>>>>>>>> here.
>>>>>>>
>>>>>>> It sounds really strange to me too,
>>>>>>> because everybody under uboot use "sync:3"(HIGH).
>>>>>>> I will retry to measure,
>>>>>>> unfortunately at home I don't have a scope,
>>>>>>> but I think I'm going to have one soon, because of this. :)
>>>>>>
>>>>>> Here I am with scope captures and tcon0 registers dump:
>>>>>> tcon0_regs => https://pasteboard.co/H4r8Zcs.png
>>>>>> dclk_d0 => https://pasteboard.co/H4r8QRe.png
>>>>>> dclk_de => https://pasteboard.co/H4r8zh4R.png
>>>>>> dclk_vsnc => https://pasteboard.co/H4r8Hye.png
>>>>>>
>>>>>> As you can see circled in reg on registers,
>>>>>> TCON0_IO_POL_REG = 0x00000000.
>>>>>> But on all the waveforms you can see:
>>>>>> - dclk_d0: clock phase is 0, but it starts with falling edge, 
>>>>>> otherwise
>>>>>> the rising front overlaps dclk rising edge(not good), so to me 
>>>>>> this is
>>>>>> falling, then I mean it Negative.
>>>>>> - dclk_de: de pulse is clearly negative, even if register is 0 and 
>>>>>> its'
>>>>>> polarity bit is 0.
>>>>>> - dclk_vsnc: same as dclk_de
>>>>>> - dclk_hsync: I didn't take scope screenshot but I can assure you 
>>>>>> it's
>>>>>> negative.
>>>>>>
>>>>>> You can also check all the other registers about TCON0.
>>>>>>
>>>>>> Now I proceed testing it on A33, maybe the peripheral is slightly
>>>>>> different between Axx SoCs, if I find it that way,
>>>>>> it should be only a check about SoC or peripheral ID,
>>>>>> and treat polarity as it should be done.
>>>>>
>>>>> Here I am with A33 waveforms:
>>>>> tcon0_regs => https://pasteboard.co/H4rXfN0M.png
>>>>> dclk_d0 => https://pasteboard.co/H4rVXwy.png
>>>>> dclk_de => https://pasteboard.co/H4rWDt8.png
>>>>> dclk_vsnc => https://pasteboard.co/H4rWRACu.png
>>>>> dclk_hsync => https://pasteboard.co/H4rWK6I.png
>>>>
>>>> Thanks, that's really helpful.
>>>>
>>>>> It behaves the same way as A20, so as I mean IO polarity,
>>>>> all signals(except D0-D23), are inverted.
>>>>> For A33 I've used A33-OLinuXino.
>>>>> For A20 our LiNova1.
>>>>
>>>> Indeed, HSYNC and VSYNC look inverted.
>>>
>>> Yes, so they should be inverted inside the driver.
>>
>> Yep. And the LCD panels used on our boards as well in order to avoid
>> any breakages.
> 
> Can you provide a list?
> Or is there a way I can find it on my own?
> I can create a whole patch-set providing this too on panel-simple.c
> Ok?

Maybe not, or only a few part of them.
This is because of what I write below.

> 
>>
>>>> I don't really know what the polarity of D0 would be just by
>>>> judging at that capture, but we would have noticed if the colors
>>>> were inverted for quite some time now.
>>>
>>> D0-D23 are correct.
>>>
>>> With that capture, I mean to show you instead dclk is inverted, as
>>> dclk samples D0 on falling edge.
>>
>> Ah right, DCLK being the first channel?
> 
> Yes, sorry I didn't place a label on channels
> 
>>
>>> So 0 is NEGEDGE and 1 is POSEDGE(1/3 of clock phase).
>>> 1/3 clock phase seems enough to me to be considered POSEDGE,
>>> 2/3 instead risks to go too much to the right of D0(even if it could 
>>> work).
>>
>> Do you have captures with both settings?
> 
> Not now, but asap I'm going to take.

Here we are:
1/3 phase: https://pasteboard.co/H4VehON.png
2/3 phase: https://pasteboard.co/H4Veq8a.png

Yellow: D0
Blue: DCLK

As you can see:
1/3 phase has DCLK rising edge almost in the middle of D0
2/3 phase has DCLK rising edge that comes too late

I would go for "1/3 phase" for Rising edge
and "normal phase" for Falling edge.

What do you think?

> 
>>
>>>> DE seems to be active high though, since it's only going to be at
>>>> a logical low level when data are not transmitted, so during the
>>>> blank periods.
>>>
>>> Yes, you're right, DE is data enable, and is asserted high as 0.
>>
>> No, it is asserted high as 1
> 
> Sorry, I wanted to tell it is asserted high with IO_POL register bit 
> cleared to 0. So we're saying same thing now.
> 
>>
>>> But it must be added.
>>> I'm planning to send a new patchset with all these things corrected for
>>> kernel.
>>
>> Ok.
>>
>>> A little out of thread but:
>>> I'd like to send one for u-boot too,
>>> but this means also to modify every sunxi "sync:3" to "sync:0" and
>>> vice-versa.
>>>
>>> What do you think?
>>
>> That it's going to be a nightmare... We've advertised since the very
>> beginning something, and we're about to break it. I'm not sure we want
>> to do that.
> 
> I can take care about that.
> But I also think that a lot of displays work because they use only 
> DE-mode, almost ignoring HSync and VSync signals(HV-mode).
> 
> In any case I have to produce these patches because of my company's 
> board based on A20 and A33, and modify defconfig according to it.
> The only technical nightmare I see is to produce a commit for every 
> defconfig to be modified and copy-paste che commit-log substituing board 
> name(1-2 days of work).
> Problem is testing, but we're speaking about something that probably was 
> badly working, but you couldn't see it on display.
> So I think this is only an improvement at the end.
> 
> I'm sorry I've taken bad news.
> Drink 1 glass of Spritz to go over! :)

IMHO I think that we have only to take care about displays that don't 
have DE signal.
If DE signal exists, then displays are driven through DE only for back 
and front porch as I know, and on most displays I've used, Hsync and 
VSync are ignored.
DE is used not only for Data Enable, but also for sync the very 
beginning of frame, the rest of syncing is done by pause between every 
line sent.
This is should be why nobody noticed it before,
I think almost every display is used in DE mode only.
So, if we fix bug for HSync and VSync, risk should be very low.
Indeed, everybody or almost, use sync:3 because display ignore those 2 
signals (HSync and VSYnc) in favour of DE.
And I don't know how many people checked with oscilloscope signals after 
getting display working in a few.

So maybe we can keep all defconfig files untouched.
The same in Linux, prior displays have DE signal of course,
but nowadays it's difficult to me finding out a display without DE-mode.
I only remember I.MX31 not supporting DE-signal,
because at that time the most used sync system was HV-Mode,
principally done by Sharp as I recall right.

Maybe the nightmare is less important than we thought.

What about it?

Thanks

Giulio

> 
>>
>> Thanks!
>> Maxime
>>
> 
> 


-- 
Giulio Benetti
R&D Manager &
Advanced Research

MICRONOVA SRL
Sede: Via A. Niedda 3 - 35010 Vigonza (PD)
Tel. 049/8931563 - Fax 049/8931346
Cod.Fiscale - P.IVA 02663420285
Capitale Sociale ? 26.000 i.v.
Iscritta al Reg. Imprese di Padova N. 02663420285
Numero R.E.A. 258642
