From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Tue, 10 Mar 2015 12:09:44 -0400 (EDT)
Subject: [PATCHv3 0/5] arm-cci400: PMU monitoring support on ARM64
In-Reply-To: <1426000735-14375-1-git-send-email-suzuki.poulose@arm.com>
References: <1426000735-14375-1-git-send-email-suzuki.poulose@arm.com>
Message-ID: <alpine.LFD.2.11.1503101205400.25484@knanqh.ubzr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 10 Mar 2015, Suzuki K. Poulose wrote:

> From: "Suzuki K. Poulose" <suzuki.poulose@arm.com>
> 
> This series enables the PMU monitoring support for CCI400 on ARM64.
> The existing CCI400 driver code is a mix of PMU driver and the MCPM
> driver code. The MCPM driver is only used on ARM(32) and contains
> arm32 assembly and hence can't be built on ARM64. This patch splits
> the code to
> 
>  - ARM_CCI400_PORT_CTRL driver - depends on ARM && V7
>  - ARM_CCI400_PMU driver
> 
> Accessing the Peripheral ID2 register(PID2) on CCI-400, to detect
> the revision of the chipset, is a secure operation. Hence, it prevents
> us from running this on non-secure platforms. The issue is overcome by
> explicitly mentioning the revision number of the CCI PMU in the device tree
> binding. The device-tree binding has been updated with the new bindings.
> 
> i.e,	arm-cci-400-pmu,r0 => revision 0
> 	arm-cci-400-pmu,r1 => revision 1
> 	arm-cci-400-pmu => (old) DEPRECATED
> 
> The old binding has been DEPRECATED and must be used only on ARM32
> system with secure access. We don't have a reliable dynamic way to detect
> if the system is running secure. This series tries to use the best safe
> method by relying on the availability of MCPM(as it was prior to the series).
> It is upto the MCPM platform driver to decide, if the system is secure before
> it goes ahead and registers its drivers and pokes the CCI. This series doesn't
> address/solve the problem of MCPM. I will be happy to use a better approach,
> if there is any.
> 
> Tested on (non-secure)TC2 and A53x2.

Would be nice if you could also test it on secure TC2 making sure MCPM 
is still functional.

For patches 1, 3 and 4, you may add:

Acked-by: Nicolas Pitre <nico@linaro.org>

Patches 2 and 5 are purely PMU stuff and out of my area of expertise.


> Changes sinve V2
> 
>  - Include suggestions from Sudeep Holla.
>  - Cleanup event validation checks.
> 
> Changes since V1 (Suggestions from Nicolas Pitre):
> 
>  - Split Patch 2 to separate the 'PMU' abstraction(now Patch 2/5)
>    from the introduction of a new device-tree binding(now Patch 3/5)
>  - Rename
> 	ARM_CCI400_MCPM => ARM_CCI400_PORT_CTRL
> 	CCI400_MCPM_PORTS_DATA => CCI400_PORTS_DATA
>  - Select ARM_CCI400_COMMON for ARM_CCI400_PORT_CTRL
>  - Better documentation in the git commit log about the ARM_CCI config.
>  - Move the 'pr_info' to its apporpriate patch.
> 
> 
> Suzuki K. Poulose (5):
>   arm-cci: Rearrange code for splitting PMU vs driver code
>   arm-cci: Abstract the CCI400 PMU speicific definitions
>   arm-cci: Get rid of secure transactions for PMU driver
>   arm-cci: Split the code for PMU vs driver support
>   arm-cci: Fix CCI PMU event validation
> 
>  Documentation/devicetree/bindings/arm/cci.txt |    7 +-
>  arch/arm/include/asm/arm-cci.h                |   42 +++
>  arch/arm/mach-exynos/Kconfig                  |    2 +-
>  arch/arm/mach-vexpress/Kconfig                |    4 +-
>  arch/arm64/include/asm/arm-cci.h              |   27 ++
>  drivers/bus/Kconfig                           |   28 +-
>  drivers/bus/arm-cci.c                         |  496 ++++++++++++++-----------
>  include/linux/arm-cci.h                       |    9 +-
>  8 files changed, 384 insertions(+), 231 deletions(-)
>  create mode 100644 arch/arm/include/asm/arm-cci.h
>  create mode 100644 arch/arm64/include/asm/arm-cci.h
> 
> -- 
> 1.7.9.5
> 
> 
> 
