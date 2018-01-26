From: andre.przywara@arm.com (Andre Przywara)
Date: Fri, 26 Jan 2018 16:39:09 +0000
Subject: [PATCH v3 0/6] 32bit ARM branch predictor hardening
In-Reply-To: <20180125152139.32431-1-marc.zyngier@arm.com>
References: <20180125152139.32431-1-marc.zyngier@arm.com>
Message-ID: <4b18d24a-353f-3c97-d05f-bdfdff825c98@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 25/01/18 15:21, Marc Zyngier wrote:
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

FWIW, I tested this series briefly on a Calxeda Midway (Cortex-A15).
Both without and with ACTLR[0] (set in the secure firmware code), I
could boot it fine and ran two KVM guests under some stress.

So at least no regression here.
Thanks for putting this together!


Tested-by: Andre Przywara <andre.przywara@arm.com>

Cheers,
Andre.

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
> 
> * From v2:
>   - Fixed !MMU build
>   - Small KVM optimisation (suggested by Robin)
>   - Fixed register zeroing in cpu_v7_btbinv_switch_mm (noticed by
>     Andre)
>   
> * From v1:
>   - Fixed broken hyp_fiq vector (noticed by Ard)
>   - Fixed broken BTB invalidation in LPAE switch_mm (reported by Andre)
>   - Revamped invalidation on PABT (noticed by James on arm64,
>     suggested by Will)
>   - Rewrote the whole HYP sequence, as Thumb2 was pretty unhappy about
>     arithmetic with the stack pointer
> 
> Marc Zyngier (6):
>   arm: Add BTB invalidation on switch_mm for Cortex-A9, A12 and A17
>   arm: Invalidate BTB on prefetch abort outside of user mapping on
>     Cortex A8, A9, A12 and A17
>   arm: KVM: Invalidate BTB on guest exit for Cortex-A12/A17
>   arm: Add icache invalidation on switch_mm for Cortex-A15
>   arm: Invalidate icache on prefetch abort outside of user mapping on
>     Cortex-A15
>   arm: KVM: Invalidate icache on guest exit for Cortex-A15
> 
>  arch/arm/include/asm/cp15.h    |  3 ++
>  arch/arm/include/asm/kvm_asm.h |  2 -
>  arch/arm/include/asm/kvm_mmu.h | 17 ++++++++-
>  arch/arm/kvm/hyp/hyp-entry.S   | 85 +++++++++++++++++++++++++++++++++++++++++-
>  arch/arm/mm/fault.c            | 29 ++++++++++++++
>  arch/arm/mm/fsr-2level.c       |  4 +-
>  arch/arm/mm/fsr-3level.c       | 67 ++++++++++++++++++++++++++++++++-
>  arch/arm/mm/proc-v7-2level.S   | 14 ++++++-
>  arch/arm/mm/proc-v7-3level.S   | 22 +++++++++++
>  arch/arm/mm/proc-v7.S          | 48 ++++++++++++++++--------
>  10 files changed, 265 insertions(+), 26 deletions(-)
> 
