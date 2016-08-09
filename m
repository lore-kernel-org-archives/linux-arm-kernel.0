From: will.deacon@arm.com (Will Deacon)
Date: Tue, 9 Aug 2016 17:48:40 +0100
Subject: [PATCH] drivers/perf: arm_pmu: fix legacy affinity-less DT support
In-Reply-To: <1470757867-13554-1-git-send-email-mark.rutland@arm.com>
References: <1470757867-13554-1-git-send-email-mark.rutland@arm.com>
Message-ID: <20160809164839.GN27508@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 09, 2016 at 04:51:07PM +0100, Mark Rutland wrote:
> Commit 19a469a58720ea96 ("drivers/perf: arm-pmu: Handle per-interrupt
> affinity mask") relies on using_spi being valid, but this is only
> initialised correctly in the presence of an interrupt-affinity property,
> which legacy DTBs do not have.
> 
> In the absence of an interrupt-affinity property, using_spi is always
> false (regardless of whether SPIs are actually used), so we call
> irq_get_percpu_devid_partition(irq). This returns -EINVAL, and we give
> up, passing on this return value.
> 
> The code which determines using_spi also verifies that we do not have
> mixed SPI/PPI interrupts. Even in the absence of an interrupt-affinity
> property we do not support mixed SPI/PPI cases, so pull the validation
> logic above the main loop, ensuring that using_spi is always valid.
> 
> At the same time, have the error message to give the path of the PMU
> node, rather than a CPU node, as the mismatch is a property of the
> entire set of PMU interrupts rather than a particular CPU associated
> with it.
> 
> Fixes: 19a469a58720ea96 ("drivers/perf: arm-pmu: Handle per-interrupt affinity mask")
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Reported-by: Robin Murphy <robin.murphy@arm.com>
> Tested-by: Robin Murphy <robin.murphy@arm.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Marc Zyngier <marc.zyngier@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> ---
>  drivers/perf/arm_pmu.c | 37 ++++++++++++++++++++-----------------
>  1 file changed, 20 insertions(+), 17 deletions(-)
> 
> It's been pointed out to me that Marc send a patch a while ago [1] fixing the
> same issue, but for some reason that didn't get queued.
> 
> This patch had the added benefit of ensuring we always avoid mismatched SPI/PPI
> mixes, but otherwise either patch should avoid the issue.

I'm a little uneasy with that change, since we now go ahead and check all
of the IRQ resources, regardless of the interrupt-affinity property. This
could result in us failing the probe, where we could previously have done
the right thing.

For now, I think I'll stick with Marc's patch (that somehow slipped through
the woodwork), but maybe we should consider removing the SPI/PPI sanity
checking altogether. At some point we have to rely on the DT being correct,
and I don't think we do anything disastrout if there is a mismatch in
interrupt types.

Will
