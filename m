From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 12 Mar 2014 08:54:01 +0000
Subject: [PATCHv4 2/2] arm: Get rid of meminfo
In-Reply-To: <1392761733-32628-3-git-send-email-lauraa@codeaurora.org>
References: <1392761733-32628-1-git-send-email-lauraa@codeaurora.org>
 <1392761733-32628-3-git-send-email-lauraa@codeaurora.org>
Message-ID: <20140312085401.GB21483@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 18, 2014 at 02:15:33PM -0800, Laura Abbott wrote:
> memblock is now fully integrated into the kernel and is the prefered
> method for tracking memory. Rather than reinvent the wheel with
> meminfo, migrate to using memblock directly instead of meminfo as
> an intermediate.
> 
> Acked-by: Jason Cooper <jason@lakedaemon.net>
> Acked-by: Catalin Marinas <catalin.marinas@arm.com>
> Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> Acked-by: Kukjin Kim <kgene.kim@samsung.com>
> Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Tested-by: Leif Lindholm <leif.lindholm@linaro.org>
> Signed-off-by: Laura Abbott <lauraa@codeaurora.org>

Laura,

This patch causes a bunch of platforms to no longer boot - imx6solo with
1GB of RAM boots, imx6q with 2GB of RAM doesn't.  Versatile Express doesn't.

The early printk messages don't reveal anything too interesting:

Booting Linux on physical CPU 0x0
Linux version 3.14.0-rc6+ (rmk at rmk-PC.arm.linux.org.uk) (gcc version 4.6.4 (GCC) ) #630 SMP Wed Mar 12 01:13:36 GMT 2014
CPU: ARMv7 Processor [412fc09a] revision 10 (ARMv7), cr=10c53c7d
CPU: PIPT / VIPT nonaliasing data cache, VIPT aliasing instruction cache
Machine model: SolidRun Cubox-i Dual/Quad
cma: CMA: reserved 64 MiB at 8c000000
Memory policy: Data cache writealloc
<hang>

vs.

Booting Linux on physical CPU 0x0
Linux version 3.14.0-rc6+ (rmk at rmk-PC.arm.linux.org.uk) (gcc version 4.6.4 (GCC) ) #631 SMP Wed Mar 12 01:15:37 GMT 2014
CPU: ARMv7 Processor [412fc09a] revision 10 (ARMv7), cr=10c53c7d
CPU: PIPT / VIPT nonaliasing data cache, VIPT aliasing instruction cache
Machine model: SolidRun Cubox-i Dual/Quad
cma: CMA: reserved 64 MiB at 3b800000
Memory policy: Data cache writealloc
On node 0 totalpages: 524288
free_area_init_node: node 0, pgdat c09d0240, node_mem_map ea7d8000
  Normal zone: 1520 pages used for memmap
  Normal zone: 0 pages reserved
  Normal zone: 194560 pages, LIFO batch:31
  HighMem zone: 2576 pages used for memmap
  HighMem zone: 329728 pages, LIFO batch:31
...

The only obvious difference is the address of that CMA reservation,
CMA shouldn't make a difference here - but I suspect that other
allocations which need to be in lowmem probably aren't.

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
