From: dianders@chromium.org (Doug Anderson)
Date: Tue, 24 Apr 2018 21:29:51 -0700
Subject: [PATCH v3 6/6] arm64: dts: rockchip: Specify override mode for
 kevin panel
In-Reply-To: <CAAEAJfAQMzUfM86o-xNoyBQzTiEMNH+W=9FyFpBy99nA3HrVgw@mail.gmail.com>
References: <20180208174855.55620-1-seanpaul@chromium.org>
 <20180208174855.55620-7-seanpaul@chromium.org>
 <CAD=FV=WGU+s015DQbNeWHkpqpHLFz+9AjHKAd0N3HWag0p5FWA@mail.gmail.com>
 <CAAEAJfAQMzUfM86o-xNoyBQzTiEMNH+W=9FyFpBy99nA3HrVgw@mail.gmail.com>
Message-ID: <CAD=FV=W9LCeGAEuZDD9FUEKVMp8YUuCcW9uLcTZqTR1spA1gEA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Apr 24, 2018 at 7:31 AM, Ezequiel Garcia
<ezequiel@vanguardiasur.com.ar> wrote:
> Hi Doug, Sean:
>
> I would like to move this forward.
>
> On 26 February 2018 at 15:23, Doug Anderson <dianders@chromium.org> wrote:
>> Hi,
>>
>> On Thu, Feb 8, 2018 at 9:48 AM, Sean Paul <seanpaul@chromium.org> wrote:
>>> This patch adds an override mode for kevin devices. The mode increases
>>> both back porches to allow a pixel clock of 26666kHz as opposed to the
>>> 'typical' value of 252750kHz. This is needed to avoid interference with
>>> the touch digitizer on these laptops.
>>>
>>> Changes in v2:
>>>  - Wrap the timing in display-timings node to match binding (Rob/Thierry)
>>> Changes in v3:
>>>  - Unwrap the timing from display-timings and rename panel-timing (Rob)
>>>
>>> Cc: Doug Anderson <dianders@chromium.org>
>>> Cc: Eric Anholt <eric@anholt.net>
>>> Cc: Heiko Stuebner <heiko@sntech.de>
>>> Cc: Jeffy Chen <jeffy.chen@rock-chips.com>
>>> Cc: Rob Herring <robh+dt@kernel.org>
>>> Cc: St?phane Marchesin <marcheu@chromium.org>
>>> Cc: Thierry Reding <thierry.reding@gmail.com>
>>> Cc: devicetree at vger.kernel.org
>>> Cc: dri-devel at lists.freedesktop.org
>>> Cc: linux-rockchip at lists.infradead.org
>>> Signed-off-by: Sean Paul <seanpaul@chromium.org>
>>> ---
>>>  arch/arm64/boot/dts/rockchip/rk3399-gru-kevin.dts | 14 ++++++++++++++
>>>  1 file changed, 14 insertions(+)
>>>
>>> diff --git a/arch/arm64/boot/dts/rockchip/rk3399-gru-kevin.dts b/arch/arm64/boot/dts/rockchip/rk3399-gru-kevin.dts
>>> index 191a6bcb1704..658411ce37ea 100644
>>> --- a/arch/arm64/boot/dts/rockchip/rk3399-gru-kevin.dts
>>> +++ b/arch/arm64/boot/dts/rockchip/rk3399-gru-kevin.dts
>>> @@ -98,6 +98,20 @@
>>>                 backlight = <&backlight>;
>>>                 power-supply = <&pp3300_disp>;
>>>
>>> +               panel-timing {
>>> +                       clock-frequency = <266604720>;
>>> +                       hactive = <2400>;
>>> +                       hfront-porch = <48>;
>>> +                       hback-porch = <84>;
>>> +                       hsync-len = <32>;
>>> +                       hsync-active = <0>;
>>> +                       vactive = <1600>;
>>> +                       vfront-porch = <3>;
>>> +                       vback-porch = <120>;
>>> +                       vsync-len = <10>;
>>> +                       vsync-active = <0>;
>>> +               };
>>> +
>>>                 ports {
>>>                         panel_in_edp: endpoint {
>>>                                 remote-endpoint = <&edp_out_panel>;
>>
>> Kristian brought an old bug to my attention
>> <https://bugs.chromium.org/p/chromium/issues/detail?id=750354> and it
>> made me think.  Should we somehow adjust the bindings here to account
>> for the fact that a board may source several different panels?
>>
>> AKA: on some boards an ODM may want to second source (or third source,
>> or ...) the panel.  They'll randomly connect several different panels
>> to the board and ship the boards out.  The panels are all compatible
>> electrically (same power sequencing) but might need slightly different
>> timings.  In this particular case there's no board-level strappings
>> for the different panels--it's assumed that the EDID on the panels can
>> be used to distinguish them.
>>
>> In that case it seems like it would be nice to allow specifying more
>> than one "panel-timing" nodes.  Maybe keyed off some type of ID that's
>> present in the EDID?
>>
>>
>> Is that something we'd want to account for before we land this series?
>>  It seems like it would just be adding an extra level of nodes?
>>
>
> AFAICS, there is no EDID without a DDC bus, which we don't
> seem to have on gru platforms, do we?

I'm fairly certain we can read the EDID on gru devices.  I see the
"aux" channel connected on the schematics.  That'll do it, right?
...and I could have sworn that at some point in time I could read the
EDID in the software.  My kevin devices are not connected for
debugging so I can't check right now, but I'm pretty sure I was able
to read the EDID in the past...

-Doug
