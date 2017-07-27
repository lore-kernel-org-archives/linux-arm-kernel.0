From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Thu, 27 Jul 2017 13:17:20 +0100
Subject: [PATCH] ARM: Use WFI when possible when halting a core
In-Reply-To: <20170727120803.27848-1-wens@csie.org>
References: <20170727120803.27848-1-wens@csie.org>
Message-ID: <20170727121720.GS31807@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 27, 2017 at 08:08:03PM +0800, Chen-Yu Tsai wrote:
> On ARM, the kernel busy loops after cleaning up when a core is to be
> halted. This may have the undesired effect of increasing the core
> temperature, at a time when no power or thermal management is
> available, such as a kernel panic or shutdown to halt.
> 
> x86 uses the more efficient HLT (halt) instruction. The equivalent
> instruction on ARM is WFI (wait for interrupt).
> 
> This patch makes the busy loops in the ARM halt/reboot/panic paths
> use WFI when available (as defined in arch/arm/include/asm/barrier.h).
> 
> A touch test indicates that this lowers the surface temperature of the
> Allwinner H3 SoC, with all 4 cores brought up with SMP, from painfully
> hot to just warm to the touch after shutdown to halt.
> 
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> ---
> 
> I asked about this some time ago, and the answer was no one had done
> it. So here it is. It is somewhat similar to the patch "arm64:
> Improve parking of stopped CPUs", for arm64 obviously.

There are various errata around the "wfi" instruction on various CPUs
which means that this simple implementation isn't going to work
reliably.

This is where cpu_do_idle() comes in - please use that instead.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
