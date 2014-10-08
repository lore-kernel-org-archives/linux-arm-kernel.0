From: khilman@kernel.org (Kevin Hilman)
Date: Wed, 08 Oct 2014 16:19:09 -0700
Subject: [PATCH v9 0/2] Adds PMU and S2R support for exynos5420
In-Reply-To: <1412673723-15551-1-git-send-email-vikas.sajjan@samsung.com>
 (Vikas Sajjan's message of "Tue, 7 Oct 2014 15:07:01 +0545")
References: <1412673723-15551-1-git-send-email-vikas.sajjan@samsung.com>
Message-ID: <7hiojuno9e.fsf@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Vikas Sajjan <vikas.sajjan@samsung.com> writes:

[...]

> Tested on Kukjin Kim's tree, for-next branch + 
> 1] http://www.spinics.net/lists/linux-samsung-soc/msg33750.html
> 2] https://www.mail-archive.com/linux-samsung-soc at vger.kernel.org/msg37260.html
> 3] with the CLK_IGNORE_UNUSED flag for aclk200_disp1 CLK
>
> on Exynos5420 based chromebook (peach-pit board)
>
> Below procedures were followed to test S2R:
> Procedure A:
> 	1. make multi_v7_defconfig 
> 	2  enable MCPM for 5420
> 	3. enable S3C RTC
> 	5. echo +20 > /sys/class/rtc/rtc0/wakealarm && echo mem > /sys/power/state
> Procedure B:
> 	1. make exynos_defconfig 
> 	4. echo +20 > /sys/class/rtc/rtc0/wakealarm && echo mem > /sys/power/state

I went tried to this on exynos5800-peach-pi and found first that
exynos_defonfig is missing the MAX77802 kconfig options for the RTC
source clock:

CONFIG_REGULATOR_MAX77802=y
CONFIG_COMMON_CLK_MAX77802=y

With those, rtc0 then comes up, but isn't waking from suspend.  However,
writing something to rtc0/wakealarm does result in /proc/interrupts
having an interrupt for the RTC, it's just not waking the system.

Anyone else tried this on 5800/peach-pi?

Kevin
