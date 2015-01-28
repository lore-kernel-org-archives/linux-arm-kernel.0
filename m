From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Wed, 28 Jan 2015 13:09:15 +0300
Subject: [PATCH v2 3/3] pm: at91: add disable/enable the L1/L2 cache while
 suspend/resume
In-Reply-To: <1422411844-13241-1-git-send-email-wenyou.yang@atmel.com>
References: <1422411707-10945-1-git-send-email-wenyou.yang@atmel.com>
 <1422411844-13241-1-git-send-email-wenyou.yang@atmel.com>
Message-ID: <54C8B54B.3090607@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 1/28/2015 5:24 AM, Wenyou Yang wrote:

> For the sama5, disable L1 D-cache and L2 cache before the cpu go to wfi,
> after wakeing up, enable L1 D-cache and L2 cache.

    Waking.

> Signed-off-by: Wenyou Yang <wenyou.yang@atmel.com>
> ---
>   arch/arm/mach-at91/pm.c         |   12 +++++
>   arch/arm/mach-at91/pm_suspend.S |  107 +++++++++++++++++++++++++++++++++++++++
>   2 files changed, 119 insertions(+)

[...]
> diff --git a/arch/arm/mach-at91/pm_suspend.S b/arch/arm/mach-at91/pm_suspend.S
> index 311cc23..02d4e56 100644
> --- a/arch/arm/mach-at91/pm_suspend.S
> +++ b/arch/arm/mach-at91/pm_suspend.S
[...]
> @@ -324,3 +325,109 @@ ram_restored:
[...]
> +l2x_sync:

    I don't see where this label is used.

> +	ldr	r0, [r2, #L2X0_CACHE_SYNC]
> +	bic	r0, r0, #0x1
> +	str	r0, [r2, #L2X0_CACHE_SYNC]
> +sync:
> +	ldr	r0, [r2, #L2X0_CACHE_SYNC]
> +	ands	r0, r0, #0x1
> +	bne	sync
> +
> +skip_l2disable:
> +	ldmfd	sp!, {r4 - r12, pc}
> +ENDPROC(at91_disable_l1_l2_cache)
[...]

WBR, Sergei
