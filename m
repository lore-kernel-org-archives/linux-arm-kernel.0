From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 28 Feb 2013 22:26:12 +0000
Subject: [PATCH v9 2/2] video: drm: exynos: Add pinctrl support to fimd
In-Reply-To: <512FD44D.1070408@gmail.com>
References: <1362024762-28406-1-git-send-email-vikas.sajjan@linaro.org>
 <1362024762-28406-3-git-send-email-vikas.sajjan@linaro.org>
 <512FD44D.1070408@gmail.com>
Message-ID: <20130228222612.GE17833@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 28, 2013 at 11:03:57PM +0100, Sylwester Nawrocki wrote:
> Please just use IS_ERR(), let's stop this IS_ERR_OR_NULL() insanity.

Yes, indeed.

On that topic (and off-topic for this thread, sorry) I've committed
a set of patches to remove most users of IS_ERR_OR_NULL() from arch/arm.
These are the last remaining ones there - and I don't want to see any
more appearing:

arch/arm/plat-samsung/clock.c:	if (IS_ERR_OR_NULL(clk))
arch/arm/plat-samsung/clock.c:	if (!IS_ERR_OR_NULL(clk) && clk->ops && clk->ops->round_rate)
arch/arm/plat-samsung/clock.c:	if (IS_ERR_OR_NULL(clk))
arch/arm/plat-samsung/clock.c:	if (IS_ERR_OR_NULL(clk) || IS_ERR_OR_NULL(parent))
arch/arm/mach-imx/devices/platform-ipu-core.c:	if (IS_ERR_OR_NULL(imx_ipu_coredev))
arch/arm/mach-imx/devices/platform-ipu-core.c:	if (IS_ERR_OR_NULL(imx_ipu_coredev))
arch/arm/kernel/smp_twd.c:		 * We use IS_ERR_OR_NULL() here, because if the clock stubs
arch/arm/kernel/smp_twd.c:		if (!IS_ERR_OR_NULL(twd_clk))

They currently all legal uses of it - though I'm sure that the samsung
clock uses can be reduced to just IS_ERR().  The IMX use looks "valid"
in that imx_ipu_coredev really can be an error pointer (on failure) or
NULL if the platform device hasn't yet been created.  The TWD one is
explained in the comments in the code (if people had to write explanations
for using IS_ERR_OR_NULL(), we'd probably have it used correctly!)
