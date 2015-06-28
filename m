From: m.smarduch@samsung.com (Mario Smarduch)
Date: Sun, 28 Jun 2015 10:57:09 -0700
Subject: [PATCH 0/3] arm: KVM: VFP lazy switch in KVM Host Mode may save
 upto 98%
In-Reply-To: <1435203028-23142-1-git-send-email-m.smarduch@samsung.com>
References: <1435203028-23142-1-git-send-email-m.smarduch@samsung.com>
Message-ID: <55903575.8060702@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marc, Christoffer -

to clarify - this series may be causing a conflict with the arm64
basic approach, and arm32 exit code touch ups.

The intent for this series  is more of an RFC or preview, to get some
feedback - if this approach is sensible (I guess later applied to
arm64 as well if it is).

Thanks,
- Mario


On 06/24/2015 08:30 PM, Mario Smarduch wrote:
> Currently we do a lazy VFP switch in Hyp mode, but once we exit and re-enter hyp
> mode we trap again on VFP access. This mode has shown around 30-50% improvement
> running hackbench and lmbench.
> 
> This patch series extends lazy VFP switch beyond Hyp mode to KVM host mode.
> 
> 1 - On guest access we switch from host to guest and set a flag accessible to 
>     host
> 2 - On exit to KVM host, VFP state is restored on vcpu_put if flag is marked (1)
> 3 - Otherwise guest is resumed and continues to use its VFP registers. 
> 4 - In case of 2 on VM entry we set VFP trap flag to repeat 1.
> 
> If guest does not access VFP registers them implemenation remains the same.
> 
> Executing hackbench on Fast Models and Exynos arm32 board shows good
> results. Considering all exits 2% of the time KVM host lazy vfp switch is 
> invoked.
> 
> Howeverr this patch set requires more burn in time and testing under various 
> loads.
> 
> Currently ARM32 is addressed later ARM64.
> 
> Mario Smarduch (3):
>   define headers and offsets to mange VFP state
>   Implement lazy VFP switching outside of Hyp Mode
>   Add VFP lazy switch hooks in Host KVM
> 
>  arch/arm/include/asm/kvm_asm.h  |    1 +
>  arch/arm/include/asm/kvm_host.h |    3 +++
>  arch/arm/kernel/asm-offsets.c   |    1 +
>  arch/arm/kvm/arm.c              |   15 ++++++++++++
>  arch/arm/kvm/interrupts.S       |   49 +++++++++++++++++++++++++--------------
>  5 files changed, 51 insertions(+), 18 deletions(-)
> 
