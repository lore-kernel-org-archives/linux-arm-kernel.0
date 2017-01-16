From: martin.blumenstingl@googlemail.com (Martin Blumenstingl)
Date: Mon, 16 Jan 2017 10:44:36 +0100
Subject: [PATCH 3/4] ARM64: dts: meson-gx-p23x-q20x: enable the Bluetooth
 module
In-Reply-To: <042e2824-0772-cf27-ffa5-4c3b2af7c92b@suse.de>
References: <20170115223255.10350-1-martin.blumenstingl@googlemail.com>
 <20170115223255.10350-4-martin.blumenstingl@googlemail.com>
 <042e2824-0772-cf27-ffa5-4c3b2af7c92b@suse.de>
Message-ID: <CAFBinCC2SzLtq9-tUFUu5CH_Q8tJSdJHc_93UmcgoTOOxnD5=Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 16, 2017 at 1:47 AM, Andreas F?rber <afaerber@suse.de> wrote:
> Am 15.01.2017 um 23:32 schrieb Martin Blumenstingl:
>> This takes the Bluetooth module out of reset (the reset line is
>> connected to GPIOX_17) and enables uart_A which is used to configure the
>> module.
>> This is identical for all boards which inherit meson-gx-p23x-q20x:
>> - GXL S905D P230
>> - GXL S905D P231
>> - GXM S912 Q200
>> - GXM S912 Q201
>>
>> To get the HCI interface up one has to install bluez-utils and run:
>> hciattach -s115200 /dev/ttyAML1 bcm43xx 2000000 flow -
>>
>> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
>> ---
>>  arch/arm64/boot/dts/amlogic/meson-gx-p23x-q20x.dtsi | 12 +++++++++++-
>>  1 file changed, 11 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/arm64/boot/dts/amlogic/meson-gx-p23x-q20x.dtsi b/arch/arm64/boot/dts/amlogic/meson-gx-p23x-q20x.dtsi
>> index 7a078bef04cd..7db779048091 100644
>> --- a/arch/arm64/boot/dts/amlogic/meson-gx-p23x-q20x.dtsi
>> +++ b/arch/arm64/boot/dts/amlogic/meson-gx-p23x-q20x.dtsi
>> @@ -48,6 +48,7 @@
>>  / {
>>       aliases {
>>               serial0 = &uart_AO;
>> +             serial1 = &uart_A;
>>       };
>>
>>       chosen {
>> @@ -94,12 +95,21 @@
>>
>>       sdio_pwrseq: sdio-pwrseq {
>>               compatible = "mmc-pwrseq-simple";
>> -             reset-gpios = <&gpio GPIOX_6 GPIO_ACTIVE_LOW>;
>> +             reset-gpios = <&gpio GPIOX_6 GPIO_ACTIVE_LOW>,
>> +                           <&gpio GPIOX_17 GPIO_ACTIVE_LOW>;
>>               clocks = <&wifi32k>;
>>               clock-names = "ext_clock";
>>       };
>>  };
>>
>> +/* This is connected to the Bluetooth module of the wifi/BT combo chip: */
>> +&uart_A {
>> +     status = "okay";
>> +     pinctrl-0 = <&uart_a_pins &uart_a_cts_rts_pins>;
>
> Nit: <&uart_a_pins>, <&uart_a_cts_rts_pins> please, like you've done for
> reset-gpios above.
indeed, not sure why I mixed it up. should I also send an update for
the pinctrl-documentation (as it seems to use the same pattern): [0]?

> Regards,
> Andreas
>
>> +     pinctrl-names = "default";
>> +     uart-has-rtscts;
>> +};
>> +
>>  /* This UART is brought out to the DB9 connector */
>>  &uart_AO {
>>       status = "okay";
>>
>
>
> --
> SUSE Linux GmbH, Maxfeldstr. 5, 90409 N?rnberg, Germany
> GF: Felix Imend?rffer, Jane Smithard, Graham Norton
> HRB 21284 (AG N?rnberg)


[0] http://lxr.free-electrons.com/source/Documentation/devicetree/bindings/pinctrl/pinctrl-bindings.txt?v=4.9#L74
