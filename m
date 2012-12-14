From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 14 Dec 2012 10:00:07 +0000
Subject: imx_v6_v7_defconfig: use v7 optimized atomic64* instead of
 GENERIC_ATOMIC64?
In-Reply-To: <20121214033313.GA3604@S2101-09.ap.freescale.net>
References: <50C884D3.2070605@de.bosch.com>
 <20121214033313.GA3604@S2101-09.ap.freescale.net>
Message-ID: <20121214100007.GI14363@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 14, 2012 at 11:33:16AM +0800, Shawn Guo wrote:
> To maintain the compatibility between v6 and v7 build, we have to live
> with that.  Actually, there are much more than just this atomic64
> optimization losing.  For example, compiler has some level of
> optimization for Cortex-A series cpus with -march=armv7-a flag, but
> arch/arm/Makefile will force it to be -march=armv6k when you build
> the kernel for you v7 device using imx_v6_v7_defconfig.

Well, the way this stuff is supposed to work is that -march is used to
select the instructions to be used, and -mtune is used to control the
optimization of those instructions.

We're doing mostly the right thing - in that if we have a v6+v7 kernel, we
build for v6 (because a v6 CPU won't have the additional v7 instructions).
However, what we're completely missing is any -mtune for v7 CPUs, which
means the optimizer will schedule instructions for some v6 CPU rather
than v7.  Whether there's much difference or not I don't know, but maybe
that's something which should be looked at?
