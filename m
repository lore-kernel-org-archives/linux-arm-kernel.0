From: felix.yang@huawei.com (Yangfei (Felix))
Date: Mon, 15 Oct 2012 10:30:21 -0000
Subject: =?gb2312?B?tPC4tDogSGFyZGNvZGVkIGluc3RydWN0aW9uIGNhdXNlcyBjZXJ0YWluIGZl?=
 =?gb2312?B?YXR1cmVzIHRvIGZhaWwgb24gQVJNIHBsYXRmcm9tIGR1ZSB0byBlbmRpYW5u?=
 =?gb2312?Q?ess?=
In-Reply-To: <20603.47887.262025.941051@pilspetsen.it.uu.se>
References: <DA41BE1DDCA941489001C7FBD7A8820E3CB407A4@szxeml549-mbx.china.huawei.com>
 <20603.47887.262025.941051@pilspetsen.it.uu.se>
Message-ID: <DA41BE1DDCA941489001C7FBD7A8820E3CB410BF@szxeml549-mbx.china.huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mikael & Russell,

    Thanks for the suggestions. I tried to replace ".word" with ".inst" and the cpu-hotplug feature now works on big-endian (BE-8) ARM platform. And illegal instruction exception disappears.

    And the following is my small patch to fix the problem,

diff -urN linux-3.7-rc1/arch/arm/mach-exynos/hotplug.c linux/arch/arm/mach-exynos/hotplug.c
--- linux-3.7-rc1/arch/arm/mach-exynos/hotplug.c	2012-10-15 05:41:04.000000000 +0800
+++ linux/arch/arm/mach-exynos/hotplug.c	2012-10-15 17:47:28.177103266 +0800
@@ -72,7 +72,7 @@
 		/*
 		 * here's the WFI
 		 */
-		asm(".word	0xe320f003\n"
+		asm(".inst	0xe320f003\n"
 		    :
 		    :
 		    : "memory", "cc");
diff -urN linux-3.7-rc1/arch/arm/mach-realview/hotplug.c linux/arch/arm/mach-realview/hotplug.c
--- linux-3.7-rc1/arch/arm/mach-realview/hotplug.c	2012-10-15 05:41:04.000000000 +0800
+++ linux/arch/arm/mach-realview/hotplug.c	2012-10-15 17:44:55.915942976 +0800
@@ -64,7 +64,7 @@
 		/*
 		 * here's the WFI
 		 */
-		asm(".word	0xe320f003\n"
+		asm(".inst	0xe320f003\n"
 		    :
 		    :
 		    : "memory", "cc");
diff -urN linux-3.7-rc1/arch/arm/mach-shmobile/hotplug.c linux/arch/arm/mach-shmobile/hotplug.c
--- linux-3.7-rc1/arch/arm/mach-shmobile/hotplug.c	2012-10-15 05:41:04.000000000 +0800
+++ linux/arch/arm/mach-shmobile/hotplug.c	2012-10-15 17:45:20.509879863 +0800
@@ -39,7 +39,7 @@
 		/*
 		 * here's the WFI
 		 */
-		asm(".word	0xe320f003\n"
+		asm(".inst	0xe320f003\n"
 		    :
 		    :
 		    : "memory", "cc");
    
    Since ARM processor can be configured to work in BE-8 big-endian, I thinks this patch is necessary. Any suggestions is welcomed. 
    Thanks




Yangfei (Felix) writes:
 > Hi all,
 > 
 >     I found that hardcoded instruction in inline asm can cause certains certain features fail to work on ARM platform due to endianness.
 >     As an example, consider the following code snippet of platform_do_lowpower function from arch/arm/mach-realview/hotplug.c:
 >                 / *
 >                  * here's the WFI
 >                  */
 >                 asm(".word      0xe320f003\n"
 >                     :
 >                     :
 >                     : "memory", "cc");
 > 
 >     The instruction generated from this inline asm will not work on big-endian ARM platform, such as ARM BE-8 format. Instead, an exception will be generated.
 > 
 >     Here the code should be:
 >                 / *
 >                  * here's the WFI
 >                  */
 >                 asm("WFI\n"
 >                     :
 >                     :
 >                     : "memory", "cc");
 > 
 >     Seems the kernel doesn't support ARM BE-8 well. I don't know why this problem happens.
 >     Can anyone tell me who owns this part? I can prepare a patch then. 
 >     Thanks.

Questions regarding the ARM kernel should go to the linux-arm-kernel mailing list
(see the MAINTAINERS file), with an optional cc: to the regular LKML.

BE-8 is, if I recall correctly, ARMv7's broken format where code and data have
different endianess.  GAS supports an ".inst" directive which is like ".word"
except the data is assumed to be code.  This matters for disassembly, and may
also be required for BE-8.

That is, just s/.word/.inst/g above and report back if that works or not.
--
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/
