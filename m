From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Wed, 17 Jan 2018 19:48:46 +0100 (CET)
Subject: DT binding for staging vchiq
In-Reply-To: <3379fe3c-62ef-85a1-0073-da184e32cdf8@orpaltech.com>
References: <3379fe3c-62ef-85a1-0073-da184e32cdf8@orpaltech.com>
Message-ID: <299185620.10681.1516214926155@email.1und1.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sergey,

> Sergey Suloev <ssuloev@orpaltech.com> hat am 17. Januar 2018 um 14:45 geschrieben:
> 
> 
> Hello everyone,
> 
> I am trying to use RPi3  VC4 gpu with Qt5 quick/qml. When I run my 
> application Qt5 is always complaining about missing vchiq device in the 
> system. I know there is vchiq driver available in staging.
> 
> My questions are:
> 
> 1) What is the current status of the driver ? Is it working at all?

>From my point of view it's still experimental. It's mostly the same driver as in downstream, but its function highly dependents on the configuration:

arm/bcm2835_defconfig = should work
arm/multi_v7_defconfig = may work
arm64/defconfig = won't work [1]

In order to the function of the driver use vchiq_test from the Raspberry Pi userland.

Btw testers are always welcome :-)

> 
> can it be used with Qt5 ?

If your application works with the downstream kernel, there is a high chance.

> 
> 2) Can I have a working example of DT binding for the driver ?

This is one of my many TODOs [2] to provide a binding document. Please try the following old patch. The cache-line-size depends on the used SoC (BCM2835 = 32, BCM2836/BCM2837 = 64).

Good luck

diff --git a/arch/arm/boot/dts/bcm2835-rpi.dtsi b/arch/arm/boot/dts/bcm2835-rpi.dtsi
index e55b362..7398b96 100644
--- a/arch/arm/boot/dts/bcm2835-rpi.dtsi
+++ b/arch/arm/boot/dts/bcm2835-rpi.dtsi
@@ -27,6 +27,14 @@
                        firmware = <&firmware>;
                        #power-domain-cells = <1>;
                };
+
+               vchiq: vchiq {
+                       compatible = "brcm,bcm2835-vchiq";
+                       reg = <0x7e00b840 0xf>;
+                       interrupts = <0 2>;
+                       cache-line-size = <64>;
+                       firmware = <&firmware>;
+		};
        };
 };


[1] - https://github.com/lategoodbye/rpi-zero/issues/23
[2] - https://github.com/lategoodbye/rpi-zero/issues/8

> 
> Thanks
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
