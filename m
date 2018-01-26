From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Fri, 26 Jan 2018 10:30:02 +0100
Subject: [PATCH v3 0/6] 32bit ARM branch predictor hardening
In-Reply-To: <20180125152139.32431-1-marc.zyngier@arm.com>
References: <20180125152139.32431-1-marc.zyngier@arm.com>
Message-ID: <20180126093002.GW21802@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 25, 2018 at 03:21:33PM +0000, Marc Zyngier wrote:
> This small series implements some basic BP hardening by invalidating
> the BTB on 32bit ARM CPUs that are known to be susceptible to aliasing
> attacks (Spectre variant 2). It doesn't help non-ARM 32bit CPUs, nor
> 32bit kernels that run on 64bit capable CPUs. This series doesn't
> mitigate Spectre variant 1 either.
> 
> These patches are closely modelled against what we do on arm64,
> although simpler as we can rely on an architected instruction to
> perform the invalidation. The notable exception is Cortex-A15, where
> BTB invalidation behaves like a NOP, and the only way to shoot the
> predictor down is to invalidate the icache *and* to have ACTLR[0] set
> to 1 (which is a secure-only operation).
> 
> The first patch reuses the Cortex-A8 BTB invalidation in switch_mm and
> generalises it to be used on all affected CPUs. The second perform the
> same invalidation on prefetch abort outside of the userspace
> range. The third one nukes it on guest exit, and results in some major
> surgery as we cannot take a branch from the vectors (that, and Thumb2
> being a massive pain).
> 
> Patches 4 to 6 are doing a similar thing for Cortex-A15, which the
> aforementioned ICIALLU.
> 
> To sum up the requirements:
> - Both Cortex-A8 and Cortex-A15 need to have ACTLR.IBE (bit 0) set to
>   1 from secure mode. For Cortex-A8, this overlaps with
>   ARM_ERRATA_430973 which also requires it.
> - Cortex-A9, A12 and A17 do not require any extra configuration.
> 
> Note 1: Contrary to the initial version, this new series relies on
> the arm64/kpti branch (I reuse the per-CPU vector hook for KVM).
> 
> Note 2: M-class CPUs are not affected and for R-class cores, the
> mitigation doesn't make much sense since we do not enforce user/kernel
> isolation.

Besides the minor nits in some of the patches, for the series:

Reviewed-by: Christoffer Dall <christoffer.dall@linaro.org>
