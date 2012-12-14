From: shawn.guo@linaro.org (Shawn Guo)
Date: Fri, 14 Dec 2012 11:33:16 +0800
Subject: imx_v6_v7_defconfig: use v7 optimized atomic64* instead of
 GENERIC_ATOMIC64?
In-Reply-To: <50C884D3.2070605@de.bosch.com>
References: <50C884D3.2070605@de.bosch.com>
Message-ID: <20121214033313.GA3604@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 12, 2012 at 02:21:23PM +0100, Dirk Behme wrote:
> 
> Working mainly with the i.MX6 using the imx_v6_v7_defconfig, we get
> CONFIG_GENERIC_ATOMIC64=y due to
> 
> CONFIG_CPU_V6=y
> CONFIG_CPU_V6K=y
> CONFIG_CPU_V7=y
> 
> and
> 
> select GENERIC_ATOMIC64 if (CPU_V6 || !CPU_32v6K || !AEABI)
> 
> in arch/arm/Kconfig.
> 
> With this, on the V7 i.MX6 we use the (non-optimized) generic
> atomic64* implementation from lib/atomic64.c instead of the V7
> optimized ones from arch/arm/include/asm/atomic.h.
> 
Yes, that's how single zImage for v6 and v7 works.

> Is this intended using imx_v6_v7_defconfig on V7 devices?
> 
To maintain the compatibility between v6 and v7 build, we have to live
with that.  Actually, there are much more than just this atomic64
optimization losing.  For example, compiler has some level of
optimization for Cortex-A series cpus with -march=armv7-a flag, but
arch/arm/Makefile will force it to be -march=armv6k when you build
the kernel for you v7 device using imx_v6_v7_defconfig.

> Is there any chance to use the optimized atomic64* functionality on
> V7 with imx_v6_v7_defconfig? Or is this only possible by disabling
> CONFIG_CPU_V6 and CONFIG_CPU_V6K in the imx_v6_v7_defconfig?
> 
If you are running a kernel with imx multiplatform support (will hit
v3.8-rc1 if everything goes well), uncheck System Type --> Multiple
platform selection --> ARMv6 based platforms, otherwise uncheck all
imx31 and imx35 platforms under System Type --> Freescale MXC
Implementations will allow you build a v7 only kernel to have all
those v7 specific optimizations back.

Shawn 
