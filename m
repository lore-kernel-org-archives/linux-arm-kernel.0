From: yegorslists@googlemail.com (Yegor Yefremov)
Date: Tue, 6 Jun 2017 16:33:23 +0200
Subject: [PATCH RFC 2/5] ARM: dts: am335x-baltos: use IRQ_TYPE_* to
 specify irq flags
In-Reply-To: <CAGm1_ktJp+3t9ExuFJhKTmbM63yt-82PGP26KkEHGqK-tnfWRg@mail.gmail.com>
References: <20170526180609.2699-1-uwe@kleine-koenig.org>
 <20170526180609.2699-2-uwe@kleine-koenig.org>
 <20170531171932.GH3730@atomide.com>
 <CAGm1_ktJp+3t9ExuFJhKTmbM63yt-82PGP26KkEHGqK-tnfWRg@mail.gmail.com>
Message-ID: <CAGm1_kuKxVOetzMLdnVO+xQ7egX+paqOHLS+ckz6nFwKD5QBuQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 31, 2017 at 7:22 PM, Yegor Yefremov
<yegorslists@googlemail.com> wrote:
> Hi Uwe, Tony,
>
> On Wed, May 31, 2017 at 7:19 PM, Tony Lindgren <tony@atomide.com> wrote:
>> * Uwe Kleine-K?nig <uwe@kleine-koenig.org> [170526 11:09]:
>>> According to the binding documentation and the source code the omap-gpio
>>> controller takes IRQ_TYPE_* as its flags values, not GPIO_ACTIVE_*.
>>>
>>> This patch uses the right variable type which yields the same result
>>> when compiled. Note that this might be wrong and actually
>>> IRQ_TYPE_LEVEL_LOW is intended by the dt author.
>>>
>>> Signed-off-by: Uwe Kleine-K?nig <uwe@kleine-koenig.org>
>>> ---
>>> Hello,
>>>
>>> can somebody with the hardware or it's documentation please check which
>>> flag is the right one?
>>
>> I'll wait on this one until we have somebody test it.
>
> I'll look at it this week.

This is what works for me (at least it doesn't produce "irq 88: nobody
cared (try booting with the "irqpoll" option)").

As for tca6416 it is working with all possible settings (from
IRQ_TYPE_EDGE_RISING till IRQ_TYPE_LEVEL_LOW). "cat /proc/interrupts"
always shows Level type:

47:          5  44e07000.gpio  20 Level     1-0020

diff --git a/arch/arm/boot/dts/am335x-baltos-ir3220.dts
b/arch/arm/boot/dts/am335x-baltos-ir3220.dts
index 1b215c4..944b095 100644
--- a/arch/arm/boot/dts/am335x-baltos-ir3220.dts
+++ b/arch/arm/boot/dts/am335x-baltos-ir3220.dts
@@ -85,7 +85,7 @@
                gpio-controller;
                #gpio-cells = <2>;
                interrupt-parent = <&gpio0>;
-               interrupts = <20 IRQ_TYPE_EDGE_RISING>;
+               interrupts = <20 IRQ_TYPE_LEVEL_LOW>;
                pinctrl-names = "default";
                pinctrl-0 = <&tca6416_pins>;
        };
diff --git a/arch/arm/boot/dts/am335x-baltos-ir5221.dts
b/arch/arm/boot/dts/am335x-baltos-ir5221.dts
index 832ead8..ae5692b 100644
--- a/arch/arm/boot/dts/am335x-baltos-ir5221.dts
+++ b/arch/arm/boot/dts/am335x-baltos-ir5221.dts
@@ -94,7 +94,7 @@
                gpio-controller;
                #gpio-cells = <2>;
                interrupt-parent = <&gpio0>;
-               interrupts = <20 IRQ_TYPE_EDGE_RISING>;
+               interrupts = <20 IRQ_TYPE_LEVEL_LOW>;
                pinctrl-names = "default";
                pinctrl-0 = <&tca6416_pins>;
        };
diff --git a/arch/arm/boot/dts/am335x-baltos.dtsi
b/arch/arm/boot/dts/am335x-baltos.dtsi
index e3234d4..863942d 100644
--- a/arch/arm/boot/dts/am335x-baltos.dtsi
+++ b/arch/arm/boot/dts/am335x-baltos.dtsi
@@ -249,7 +249,7 @@
                gpio-controller;
                #gpio-cells = <2>;
                interrupt-parent = <&gpio1>;
-               interrupts = <28 IRQ_TYPE_EDGE_RISING>;
+               interrupts = <28 IRQ_TYPE_EDGE_FALLING>;
                pinctrl-names = "default";
                pinctrl-0 = <&tps65910_pins>;
        };

Yegor
