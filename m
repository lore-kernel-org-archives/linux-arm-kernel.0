From: Sudeep.KarkadaNagesha@arm.com (Sudeep KarkadaNagesha)
Date: Thu, 17 Oct 2013 11:55:20 +0100
Subject: [PATCH 2/2] ARM: vexpress: Enable platform-specific options in
 defconfig
In-Reply-To: <1382006321.27517.119.camel@hornet>
References: <1381930594-1701-1-git-send-email-pawel.moll@arm.com>	
 <1381930594-1701-3-git-send-email-pawel.moll@arm.com>	
 <525FB49C.7040607@arm.com> <1382006321.27517.119.camel@hornet>
Message-ID: <525FC218.7020404@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Pawel,

On 17/10/13 11:38, Pawel Moll wrote:
> On Thu, 2013-10-17 at 10:57 +0100, Sudeep KarkadaNagesha wrote:
>>> +CONFIG_MTD_PHYSMAP=y
>>> +CONFIG_MTD_PHYSMAP_OF=y
>>
>> This could cause issues with CPUIdle on TC2. Since TC2 reset vector is in NOR
>> flash, NOR flash has to be in Read mode when CPU resets and enter reset vector.
>> But what I have seen is that NOR flash is left in Read Identifier Mode after the
>> driver is initialised. So we need to make sure NOR device is in Read mode
>> whenever CPU enters deeper C-states and also may have to register notifiers
>> which seems overkill IMO. Most of the platform have separate(or secure) flash
>> for this reason.
> 
> Oh boy, yes, I remember this now.
> 
>> Is it possible to disable flash on TC2 only in it's DT something like
>>          flash at 0,00000000 {
>>                 status = "disabled";
>>          };	
> 
> But flash is innocent, really... I may just remove CPU_IDLE for the time
> being.
> 

I tried disabling flash device only on TC2 in DT which seem to work for me.

Regards,
Sudeep

-->8
diff --git a/arch/arm/boot/dts/vexpress-v2p-ca15_a7.dts b/arch/arm/boot/dts/vexpress-v2p-ca15_a7.dts
index d2836a2..f649c58 100644
--- a/arch/arm/boot/dts/vexpress-v2p-ca15_a7.dts
+++ b/arch/arm/boot/dts/vexpress-v2p-ca15_a7.dts
@@ -418,3 +418,12 @@
                /include/ "vexpress-v2m-rs1.dtsi"
        };
 };
+/ {
+       smb {
+               motherboard {
+                       flash at 0,00000000 {
+                               status = "disabled";
+                       };
+               };
+       };
+};
