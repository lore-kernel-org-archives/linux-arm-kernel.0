From: wens@csie.org (Chen-Yu Tsai)
Date: Mon, 26 May 2014 12:23:09 +0800
Subject: [PATCH 22/22] ARM: sun8i: dt: Add Ippo-q8h v5 support
In-Reply-To: <20140525193955.GB10768@lukather>
References: <1400831485-28576-1-git-send-email-wens@csie.org>
 <1400831485-28576-23-git-send-email-wens@csie.org>
 <20140525193955.GB10768@lukather>
Message-ID: <CAGb2v64EHLsj-cy13yf28K8vkTJUCv95q=x-7c2yiHQ=uBm-sw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 26, 2014 at 3:39 AM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> On Fri, May 23, 2014 at 03:51:25PM +0800, Chen-Yu Tsai wrote:
>> The Ippo-q8h is a tablet circiut board commonly found in cheap Android
>> tablets with A23 SoCs. There are at least 2 versions of the board, with
>> different peripherals, such as WiFi chips.
>>
>> This patch add supports for v5 of such boards, which has a ESP8089 WiFi
>> chip (not supported) connected to mmc1.
>>
>> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
>> ---
>>  arch/arm/boot/dts/Makefile                  |  2 ++
>>  arch/arm/boot/dts/sun8i-a23-ippo-q8h-v5.dts | 51 +++++++++++++++++++++++++++++
>>  2 files changed, 53 insertions(+)
>>  create mode 100644 arch/arm/boot/dts/sun8i-a23-ippo-q8h-v5.dts
>>
>> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
>> index 6967393..f809a53 100644
>> --- a/arch/arm/boot/dts/Makefile
>> +++ b/arch/arm/boot/dts/Makefile
>> @@ -354,6 +354,8 @@ dtb-$(CONFIG_MACH_SUN7I) += \
>>       sun7i-a20-cubietruck.dtb \
>>       sun7i-a20-i12-tvbox.dtb \
>>       sun7i-a20-olinuxino-micro.dtb
>> +dtb-$(CONFIG_MACH_SUN8I) += \
>> +     sun8i-a23-ippo-q8h-v5.dtb
>>  dtb-$(CONFIG_ARCH_TEGRA) += tegra20-harmony.dtb \
>>       tegra20-iris-512.dtb \
>>       tegra20-medcom-wide.dtb \
>> diff --git a/arch/arm/boot/dts/sun8i-a23-ippo-q8h-v5.dts b/arch/arm/boot/dts/sun8i-a23-ippo-q8h-v5.dts
>> new file mode 100644
>> index 0000000..7d0bd97
>> --- /dev/null
>> +++ b/arch/arm/boot/dts/sun8i-a23-ippo-q8h-v5.dts
>> @@ -0,0 +1,51 @@
>> +/*
>> + * Copyright 2014 Chen-Yu Tsai
>> + *
>> + * Chen-Yu Tsai <wens@csie.org>
>> + *
>> + * The code contained herein is licensed under the GNU General Public
>> + * License. You may obtain a copy of the GNU General Public License
>> + * Version 2 or later at the following locations:
>> + *
>> + * http://www.opensource.org/licenses/gpl-license.html
>> + * http://www.gnu.org/copyleft/gpl.html
>> + */
>> +
>> +/dts-v1/;
>> +/include/ "sun8i-a23.dtsi"
>> +
>> +/ {
>> +     model = "Ippo Q8H Dual Core Tablet (v5)";
>> +     compatible = "ippo,q8h-v5", "allwinner,sun8i-a23";
>> +
>> +     chosen {
>> +             bootargs = "earlyprintk console=ttyS0,115200";
>> +     };
>
> You should probably add the memory node here too.

OK.

>> +
>> +     soc at 01c00000 {
>> +             uart0: serial at 01c28000 {
>> +                     pinctrl-names = "default";
>> +                     pinctrl-0 = <&uart0_pins_a>;
>> +                     status = "okay";
>> +             };
>> +
>> +             i2c0: i2c at 01c2ac00 {
>> +                     pinctrl-names = "default";
>> +                     pinctrl-0 = <&i2c0_pins_a>;
>> +                     status = "okay";
>> +             };
>> +
>> +             i2c1: i2c at 01c2b000 {
>> +                     pinctrl-names = "default";
>> +                     pinctrl-0 = <&i2c1_pins_a>;
>> +                     status = "okay";
>> +             };
>
> What are the two i2c busses wired to?

i2c0 has the capacitive touch panel controller gsl1680 @ 0x40.

i2c1 has something (gsensor maybe) connected @ 0x15.
The FEX file lists the gsensor on i2c1, but with the address as 0x18.
I may need to boot back to stock Android to figure it out.

i2c2 has the camera sensor (GC0309) control connected to it @ 0x66.
I didn't list it because I overlooked it, and i2cdetect hangs.
It seems to need AXP PMIC support to activate the regulators.

AFAIK, the kernel doesn't have drivers for these devices,
so how would we list them?

>> +             r_uart: serial at 01f02800 {
>> +                     pinctrl-names = "default";
>> +                     pinctrl-0 = <&r_uart_pins_a>;
>> +                     status = "okay";
>> +             };
>> +     };
>> +};
>> +
>> --
>> 2.0.0.rc2
>>
>
> Thanks,
> Maxime

Thanks,
ChenYu
