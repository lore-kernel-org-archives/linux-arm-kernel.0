From: robherring2@gmail.com (Rob Herring)
Date: Wed, 11 Jul 2012 13:06:29 -0500
Subject: [PATCH 1/9] ARM: vexpress: remove automatic errata workaround
 selection
In-Reply-To: <20120711155303.GF13498@mudshark.cambridge.arm.com>
References: <1342013791-19516-1-git-send-email-pawel.moll@arm.com>
 <1342013791-19516-2-git-send-email-pawel.moll@arm.com>
 <4FFD956D.7020901@gmail.com>
 <20120711151846.GE13498@mudshark.cambridge.arm.com>
 <4FFD9F7F.7020103@gmail.com>
 <20120711155303.GF13498@mudshark.cambridge.arm.com>
Message-ID: <4FFDC0A5.7000300@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/11/2012 10:53 AM, Will Deacon wrote:
> On Wed, Jul 11, 2012 at 04:45:03PM +0100, Rob Herring wrote:
>> On 07/11/2012 10:18 AM, Will Deacon wrote:
>>> The problem I have with the current scheme for vexpress is that you can't
>>> disable the workarounds when you know they are not needed. The Kconfig
>>> *forces* them to be enabled -- that's certainly not right. Of the
>>> workarounds in question, ARM_ERRATA_720789 is not runtime enabled and I
>>> would like to deselect if when running on my A5, A7 or A15 cores. The
>>> description clearly states it's an A9 erratum, so I don't think users will
>>> have any difficulty knowing that they don't need it for other cores
>>> (although I agree that it should be enabled for single zimage).
>>>
>>> The defconfig changes were just a courtesy to reflect the change in the
>>> Kconfig, I'm happy for them to be dropped.
>>
>> It's not a courtesy. It's the only place it remains documented other
>> than git history.
> 
> Sorry, I also meant to say that we could select them for the CA9X4 platform,
> so the information wouldn't be lost.
> 
>> What if you just make the existing config option user selectable?
> 
> I think that's harder than it sounds. How would you do this without adding
> vexpress-specific dependencies to the erratum config option itself? I
> suppose you could make them default y for multi-platform kernels (I can't
> remember if Arnd's single zImage changes had a config option for that).
> 

You're not following what I meant. Something like this:

diff --git a/arch/arm/mach-vexpress/Kconfig b/arch/arm/mach-vexpress/Kconfig
index cf8730d..fc3730f 100644
--- a/arch/arm/mach-vexpress/Kconfig
+++ b/arch/arm/mach-vexpress/Kconfig
@@ -2,7 +2,8 @@ menu "Versatile Express platform type"
        depends on ARCH_VEXPRESS

 config ARCH_VEXPRESS_CORTEX_A5_A9_ERRATA
-       bool
+       bool "Enable A5 and A9 only errata work-arounds"
+       default y
        select ARM_ERRATA_720789
        select ARM_ERRATA_751472
        select PL310_ERRATA_753970 if CACHE_PL310
@@ -14,7 +15,6 @@ config ARCH_VEXPRESS_CORTEX_A5_A9_ERRATA

 config ARCH_VEXPRESS_CA9X4
        bool "Versatile Express Cortex-A9x4 tile"
-       select ARCH_VEXPRESS_CORTEX_A5_A9_ERRATA
        select ARM_GIC
        select CPU_V7
        select HAVE_SMP
@@ -22,7 +22,6 @@ config ARCH_VEXPRESS_CA9X4

 config ARCH_VEXPRESS_DT
        bool "Device Tree support for Versatile Express platforms"
-       select ARCH_VEXPRESS_CORTEX_A5_A9_ERRATA
        select ARM_GIC
        select ARM_PATCH_PHYS_VIRT
        select AUTO_ZRELADDR

>> That doesn't solve the problem with this errata. Obviously on my newer
>> A9, I wouldn't want this errata enabled either (assuming there is
>> measurable impact). So we should come up with a better solution for
>> single kernel image.
> 
> Agreed, and I think that's a discussion we should have with a wider
> audience. For some of the simpler workarounds we could probably use code
> patching like we do for the SMP/UP stuff and like (I think) powerpc does
> too.
> 
> Will
> 
