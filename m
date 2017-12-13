From: eballetbo@gmail.com (Enric Balletbo Serra)
Date: Wed, 13 Dec 2017 11:28:35 +0100
Subject: [PATCH 3/3] arm64: dts: rockchip: add extcon nodes and enable
 tcphy.
In-Reply-To: <20171206172919.GA87458@google.com>
References: <20171206111008.3079-1-enric.balletbo@collabora.com>
 <20171206111008.3079-3-enric.balletbo@collabora.com>
 <20171206172919.GA87458@google.com>
Message-ID: <CAFqH_53drWwMJ0g=ouuhMRaircGM_ccga8Cconff-LESzQBfwQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Brian,

2017-12-06 18:29 GMT+01:00 Brian Norris <briannorris@chromium.org>:
> + Alex, Jeffy, Frank Wang
>
> Hi,
>
> On Wed, Dec 06, 2017 at 12:10:08PM +0100, Enric Balletbo i Serra wrote:
>> Enable tcphy and create the cros-ec's extcon node for the USB Type-C port.
>>
>> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
>> ---
>>  arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi | 26 ++++++++++++++++++++++++++
>>  1 file changed, 26 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi b/arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi
>> index 470105d..03f1950 100644
>> --- a/arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi
>> +++ b/arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi
>> @@ -855,6 +855,20 @@ ap_i2c_audio: &i2c8 {
>>                       compatible = "google,cros-ec-pwm";
>>                       #pwm-cells = <1>;
>>               };
>> +
>> +             usbc_extcon0: extcon at 0 {
>> +                     compatible = "google,extcon-usbc-cros-ec";
>> +                     google,usb-port-id = <0>;
>> +
>> +                     #extcon-cells = <0>;
>> +             };
>> +
>> +             usbc_extcon1: extcon at 1 {
>> +                     compatible = "google,extcon-usbc-cros-ec";
>> +                     google,usb-port-id = <1>;
>> +
>> +                     #extcon-cells = <0>;
>> +             };
>>       };
>>  };
>>
>> @@ -865,6 +879,16 @@ ap_i2c_audio: &i2c8 {
>>       rockchip,hw-tshut-polarity = <1>; /* tshut polarity 0:LOW 1:HIGH */
>>  };
>>
>> +&tcphy0 {
>> +     status = "okay";
>> +     extcon = <&usbc_extcon0>;
>> +};
>> +
>> +&tcphy1 {
>> +     status = "okay";
>> +     extcon = <&usbc_extcon1>;
>> +};
>> +
>>  &u2phy0 {
>>       status = "okay";
>>  };
>> @@ -911,6 +935,7 @@ ap_i2c_audio: &i2c8 {
>>
>>  &usbdrd3_0 {
>>       status = "okay";
>> +     extcon = <&usbc_extcon0>;
>>  };
>>
>>  &usbdrd_dwc3_0 {
>> @@ -920,6 +945,7 @@ ap_i2c_audio: &i2c8 {
>>
>>  &usbdrd3_1 {
>>       status = "okay";
>> +     extcon = <&usbc_extcon1>;
>>  };
>>
>>  &usbdrd_dwc3_1 {
>
> Seems OK.
>
> Also, IIUC, I think if we ever want to support dual-role/OTG, we need an
> extcon reference in the USB2/OTG PHY that serves these ports too. i.e.,
> u2phy0 and u2phy1? Notably, the PHY driver supports the extcon
> properties, but it's not documented in
> Documentation/devicetree/bindings/phy/phy-rockchip-inno-usb2.txt yet (we
> should probably get that fixed).
>

I'll take a look at this and send a separate patchset. Thanks.

  Enric

> So, anyway, maybe the above isn't a blocker for this patch. Just noticed
> it while reading. Assuming the driver stuff falls into place:
>
> Reviewed-by: Brian Norris <briannorris@chromium.org>
