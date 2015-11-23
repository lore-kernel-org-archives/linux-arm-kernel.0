From: thierry.reding@gmail.com (Thierry Reding)
Date: Mon, 23 Nov 2015 12:14:58 +0100
Subject: [PATCH] ARM: tegra: Ensure entire dcache is flushed on entering
 LP0/1
In-Reply-To: <1447942787-31137-1-git-send-email-jonathanh@nvidia.com>
References: <1447942787-31137-1-git-send-email-jonathanh@nvidia.com>
Message-ID: <20151123111458.GF31868@ulmo.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 19, 2015 at 02:19:47PM +0000, Jon Hunter wrote:
> Tegra support several low-power (LPx) states, which are:
> - LP0: CPU + Core voltage off and DRAM in self-refresh
> - LP1: CPU voltage off and DRAM in self-refresh
> - LP2: CPU voltage off
> 
> When entering any of the above states the tegra_disable_clean_inv_dcache()
> function is called to flush the dcache. The function
> tegra_disable_clean_inv_dcache() will either flush the entire data cache or
> up to the Level of Unification Inner Shareable (LoUIS) depending on the
> value in r0. When tegra_disable_clean_inv_dcache() is called by
> tegra20_sleep_core_finish() or tegra30_sleep_core_finish(), to enter LP0
> and LP1 power state, the r0 register contains a physical memory address
> which will not be equal to TEGRA_FLUSH_CACHE_ALL (1) and so the data cache
> will be only flushed to the LoUIS. However, when
> tegra_disable_clean_inv_dcache() called by tegra_sleep_cpu_finish() to
> enter to LP2 power state, r0 is set to TEGRA_FLUSH_CACHE_ALL to flush the
> entire dcache.
> 
> Please note that tegra20_sleep_core_finish(), tegra30_sleep_core_finish()
> and tegra_sleep_cpu_finish() are called by the boot CPU once all other CPUs
> have been disabled and so it seems appropriate to flush the entire cache at
> this stage.
> 
> Therefore, ensure that r0 is set to TEGRA_FLUSH_CACHE_ALL when calling
> tegra_disable_clean_inv_dcache() from tegra20_sleep_core_finish() and
> tegra30_sleep_core_finish().
> 
> Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
> ---
> 
> Please note that I have not encountered any problems without this change
> so far, but I noticed this from reviewing the suspend sequence. I have
> tested this on tegra20, tegra30, tegra114 and tegra124 and verified that
> suspend/resume to LP1 is working fine.
> 
>  arch/arm/mach-tegra/sleep-tegra20.S | 3 +++
>  arch/arm/mach-tegra/sleep-tegra30.S | 3 +++
>  2 files changed, 6 insertions(+)

Applied, thanks.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151123/24f4fe94/attachment.sig>
