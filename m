From: sshtylyov@mvista.com (Sergei Shtylyov)
Date: Mon, 23 Apr 2012 15:19:44 +0400
Subject: [PATCH] ARM: cache-l2x0.c: save aux ctrl for resume in case that
 l2x0 is enabled before init
In-Reply-To: <1335167001-28031-1-git-send-email-ylmao@marvell.com>
References: <1335167001-28031-1-git-send-email-ylmao@marvell.com>
Message-ID: <4F953AD0.5020503@mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 23-04-2012 11:43, Yilu Mao wrote:

> If l2x0 controller has been enabled when calling l2x0_init, the aux ctrl
> register will not be saved in l2x0_saved_regs. Therefore we can not use
> l2x0_saved_regs.aux_ctrl for resume later. This patch fixed the problem
> by saving aux ctrl in l2x0_saved_regs just after it's being read from
> the register.

> Signed-off-by: Yilu Mao<ylmao@marvell.com>
> ---
>   arch/arm/mm/cache-l2x0.c |    5 +++++
>   1 files changed, 5 insertions(+), 0 deletions(-)

> diff --git a/arch/arm/mm/cache-l2x0.c b/arch/arm/mm/cache-l2x0.c
> index 8936595..3b6428b 100644
> --- a/arch/arm/mm/cache-l2x0.c
> +++ b/arch/arm/mm/cache-l2x0.c
> @@ -362,6 +362,11 @@ void __init l2x0_init(void __iomem *base, u32 aux_val, u32 aux_mask)
>   	l2x0_cache_id = readl_relaxed(l2x0_base + L2X0_CACHE_ID);
>   	aux = readl_relaxed(l2x0_base + L2X0_AUX_CTRL);
>
> +	/* In case l2x controller is enabled, the aux ctrl register
> +	 * can't be set. So the original value should be stored in
> +	 * the l2x0_saved_regs for restoring when resume. */

    The preferred style of multi-line comments is this:

/*
  * bla
  * bla
  */

WBR, Sergei
