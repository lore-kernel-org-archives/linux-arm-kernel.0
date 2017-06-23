From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 23 Jun 2017 16:38:35 +0200
Subject: [GIT PULL] ARM: mvebu: dt64 for v4.13 (#2)
In-Reply-To: <87shiqydwj.fsf@free-electrons.com>
References: <877f041a4p.fsf@free-electrons.com>
 <CAK8P3a3UuLFVxZv1o1+gKSafsGgV=vgWRM_yjnT_E4fAUPZx8g@mail.gmail.com>
 <87wp82yeng.fsf@free-electrons.com>
 <CAK8P3a1awsqu5eN4eMPMmiZ-JXn64wA+y-LUR0EdHjYiCRK+Bg@mail.gmail.com>
 <87shiqydwj.fsf@free-electrons.com>
Message-ID: <CAK8P3a3XTz_DkUsRumQz2OB_qEE2mxUFagfq2sGpAHuFDCiXGg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 23, 2017 at 4:30 PM, Gregory CLEMENT
<gregory.clement@free-electrons.com> wrote:
> Hi Arnd,
>
>  On ven., juin 23 2017, Arnd Bergmann <arnd@arndb.de> wrote:
>
>> On Fri, Jun 23, 2017 at 4:14 PM, Gregory CLEMENT
>> <gregory.clement@free-electrons.com> wrote:
>>> Hi Arnd,
>>>
>>>  On ven., juin 23 2017, Arnd Bergmann <arnd@arndb.de> wrote:
>>>
>>>
>>>>
>>>>
>>>> Please send a revert for that, and remove the code that tries to
>>>> parse the dma-mask from DT from that driver!
>>>
>>> I see on IRC you agree with Antoine about it the driver part. For the DT
>>> part do you want a PR with the revert or just the patch alone?
>>
>> Either way is fine, or just let me know (here or on IRC) if I should
>> just revert the patch and add an explanation myself.
>
> If you can do it, it's better. You know better than me why we should
> revert this patch! :)

No worries, I applied this patch now:

>From 2b29ca22ed8a79ef1942b6546ccab5953678028d Mon Sep 17 00:00:00 2001
From: Arnd Bergmann <arnd@arndb.de>
Date: Fri, 23 Jun 2017 16:33:43 +0200
Subject: [PATCH] Revert "arm64: dts: marvell: add dma-mask in crypto nodes for
 7k/8k"

As I found by chance while merging another patch, the usage of
a dma-mask in this DT node is wrong for multiple reasons:

- dma-masks are a Linux specific concept, not a general
  hardware feature
- In DT, we use the "dma-ranges" property to describe how DMA
  addresses related between devices.
- The 40-bit mask appears to be completely unnecessary here, as
  the SoC cannot address that much memory anyway, so simply
  asking for a 64-bit mask (as supported by the device) should
  succeed anyway.

The patch to remove the parsing of the property is getting merged
through the crypto tree.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>

diff --git a/arch/arm64/boot/dts/marvell/armada-cp110-master.dtsi
b/arch/arm64/boot/dts/marvell/armada-cp110-master.dtsi
index f611e843094c..726528ce54e9 100644
--- a/arch/arm64/boot/dts/marvell/armada-cp110-master.dtsi
+++ b/arch/arm64/boot/dts/marvell/armada-cp110-master.dtsi
@@ -270,7 +270,6 @@
                                interrupt-names = "mem", "ring0", "ring1",
                                "ring2", "ring3", "eip";
                                clocks = <&cpm_clk 1 26>;
-                               dma-mask = <0xff 0xffffffff>;
                        };
                };

diff --git a/arch/arm64/boot/dts/marvell/armada-cp110-slave.dtsi
b/arch/arm64/boot/dts/marvell/armada-cp110-slave.dtsi
index 84d3bd80eb51..95f8e5f607f6 100644
--- a/arch/arm64/boot/dts/marvell/armada-cp110-slave.dtsi
+++ b/arch/arm64/boot/dts/marvell/armada-cp110-slave.dtsi
@@ -261,7 +261,6 @@
                                interrupt-names = "mem", "ring0", "ring1",
                                                  "ring2", "ring3", "eip";
                                clocks = <&cps_clk 1 26>;
-                               dma-mask = <0xff 0xffffffff>;
                                /*
                                 * The cryptographic engine found on the cp110
                                 * master is enabled by default at the SoC
