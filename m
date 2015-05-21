From: thierry.reding@gmail.com (Thierry Reding)
Date: Thu, 21 May 2015 10:30:47 +0200
Subject: [PATCH] ARM: v7 setup function should invalidate L1 cache
In-Reply-To: <E1Yuk8W-0001tC-IK@rmk-PC.arm.linux.org.uk>
References: <E1Yuk8W-0001tC-IK@rmk-PC.arm.linux.org.uk>
Message-ID: <20150521083046.GA30323@ulmo.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 19, 2015 at 05:12:56PM +0100, Russell King wrote:
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
[...]
>  arch/arm/mach-tegra/Makefile          |  2 +-
>  arch/arm/mach-tegra/headsmp.S         | 12 ------------
>  arch/arm/mach-tegra/reset.c           |  2 +-
>  arch/arm/mach-tegra/reset.h           |  1 -
[...]

Russell,

I saw a couple of conflicts trying to apply this to v4.1-rc1..v4.1-rc4
or any of recent linux-next versions. I ended up applying this on top of
your for-next branch and tested using that. The conflicts seem very
minor and a test merge of Tegra's for-next branch resolved this fine. A
test merge of next-20150520 shows one conflict in mach-socfpga/core.h,
but it's a trivial one to resolve.

Anyway, the patch seems to work fine on TrimSlice (Tegra20), Beaver
(Tegra30), Dalmore (Tegra114) and Jetson TK1 (Tegra124). Tested on
Paul's boot farm:

Tested-by: Thierry Reding <treding@nvidia.com>
Acked-by: Thierry Reding <treding@nvidia.com>

Paul, thanks for setting up the boot test infrastructure, this saved me
a lot of time.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150521/a52aa9be/attachment-0001.sig>
