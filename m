From: jagan@openedev.com (Jagan Teki)
Date: Mon, 1 Oct 2018 13:39:17 +0530
Subject: [linux-sunxi] Re: [PATCH 06/12] drm/sun4i: sun6i_mipi_dsi: Fix
 VBP size calculation
In-Reply-To: <20180929135302.ymdzapz5npvapti2@flea>
References: <20180927114850.24565-1-jagan@amarulasolutions.com>
 <20180927114850.24565-7-jagan@amarulasolutions.com>
 <20180927152126.vovnvwmqdfpuxgdm@flea>
 <CAMty3ZABx9Fod5W_T7JciZEsn7jGvuM-LsBFATdA=hQ2CVwELw@mail.gmail.com>
 <20180929135302.ymdzapz5npvapti2@flea>
Message-ID: <63b40c20-670b-1c53-bf5e-62f64e6e02f0@openedev.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday 29 September 2018 07:23 PM, Maxime Ripard wrote:
> On Thu, Sep 27, 2018 at 09:50:34PM +0530, Jagan Teki wrote:
>> On Thu, Sep 27, 2018 at 8:51 PM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
>>>
>>> On Thu, Sep 27, 2018 at 05:18:44PM +0530, Jagan Teki wrote:
>>>> According to horizontal and vertical timings are defined
>>>> per the diagram from include/drm/drm_modes.h
>>>>
>>>> Back porch = [hv]total - [hv]sync_end
>>>>
>>>> So, update SUN6I_DSI_BASIC_SIZE0_VBP calculation as
>>>> mode->vtotal - mode->vsync_end
>>>>
>>>> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
>>>> ---
>>>>   drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c | 4 ++--
>>>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
>>>> index 1c7e42015645..599284971ab6 100644
>>>> --- a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
>>>> +++ b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
>>>> @@ -526,8 +526,8 @@ static void sun6i_dsi_setup_timings(struct sun6i_dsi *dsi,
>>>>        regmap_write(dsi->regs, SUN6I_DSI_BASIC_SIZE0_REG,
>>>>                     SUN6I_DSI_BASIC_SIZE0_VSA(mode->vsync_end -
>>>>                                               mode->vsync_start) |
>>>> -                  SUN6I_DSI_BASIC_SIZE0_VBP(mode->vsync_start -
>>>> -                                            mode->vdisplay));
>>>> +                  SUN6I_DSI_BASIC_SIZE0_VBP(mode->vtotal -
>>>> +                                            mode->vsync_end));
>>>
>>> Is it purely theoretical, or did you find some source that back that?
>>
>> VSA is done as per that, sync_end - sync start would give sync time.
> 
> That's a different register though.
> 
>> VBP also done in BPI-M64-bsp[1] which results back porch existing code
>> results fron porch.
>>
>> [1] https://github.com/BPI-SINOVOIP/BPI-M64-bsp/blob/master/linux-sunxi/drivers/video/sunxi/disp2/disp/de/lowlevel_sun50iw1/de_dsi.c#L955
> 
> That code does back porch - sync length. Such a calculation doesn't
> make much sense as is, but you're saying that it results in the front
> porch. Again, what makes you say that?

No what code shows is not a real back porch value used for drm it's 
panel back porch value which is a DTS property in BSP.
(I made wrong comment on previous mail as front porch, sorry)

here is the real code

from drivers/video/sunxi/disp2/disp/de/disp_lcd.c
timmings->ver_sync_time= panel_info->lcd_vspw;
timmings->ver_back_porch= panel_info->lcd_vbp-panel_info->lcd_vspw;


u32 vbp = panel->lcd_vbp;
u32 vspw = panel->lcd_vspw;
dsi_dev[sel]->dsi_basic_size0.bits.vbp = vbp-vspw;

So,

dsi_dev[sel]->dsi_basic_size0.bits.vbp = panel->lcd_vbp - panel->lcd_vspw;

=>  timmings->ver_back_porch + panel_info->lcd_vspw - panel_info->lcd_vspw
=>  timmings->ver_back_porch
=>  mode->vtotal - mode->end

VSA, which a proper value.

dsi_dev[sel]->dsi_basic_size0.bits.vsa = vspw;
=> panel_info->lcd_vspw;
=> timmings->ver_sync_time
=> mode->vsync_end - mode->vsync_start
