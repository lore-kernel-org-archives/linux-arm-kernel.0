From: hdegoede@redhat.com (Hans de Goede)
Date: Mon, 7 Nov 2016 10:26:02 +0100
Subject: [linux-sunxi] Re: [RFC PATCH] ARM: dts: add panel and tcon nodes
 to Allwinner A33 Q8 tablet dts
In-Reply-To: <2578261478451207@web24j.yandex.ru>
References: <20161106111119.14927-1-icenowy@aosc.xyz>
 <948897e3-12a2-b02c-ed26-929921ff04b2@redhat.com>
 <2578261478451207@web24j.yandex.ru>
Message-ID: <a8cbb66c-246d-287c-33e4-13d6e3c59084@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 06-11-16 17:53, Icenowy Zheng wrote:
>
>
> 06.11.2016, 22:27, "Hans de Goede" <hdegoede@redhat.com>:
>> Hi,
>>
>> On 06-11-16 12:11, Icenowy Zheng wrote:
>>>  All A33 Q8 tablets features a LCD panel, with a resolution of either
>>>  800x480 or 1024x600.
>>>
>>>  Add "bone" device nodes to the device tree.
>>
>> Bone ?
>>
>>>  Signed-off-by: Icenowy Zheng <icenowy@aosc.xyz>
>>
>> He, as discussed in the other thread since sun8i-a33-q8-tablet.dts
>> is used for both 800x480 and 1024x600 versions we really need to
>> introduce new sun8i-a33-q8-tablet-800x600.dts and
>> sun8i-a33-q8-tablet-1024x600.dts files, which include
>> sun8i-a33-q8-tablet.dts and then add just the panel bits; and patch
>> newer u-boots to use those instead.
>>
>> This way people who stick with an old u-boot will just not get
>> the drm driver, rather then all of a sudden getting a wrong
>> resolution.
>>
>> Icenowy, can you please also submit a matching u-boot patch
>> (both the new dts file, as well as updating the defconfig you
>>   use to the new dts file)?
>
> Could you choose a compatible for 1024x600 variant?

Lets just add a sun8i-a33-q8-tablet-800x600.dts now and then
I will add a sun8i-a33-q8-tablet-1024x600.dts file later.

Regards,

Hans



>
> (Since I have never such a Q8 tablet)
>
>>
>> Regards,
>>
>> Hans
>>
>>>  ---
>>>
>>>  Maybe it will be better to add them to sun8i-q8-reference-tablet.dtsi, as
>>>  these pin configurations are part of reference design of both A23 and A33,
>>>  not only restricted to Q8.
>>>
>>>  The DTS file is tested by me, after cherry-picks this patch from Chen-Yu Tsai:
>>>  https://github.com/wens/linux/commit/2823b887a289fbee5f97f3c6b45ed6c74a6368c6
>>>
>>>  And add these commands to my U-Boot boot command:
>>>
>>>  fdt addr 0x43000000
>>>  fdt resize
>>>  fdt set /panel compatible "urt,umsh-8596md-t"
>>>  fdt set /panel status "okay"
>>>  fdt set /display-engine status "okay"
>>>  fdt set /soc at 01c00000/lcd-controller at 01c0c000 status "okay"
>>>
>>>   arch/arm/boot/dts/sun8i-a33-q8-tablet.dts | 44 +++++++++++++++++++++++++++++++
>>>   1 file changed, 44 insertions(+)
>>>
>>>  diff --git a/arch/arm/boot/dts/sun8i-a33-q8-tablet.dts b/arch/arm/boot/dts/sun8i-a33-q8-tablet.dts
>>>  index b0bc236..871a20c 100644
>>>  --- a/arch/arm/boot/dts/sun8i-a33-q8-tablet.dts
>>>  +++ b/arch/arm/boot/dts/sun8i-a33-q8-tablet.dts
>>>  @@ -47,4 +47,48 @@
>>>   / {
>>>           model = "Q8 A33 Tablet";
>>>           compatible = "allwinner,q8-a33", "allwinner,sun8i-a33";
>>>  +
>>>  + panel: panel {
>>>  + /* compatible should be set according to the panel */
>>>  + pinctrl-names = "default";
>>>  + pinctrl-0 = <&lcd_en_q8>;
>>>  + backlight = <&backlight>;
>>>  + enable-gpios = <&pio 7 7 GPIO_ACTIVE_HIGH>; /* PH7 */
>>>  + power-supply = <&reg_dc1sw>;
>>>  + status = "disabled";
>>>  + #address-cells = <1>;
>>>  + #size-cells = <0>;
>>>  +
>>>  + port at 0 {
>>>  + reg = <0>;
>>>  + #address-cells = <1>;
>>>  + #size-cells = <0>;
>>>  +
>>>  + panel_input: endpoint at 0 {
>>>  + reg = <0>;
>>>  + remote-endpoint = <&tcon0_out_lcd>;
>>>  + };
>>>  + };
>>>  + };
>>>  +};
>>>  +
>>>  +&tcon0 {
>>>  + pinctrl-names = "default";
>>>  + pinctrl-0 = <&lcd_rgb666_pins>;
>>>  +};
>>>  +
>>>  +&tcon0_out {
>>>  + tcon0_out_lcd: endpoint at 0 {
>>>  + reg = <0>;
>>>  + remote-endpoint = <&panel_input>;
>>>  + };
>>>  +};
>>>  +
>>>  +&pio {
>>>  + lcd_en_q8: lcd_en at 0 {
>>>  + allwinner,pins = "PH7";
>>>  + allwinner,function = "gpio_out";
>>>  + allwinner,drive = <SUN4I_PINCTRL_10_MA>;
>>>  + allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
>>>  + };
>>>   };
>
