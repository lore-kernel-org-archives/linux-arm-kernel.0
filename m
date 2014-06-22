From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Sun, 22 Jun 2014 15:40:00 -0400
Subject: [PATCH] dt/documentation: add specification of dma bus information
In-Reply-To: <CAL_JsqLYho6dRA=-ovKqF7H4EGHJcH_aN3ywd+76oXSprfTMbQ@mail.gmail.com>
References: <1401981720-6946-1-git-send-email-santosh.shilimkar@ti.com>
 <CAL_JsqJAtWnHKPVpDsdOOzT_X=npc3hroLNTGqULM2SJr=1OEg@mail.gmail.com>
 <53A46CB7.1030109@ti.com> <4193075.zZSpRTFEYz@wuerfel>
 <53A48553.2080504@ti.com>
 <CAL_JsqLYho6dRA=-ovKqF7H4EGHJcH_aN3ywd+76oXSprfTMbQ@mail.gmail.com>
Message-ID: <53A73110.60405@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 20 June 2014 03:46 PM, Rob Herring wrote:
> On Fri, Jun 20, 2014 at 2:02 PM, Santosh Shilimkar
> <santosh.shilimkar@ti.com> wrote:
>> On Friday 20 June 2014 02:56 PM, Arnd Bergmann wrote:
>>> On Friday 20 June 2014 13:17:43 Santosh Shilimkar wrote:
>>>>>> +                       dma-coherent;
>>>>>> +                       dma-ranges;
>>>>>> +
>>>>>> +                       dwc3 at 2690000 {
>>>>>> +                               compatible = "synopsys,dwc3";
>>>>>> +                               [...]
>>>>>> +                       };
>>>>>
>>>>> This example is a bit strange. I don't understand the relationship
>>>>> between keystone-dwc3 and synopsys,dwc3, nor do I want to. I'd prefer
>>>>> to see a simple example here.
>>>
>>>
>>>>> dma-ranges is a property of the parent which you show, but
>>>>> dma-coherent originally was a property of the bus master itself. While
>>>>> we need to support that, are we changing that? We need to be clear on
>>>>> where the property belongs even if the kernel is more lax.
>>>>>
>>>> I don't think we are changing it fundamentally but may be I missing
>>>> your point. The dma-coherent as is now a per-device property.
>>>> USB is one of the bus master supports coherency and hence showed
>>>> up in above example.
>>>
>>> I think it's enough if you just drop the "synopsys,dwc3" node and the
>>> intermediate dma-ranges property from the example, leaving the
>>> dma-coherent property in the "ti,keystone-dwc3" node.
>>>
>> Thanks Arnd. That should avoid the confusion. Just to see if Rob is
>> fine by it, the example will look like below.
> 
> Yes. Looks fine.
> 
Great. Updated version 2 below.

>From 7df26004fe11b7d3ef9592161205c69e1fb663be Mon Sep 17 00:00:00 2001
From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Date: Fri, 20 Jun 2014 11:01:54 -0400
Subject: [PATCH v2] dt/documentation: add specification of dma bus information

Recently we introduced the generic device tree infrastructure for couple of DMA
bus parameter, dma-ranges and dma-coherent. Update the documentation so that
its useful for future users.

The "dma-ranges" property is intended to be used for describing the
configuration of DMA bus RAM addresses and its offset w.r.t CPU addresses.

The "dma-coherent" property is intended to be used for identifying devices
supported coherent DMA operations.

Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Grant Likely <grant.likely@linaro.org>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Pawel Moll <pawel.moll@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Ian Campbell <ijc+devicetree@hellion.org.uk>
Cc: Kumar Gala <galak@codeaurora.org>
Acked-by: Shawn Guo <shawn.guo@freescale.com>
Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 Documentation/devicetree/booting-without-of.txt |   53 +++++++++++++++++++++++
 1 file changed, 53 insertions(+)

diff --git a/Documentation/devicetree/booting-without-of.txt b/Documentation/devicetree/booting-without-of.txt
index 1f013bd..7768518 100644
--- a/Documentation/devicetree/booting-without-of.txt
+++ b/Documentation/devicetree/booting-without-of.txt
@@ -51,6 +51,8 @@ Table of Contents
 
   VIII - Specifying device power management information (sleep property)
 
+  IX - Specifying dma bus information
+
   Appendix A - Sample SOC node for MPC8540
 
 
@@ -1332,6 +1334,57 @@ reasonably grouped in this manner, then create a virtual sleep controller
 (similar to an interrupt nexus, except that defining a standardized
 sleep-map should wait until its necessity is demonstrated).
 
+IX - Specifying dma bus information
+
+Some devices may have DMA memory range shifted relatively to the beginning of
+RAM, or even placed outside of kernel RAM. For example, the Keystone 2 SoC
+worked in LPAE mode with 4G memory has:
+- RAM range: [0x8 0000 0000, 0x8 FFFF FFFF]
+- DMA range: [  0x8000 0000,   0xFFFF FFFF]
+and DMA range is aliased into first 2G of RAM in HW.
+
+In such cases, DMA addresses translation should be performed between CPU phys
+and DMA addresses. The "dma-ranges" property is intended to be used
+for describing the configuration of such system in DT.
+
+In addition, each DMA master device on the DMA bus may or may not support
+coherent DMA operations. The "dma-coherent" property is intended to be used
+for identifying devices supported coherent DMA operations in DT.
+
+* DMA Bus master
+Optional property:
+- dma-ranges: <prop-encoded-array> encoded as arbitrary number of triplets of
+	(child-bus-address, parent-bus-address, length). Each triplet specified
+	describes a contiguous DMA address range.
+	The dma-ranges property is used to describe the direct memory access (DMA)
+	structure of a memory-mapped bus whose device tree parent can be accessed
+	from DMA operations originating from the bus. It provides a means of
+	defining a mapping or translation between the physical address space of
+	the bus and the physical address space of the parent of the bus.
+	(for more information see ePAPR specification)
+
+* DMA Bus child
+Optional property:
+- dma-ranges: <empty> value. if present - It means that DMA addresses
+	translation has to be enabled for this device.
+- dma-coherent: Present if dma operations are coherent
+
+Example:
+soc {
+		compatible = "ti,keystone","simple-bus";
+		ranges = <0x0 0x0 0x0 0xc0000000>;
+		dma-ranges = <0x80000000 0x8 0x00000000 0x80000000>;
+
+		[...]
+
+		usb: usb at 2680000 {
+			compatible = "ti,keystone-dwc3";
+
+			[...]
+			dma-coherent;
+		};
+};
+
 Appendix A - Sample SOC node for MPC8540
 ========================================
 
-- 
1.7.9.5
