From: wens@csie.org (Chen-Yu Tsai)
Date: Tue, 25 Oct 2016 16:50:25 +0800
Subject: [PATCH v2 8/8] ARM: dts: sun6i: hummingbird-a31: Enable display
 output through VGA bridge
In-Reply-To: <bac9a59f-df97-245b-f349-bed57dec6aad@codeaurora.org>
References: <20161020034344.14154-1-wens@csie.org>
 <20161020034344.14154-9-wens@csie.org>
 <bac9a59f-df97-245b-f349-bed57dec6aad@codeaurora.org>
Message-ID: <CAGb2v64bMqixiw=kA5_DyncSW7+=dC8foNvOpYUmNAM3zfL0mw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 25, 2016 at 4:13 PM, Archit Taneja <architt@codeaurora.org> wrote:
>
>
> On 10/20/2016 09:13 AM, Chen-Yu Tsai wrote:
>>
>> The Hummingbird A31 board has a RGB-to-VGA bridge which converts RGB
>> output from the LCD interface to VGA signals.
>>
>> Enable this part of the display pipeline.
>
>
> I couldn't find the enable-gpios binding for the bridge that you
> introduced in the previous patch. Is that intentional?

Error on my part. Thanks for spotting that.

ChenYu

>
> Thanks,
> Archit
>
>
>>
>> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
>> ---
>>  arch/arm/boot/dts/sun6i-a31-hummingbird.dts | 56
>> +++++++++++++++++++++++++++++
>>  1 file changed, 56 insertions(+)
>>
>> diff --git a/arch/arm/boot/dts/sun6i-a31-hummingbird.dts
>> b/arch/arm/boot/dts/sun6i-a31-hummingbird.dts
>> index 9a74637f677f..05a49b2147f1 100644
>> --- a/arch/arm/boot/dts/sun6i-a31-hummingbird.dts
>> +++ b/arch/arm/boot/dts/sun6i-a31-hummingbird.dts
>> @@ -63,6 +63,49 @@
>>                 stdout-path = "serial0:115200n8";
>>         };
>>
>> +       bridge {
>> +               compatible = "dumb-vga-dac";
>> +               #address-cells = <1>;
>> +               #size-cells = <0>;
>> +
>> +               ports {
>> +                       #address-cells = <1>;
>> +                       #size-cells = <0>;
>> +
>> +                       port at 0 {
>> +                               #address-cells = <1>;
>> +                               #size-cells = <0>;
>> +                               reg = <0>;
>> +
>> +                               vga_bridge_in: endpoint at 0 {
>> +                                       reg = <0>;
>> +                                       remote-endpoint =
>> <&tcon0_out_vga>;
>> +                               };
>> +                       };
>> +
>> +                       port at 1 {
>> +                               #address-cells = <1>;
>> +                               #size-cells = <0>;
>> +                               reg = <1>;
>> +
>> +                               vga_bridge_out: endpoint at 0 {
>> +                                       reg = <0>;
>> +                                       remote-endpoint = <&vga_con_in>;
>> +                               };
>> +                       };
>> +               };
>> +       };
>> +
>> +       vga {
>> +               compatible = "vga-connector";
>> +
>> +               port {
>> +                       vga_con_in: endpoint {
>> +                               remote-endpoint = <&vga_bridge_out>;
>> +                       };
>> +               };
>> +       };
>> +
>>         wifi_pwrseq: wifi_pwrseq {
>>                 compatible = "mmc-pwrseq-simple";
>>                 reset-gpios = <&pio 6 10 GPIO_ACTIVE_LOW>; /* PG10 */
>> @@ -245,6 +288,19 @@
>>         status = "okay";
>>  };
>>
>> +&tcon0 {
>> +       pinctrl-names = "default";
>> +       pinctrl-0 = <&lcd0_rgb888_pins>;
>> +       status = "okay";
>> +};
>> +
>> +&tcon0_out {
>> +       tcon0_out_vga: endpoint at 0 {
>> +               reg = <0>;
>> +               remote-endpoint = <&vga_bridge_in>;
>> +       };
>> +};
>> +
>>  &uart0 {
>>         pinctrl-names = "default";
>>         pinctrl-0 = <&uart0_pins_a>;
>>
>
> --
> Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
> a Linux Foundation Collaborative Project
