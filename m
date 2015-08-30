From: andrew.c12@gmail.com (Andrew Innes)
Date: Sun, 30 Aug 2015 09:11:08 +0800
Subject: Trying to get a Pogoplug v4 board description added
In-Reply-To: <20150829153646.GB31545@lunn.ch>
References: <CAAKvOShfrRn-E9o2Gjek5xb8xfGucUmO_FRu7c3T7S2V=co-2g@mail.gmail.com>
 <20150829153646.GB31545@lunn.ch>
Message-ID: <CAAKvOSg7h=YOVWQ1gKLv-WGw6BGF_rBfp+Zb=za7FkKE2Zwbhg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I have found the author and I have sent ebbix a pivate message
informing him of what I'm doing and asking for his email address.
http://archlinuxarm.org/forum/
There is a severe lack of licence information.

The following is me trying to find the author.

This is the first dts I remember being available
Postby ebbix ? Tue Mar 11, 2014 4:25 pm
http://archlinuxarm.org/forum/viewtopic.php?f=53&t=6974

ebbix posting it to a thread for bodhi
http://forum.doozan.com/read.php?3,14697,17934,quote=1

The fIle I included in the previous e-mail is from this 4.1 kernel
maintained by bodhi <mibodhi@gmail.com> just with the commented out
sections removed
He credits ebbix for the original dts in the 3.17 credits
Credits: Thanks the ALARM devs at Arch site for the GoFlex Home and
Pogo E02 DTS, and forum member ebbix for Pogo V4 DTS, and pkirchhofer
for the NSA325 DTS.
http://forum.doozan.com/read.php?2,12096


Then there are various different versions around the Internet

moonman made a committ on github containing it
https://github.com/archlinuxarm/PKGBUILDs/blob/master/core/linux-kirkwood-dt/pogoplugv4_fdt.patch

line 2041
https://github.com/davidedg/NAS-NSA325-mod/blob/57c412d98295ee25a53f9a2f326a4e44159074ab/kernel/linux-4.1.0-kirkwood-tld-2.patch

Openwrt
https://www.mail-archive.com/openwrt-devel at lists.openwrt.org/msg27147.html

Even a bsd lisenced one from freebsd that looks like it was written from scratch
https://bz-attachments.freebsd.org/attachment.cgi?id=155083

On Sat, Aug 29, 2015 at 11:36 PM, Andrew Lunn <andrew@lunn.ch> wrote:
> On Sat, Aug 29, 2015 at 01:04:54PM +0800, Andrew Innes wrote:
>> Hi Andrew
>> Sorry to contact you like this but I was a little bit unsure on how to
>> go about getting a device tree description added to the kernel.
>
> No problems as a first contact. However, the rest should be done on
> list.
>
>> I own a couple of these devices and there is an out of tree patch with
>> this description.
>> I haven't seen any attempt to get them added on the device tree
>> mailing list archives so I thought I would try.
>
> Device tree would actually be the wrong list. You should send it to
> the four maintainers, me, Jason, Gregory and Sebastian.  You can find
> emails addresses in the MAINTAINERS file, section:
>
> ARM/Marvell Kirkwood and Armada 370, 375, 38x, XP SOC support
>
> and also CC linux-arm-kernel at lists.infradead.org
>
>> Would you be able to offer any advice on the quality of the included file.
>
> At a first look, it seems pretty good. Once you post it, i will take a
> proper look.
>
> What does need to be sorted out is copyright and license. Who actually
> wrote it, and what license is it released under. Can you try to find
> that out?
>
> Thanks
>         Andrew
>
>
>>
>>
>> kirkwood-pogoplug_v4.dts
>> /dts-v1/;
>>
>> #include "kirkwood.dtsi"
>> #include "kirkwood-6192.dtsi"
>>
>> / {
>>         model = "Pogoplug v4";
>>         compatible = "cloudengines,pogoplug-v4",
>> "cloudengines,pogoplug-mobile", "marvell,kirkwood-88f6192",
>> "marvell,kirkwood";
>>
>>         memory {
>>                 device_type = "memory";
>>                 reg = <0x00000000 0x8000000>;
>>         };
>>
>>         chosen {
>>                 bootargs = "console=ttyS0,115200";
>>                 stdout-path = &uart0;
>>         };
>>
>>         mbus {
>>                 pcie-controller {
>>                         status = "okay";
>>
>>                         pcie at 1,0 {
>>                                 status = "okay";
>>                         };
>>                 };
>>         };
>>
>>         ocp at f1000000 {
>>                 pinctrl: pin-controller at 10000 {
>>                         pmx_led_green: pmx-led-green {
>>                                 marvell,pins = "mpp22";
>>                                 marvell,function = "gpio";
>>                         };
>>                         pmx_led_red: pmx-led-red {
>>                                 marvell,pins = "mpp24";
>>                                 marvell,function = "gpio";
>>                         };
>>                         pmx_button_eject: pmx-button-eject {
>>                                 marvell,pins = "mpp29";
>>                                 marvell,function = "gpio";
>>                         };
>>                 };
>>
>>                 serial at 12000 {
>>                         status = "okay";
>>                 };
>>
>>                 sata at 80000 {
>>                         status = "okay";
>>                         nr-ports = <1>;
>>                         phys = <&sata_phy0>;
>>                         phy-names = "port0";
>>                 };
>>
>>                 mvsdio at 90000 {
>>                         pinctrl-0 = <&pmx_sdio>;
>>                         pinctrl-names = "default";
>>                         status = "okay";
>>                         cd-gpios = <&gpio0 27 GPIO_ACTIVE_HIGH>;
>>                         /* No WP GPIO */
>>                 };
>>         };
>>
>>         gpio-leds {
>>                 compatible = "gpio-leds";
>>                 pinctrl-0 = <&pmx_led_red &pmx_led_green>;
>>                 pinctrl-names = "default";
>>
>>                 health {
>>                         label = "status:green:health";
>>                         gpios = <&gpio0 22 GPIO_ACTIVE_LOW>;
>>                         default-state = "keep";
>>                 };
>>                 fault {
>>                         label = "status:red:fault";
>>                         gpios = <&gpio0 24 GPIO_ACTIVE_LOW>;
>>                 };
>>         };
>>
>>         gpio_keys {
>>                 compatible = "gpio-keys";
>>                 #address-cells = <1>;
>>                 #size-cells = <0>;
>>                 pinctrl-0 = <&pmx_button_eject>;
>>                 pinctrl-names = "default";
>>
>>                 button at 1 {
>>                         label = "Eject Button";
>>                         linux,code = <KEY_EJECTCD>;
>>                         gpios = <&gpio0 29 GPIO_ACTIVE_LOW>;
>>                 };
>>         };
>> };
>>
>> &nand {
>>         status = "okay";
>>
>>         partition at 0 {
>>                 label = "u-boot";
>>                 reg = <0x0000000 0x200000>;
>>                 read-only;
>>         };
>>
>>         partition at 200000 {
>>                 label = "uImage";
>>                 reg = <0x200000 0x300000>;
>>         };
>>
>>         partition at 500000 {
>>                 label = "uImage2";
>>                 reg = <0x500000 0x300000>;
>>         };
>>
>>         partition at 800000 {
>>                 label = "failsafe";
>>                 reg = <0x800000 0x800000>;
>>         };
>>
>>         partition at 1000000 {
>>                 label = "root";
>>                 reg = <0x1000000 0x7000000>;
>>         };
>> };
>>
>> &mdio {
>>         status = "okay";
>>
>>         ethphy0: ethernet-phy at 0 {
>>                 reg = <0>;
>>         };
>> };
>>
>> &eth0 {
>>         status = "okay";
>>         ethernet0-port at 0 {
>>                 phy-handle = <&ethphy0>;
>>         };
>> };
