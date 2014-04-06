From: shawn.guo@linaro.org (Shawn Guo)
Date: Sun, 6 Apr 2014 19:40:35 +0800
Subject: L2 cache suspend/resume
In-Reply-To: <20140405112700.GJ7528@n2100.arm.linux.org.uk>
References: <20140405112700.GJ7528@n2100.arm.linux.org.uk>
Message-ID: <20140406114033.GC24260@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Apr 05, 2014 at 12:27:00PM +0100, Russell King - ARM Linux wrote:
> While looking through the L2 resume code paths, I notice that:
> 
>  * exynos
>  * imx
>  * tegra
> 
> all resume their L2 caches from assembly code, rather than using
> outer_disable() before cpu_suspend(), and outer_resume() afterwards.
> From what I can see, these are all running in the secure world, so that
> isn't the reason.
> 
> What is the reason for this difference?  Can these three be converted to
> the outer_disable()...outer_resume() method?

For imx, the L2 power and therefore the memory array is retained in
suspend.  We do not want to call outer_disable() to have these data
flushed, and need to restore L2 controller before MMU is enabled.

Shawn
