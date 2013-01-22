From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 22 Jan 2013 21:19:23 +0000
Subject: [PATCH 3/6] arm: kconfig: don't select TWD with local timer for
 Armada 370/XP
In-Reply-To: <50FEFAB9.4030503@gmail.com>
References: <1358790842-2986-1-git-send-email-gregory.clement@free-electrons.com>
 <201301212044.41865.arnd@arndb.de> <50FEFAB9.4030503@gmail.com>
Message-ID: <201301222119.23750.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 22 January 2013, Rob Herring wrote:
> No, I expect all future platforms will have architected timers. TWD is
> pretty much A9 and A5 only I believe. Same with SCU. I've probably
> missed some in my list.

Ah, I was incorrectly assuming that TWD was referring to the architected
timers, sorry about that.

Maybe we should do this differently then and do the more logical

config LOCAL_TIMERS
	bool

config ARM_TWD
	bool "ARM TWD local timer"
	depends on SMP && CPU_V7
	select LOCAL_TIMERS

config EXYNOS4_MCT
	bool "Samsung Exynos4 MCT Timer"
	depends on SMP && ARCH_EXYNOS
	select LOCAL_TIMERS

config MSM_LOCAL_TIMER
	bool "Qualcomm MSM Local Timer"
	depends on SMP && ARCH_MSM
	select LOCAL_TIMERS

That way we have no implicit assumptions. Everything will still work if you
disable local timers, but of course we will enable them in the defconfigs.

	Arnd
