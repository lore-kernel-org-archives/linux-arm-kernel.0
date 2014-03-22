From: arnd@arndb.de (Arnd Bergmann)
Date: Sat, 22 Mar 2014 10:54:39 +0100
Subject: [PATCH 0/8] Generic serial earlycon
In-Reply-To: <1395436128-11244-1-git-send-email-robherring2@gmail.com>
References: <1395436128-11244-1-git-send-email-robherring2@gmail.com>
Message-ID: <201403221054.39799.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 21 March 2014, Rob Herring wrote:
> From: Rob Herring <robh@kernel.org>
> 
> This started out as an attempt to add arm64's earlyprintk support to ARM
> in order to get an earlier, runtime setup console on multi-platform
> kernels. The first issue was needing the fixmap support which
> conveniently Mark Salter was working on and is mostly in place now. Like
> many things on ARM and arm64 now, it then became where do I put the now
> common, shared code. After digging more into various early console/printk
> support, it turns out the 8250_early.c setup code was the best starting
> point. 
> 
> This is based on Mark Salter's fixmap support currently in linux-next.
> This is tested on arm64 and ARM with pl011 and 8250. The ARM support
> also requires fixmap and fixed mapping support which are not yet in place.
> I have some patches in my tree to support fixmap, but they need some more
> work. Fortunately, once fixmap is in place, it is just a Kconfig option
> to enable earlycon support on ARM. A git tree is available here[1].
> 
> Based on this series, I would like to add support for doing earlycon
> setup using DT.

Hi Rob,

I like this series a lot, great work!

I would consider the DT parsing support essential here, we should not
merge the patches until that is done as well, because I don't want
to see users pass earlycon command line options in DT when they can
use the established "linux,stdout-path" property instead. I would
expect that in almost every case in which we are booting using DT
today, we can just use linux,stdout-path to locate the device that
the boot loader has already set up and start usign it.

	Arnd
