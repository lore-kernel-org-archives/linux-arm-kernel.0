From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 21 Jan 2013 18:31:45 +0000
Subject: [PATCH 3/6] arm: kconfig: don't select TWD with local timer for
 Armada 370/XP
In-Reply-To: <1358790842-2986-4-git-send-email-gregory.clement@free-electrons.com>
References: <1358790842-2986-1-git-send-email-gregory.clement@free-electrons.com>
 <1358790842-2986-4-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <201301211831.45947.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 21 January 2013, Gregory CLEMENT wrote:
> @@ -1624,7 +1624,7 @@ config LOCAL_TIMERS
>         bool "Use local timer interrupts"
>         depends on SMP
>         default y
> -       select HAVE_ARM_TWD if (!ARCH_MSM_SCORPIONMP && !EXYNOS4_MCT)
> +       select HAVE_ARM_TWD if (!ARCH_MSM_SCORPIONMP && !EXYNOS4_MCT && !ARMADA_370_XP_TIMER)
>         

Your change is fine, but I just noticed that this line is asking for trouble
when we enable multipleform support for MSM and/or EXYNOS.

Also, I wonder if we should change this somehow in 3.8, because it seems
that for a multiplatform kernel including armadaxp and e.g. versatile express,
you have no ARM_TWD support in the kernel, which seems wrong. Is there any
reason we can't enable the ARM_TWD code to be built-in on platforms that
don't use it?

Maybe it can be written as

config LOCAL_TIMERS
	bool "Use local timer interrupts"
	depends on SMP
	default y

config HAVE_ARM_TWD
	depends on LOCAL_TIMERS
	default ARCH_MULTIPLATFORM || (!ARCH_MSM_SCORPIONMP && !EXYNOS4_MCT)
	default y

This will still be slightly wrong (generating extra code) on a multiplatform
kernel that has no platform other than MSM or EXYNOS, but the other alternative
would be that each platform with TWD support has to select HAVE_ARM_TWD itself.

	Arnd
