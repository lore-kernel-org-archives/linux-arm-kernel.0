From: rogershimizu@gmail.com (Roger Shimizu)
Date: Sat, 20 Jun 2015 21:36:54 +0900
Subject: [PATCH 1/2] ARM: dts: add buffalo linkstation ls-wxl/wsxl
In-Reply-To: <20150619221448.GA1116@lunn.ch>
References: <1434713319-8691-1-git-send-email-rogershimizu@gmail.com>
 <1434713319-8691-2-git-send-email-rogershimizu@gmail.com>
 <20150619221448.GA1116@lunn.ch>
Message-ID: <CAEQ9gEkSYtBtmzN3+0FXFeYJZfGFQNQz=nX+54LDTbniQREqPQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Andrew,

Thanks for your comments!

Let me clarify and confirm with you before sending the modified patches.

>> +     compatible = "buffalo,linkstation,lswxl", "buffalo,lswxl", "marvell,kirkwood-88f6281", "marvell,kirkwood";
>
> Compatibility strings don't normally have two , in them. I would drop
> the first one.

So the following would be OK for you?
+     compatible = "buffalo,lswxl", "marvell,kirkwood-88f6281",
"marvell,kirkwood";

>> +                             compatible = "m25p40";
>
> There should be a vendor in this compatibility string, probably "st".

I wrote this based on kirkwood-lsxl.dtsi and other dts files.
Maybe those are quite old, and I'll follow your suggestion.

>> +             button at 2 {
>> +                     label = "Power-on Switch";
>> +                     linux,code = <KEY_RESERVED>;
>> +                     linux,input-type = <5>;
>> +                     gpios = <&gpio1 42 GPIO_ACTIVE_LOW>;
>> +             };
>
> Why did you pick these values? <KEY_POWER> is a more common code for a
> power button.

I copied this part exact from kirkwood-lsxl.dtsi, only changed the
gpio pin number.
Please tell me how to proceed since I actually don't have much knowledge on it.

>> +             button at 3 {
>> +                     label = "Power-auto Switch";
>> +                     linux,code = <KEY_ESC>;
>> +                     linux,input-type = <5>;
>> +                     gpios = <&gpio1 43 GPIO_ACTIVE_LOW>;
>
> Also a bit unusual. What is this button used for?

This button is for auto power-on when getting WOL (wake-on-lan) signal.
Also copied from kirkwood-lsxl.dtsi.

>> +             led at 5 {
>> +                     label = "lswxl:red:func";
>> +                     gpios = <&gpio1 5 GPIO_ACTIVE_LOW>;
>> +                     default-state = "keep";
>> +                     linux,default-trigger = "heartbeat";
>> +             };
>
> I know of one maintainer who will not like the heartbeat here.  Also,
> default-state and heartbeat at the same time?

I'll remove these two lines.

>> +&eth0 {
>> +     status = "okay";
>> +     reg = <0x76000 0x4000>;
>> +     clocks = <&gate_clk 19>;
>> +     ethernet0-port at 0 {
>> +             phy-handle = <&ethphy1>;
>> +             interrupts = <15>;
>> +     };
>
> Why reg, clocks and interrupts here? These values belong to eth1.

Originally, I tried the same as the dts for ls-wvl, but I see no eth0
but only eth1 in linux system,
even "ifconfig -a" command which list all interfaces including un-used ones.
So I change this part of dts to make the only network interface as eth0.
For both ls-wxl and ls-wsxl boards, I confirmed both working well with
this setting.

Thanks and looking forward to your comment again.

Cheers,
Roger

On Sat, Jun 20, 2015 at 7:14 AM, Andrew Lunn <andrew@lunn.ch> wrote:
> Hi Roger
>
> These two look quite good. Just some minor comments. Many of them
> apply to both dts files.
>
>> +/ {
>> +     model = "Buffalo Linkstation LS-WXL/WSXL";
>> +     compatible = "buffalo,linkstation,lswxl", "buffalo,lswxl", "marvell,kirkwood-88f6281", "marvell,kirkwood";
>
> Compatibility strings don't normally have two , in them. I would drop
> the first one.
>
>> +                     pmx_led_function_red: pmx-led-function_red {
>
> The second _red should be -red.
>> +             spi at 10600 {
>> +                     status = "okay";
>> +
>> +                     m25p40 at 0 {
>> +                             #address-cells = <1>;
>> +                             #size-cells = <1>;
>> +                             compatible = "m25p40";
>
> There should be a vendor in this compatibility string, probably "st".
>
>> +             button at 2 {
>> +                     label = "Power-on Switch";
>> +                     linux,code = <KEY_RESERVED>;
>> +                     linux,input-type = <5>;
>> +                     gpios = <&gpio1 42 GPIO_ACTIVE_LOW>;
>> +             };
>
> Why did you pick these values? <KEY_POWER> is a more common code for a
> power button.
>
>> +
>> +             button at 3 {
>> +                     label = "Power-auto Switch";
>> +                     linux,code = <KEY_ESC>;
>> +                     linux,input-type = <5>;
>> +                     gpios = <&gpio1 43 GPIO_ACTIVE_LOW>;
>
> Also a bit unusual. What is this button used for?
>
>> +             led at 5 {
>> +                     label = "lswxl:red:func";
>> +                     gpios = <&gpio1 5 GPIO_ACTIVE_LOW>;
>> +                     default-state = "keep";
>> +                     linux,default-trigger = "heartbeat";
>> +             };
>
> I know of one maintainer who will not like the heartbeat here.  Also,
> default-state and heartbeat at the same time?
>
>> +&eth0 {
>> +     status = "okay";
>> +     reg = <0x76000 0x4000>;
>> +     clocks = <&gate_clk 19>;
>> +     ethernet0-port at 0 {
>> +             phy-handle = <&ethphy1>;
>> +             interrupts = <15>;
>> +     };
>
> Why reg, clocks and interrupts here? These values belong to eth1.
>
> Thanks
>
>     Andrew
