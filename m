From: giulio.benetti@micronovasrl.com (Giulio Benetti)
Date: Fri, 2 Mar 2018 12:43:59 +0100
Subject: [PATCH] drm/sun4i: Handle DRM_BUS_FLAG_PIXDATA_*EDGE
In-Reply-To: <20180301093909.ph6nuvxuqtwyfssd@flea>
References: <1519834492-30559-1-git-send-email-giulio.benetti@micronovasrl.com>
 <20180301093909.ph6nuvxuqtwyfssd@flea>
Message-ID: <0666b792-1f01-8138-7a6f-f98f9de95348@micronovasrl.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Il 01/03/2018 10:39, Maxime Ripard ha scritto:
> On Wed, Feb 28, 2018 at 05:14:52PM +0100, Giulio Benetti wrote:
>> Handle both positive and negative dclk polarity,
>> according to bus_flags.
>>
>> Signed-off-by: Giulio Benetti <giulio.benetti@micronovasrl.com>
>> ---
>>   drivers/gpu/drm/sun4i/sun4i_tcon.c | 13 ++++++++++++-
>>   1 file changed, 12 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/sun4i/sun4i_tcon.c b/drivers/gpu/drm/sun4i/sun4i_tcon.c
>> index aaf911a..534e5ee 100644
>> --- a/drivers/gpu/drm/sun4i/sun4i_tcon.c
>> +++ b/drivers/gpu/drm/sun4i/sun4i_tcon.c
>> @@ -17,6 +17,7 @@
>>   #include <drm/drm_encoder.h>
>>   #include <drm/drm_modes.h>
>>   #include <drm/drm_of.h>
>> +#include <drm/drm_panel.h>
>>   
>>   #include <uapi/drm/drm_mode.h>
>>   
>> @@ -340,6 +341,9 @@ static void sun4i_tcon0_mode_set_lvds(struct sun4i_tcon *tcon,
>>   static void sun4i_tcon0_mode_set_rgb(struct sun4i_tcon *tcon,
>>   				     const struct drm_display_mode *mode)
>>   {
>> +	struct drm_panel *panel = tcon->panel;
>> +	struct drm_connector *connector = panel->connector;
>> +	struct drm_display_info display_info = connector->display_info;
>>   	unsigned int bp, hsync, vsync;
>>   	u8 clk_delay;
>>   	u32 val = 0;
>> @@ -395,8 +399,15 @@ static void sun4i_tcon0_mode_set_rgb(struct sun4i_tcon *tcon,
>>   	if (mode->flags & DRM_MODE_FLAG_PVSYNC)
>>   		val |= SUN4I_TCON0_IO_POL_VSYNC_POSITIVE;
>>   
>> +	if (display_info.bus_flags & DRM_BUS_FLAG_PIXDATA_POSEDGE)
>> +		clk_set_phase(tcon->dclk, 240);
>> +
>> +	if (display_info.bus_flags & DRM_BUS_FLAG_PIXDATA_NEGEDGE)
>> +		clk_set_phase(tcon->dclk, 0);
>> +
> 
> This needs to have a whole bunch of comments here. We want to have
> basically the whole discussion we had by mail previously about this in
> there.
> 
> And the same goes for your commit log.

Ok, I follow asap with V2 patch describing everything we told on 
previous thread.

> 
>>   	regmap_update_bits(tcon->regs, SUN4I_TCON0_IO_POL_REG,
>> -			   SUN4I_TCON0_IO_POL_HSYNC_POSITIVE | SUN4I_TCON0_IO_POL_VSYNC_POSITIVE,
>> +			   SUN4I_TCON0_IO_POL_HSYNC_POSITIVE |
>> +			   SUN4I_TCON0_IO_POL_VSYNC_POSITIVE,
>>   			   val);
> 
> This has nothing to do with your patch.

Yes, sorry, I've seen it now, I remove it on V2 patch

> 
> Maxime
> 
> 
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel at lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
> 


-- 
Giulio Benetti
CTO

MICRONOVA SRL
Sede: Via A. Niedda 3 - 35010 Vigonza (PD)
Tel. 049/8931563 - Fax 049/8931346
Cod.Fiscale - P.IVA 02663420285
Capitale Sociale ? 26.000 i.v.
Iscritta al Reg. Imprese di Padova N. 02663420285
Numero R.E.A. 258642
