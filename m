From: robherring2@gmail.com (Rob Herring)
Date: Mon, 08 Jun 2015 11:52:42 -0500
Subject: [PATCH v4 0/6] SA1100/PXA RTC clean-up
In-Reply-To: <87wpzg4ji2.fsf@belgarion.home>
References: <1431529350-4597-1-git-send-email-robh@kernel.org>
 <87pp62jdpj.fsf@belgarion.home>
 <CAL_JsqJ-VMQHXFF9Gxf5mmPjYXZ6gyktYFjgvxAHRx-Kmuoq8A@mail.gmail.com>
 <877fs5k9ps.fsf@belgarion.home>
 <CAL_JsqKWNNH4stY+CNtKCiE7qcwDYaxZc36-iqqe1ddmG82g1Q@mail.gmail.com>
 <871thq54c7.fsf@belgarion.home>
 <CAL_JsqJnj+JLFoUmE6COqhr83_H0n1=Bdk_wYnMZEzsZRu=aew@mail.gmail.com>
 <87wpzg4ji2.fsf@belgarion.home>
Message-ID: <5575C85A.6010802@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jun 6, 2015 at 4:25 PM, Robert Jarzmik <robert.jarzmik@free.fr> wrote:
> Rob Herring <robh@kernel.org> writes:
>
>>>>>  - you explain in the commit message that from a userland perspective, nothing
>>>>>    changes, except that the RTC IP will change, and any dependency on a
>>>>
>>>> The IP does not change here. rtc0 is still going to be the SA1100 RTC
>>>> being registered first. The only change will be the addition of rtc1.
>>> For boards which were only using rtc-pxa.c (as mioa701 for example), they relied
>>> on the fact that rtc0 == pxa_rtc. Their time is stored in PXA IP. Therefore,
>>> each of their hwclock will end up on sa1100-rtc instead of pxa-rtc.
>>>
>>> So for these boards, ie. for all boards where only rtc-pxa.c was used, the IP
>>> addressed changes from a casual userspace perspective.
>>
>> Okay, so this is the case where the time will be wrong.
>>
>> I could remove the select of the sa1100-rtc and do an empty function
>> for sa1100_rtc_init. This would preserve current behavior.
> Please don't. I only ask for a sentence in the commit message.
>
>>>>>    bootloader fidling with RTC should be considered as a source of regression.
>>>>
>>>> I'm not sure that I follow.
>>> Let's talk about how a double boot windows + linux box works.
>>> The bootloader ensures that :
>>>  - sa1100-rtc holds the number of seconds since the OS start (think jiffies)
>>>  - pxa-rtc holds the wall clock time
>>>
>>> Upon each reboot, sa1100-rtc is checked to see how much time has passed. If an
>>> "oustanding number" is detected, for example 10 years, the firmware resets the
>>> data partition.
>>>
>>> Now think what will happen when this change will be commited, upon the first
>>> reboot after the linux kernel has change sa1100-rtc time.
>>
>> That would be bad. But on these platforms, the kernel has been using
>> both RTCs right? Presumably on platforms only using 1 of the RTCs, the
>> bootloader does not touch the RTCs.
> No, the kernel has been using only pxa-rtc. The sa1100-rtc is not used, and yet
> it accounts the passed time in it.
>
> On platforms where all the OSes use only 1 RTC, the bootloader only touches one
> RTC, that's correct. Or said differently : the bootloader touches the union of
> all the RTCs the OSes it launches do touch.

Sorry, I'm being dense here, but I'm not any less confused as to which 
scenarios you think have an issue. Rather than go around again on this, 
perhaps you can just provide the warning for the commit text. Here's 
what I have.

Rob


8<-------------------------------------------------------------------
>From e43db14b27486faef8d8e74e4aa555aba7f31a0e Mon Sep 17 00:00:00 2001
From: Rob Herring <robh@kernel.org>
Date: Mon, 1 Jun 2015 07:53:01 -0500
Subject: [PATCH] ARM: config: Switch PXA27x platforms to use PXA RTC driver

With the SA1100 and PXA RTC drivers be mutually exclusive and no
longer sharing hardware, PXA27x/PXA3xx platforms must use the PXA RTC
driver as the SA1100 platform device is no longer registered.

This change should be transparent to userspace, but the first reboot
after the switch will have the wrong time.

Signed-off-by: Rob Herring <robh@kernel.org>
Cc: Daniel Mack <daniel@zonque.org>
Cc: Haojian Zhuang <haojian.zhuang@gmail.com>
Cc: Robert Jarzmik <robert.jarzmik@free.fr>
Cc: Sergey Lapin <slapin@ossfans.org>
Cc: Russell King <linux@arm.linux.org.uk>
---
 arch/arm/configs/cm_x2xx_defconfig  | 2 +-
 arch/arm/configs/em_x270_defconfig  | 2 +-
 arch/arm/configs/magician_defconfig | 2 +-
 arch/arm/configs/palmz72_defconfig  | 2 +-
 arch/arm/configs/pcm027_defconfig   | 2 +-
 arch/arm/configs/trizeps4_defconfig | 2 +-
 6 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm/configs/cm_x2xx_defconfig b/arch/arm/configs/cm_x2xx_defconfig
index dc01c04..3b32d5f 100644
--- a/arch/arm/configs/cm_x2xx_defconfig
+++ b/arch/arm/configs/cm_x2xx_defconfig
@@ -157,7 +157,7 @@ CONFIG_LEDS_TRIGGERS=y
 CONFIG_LEDS_TRIGGER_HEARTBEAT=y
 CONFIG_RTC_CLASS=y
 CONFIG_RTC_DRV_V3020=y
-CONFIG_RTC_DRV_SA1100=y
+CONFIG_RTC_DRV_PXA=y
 CONFIG_EXT2_FS=y
 CONFIG_EXT3_FS=y
 CONFIG_INOTIFY=y
diff --git a/arch/arm/configs/em_x270_defconfig b/arch/arm/configs/em_x270_defconfig
index 4560c9c..8e10df7 100644
--- a/arch/arm/configs/em_x270_defconfig
+++ b/arch/arm/configs/em_x270_defconfig
@@ -157,7 +157,7 @@ CONFIG_LEDS_TRIGGERS=y
 CONFIG_LEDS_TRIGGER_HEARTBEAT=y
 CONFIG_RTC_CLASS=y
 CONFIG_RTC_DRV_V3020=y
-CONFIG_RTC_DRV_SA1100=y
+CONFIG_RTC_DRV_PXA=y
 CONFIG_EXT2_FS=y
 CONFIG_EXT3_FS=y
 CONFIG_INOTIFY=y
diff --git a/arch/arm/configs/magician_defconfig b/arch/arm/configs/magician_defconfig
index 557dd29..a5b4920 100644
--- a/arch/arm/configs/magician_defconfig
+++ b/arch/arm/configs/magician_defconfig
@@ -150,7 +150,7 @@ CONFIG_LEDS_TRIGGERS=y
 CONFIG_LEDS_TRIGGER_BACKLIGHT=y
 CONFIG_RTC_CLASS=y
 CONFIG_RTC_DEBUG=y
-CONFIG_RTC_DRV_SA1100=y
+CONFIG_RTC_DRV_PXA=y
 CONFIG_EXT2_FS=y
 CONFIG_INOTIFY=y
 CONFIG_MSDOS_FS=m
diff --git a/arch/arm/configs/palmz72_defconfig b/arch/arm/configs/palmz72_defconfig
index 4baa83c..83c135e 100644
--- a/arch/arm/configs/palmz72_defconfig
+++ b/arch/arm/configs/palmz72_defconfig
@@ -67,7 +67,7 @@ CONFIG_MMC=y
 CONFIG_MMC_DEBUG=y
 CONFIG_MMC_PXA=y
 CONFIG_RTC_CLASS=y
-CONFIG_RTC_DRV_SA1100=y
+CONFIG_RTC_DRV_PXA=y
 CONFIG_EXT2_FS=y
 CONFIG_EXT3_FS=y
 # CONFIG_DNOTIFY is not set
diff --git a/arch/arm/configs/pcm027_defconfig b/arch/arm/configs/pcm027_defconfig
index 0a847d0..b5624e3 100644
--- a/arch/arm/configs/pcm027_defconfig
+++ b/arch/arm/configs/pcm027_defconfig
@@ -82,7 +82,7 @@ CONFIG_MMC=y
 CONFIG_MMC_PXA=y
 CONFIG_RTC_CLASS=y
 CONFIG_RTC_DRV_PCF8563=m
-CONFIG_RTC_DRV_SA1100=m
+CONFIG_RTC_DRV_PXA=m
 CONFIG_EXT2_FS=m
 CONFIG_EXT3_FS=m
 # CONFIG_DNOTIFY is not set
diff --git a/arch/arm/configs/trizeps4_defconfig b/arch/arm/configs/trizeps4_defconfig
index 932ee4e..4bc8700 100644
--- a/arch/arm/configs/trizeps4_defconfig
+++ b/arch/arm/configs/trizeps4_defconfig
@@ -177,7 +177,7 @@ CONFIG_NEW_LEDS=y
 CONFIG_RTC_CLASS=y
 # CONFIG_RTC_HCTOSYS is not set
 CONFIG_RTC_DRV_PCF8583=m
-CONFIG_RTC_DRV_SA1100=y
+CONFIG_RTC_DRV_PXA=y
 CONFIG_EXT2_FS=y
 CONFIG_EXT2_FS_XATTR=y
 CONFIG_EXT2_FS_POSIX_ACL=y
-- 
2.1.0
