From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Mon, 24 Mar 2014 16:00:50 -0400 (EDT)
Subject: [PATCH RFC] ARM: extend fixmap mapping region to support 30 CPUs
In-Reply-To: <1395652367-12308-1-git-send-email-sdu.liu@huawei.com>
References: <1395652367-12308-1-git-send-email-sdu.liu@huawei.com>
Message-ID: <alpine.LFD.2.11.1403241250560.1291@knanqh.ubzr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 24 Mar 2014, Liu Hua wrote:

> In 32-bit ARM systems, the fixmap mapping region can support
> no more than 14 CPUs(total: 896k; one CPU: 64K). And we can
> configure NR_CPUS up to 32. So there is a mismatch.
> 
> This patch extends the fixmapping region downwards to boundary
> of DMA mapping region(0xffe00000-0xfffe0000). Then the fixmap
> mapping region can support up to 30 CPUs.

You failed to update CONSISTENT_END in your patch.

Hmmm?  Waitaminute...

Well well...

It looks like the static mapping area for DMA was removed from the code 
by commit e9da6e9905e6 but the information in 
Documentation/arm/memory.txt was not updated accordingly.

CONSISTENT_END in arch/arm/include/asm/memory.h has no more users and 
shoule probably be removed.

This means 0xffc00000 to 0xffefffff is no longer used by anything.

> There seems to be no easy way to support 32 CPUs by simply 
> changing memory layout on ARM Linux. So I also limit the 
> maximal CPU number one can configure.

I think the above should help you solve your CPU limit easily.


Nicolas
