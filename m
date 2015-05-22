From: michal.simek@xilinx.com (Michal Simek)
Date: Fri, 22 May 2015 12:45:12 +0200
Subject: [PATCH] ARM: v7 setup function should invalidate L1 cache
In-Reply-To: <E1Yuk8W-0001tC-IK@rmk-PC.arm.linux.org.uk>
References: <E1Yuk8W-0001tC-IK@rmk-PC.arm.linux.org.uk>
Message-ID: <555F08B8.5060606@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/19/2015 06:12 PM, Russell King wrote:
> All ARMv5 and older CPUs invalidate their caches in the early assembly
> setup function, prior to enabling the MMU.  This is because the L1
> cache should not contain any data relevant to the execution of the
> kernel at this point; all data should have been flushed out to memory.
> 
> This requirement should also be true for ARMv6 and ARMv7 CPUs - indeed,
> these typically do not search their caches when caching is disabled (as
> it needs to be when the MMU is disabled) so this change should be safe.
> 
> ARMv7 allows there to be CPUs which search their caches while caching is
> disabled, and it's permitted that the cache is uninitialised at boot;
> for these, the architecture reference manual requires that an
> implementation specific code sequence is used immediately after reset
> to ensure that the cache is placed into a sane state.  Such
> functionality is definitely outside the remit of the Linux kernel, and
> must be done by the SoC's firmware before _any_ CPU gets to the Linux
> kernel.
> 
> Changing the data cache clean+invalidate to a mere invalidate allows us
> to get rid of a lot of platform specific hacks around this issue for
> their secondary CPU bringup paths - some of which were buggy.
> 
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> ---

...

>  arch/arm/mach-zynq/common.h           |  2 --
>  arch/arm/mach-zynq/headsmp.S          |  5 -----
>  arch/arm/mach-zynq/platsmp.c          |  5 ++---

For Zynq:
Tested-by: Michal Simek <michal.simek@xilinx.com>

Thanks,
Michal
