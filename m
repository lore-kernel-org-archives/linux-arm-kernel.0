From: wens@csie.org (Chen-Yu Tsai)
Date: Wed, 16 May 2018 00:56:36 -0700
Subject: [PATCH 4/6] drm/panel: simple: Add support for Banana Pi 7"
 S070WV20-CT16 panel
In-Reply-To: <CAMty3ZBSkrdV=SPqK5UoBTN8b+KLD9vsgDkx6DYLxEfb9_TazA@mail.gmail.com>
References: <20180419093225.614-1-wens@csie.org>
 <20180419093225.614-5-wens@csie.org>
 <CAMty3ZD7MbvX5eJ9U4QZRSPTXKD3Ps=hQF2hJSsF17YosXFmmg@mail.gmail.com>
 <CAGb2v64CASge22O0CviNmgEV0CSFgipkKu86F-6hiaLChPh_EA@mail.gmail.com>
 <CAMty3ZBSkrdV=SPqK5UoBTN8b+KLD9vsgDkx6DYLxEfb9_TazA@mail.gmail.com>
Message-ID: <CAGb2v679hCrS3zjjb5oPkiODha2tnc0sGVSv2f92JBPf6N7+6A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 16, 2018 at 12:20 AM, Jagan Teki <jagan@amarulasolutions.com> wrote:
> On Wed, May 16, 2018 at 12:12 PM, Chen-Yu Tsai <wens@csie.org> wrote:
>> On Mon, May 14, 2018 at 11:03 AM, Jagan Teki <jagan@amarulasolutions.com> wrote:
>>> On Thu, Apr 19, 2018 at 3:02 PM, Chen-Yu Tsai <wens@csie.org> wrote:
>>>> This panel is marketed as Banana Pi 7" LCD display. On the back is
>>>> a sticker denoting the model name S070WV20-CT16.
>>>>
>>>> This is a 7" 800x480 panel connected through a 24-bit RGB interface.
>>>> However the panel only does 262k colors.
>>>>
>>>> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
>>>> ---
>>>>  .../display/panel/bananapi,s070wv20-ct16.txt  |  7 ++++++
>>>>  drivers/gpu/drm/panel/panel-simple.c          | 25 +++++++++++++++++++
>>>>  2 files changed, 32 insertions(+)
>>>>  create mode 100644 Documentation/devicetree/bindings/display/panel/bananapi,s070wv20-ct16.txt
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/display/panel/bananapi,s070wv20-ct16.txt b/Documentation/devicetree/bindings/display/panel/bananapi,s070wv20-ct16.txt
>>>> new file mode 100644
>>>> index 000000000000..2ec35ce36e9a
>>>> --- /dev/null
>>>> +++ b/Documentation/devicetree/bindings/display/panel/bananapi,s070wv20-ct16.txt
>>>> @@ -0,0 +1,7 @@
>>>> +Banana Pi 7" (S070WV20-CT16) TFT LCD Panel
>>>> +
>>>> +Required properties:
>>>> +- compatible: should be "bananapi,s070wv20-ct16"
>>>> +
>>>> +This binding is compatible with the simple-panel binding, which is specified
>>>> +in simple-panel.txt in this directory.
>>>> diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
>>>> index cbf1ab404ee7..9bc037f74d6c 100644
>>>> --- a/drivers/gpu/drm/panel/panel-simple.c
>>>> +++ b/drivers/gpu/drm/panel/panel-simple.c
>>>> @@ -745,6 +745,28 @@ static const struct panel_desc avic_tm070ddh03 = {
>>>>         },
>>>>  };
>>>>
>>>> +static const struct drm_display_mode bananapi_s070wv20_ct16_mode = {
>>>> +       .clock = 30000,
>>>> +       .hdisplay = 800,
>>>> +       .hsync_start = 800 + 40,
>>>> +       .hsync_end = 800 + 40 + 48,
>>>> +       .htotal = 800 + 40 + 48 + 40,
>>>> +       .vdisplay = 480,
>>>> +       .vsync_start = 480 + 13,
>>>> +       .vsync_end = 480 + 13 + 3,
>>>> +       .vtotal = 480 + 13 + 3 + 29,
>>>> +};
>>>> +
>>>> +static const struct panel_desc bananapi_s070wv20_ct16 = {
>>>> +       .modes = &bananapi_s070wv20_ct16_mode,
>>>> +       .num_modes = 1,
>>>> +       .bpc = 6,
>>>> +       .size = {
>>>> +               .width = 154,
>>>> +               .height = 86,
>>>> +       },
>>>> +};
>>>
>>> I think this parallel RGB interface right? I too have same display
>>> with DSI I'm sure these setting will not useful right? do we need to
>>> write separate panel driver for that?
>>
>> AFAIK the DSI model is an RGB panel with a MIPI DSI bridge on the
>> connector board. The model I have is dual interface.
>
> Yes, this is what I have [1] where same strip can use for both RGB and
> MIPI DSI. can bananapi,s070wv20-ct16 work for DSI interface as well?

In theory yes. You can use RGB with Banana Pi M1+ and DSI with Banana Pi M3.
However, DSI on A83T is not supported yet, and I don't intend to spend my
time writing a driver for the MIPI DSI bridge on that panel. The bridge IC
is the one on top of the DSI FPC connector.

ChenYu

> [1] https://www.aliexpress.com/item/New-Arrival-Banana-Pro-Pi-7-inch-LCD-Display-Touch-Screen-Raspberry-Pi-Car-GPS-FreeShipping/32335608836.html
>
> Jagan.
