From: jonathan.austin@arm.com (Jonathan Austin)
Date: Fri, 07 Jun 2013 17:51:07 +0100
Subject: [PATCH v3 0/3] Separate generic header usage from
 ARCH_MULTIPLATFORM
In-Reply-To: <29798869.9FjkuBXpzS@wuerfel>
References: <1370602111-28737-1-git-send-email-jonathan.austin@arm.com>
 <51B1DC74.9090203@arm.com> <3354049.TGIUmJXV0H@wuerfel>
 <29798869.9FjkuBXpzS@wuerfel>
Message-ID: <51B20F7B.1080909@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/06/13 15:04, Arnd Bergmann wrote:
> On Friday 07 June 2013 16:00:47 Arnd Bergmann wrote:
>>> Doesn't the explicit dependency of CONFIG_MMU for ARCH_MULTIPLATFORM
>>> mean that randconfig builds still work, even without the changes below?
>>>
>>> Apologies if I'm missing a use-case here!
>>
>> I am somewhat annoyed by the fact that I had to disable ARCH_MULTIPLATFORM
>> for !MMU kernels in order to get 'make randconfig' to work and I would rather
>> allow it and fix the bugs.
>
> To expand on this a bit more: I want to eventually make ARCH_MULTIPLATFORM
> mandatory for all modern platforms, in particular anything ARMv6 and ARMv7
> based. Forcing all !MMU-kernels to be !ARCH_MULTIPLATFORM means we won't
> get there unless we disallow !MMU on modern platforms.
>

Thanks for the expansion. I like that as an aim :). We should remember 
it'll still only make sense for platforms where PHYS_OFFSET/DRAM_BASE is 
the same - not sure how many that will be.

I've had a play with keeping !MMU and ARCH_MULTIPLATFORM selectable 
together, and of the fixes in your diff, only the following is required 
to get R7 booting on top of Vexpress:

-----8<-------
diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index a7f066e..ead2b25 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -289,8 +289,7 @@ choice

  config ARCH_MULTIPLATFORM
         bool "Allow multiple platforms to be selected"
-       depends on MMU
-       select ARM_PATCH_PHYS_VIRT
+       select ARM_PATCH_PHYS_VIRT if MMU
         select AUTO_ZRELADDR
         select COMMON_CLK
         select MULTI_IRQ_HANDLER
----->8--------

It's nice too, because we don't need to add back Makefile.boot for vexpress.

The R7 support, nommu-fixes and MPU patches I sent before and which I 
hope to have merged for 3.11 (pull request for rmk coming shortly) can 
all work fine using this instead of the NEED_NO_MACH_HEADERS series (IE 
this series)....

It would be cool, then, to have the small patch above in for 3.11 too if 
we're not too late and if nobody is against going down this route?

Arnd: would you like to send it as a patch to the list for 
consideration, or shall I take this on?

Jonny
> 	Arnd
>
>
