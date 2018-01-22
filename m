From: giulio.benetti@micronovasrl.com (Giulio Benetti)
Date: Mon, 22 Jan 2018 21:27:58 +0100
Subject: [PATCH 2/2] drm/sun4i: Handle DRM_MODE_FLAG_**SYNC_POSITIVE
 correctly
In-Reply-To: <20180122085112.7xo2t3x5ag4k2kpl@flea.lan>
References: <1516474221-114596-1-git-send-email-giulio.benetti@micronovasrl.com>
 <1516474221-114596-2-git-send-email-giulio.benetti@micronovasrl.com>
 <20180122085112.7xo2t3x5ag4k2kpl@flea.lan>
Message-ID: <aa724bd5-cfb1-128c-af32-db29253f32aa@micronovasrl.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Il 22/01/2018 09:51, Maxime Ripard ha scritto:
> On Sat, Jan 20, 2018 at 07:50:21PM +0100, Giulio Benetti wrote:
>> On previous handling, if specified DRM_MODE_FLAG_N*SYNC,
>> it was ignored,
>> because only PHSYNC and PVSYNC were taken into account.
>> DRM_MODE_FLAG_P*SYNC and DRM_MODE_FLAG_N*SYNC are not exclusive.
>>
>> If flags contains PVSYNC, it doesn't mean it is NVSYNC.
>> And it's true also the contrary.
>> Also, as I've checked with scope on A20,
>> if (flags & PVSYNC) then SUN4I_TCON0_IO_POL_VSYNC_POSITIVE
>> must be set, as name suggests.
>> It seems all display io polarities starts inverted if 0.
>>
>> Signed-off-by: Giulio Benetti <giulio.benetti@micronovasrl.com>
>>
>> PVSYNC and PHSYNC only
>>
>> Signed-off-by: Giulio Benetti <giulio.benetti@micronovasrl.com>
> 
> Checkpatch:
> WARNING: Duplicate signature

Sorry I didn't use ./scripts/checkpatch.pl

> 
>> ---
>>   drivers/gpu/drm/sun4i/sun4i_tcon.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/sun4i/sun4i_tcon.c b/drivers/gpu/drm/sun4i/sun4i_tcon.c
>> index 6121210..e873a37 100644
>> --- a/drivers/gpu/drm/sun4i/sun4i_tcon.c
>> +++ b/drivers/gpu/drm/sun4i/sun4i_tcon.c
>> @@ -224,10 +224,10 @@ static void sun4i_tcon0_mode_set_rgb(struct sun4i_tcon *tcon,
>>   		     SUN4I_TCON0_BASIC3_H_SYNC(hsync));
>>   
>>   	/* Setup the polarity of the various signals */
>> -	if (!(mode->flags & DRM_MODE_FLAG_PHSYNC))
>> +	if (mode->flags & DRM_MODE_FLAG_PHSYNC)
>>   		val |= SUN4I_TCON0_IO_POL_HSYNC_POSITIVE;
>>   
>> -	if (!(mode->flags & DRM_MODE_FLAG_PVSYNC))
>> +	if (mode->flags & DRM_MODE_FLAG_PVSYNC)
>>   		val |= SUN4I_TCON0_IO_POL_VSYNC_POSITIVE;
> 
> I'm not sure why you were talking of the differences between NVSYNC
> and PVSYNC if you're not making use of any of it here?

Thinking about it more now, the point is that all Lcd IOs seem to be 
inverted by default(at least on A20).
With inverted, I mean that if for example PVSYNC,
I should see vsync line low and when asserted to give VSync,
it goes high.
This is what I've checked with oscilloscope on A20.
Can someone give a try on A33? Otherwise I will,
but I will take some time.
On uboot, everything is treated equal to kernel,
but to have my falling edge dclk and low h/vsync I had to specify:
CONFIG_VIDEO_LCD_DCLK_PHASE=0 (giving me falling edge on dclk)
and
CONFIG_VIDEO_LCD_MODE="....,sync:3,..."
but digging into code, I see "sync:3" means H/VSYNC HIGH,
but I experience both LOW during their pulse.

> 
> Also, how was it tested? This seems quite weird that we haven't caught
> that one sooner, and I'm a bit worried about the possible regressions
> here.

It sounds really strange to me too,
because everybody under uboot use "sync:3"(HIGH).
I will retry to measure,
unfortunately at home I don't have a scope,
but I think I'm going to have one soon, because of this. :)

> 
> Maxime
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
