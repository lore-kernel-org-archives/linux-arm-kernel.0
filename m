From: heiko@sntech.de (Heiko Stuebner)
Date: Tue, 19 May 2015 23:44:58 +0200
Subject: [PATCH] ARM: v7 setup function should invalidate L1 cache
In-Reply-To: <E1Yuk8W-0001tC-IK@rmk-PC.arm.linux.org.uk>
References: <E1Yuk8W-0001tC-IK@rmk-PC.arm.linux.org.uk>
Message-ID: <6452458.LAJUB33YSi@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

Am Dienstag, 19. Mai 2015, 17:12:56 schrieb Russell King:
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


Michael Niewoehner tested this on a rk3188 (Cortex-A9) and wrote in [0]
> Tested-by: Michael Niewoehner <mniewoeh@stud.hs-offenburg.de>
> 
> Tested on Radxa Rock Pro with RK3188.
> The kernel panics on reboot I had before and also a kernel BUG when running
> "memtester 1900M" went away and the rock seems to run stable now.


I've also tested the patch on a rk3288-based board, so both supported Rockchip 
ARM-cores (A9 and A12/A17) seem to run fine with this change.

Tested-by: Heiko Stuebner <heiko@sntech.de>

Rockchip-specific changes
Reviewed-by: Heiko Stuebner <heiko@sntech.de>


Thanks Heiko


[0] http://lists.infradead.org/pipermail/linux-rockchip/2015-May/003046.html
