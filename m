From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 27 Nov 2014 22:51:00 +0000
Subject: [PATCH v9 0/7] Enable L2 cache support on Exynos4210/4x12 SoCs
In-Reply-To: <1416224909-4290-1-git-send-email-m.szyprowski@samsung.com>
References: <1416224909-4290-1-git-send-email-m.szyprowski@samsung.com>
Message-ID: <20141127225100.GA3840@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 17, 2014 at 12:48:22PM +0100, Marek Szyprowski wrote:
> This is an updated patchset, which intends to add support for L2 cache
> on Exynos4 SoCs on boards running under secure firmware, which requires
> certain initialization steps to be done with help of firmware, as
> selected registers are writable only from secure mode.
> 
> First four patches extend existing support for secure write in L2C driver
> to account for design of secure firmware running on Exynos. Namely:
>  1) direct read access to certain registers is needed on Exynos, because
>     secure firmware calls set several registers at once,
>  2) not all boards are running secure firmware, so .write_sec callback
>     needs to be installed in Exynos firmware ops initialization code,
>  3) write access to {DATA,TAG}_LATENCY_CTRL registers fron non-secure world
>     is not allowed and so must use l2c_write_sec as well,
>  4) on certain boards, default value of prefetch register is incorrect
>     and must be overridden at L2C initialization.
> For boards running with firmware that provides access to individual
> L2C registers this series should introduce no functional changes. However
> since the driver is widely used on other platforms I'd like to kindly ask
> any interested people for testing.
> 
> Further three patches add implementation of .write_sec and .configure
> callbacks for Exynos secure firmware and necessary DT nodes to enable
> L2 cache.
> 
> Changes in this version tested on Exynos4412-based TRATS2 and OdroidU3+
> boards (both with secure firmware). There should be no functional change
> for Exynos boards running without secure firmware. I do not have access
> to affected non-Exynos boards, so I could not test on them.

So, I applied this series, and now I get a conflicts between my tree and
arm-soc for:

arch/arm/mach-exynos/firmware.c
arch/arm/mach-exynos/sleep.S

So, I'm going to un-stage the exynos bits, and we'll have to work out
some way to handle those.

-- 
FTTC broadband for 0.8mile line: currently at 9.5Mbps down 400kbps up
according to speedtest.net.
