From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 12 Feb 2014 14:26:41 +0100
Subject: [PATCH v2 0/9] ARM: multi-platform kconfig cleanup and mach-virt
 removal
In-Reply-To: <1392153119-23248-1-git-send-email-robherring2@gmail.com>
References: <1392153119-23248-1-git-send-email-robherring2@gmail.com>
Message-ID: <201402121426.41914.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 11 February 2014, Rob Herring wrote:
> From: Rob Herring <robh@kernel.org>
> 
> This series removes common kconfig options required by multi-platform
> builds out of individual platforms as they are redundant. Patches 2 and
> 3 make SMP and CACHE_L2X0 config options visible on MULTI_V7 builds as
> most platforms enable these options and all platforms can run with them
> enabled.

Overall looks pretty good, let's wait for a few more Acks or a possible
Nak and then put it into arm-soc. You can add my 'Acked-by' to all patches
if you like.

> The previous version [1] was mainly a discussion about v6 vs. v6K.
> Several platforms have this wrong and incorrectly select v6 when the
> more optimal v6K option could be used. After more research, my memory
> about i.MX31 was wrong and it does need to remain v6.

Just curious: do you have more information on this? Are all i.MX31 ARMv6
and all i.MX35 v6k as the current Kconfig claims,  or is it more
complicated?

> Finally, patch 8 removes mach-virt as it is no longer needed. The core
> ARM code can handle all the necessary initialization and mach-virt is
> left as a kconfig option. Although not really related to this series, 
> it would otherwise conflict with it.

Makes sense. It's still a cleanup, so you could send it as a 
separate patch to be applied on-top of the pull rather than the
same pull request, although the difference is really marginal.

You are probably right in leaving out the non-multiplatform
platforms, but maybe we can figure out whether they should be
changed as well, especially as some of them are going to become
multiplatform-enabled in the future:

* ARCH_S5P64X0 should be changed, it's next on the list
* DaVinci/TNETV107X looks rather broken, I wonder if we should
  just remove it entirely rather than fix it. I have a series
  to fix all 'randconfig' build bugs locally and there were a
  lot of them for TNETV107X, and I doubt fixing the build will
  actually give you a booting kernel.
* ARCH_MSM7X00A should just be changed, although probably nobody
  really cares.
* integrator and realview apparently allow both CPU_V6 and CPU_V6K
  to be manually selected. Is that actually the correct behavior
  in that both kinds of core tiles exist?

	Arnd
