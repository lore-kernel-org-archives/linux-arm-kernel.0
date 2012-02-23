From: santosh.shilimkar@ti.com (Shilimkar, Santosh)
Date: Thu, 23 Feb 2012 14:10:30 +0530
Subject: [PATCH 2/2] ARM: OMAP: Fix section mismatch warning for
 platform_cpu_die()
In-Reply-To: <20120223074504.GZ14173@pengutronix.de>
References: <1329980310-9007-1-git-send-email-santosh.shilimkar@ti.com>
 <1329980310-9007-3-git-send-email-santosh.shilimkar@ti.com>
 <20120223074504.GZ14173@pengutronix.de>
Message-ID: <CAMQu2gxLJOY8HzMO71dHTr8VfQ+G=KJP+wv5SwvrktTi7b82+A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2012/2/23 Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>:
> Hello,
>
> On Thu, Feb 23, 2012 at 12:28:30PM +0530, Santosh Shilimkar wrote:
>> WARNING: vmlinux.o(.text+0x226d0):
>> Section mismatch in reference from the function
>> platform_cpu_die() to the function .cpuinit.text:omap4_hotplug_cpu()
>> The function platform_cpu_die() references
>> the function __cpuinit omap4_hotplug_cpu().
>> This is often because platform_cpu_die lacks a __cpuinit
>> annotation or the annotation of omap4_hotplug_cpu is wrong.
>>
>> Thanks to Russell King for suggesting __ref annotation trick
>> just like it's parent function for this warning becasue __cupinit
> s/it's/its/; s/becasue/because/; s/cup/cpu/
>
> Having said that I think the grammar is broken, too. Maybe:
>
> ? ? ? ?Thanks to Russell King for suggesting to use __ref instead of
> ? ? ? ?the initial (and wrong) approach to use __cpuinit.
>
> (But note I'm not a native speaker, too)
>
Thanks for fixing the grammar. :)
Updated patch below with comments corrected as per
your suggestion.

Regards
Santosh

>From a53dd2d822dc9c9894c2f2f3d239af341c66d891 Mon Sep 17 00:00:00 2001
From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Date: Wed, 22 Feb 2012 16:10:04 +0530
Subject: [PATCH 2/2] ARM: OMAP: Fix section mismatch warning for
platform_cpu_die()

WARNING: vmlinux.o(.text+0x226d0):
Section mismatch in reference from the function
platform_cpu_die() to the function .cpuinit.text:omap4_hotplug_cpu()
The function platform_cpu_die() references
the function __cpuinit omap4_hotplug_cpu().
This is often because platform_cpu_die lacks a __cpuinit
annotation or the annotation of omap4_hotplug_cpu is wrong.

Thanks to Russell King for suggesting to use __ref instead of
the initial (and wrong) approach to use __cpuinit.

Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 arch/arm/mach-omap2/omap-hotplug.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/omap-hotplug.c
b/arch/arm/mach-omap2/omap-hotplug.c
index adbe4d8..56c345b 100644
--- a/arch/arm/mach-omap2/omap-hotplug.c
+++ b/arch/arm/mach-omap2/omap-hotplug.c
@@ -33,7 +33,7 @@ int platform_cpu_kill(unsigned int cpu)
  * platform-specific code to shutdown a CPU
  * Called with IRQs disabled
  */
-void platform_cpu_die(unsigned int cpu)
+void __ref platform_cpu_die(unsigned int cpu)
 {
 	unsigned int this_cpu;

-- 
1.7.4.1
-------------- next part --------------
A non-text attachment was scrubbed...
Name: 0002-ARM-OMAP-Fix-section-mismatch-warning-for-platform_c.patch
Type: application/octet-stream
Size: 1343 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120223/148fa317/attachment.obj>
