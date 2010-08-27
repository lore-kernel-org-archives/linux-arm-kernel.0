From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 27 Aug 2010 14:54:40 +0100
Subject: [PATCH 03/24] arm: mm: add proc info for ScorpionMP
In-Reply-To: <1282712273-344-4-git-send-email-johlstei@codeaurora.org>
References: <1282712273-344-4-git-send-email-johlstei@codeaurora.org>
Message-ID: <1282917280.26355.33.camel@e102109-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2010-08-25 at 05:57 +0100, Jeff Ohlstein wrote:
> From: Daniel Walker <dwalker@codeaurora.org>
> 
> ScorpionMP does not have the SMP/nAMP and TLB ops broadcasting bits in
> ACTLR.
> 
> Signed-off-by: Daniel Walker <dwalker@codeaurora.org>
> Signed-off-by: Jeff Ohlstein <johlstei@codeaurora.org>
> ---
>  arch/arm/mm/proc-v7.S |   24 ++++++++++++++++++++++++
>  1 files changed, 24 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mm/proc-v7.S b/arch/arm/mm/proc-v7.S
> index 7aaf88a..98fd7e5 100644
> --- a/arch/arm/mm/proc-v7.S
> +++ b/arch/arm/mm/proc-v7.S
> @@ -196,6 +196,7 @@ __v7_setup:
>         orreq   r0, r0, #(1 << 6) | (1 << 0)    @ Enable SMP/nAMP mode and
>         mcreq   p15, 0, r0, c1, c0, 1           @ TLB ops broadcasting
>  #endif
> +__v7_msm_setup:
>         adr     r12, __v7_setup_stack           @ the local stack
>         stmia   r12, {r0-r5, r7, r9, r11, lr}
>         bl      v7_flush_dcache_all

It may be better to move the generic __v7_setup here and have a specific
entry for ARM Ltd cores (mask 0xff0f0000 and value 0x410f0000).

In general, I would have liked a different way (still ID-based) of
handling such issues without duplicating the whole structure. But I see
this becoming the standard as proc-v6.S follows it as well.

-- 
Catalin
