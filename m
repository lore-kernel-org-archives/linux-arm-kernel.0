From: linux.amoon@gmail.com (Anand Moon)
Date: Thu, 27 Oct 2016 17:19:11 +0530
Subject: Pinctrl nodes missing for USB
In-Reply-To: <20161026175827.GA10224@kozik-lap>
References: <CANAwSgQ=pp93tDAERQ1iaryY3_pVhTeun=RaTo9ws1UKtS1PhA@mail.gmail.com>
 <20161026165348.GA5600@kozik-lap>
 <CANAwSgSfRVDA_MXN9S+G0-u-mQNhPuPJ65FT_Y-ZH5nFpX4ptg@mail.gmail.com>
 <20161026175827.GA10224@kozik-lap>
Message-ID: <CANAwSgQNXLo43+chXMRuRSpGvwt5RpNw5wefD6vBjpCaf++3MQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Krzysztof,

On 26 October 2016 at 23:28, Krzysztof Kozlowski <krzk@kernel.org> wrote:
> On Wed, Oct 26, 2016 at 11:15:51PM +0530, Anand Moon wrote:
>> Hi Krzysztof
>>
>> On 26 October 2016 at 22:23, Krzysztof Kozlowski <krzk@kernel.org> wrote:
>> > On Wed, Oct 26, 2016 at 05:56:54PM +0530, Anand Moon wrote:
>> >> Hi All,
>> >>
>> >> I have tried to enable CONFIG_DEBUG_PINCTRL=y on Odroid XU4.
>> >> Just to try to understand the feature.
>> >> Is this feature suppoted for USB nodes.
>> >>
>> >> Below is the output of failed to pase pinctrl for USB nodes via dts.
>> >
>> > I do not see any question here...
>> >
>> > Anyway the devices not instantiated from DT will have such warning and
>> > USB devices are not present in DT, from obvious reasons... However what
>> > surprises me is why pinctrl_dt_to_map() was called for USB devices?
>> >
>> > Best regards,
>> > Krzysztof
>> >
>> [snip]
>>
>> Sorry. I was just referring HK odroidxu3 dts for reference for dwc3 controller.
>>
>> https://github.com/hardkernel/linux/blob/odroidxu3-3.10.y/arch/arm/boot/dts/exynos5422-odroidxu3.dts#L525
>>
>> I am just trying to understand if such a configuration possible for
>> dwc3 controllers.
>
> What do you mean by "configuration"? Which configuration?

I am just elaborating what I have understood below.

>
> Best regards,
> Krzysztof
>
Adding Vivek Gautam +

Apologize for my poor English and explanation of what I am trying to
work on or understand the feature related to dwc3

For some time I am trying to figure out the performance issue of USB
3.0 on Odroid XU4 boards.

[1] https://lkml.org/lkml/2015/2/2/259

Following above patch helps registration of USB storage device to
"Super-Speed" ie

root at odroidcsh:/usr/src/odroidxu3-4.y-devel# lsusb -t
/:  Bus 06.Port 1: Dev 1, Class=root_hub, Driver=xhci-hcd/1p, 5000M
/:  Bus 05.Port 1: Dev 1, Class=root_hub, Driver=xhci-hcd/1p, 480M
    |__ Port 1: Dev 3, If 0, Class=Vendor Specific Class, Driver=r8152, 480M
/:  Bus 04.Port 1: Dev 1, Class=root_hub, Driver=xhci-hcd/1p, 5000M
    |__ Port 1: Dev 2, If 0, Class=Hub, Driver=hub/2p, 5000M
        |__ Port 1: Dev 3, If 0, Class=Mass Storage, Driver=usb-storage, 5000M
        |__ Port 2: Dev 4, If 0, Class=Mass Storage, Driver=usb-storage, 5000M
/:  Bus 03.Port 1: Dev 1, Class=root_hub, Driver=xhci-hcd/1p, 480M
    |__ Port 1: Dev 2, If 0, Class=Hub, Driver=hub/2p, 480M
/:  Bus 02.Port 1: Dev 1, Class=root_hub, Driver=exynos-ohci/3p, 12M
/:  Bus 01.Port 1: Dev 1, Class=root_hub, Driver=exynos-ehci/3p, 480M

But the performance is not good enough to work on the storage device.
we cannot compile whole kernel or source code on this drive attached.

So did some investigation on this by comparing the dts nodes and driver.
I was looking into some logic to do some "gpio_reset" which will help
reset the driver.

But after studying the driver code of OdroidXU4 Hardkernel,
I tried to understand the requirement of gpio pin controlled by pinctrl.

Sorry I am not an expert in the internal of the the pinctrl and
internal gpio bus.
So I have just for my understanding created this small patch to help
elaborate this feature.

--------------------------------------------------------------------------------------------
root at odroidcsh:/usr/src/odroidxu3-4.y-devel# git diff
arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi
diff --git a/arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi
b/arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi
index 246d298..03e90b6 100644
--- a/arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi
+++ b/arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi
@@ -560,6 +560,24 @@
                samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
                samsung,pin-drv = <EXYNOS5420_PIN_DRV_LV1>;
        };
+
+       b_sess0_irq: b-sess0-irq {
+               samsung,pins = "gpx3-5";
+               samsung,pin-function = <0xf>;
+               samsung,pin-pud = <0>;
+       };
+
+       b_sess1_irq: b-sess1-irq {
+               samsung,pins = "gpx3-4";
+               samsung,pin-function = <0xf>;
+               samsung,pin-pud = <0>;
+       };
+
+       id2_irq: id2-irq {
+               samsung,pins = "gpx1-1";
+               samsung,pin-function = <0xf>;
+               samsung,pin-pud = <0>;
+        };
 };

 &pinctrl_1 {
@@ -569,6 +587,12 @@
                samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
                samsung,pin-drv = <EXYNOS5420_PIN_DRV_LV1>;
        };
+
+        id1_irq: id1-irq {
+                samsung,pins = "gpc1-0";
+                samsung,pin-function = <0xf>;
+                samsung,pin-pud = <3>;
+        };
 };

 &tmu_cpu0 {
@@ -604,11 +628,23 @@
 /* usbdrd_dwc3_1 mode customized in each board */

 &usbdrd3_0 {
+       samsung,bsess-gpio = <&gpx3 5 0xf>;
+       pinctrl-names = "default";
+       pinctrl-0 = <&b_sess0_irq>;
+       samsung,id-gpio = <&gpc1 0 0xf>;
+       pinctrl-names = "default";
+       pinctrl-0 = <&id1_irq>;
        vdd33-supply = <&ldo9_reg>;
        vdd10-supply = <&ldo11_reg>;
 };

 &usbdrd3_1 {
+       samsung,bsess-gpio = <&gpx3 4 0xf>;
+       pinctrl-names = "default";
+       pinctrl-0 = <&b_sess1_irq>;
+       samsung,id-gpio = <&gpx1 1 0xf>;
+       pinctrl-names = "default";
+       pinctrl-0 = <&id2_irq>;
        vdd33-supply = <&ldo9_reg>;
        vdd10-supply = <&ldo11_reg>;
 };
--------------------------------------------------------------------------------------------
Here is the core logic as I understood out of the driver code from
OdroidXU3 Hardkernel.
so we have samsung,bsess-gpio and samsung,id-gpio two gpio pins control
by the exynos-dwc3 driver in the Odroid Hardkernel

# drivers/usb/dwc3/dwc3-exynos.c

tries to register interrupts on these gpio pin to control the flow via gpio-irq.
Also It monitor the vbus controller changes

Below irq to monitor id-gpio thread.

https://github.com/hardkernel/linux/blob/odroidxu3-3.10.y/drivers/usb/dwc3/dwc3-exynos.c#L217

Below irq to monitor bsess-gpio thread.

https://github.com/hardkernel/linux/blob/odroidxu3-3.10.y/drivers/usb/dwc3/dwc3-exynos.c#L230

Once again I am not an expert in this configuration, I am just trying
to map the feature and the code.
Please let me know If my understanding is wrong or the feature should
work little bit different.

I am poor in English to explain technically details.
If any body have any other input on this please let me know.

-Best Regards
Anand Moon
