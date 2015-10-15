From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Thu, 15 Oct 2015 10:08:37 +0300
Subject: [PATCH 00/11] ARM: OMAP/DTS: dra7/72-evm/beagle-x15: Audio support
In-Reply-To: <20151012205732.GW23801@atomide.com>
References: <1440400807-32274-1-git-send-email-peter.ujfalusi@ti.com>
 <55F68A60.6050900@ti.com> <20150914162851.GM4215@atomide.com>
 <20151012205732.GW23801@atomide.com>
Message-ID: <561F50F5.9060909@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Tony,

On 10/12/2015 11:57 PM, Tony Lindgren wrote:
> * Tony Lindgren <tony@atomide.com> [150914 09:32]:
>> * Peter Ujfalusi <peter.ujfalusi@ti.com> [150914 01:54]:
>>> Hi Tony,
>>>
>>> On 08/24/2015 10:19 AM, Peter Ujfalusi wrote:
>>>> Hi,
>>>>
>>>> this series will enable analog audio (via onboard aic310x codec) for dra7-evm,
>>>> dra72-evm and am57xx-beagle-x15 boards.
>>>> In these board McASP3 is connected to the codec and for the McASP3 we needed to
>>>> have the DMA crossbar in place since the request lines are not mapped by
>>>> default.
>>>
>>> Did you had a chance to look at this series?
>>
>> Looks OK to me, will look at it more once we have the fixes merged.
>>
>> Paul may have comments on the hwmod chage, looks like you forgot
>> to Cc him on it. Can you please resend that one with Paul in Cc?
> 
> Applying all the dts changes into omap-for-v4.3/dt thanks. Paul
> can pick up the hwmod change then after reviewing it.

Thanks for taking the DTS patches, however if Paul agrees with the way I think we can handle the McASP in DRA7xx then the patch which adds the mcasp3 node to dra7.dtsi needs to be replaced by:

>From b6733f9ca96a997fab3d0455783e875dd9ae032b Mon Sep 17 00:00:00 2001
From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Date: Tue, 24 Feb 2015 15:12:59 +0200
Subject: [PATCH v2 03/12] ARM: DTS: dra7: Add McASP3 node

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 arch/arm/boot/dts/dra7.dtsi | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/arm/boot/dts/dra7.dtsi b/arch/arm/boot/dts/dra7.dtsi
index 8fedddc35999..cde0a3cbf262 100644
--- a/arch/arm/boot/dts/dra7.dtsi
+++ b/arch/arm/boot/dts/dra7.dtsi
@@ -1404,6 +1404,21 @@
 			status = "disabled";
 		};
 
+		mcasp3: mcasp at 48468000 {
+			compatible = "ti,dra7-mcasp-audio";
+			ti,hwmods = "mcasp3";
+			reg = <0x48468000 0x2000>;
+			reg-names = "mpu";
+			interrupts = <GIC_SPI 151 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 150 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "tx", "rx";
+			dmas = <&sdma_xbar 133>, <&sdma_xbar 132>;
+			dma-names = "tx", "rx";
+			clocks = <&mcasp3_aux_gfclk_mux>, <&mcasp3_ahclkx_mux>;
+			clock-names = "fck", "ahclkx";
+			status = "disabled";
+		};
+
 		crossbar_mpu: crossbar at 4a002a48 {
 			compatible = "ti,irq-crossbar";
 			reg = <0x4a002a48 0x130>;
-- 
2.6.1




-- 
P?ter
