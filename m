From: f.fainelli@gmail.com (Florian Fainelli)
Date: Sat, 3 Feb 2018 18:51:49 -0800
Subject: [PATCH v4 0/6] 32bit ARM branch predictor hardening
In-Reply-To: <20180201110738.5421-1-marc.zyngier@arm.com>
References: <20180201110738.5421-1-marc.zyngier@arm.com>
Message-ID: <47d908e3-dc59-cc83-bf29-b97301fe0fb0@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marc,

On 02/01/2018 03:07 AM, Marc Zyngier wrote:
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

I have not had a chance to integrate those patches into the different
downstream branches that we maintain, including upstream, but that's the
plan for next week, because there is nothing else besides spectre &
meltdown anyway right now :)

I would still like to pursue the RFC patch posted to your v3 where the
kernel, if running in secure PL1 tries to set ACTLR[0], except maybe, I
won't try to be too smart and detect the 3 states (firmware set, kernel
set, not set) and just check whether it is set, and if not *and*
HARDEN_BRANCH_PREDICTOR is enabled, then issue a warning?

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
> 
> * From v3:
>   - Added configuration option
>   - Reorganized the proc-v7 code to be neater
>   - Make the Thumb2 KVM madness Thumb2 specific
>   - Cleanups all over
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
>  arch/arm/include/asm/kvm_mmu.h | 23 +++++++++-
>  arch/arm/kvm/hyp/hyp-entry.S   | 95 +++++++++++++++++++++++++++++++++++++++++-
>  arch/arm/mm/Kconfig            | 17 ++++++++
>  arch/arm/mm/fault.c            | 29 +++++++++++++
>  arch/arm/mm/fsr-2level.c       |  4 +-
>  arch/arm/mm/fsr-3level.c       | 69 ++++++++++++++++++++++++++++++
>  arch/arm/mm/proc-v7-2level.S   | 14 ++++++-
>  arch/arm/mm/proc-v7-3level.S   | 15 +++++++
>  arch/arm/mm/proc-v7.S          | 53 +++++++++++++++++++++--
>  11 files changed, 312 insertions(+), 12 deletions(-)
> 

-- 
Florian
