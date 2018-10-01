From: jagan@openedev.com (Jagan Teki)
Date: Mon, 1 Oct 2018 13:25:59 +0530
Subject: [linux-sunxi] Re: [PATCH 08/12] drm/sun4i: sun6i_mipi_dsi:
 Refactor vertical video start delay
In-Reply-To: <20180929152758.g3goxwjud2ym5rft@flea>
References: <20180927114850.24565-1-jagan@amarulasolutions.com>
 <20180927114850.24565-9-jagan@amarulasolutions.com>
 <20180927171451.7iqt2nt2log5qojf@flea>
 <CAMty3ZDxpLwVDsgVMjX+6+uz89sQ1aZaXHHZ+-5aogrA4MHmqw@mail.gmail.com>
 <20180929152758.g3goxwjud2ym5rft@flea>
Message-ID: <c6933daf-c445-ade4-a31b-f311ddae7256@openedev.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday 29 September 2018 08:57 PM, Maxime Ripard wrote:
> On Thu, Sep 27, 2018 at 11:03:19PM +0530, Jagan Teki wrote:
>> On Thu, Sep 27, 2018 at 10:44 PM Maxime Ripard
>> <maxime.ripard@bootlin.com> wrote:
>>>
>>> On Thu, Sep 27, 2018 at 05:18:46PM +0530, Jagan Teki wrote:
>>>> Accordingly to BPI-M64-bsp DE DSI code Video start delay
>>>> can be computed by subtracting total vertical timing with
>>>> front porch timing and with adding 1 delay line for TCON.
>>>
>>> This is what the current code is doing as well.
>>
>> The current code
>> return mode->vtotal - (mode->vsync_end - mode->vdisplay) + 1;
>>
>> (mode->vsync_end - mode->vdisplay) = front porch + sync
>>
>> but I'm updating here only front porch.
>>
>>>
>>>> This patch simply add the start_delay logic from BPI-M64-bsp,
>>>> w/o this new computation, the DSI on A64 encounter vblank time out.
>>>>
>>>> [CRTC:36:crtc-0] vblank wait timed out
>>>>
>>>> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
>>>> ---
>>>>   drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c | 12 +++++++++++-
>>>>   1 file changed, 11 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
>>>> index 9918fdb990ff..217db74c6dc3 100644
>>>> --- a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
>>>> +++ b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
>>>> @@ -358,7 +358,17 @@ static void sun6i_dsi_inst_init(struct sun6i_dsi *dsi,
>>>>   static u16 sun6i_dsi_get_video_start_delay(struct sun6i_dsi *dsi,
>>>>                                           struct drm_display_mode *mode)
>>>>   {
>>>> -     return mode->vtotal - (mode->vsync_end - mode->vdisplay) + 1;
>>>> +     u32 vfp = mode->vsync_start - mode->vdisplay;
>>
>> let me explain this.
>>
>> Actual code from Allwinner
>> u32 vfp = panel->lcd_vt - panel->lcd_y - panel->lcd_vbp;
>>
>> So,
>>
>> => (panel->lcd_vt - panel->lcd_y) - (panel->lcd_vbp)
>> => (front porch + sync + back porch) - (back porch + sync)
> 
> Unless Allwinner is doing something fishy, in which case that should
> be mentionned, the back porch doesn't contain the sync pulse.

As per as I understand panel->lcd_vbp is not back porch timings value 
which i used by drm. It is BSP DTS property value and actual back porch 
is calculated as "panel->lcd_vbp - panel->sync"

timmings->ver_sync_time= panel_info->lcd_vspw;
timmings->ver_back_porch= panel_info->lcd_vbp-panel_info->lcd_vspw;
