From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed, 05 Dec 2012 15:09:09 -0700
Subject: [PATCH V2 1/6] ARM: tegra: add pending SGI checking API
In-Reply-To: <1354701715-24150-2-git-send-email-josephl@nvidia.com>
References: <1354701715-24150-1-git-send-email-josephl@nvidia.com>
 <1354701715-24150-2-git-send-email-josephl@nvidia.com>
Message-ID: <50BFC605.3000402@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/05/2012 03:01 AM, Joseph Lo wrote:
> The "powered-down" CPU idle mode of Tegra cut off the vdd_cpu rail, it
> include the power of GIC. That caused the SGI (Software Generated
> Interrupt) been lost. Because the SGI can't wake up the CPU that in
> the "powered-down" CPU idle mode. We need to check if there is any
> pending SGI when go into "powered-down" CPU idle mode. This is important
> especially when applying the coupled cpuidle framework into "power-down"
> cpuidle dirver. Because the coupled cpuidle framework may have the
> chance that misses IPI_SINGLE_FUNC handling sometimes.
> 
> For the PPI or SPI, something like the legacy peripheral interrupt. It
> still can be maintained by Tegra legacy interrupt controller. If there
> is any pending PPI or SPI when CPU in "powered-down" CPU idle mode. The
> CPU can be woken up immediately. So we don't need to take care the same
> situation for PPI or SPI.

Is this feature something that can/should be added to the core GIC
driver, rather than something custom in the Tegra code?

Part of the reason I ask is that I'd like to avoid any more:

static void __iomem *distbase = IO_ADDRESS(TEGRA_ARM_INT_DIST_BASE);

since that requires static page tables to be set up, whereas I'd like to
reduce, as much as possible, the set of pages Tegra maps statically.
