From: a.hajda@samsung.com (Andrzej Hajda)
Date: Thu, 01 Sep 2016 10:53:27 +0200
Subject: [PATCH RFC] ARM: dts: samsung: add rga-lvds panel in itop elite
In-Reply-To: <20EC8D13-CF96-4869-B46F-93A89211367E@soulik.info>
References: <1472511002-9019-1-git-send-email-ayaka@soulik.info>
 <dee989f5-17b0-7445-514b-559e98d77acd@samsung.com>
 <790048d1-6533-2e43-5343-13782382bf84@soulik.info>
 <94dc2e0d-2521-a636-ee3d-90168f30fe28@samsung.com>
 <20EC8D13-CF96-4869-B46F-93A89211367E@soulik.info>
Message-ID: <28f6838b-6bd8-a533-fcdb-5af41dbdaa7f@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/01/2016 10:24 AM, Ayaka wrote:
>
> ??? iPad ??
> Thank you
>> Andrzej Hajda <a.hajda@samsung.com> ? 2016?9?1? ??3:04 ???
>>
>>> On 08/31/2016 07:55 PM, ayaka wrote:
>>>
>>>> On 08/31/2016 08:30 PM, Andrzej Hajda wrote:
>>>> Hi,
>>>>
>>>>
>>>>> On 08/30/2016 12:50 AM, Randy Li wrote:
>>>>> It is actually a lvds panel connected through a rga-lvds bridge.
>>>>> But I really have no idea about what does a port mean in fimd node.
>>>>>
>>>>> Also how should I configure this panel size? I think the i2c found
>>>>> on the panel schematic, but it more likely to be used a touch screen
>>>>> touth. Also the touch screen is not supported in currently driver.
>>>>>
>>>>> Signed-off-by: Randy Li <ayaka@soulik.info>
>>>>> ---
>>>>>  arch/arm/boot/dts/exynos4412-itop-elite.dts | 35 ++++++++++++++++++++++++++---
>>>>>  1 file changed, 32 insertions(+), 3 deletions(-)
>>>>>
>>>>> diff --git a/arch/arm/boot/dts/exynos4412-itop-elite.dts b/arch/arm/boot/dts/exynos4412-itop-elite.dts
>>>>> index e1cda54..2d67385 100644
>>>>> --- a/arch/arm/boot/dts/exynos4412-itop-elite.dts
>>>>> +++ b/arch/arm/boot/dts/exynos4412-itop-elite.dts
>>>>> @@ -139,6 +139,20 @@
>>>>>          assigned-clocks = <&clock CLK_MOUT_CAM0>;
>>>>>          assigned-clock-parents = <&clock CLK_XUSBXTI>;
>>>>>      };
>>>>> +    
>>>>> +    vcc_sys_lcd: sys-lcd {
>>>>> +        compatible = "regulator-fixed";
>>>>> +        regulator-name = "vcc_5v";
>>>>> +        regulator-min-microvolt = <5000000>;
>>>>> +        regulator-max-microvolt = <5000000>;
>>>>> +        gpio = <&gpl0 4 GPIO_ACTIVE_HIGH>;
>>>>> +    };
>>>>> +
>>>>> +    panel: panel {
>>>>> +        ddc-i2c-bus = <&i2c_3>;
>>>>> +        power-supply = <&vcc_sys_lcd>;
>>>>> +        enable-gpios = <&gpl0 2 GPIO_ACTIVE_HIGH>;
>>>>> +    };
>>>> Panel has no compatible string, which driver will handle this node?
>>> The problem is that, it is panel not supported by kernel. 
>> For simple panel you can take a look at [1][2]. Ie. if the panel needs
>> only power supply and enable gpio, you just need to add few lines to [2].
> But I still don't know which compatible string I should use, "simple-dpi" ?

Have you looked at [2]?
Or just run command in kernel git tree:
git log -p drivers/gpu/drm/panel/panel-simple.c

To add support for specific panel you add:
1. display mode(s),
2. panel description,
3. panel compatible string.

And then you use this compatible in dts.
To have patches accepted in mainline you should add bindings
for the panel, check history of dri-devel to see how to do it.

>>
>> [1]: Documentation/devicetree/bindings/display/panel/simple-panel.txt
>> [2]: drivers/gpu/drm/panel/panel-simple.c
>>
>>> Is it possible 
>>> to support without adding a new driver for it ? I know there is a 
>>> simple-dpi for MIPI, but what is for parallel video or lvds?
>> simple-dpi is just parallel output. LVDS is not supported by Exynos4412 but
>> boards usually have RGB/LVDS bridge for such panels, I have no access to
>> itop
>> board schematics, but I suppose it has such bridge. LVDS bridges often
>> do not
>> need Linux driver, so from developer point of view LVDS panels with such
>> bridge
> Yes it is.
>> are handled the same way as RGB panels. Example fimd bindings for RGB panels
>> are in [3].
>>
>> [3]: arch/arm/boot/dts/exynos4210-universal_c210.dts
>>
> Would it appear as a frame buffer device in Linux ? Regard of display timings, I could solve it later. If the frame buffer node is created, I could know I have a way to test.

Yes, it should, if everything is properly done /dev/fb0 should be available.
Roughly steps to do:
1. add panel definition to drivers/gpu/drm/panel/panel-simple.c.
2. add panel entry and fimd bindings to itop dts.
3. enable exynos dpi, simple panel, drm_framebuffer in .config.


>>>> Regards
>>>> Andrzej
>>> The other problem is that I don't how to configure the display-times, 
>>> the datasheet for CLAA070WP03XG only talk about total time, active time 
>>> and blank time for both Horizontal an Vertical time. Does it mean the 
>>> front-porch and sync-len for horizontal and vertical are zero ?
>> You can look at vendor's code.
> It is a very old kernel. But it seems that they didn't configure the fimd but the frame buffer.

This is just matter of different display framework they have used.
In current kernel you should use drm framework.

>> Or just experiment with different values.
>> The equation is: total=active+back_porch+blank+front_porch.
>> So if htotal=864, hactive=800, hblank=64, then hporches are 0.
>> In case of vtotal=1288, vactive=1200, vblank=8 you have left 80 for porches,
>> you can try to split them equally for front and back for starters.
> But timings diagram in data sheet doesn't look like that, I have asked the vendor for some help, I hope I could get a reply from the vendor.

After entering CLAA070WP03XG into web search you can find datasheet of it.
It contains timings specified above.

Regards
Andrzej


>> Regards
>> Andrzej
>>
>>> +       ports {
>>> +               #address-cells = <1>;
>>> +               #size-cells = <0>;
>>> +               port at 3 {
>>> +                       reg = <3>;
>>> +                       rga_lvds: endpoint {
>>> +                               remote-endpoint = <&panel>;
>>> +                       };
>>> +               };
>>> +       };
>>> +
>>> +       panel: panel at 0 {
>>> +               compatible = "panel-simple";
>>> +
>>> +               power-supply = <&vcc_sys_lcd>;
>>> +               enable-gpios = <&gpl0 2 GPIO_ACTIVE_HIGH>;
>>> +               display-timings {
>>> +                       timing-0 {
>>> +                               clock-frequency = <66770000>;
>>> +                               hactive = <800>;
>>> +                               vactive = <1280>;
>>> +                               hfront-porch = <0>;
>>> +                               hback-porch = <64>;
>>> +                               hsync-len = <0>;
>>> +                               vfront-porch = <0>;
>>> +                               vback-porch = <8>;
>>> +                               vsync-len = <0>;
>>> +                       };
>>> +      };
>>>
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe linux-samsung-soc" in
>>> the body of a message to majordomo at vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>
>>>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-samsung-soc" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>
