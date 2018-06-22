From: pawel.mikolaj.chmiel@gmail.com (=?utf-8?B?UGF3ZcWC?= Chmiel)
Date: Fri, 22 Jun 2018 10:42:22 +0200
Subject: [PATCH 3/7] ARM: dts: s5pv210: Add initial DTS for Samsung Galaxy
 S phone.
In-Reply-To: <CAJKOXPf8cpJ-pivG9j1sCM3aB_-i2n73MoeQKOd4oXxz976EVw@mail.gmail.com>
References: <1529608199-5583-1-git-send-email-pawel.mikolaj.chmiel@gmail.com>
 <1529608199-5583-4-git-send-email-pawel.mikolaj.chmiel@gmail.com>
 <CAJKOXPf8cpJ-pivG9j1sCM3aB_-i2n73MoeQKOd4oXxz976EVw@mail.gmail.com>
Message-ID: <1851346.itd6mG8ZId@acerlaptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday, June 22, 2018 9:49:42 AM CEST Krzysztof Kozlowski wrote:
> On 21 June 2018 at 21:09, Pawe? Chmiel <pawel.mikolaj.chmiel@gmail.com> wrote:
> > Signed-off-by: Pawe? Chmiel <pawel.mikolaj.chmiel@gmail.com>
> 
> Please add commit message. This can be something as simple as "Add
> Samsung Galaxy S DTS which is a commercial phone based on Aries
> family." or something more (e.g. describe what is working).
> 
> > ---
> >  arch/arm/boot/dts/Makefile            |  1 +
> >  arch/arm/boot/dts/s5pv210-galaxys.dts | 72 +++++++++++++++++++++++++++++++++++
> >  2 files changed, 73 insertions(+)
> >  create mode 100644 arch/arm/boot/dts/s5pv210-galaxys.dts
> >
> > diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> > index 7e2424957809..522ebdca1d3d 100644
> > --- a/arch/arm/boot/dts/Makefile
> > +++ b/arch/arm/boot/dts/Makefile
> > @@ -846,6 +846,7 @@ dtb-$(CONFIG_ARCH_S3C64XX) += \
> >         s3c6410-smdk6410.dtb
> >  dtb-$(CONFIG_ARCH_S5PV210) += \
> >         s5pv210-aquila.dtb \
> > +       s5pv210-galaxys.dtb \
> >         s5pv210-goni.dtb \
> >         s5pv210-smdkc110.dtb \
> >         s5pv210-smdkv210.dtb \
> > diff --git a/arch/arm/boot/dts/s5pv210-galaxys.dts b/arch/arm/boot/dts/s5pv210-galaxys.dts
> > new file mode 100644
> > index 000000000000..d435032541a9
> > --- /dev/null
> > +++ b/arch/arm/boot/dts/s5pv210-galaxys.dts
> > @@ -0,0 +1,72 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +
> > +/dts-v1/;
> > +#include <dt-bindings/gpio/gpio.h>
> > +#include <dt-bindings/interrupt-controller/irq.h>
> > +#include <dt-bindings/input/input.h>
> > +#include <dt-bindings/interrupt-controller/irq.h>
> 
> Duplicated inclusion.
> 
> > +#include "s5pv210-aries.dtsi"
> > +
> > +/ {
> > +       model = "Samsung Galaxy S1 (GT-I9000) based on S5PV210";
> > +       compatible = "samsung,galaxys", "samsung,aries", "samsung,s5pv210";
> > +
> > +       chosen {
> > +               bootargs = "console=ttySAC2,115200n8 root=/dev/mmcblk2p1 rw rootwait ignore_loglevel earlyprintk";
> 
> stdout-path = "serial2:115200n8";
> 
> Rest of bootargs should not be here (they are not HW dependent) unless
> you cannot configure them through bootloader?
> 
Stock (proprietary) bootloader is little problematic for me:
- to access it, You need to build special cable.
- i wasn't able to boot any kernel newer than 2.6.35/3.0 on it, without following hack/patch
https://github.com/tom3q/linux/commit/af96ebcba03b607ab93bd5778301890feb038479.patch

I would like to leave those bootargs for now, so anyone can easly test this kernel (just with that one patch),
without breaking booting existing software, so they could easly go back to stock software by just flashing old kernel.
Later it'll be removed because there is initial port of mainline u-boot started for both devices
- currently it can be flashed to device, instead of kernel and boot kernels from onenand/sdcard.
In this way migration from old kernel to new one will be much easier to users (and won't require special tools/cables/etc).


> > +       };
> > +
> > +       nand_pwrseq: nand-pwrseq {
> > +               compatible = "mmc-pwrseq-simple";
> > +               reset-gpios = <&gpj2 7 GPIO_ACTIVE_LOW>;
> > +               pinctrl-names = "default";
> > +               pinctrl-0 = <&massmemory_en>;
> 
> massmemory_en is used only here, so please move it from aries.dtsi.
> The same applies to all other possible properties if they are not used
> in other DTSes including aries.
> 
> > +       };
> > +
> > +       gpio-keys {
> > +               compatible = "gpio-keys";
> > +
> > +               power {
> > +                       label = "power";
> > +                       gpios = <&gph2 6 GPIO_ACTIVE_LOW>;
> > +                       linux,code = <KEY_POWER>;
> > +                       wakeup-source;
> > +               };
> > +
> > +               vol-down {
> > +                       label = "volume_down";
> > +                       gpios = <&gph3 1 GPIO_ACTIVE_LOW>;
> > +                       linux,code = <KEY_VOLUMEDOWN>;
> > +               };
> > +
> > +               vol-up {
> > +                       label = "volume_up";
> > +                       gpios = <&gph3 2 GPIO_ACTIVE_LOW>;
> > +                       linux,code = <KEY_VOLUMEUP>;
> > +               };
> > +
> > +               home {
> > +                       label = "home";
> > +                       gpios = <&gph3 5 GPIO_ACTIVE_LOW>;
> > +                       linux,code = <KEY_HOME>;
> > +                       wakeup-source;
> > +               };
> > +       };
> > +};
> > +
> > +&pinctrl0 {
> > +       massmemory_en: massmemory-en {
> 
> Oh wait, I see massmemory_en here... so there is no need of such in aries.dtsi.
> 
> Best regards,
> Krzysztof
> 
> > +               samsung,pins = "gpj2-7";
> > +               samsung,pin-function = <EXYNOS_PIN_FUNC_OUTPUT>;
> > +               samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
> > +               samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
> > +       };
> > +};
> > +
> > +&sdhci0 {
> > +       bus-width = <4>;
> > +       non-removable;
> > +       mmc-pwrseq = <&nand_pwrseq>;
> > +       pinctrl-0 = <&sd0_clk &sd0_cmd &sd0_bus4>;
> > +       pinctrl-names = "default";
> > +       status = "okay";
> > +};
> > --
> > 2.7.4
> >
> 
