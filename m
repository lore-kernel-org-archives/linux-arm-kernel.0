From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Mon, 5 Feb 2018 11:01:44 +0100
Subject: [PATCH v4 0/6] 32bit ARM branch predictor hardening
In-Reply-To: <20180201110738.5421-1-marc.zyngier@arm.com>
References: <20180201110738.5421-1-marc.zyngier@arm.com>
Message-ID: <20180205100144.GT21802@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 01, 2018 at 11:07:32AM +0000, Marc Zyngier wrote:
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
> Patches 4 to 6 are doing a similar thing for Cortex-A15, with the
> aforementioned ICIALLU.
> 
> To sum up the requirements:
> 
> - Cortex-A15 need to have ACTLR.IBE (bit 0) set to 1 from secure
>   mode. Cortex-A8 also needs to have ACTLR.IBE (bit 6) set, overlaping
>   with ARM_ERRATA_430973 which also requires it.
> - Cortex-A9, A12 and A17 do not require any extra configuration.
> 
> Note 1: Contrary to the initial version, this new series relies on
> the arm64/kpti branch (I reuse the per-CPU vector hook for KVM).
> 
> Note 2: M-class CPUs are not affected and for R-class cores, the
> mitigation doesn't make much sense since we do not enforce user/kernel
> isolation.
> 
> [Christoffer: since the patches have significantly changed since v3,
> I've dropped your RB tags]

Except for the question on patch 4, you can add my tag back to the
series.

I particularly enjoyed the cute xor hack in patch 3.

Reviewed-by: Christoffer Dall <christoffer.dall@linaro.org>
