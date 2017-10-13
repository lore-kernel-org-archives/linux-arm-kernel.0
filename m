From: emil.renner.berthing@gmail.com (Emil Renner Berthing)
Date: Fri, 13 Oct 2017 17:15:50 +0200
Subject: [RESEND PATCH 2/2] arm64: dts: rockchip: Enable edp disaplay on
 kevin
In-Reply-To: <CANBLGcyqbfmVJ75Nu_RtVD2TUJs_pXZ+jZBhQ7J0E9U4DvwtSg@mail.gmail.com>
References: <20171013104138.3216-1-jeffy.chen@rock-chips.com>
 <20171013104138.3216-3-jeffy.chen@rock-chips.com> <3037285.0MAZvLKA4I@phil>
 <CANBLGcyqbfmVJ75Nu_RtVD2TUJs_pXZ+jZBhQ7J0E9U4DvwtSg@mail.gmail.com>
Message-ID: <CANBLGczVi9=+3um-jMmRxbtG+WsJNDXeKTFQYCZ=e=gnNj67gA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 13 October 2017 at 15:42, Emil Renner Berthing
<emil.renner.berthing@gmail.com> wrote:
> On 13 October 2017 at 15:25, Heiko Stuebner <heiko@sntech.de> wrote:
>> Am Freitag, 13. Oktober 2017, 18:41:38 CEST schrieb Jeffy Chen:
>>> Add edp panel and enable related nodes on kevin.
>>>
>>> Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>
>>
>> does this actually work with mainline kernel sources?
>>
>> Sean Paul did look at making the edp work on Chromebooks recently,
>> but it seemed there were still parts missing to make it actually display
>> something.
>
> That's funny. I've been using your own similar patch on my Chromebook
> Plus for a while now and it works "fine":
> https://github.com/esmil/linux/commits/kevin
>
> ..where fine means I can't get the armsoc X11 driver to work, but
> modesetting works and screenblank seems to freeze the kernel.
>
> I'll test this version of the dts changes as soon as I'm near my
> chrombook again.

I've just tested this series and the internal screen works with this
too. Screenblank still seems to freeze the kernel though. Eg.
# setterm --powersave on
# setterm --blank 1
#  < wait 1 minute >

But getting output on the screen is progress ;)

As for the spi change suspend now works too, which it didn't before,
but the screen just didn't come up properly after the suspend. I could
still ssh into it after suspend though.

/Emil

>>>
>>>  arch/arm64/boot/dts/rockchip/rk3399-gru-kevin.dts | 29 +++++++++++++++++++++++
>>>  arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi      | 16 +++++++++++++
>>>  2 files changed, 45 insertions(+)
>>>
>>> diff --git a/arch/arm64/boot/dts/rockchip/rk3399-gru-kevin.dts b/arch/arm64/boot/dts/rockchip/rk3399-gru-kevin.dts
>>> index a3d3cea7dc4f..bc67b19f0af5 100644
>>> --- a/arch/arm64/boot/dts/rockchip/rk3399-gru-kevin.dts
>>> +++ b/arch/arm64/boot/dts/rockchip/rk3399-gru-kevin.dts
>>> @@ -93,6 +93,18 @@
>>>               pwm-delay-us = <10000>;
>>>       };
>>>
>>> +     edp_panel: edp-panel {
>>> +             compatible = "sharp,lq123p1jx31", "simple-panel";
>>> +             backlight = <&backlight>;
>>> +             power-supply = <&pp3300_disp>;
>>> +
>>> +             ports {
>>> +                     panel_in_edp: endpoint {
>>> +                             remote-endpoint = <&edp_out_panel>;
>>> +                     };
>>> +             };
>>> +     };
>>> +
>>>       thermistor_ppvar_bigcpu: thermistor-ppvar-bigcpu {
>>>               compatible = "murata,ncp15wb473";
>>>               pullup-uv = <1800000>;
>>> @@ -264,6 +276,23 @@ ap_i2c_dig: &i2c2 {
>>>       };
>>>  };
>>>
>>> +&edp {
>>> +     status = "okay";
>>> +
>>> +     ports {
>>> +             edp_out: port at 1 {
>>> +                     reg = <1>;
>>> +                     #address-cells = <1>;
>>> +                     #size-cells = <0>;
>>> +
>>> +                     edp_out_panel: endpoint at 0 {
>>> +                             reg = <0>;
>>> +                             remote-endpoint = <&panel_in_edp>;
>>> +                     };
>>> +             };
>>> +     };
>>> +};
>>> +
>>>  &ppvar_bigcpu_pwm {
>>>       regulator-min-microvolt = <798674>;
>>>       regulator-max-microvolt = <1302172>;
>>> diff --git a/arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi b/arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi
>>> index 5772c52fbfd3..470105d651c2 100644
>>> --- a/arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi
>>> +++ b/arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi
>>> @@ -927,6 +927,22 @@ ap_i2c_audio: &i2c8 {
>>>       dr_mode = "host";
>>>  };
>>>
>>> +&vopb {
>>> +     status = "okay";
>>> +};
>>> +
>>> +&vopb_mmu {
>>> +     status = "okay";
>>> +};
>>> +
>>> +&vopl {
>>> +     status = "okay";
>>> +};
>>> +
>>> +&vopl_mmu {
>>> +     status = "okay";
>>> +};
>>> +
>>>  #include <arm/cros-ec-keyboard.dtsi>
>>>  #include <arm/cros-ec-sbs.dtsi>
>>>
>>>
>>
>>
>>
>> _______________________________________________
>> Linux-rockchip mailing list
>> Linux-rockchip at lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-rockchip
