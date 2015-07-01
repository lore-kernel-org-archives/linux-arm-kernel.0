From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Wed, 1 Jul 2015 11:49:10 +0200
Subject: [PATCH v3 0/2] arm/arm64: KVM: Optimize arm64 fp/simd, saves
 30-50% on exits
In-Reply-To: <1435190652-5831-1-git-send-email-m.smarduch@samsung.com>
References: <1435190652-5831-1-git-send-email-m.smarduch@samsung.com>
Message-ID: <20150701094910.GF11332@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 24, 2015 at 05:04:10PM -0700, Mario Smarduch wrote:
> Currently we save/restore fp/simd on each exit. Fist  patch optimizes arm64
> save/restore, we only do so on Guest access. hackbench and
> several lmbench tests show anywhere from 30% to above 50% optimzation
> achieved.
> 
> In second patch 32-bit handler is updated to keep exit handling consistent
> with 64-bit code.

30-50% of what?  The overhead or overall performance?

> 
> Changes since v1:
> - Addressed Marcs comments
> - Verified optimization improvements with lmbench and hackbench, updated 
>   commit message
> 
> Changes since v2:
> - only for patch 2/2
>   - Reworked trapping to vfp access handler
> 
> Changes since v3:
> - Only for patch 2/2
>   - Removed load_vcpu in switch_to_guest_vfp per Marcs comment
>   - Got another chance to replace an unreferenced label with a comment
> 
> 
> Mario Smarduch (2):
>   Optimize arm64 skip 30-50% vfp/simd save/restore on exits
>   keep arm vfp/simd exit handling consistent with arm64
> 
>  arch/arm/kvm/interrupts.S        |   14 +++++++-----
>  arch/arm64/include/asm/kvm_arm.h |    5 ++++-
>  arch/arm64/kvm/hyp.S             |   46 +++++++++++++++++++++++++++++++++++---
>  3 files changed, 55 insertions(+), 10 deletions(-)
> 
> -- 
> 1.7.9.5
> 
