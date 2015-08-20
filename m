From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 20 Aug 2015 14:02:00 +0100
Subject: [PATCH 3/3] [v2] hvc_dcc: disable user-space access to DCC
In-Reply-To: <20150820104645.GD19328@arm.com>
References: <1440025370-9519-1-git-send-email-timur@codeaurora.org>
 <1440025370-9519-3-git-send-email-timur@codeaurora.org>
 <20150820104645.GD19328@arm.com>
Message-ID: <20150820130200.GE2972@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 20, 2015 at 11:46:45AM +0100, Will Deacon wrote:
> On Thu, Aug 20, 2015 at 12:02:50AM +0100, Timur Tabi wrote:
> > If the DCC driver loads, then disable user-space access to the DCC so that
> > we don't have two entities trying to access the DCC at the same time.
> 
> In the interests of making some headway with this, just drop this patch
> and I'll queue the diff below via the arm64 tree.
> 
> Will
> 
> --->8
> 
> diff --git a/arch/arm64/mm/proc.S b/arch/arm64/mm/proc.S
> index 39139a3aa16d..4c922ecce600 100644
> --- a/arch/arm64/mm/proc.S
> +++ b/arch/arm64/mm/proc.S
> @@ -156,7 +156,7 @@ ENTRY(__cpu_setup)
>  
>  	mov	x0, #3 << 20
>  	msr	cpacr_el1, x0			// Enable FP/ASIMD
> -	msr	mdscr_el1, xzr			// Reset mdscr_el1
> +	msr	mdscr_el1, #1 << 12		// Reset mdscr_el1

Nitpick: expand the "Reset..." comment to include some text about this
bit.

-- 
Catalin
