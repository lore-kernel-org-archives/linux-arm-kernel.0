From: a.hajda@samsung.com (Andrzej Hajda)
Date: Wed, 16 Sep 2015 11:52:37 +0200
Subject: [PATCH 01/31] arch/arm/mach-lpc32xx: use kmemdup rather than
 duplicating its implementation
In-Reply-To: <1438934377-4922-2-git-send-email-a.hajda@samsung.com>
References: <1438934377-4922-1-git-send-email-a.hajda@samsung.com>
 <1438934377-4922-2-git-send-email-a.hajda@samsung.com>
Message-ID: <55F93BE5.60508@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Ping.

Regards
Andrzej

On 08/07/2015 09:59 AM, Andrzej Hajda wrote:
> The patch was generated using fixed coccinelle semantic patch
> scripts/coccinelle/api/memdup.cocci [1].
>
> [1]: http://permalink.gmane.org/gmane.linux.kernel/2014320
>
> Signed-off-by: Andrzej Hajda <a.hajda@samsung.com>
> ---
>  arch/arm/mach-lpc32xx/pm.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
>
> diff --git a/arch/arm/mach-lpc32xx/pm.c b/arch/arm/mach-lpc32xx/pm.c
> index 207e812..dd3a432 100644
> --- a/arch/arm/mach-lpc32xx/pm.c
> +++ b/arch/arm/mach-lpc32xx/pm.c
> @@ -87,7 +87,8 @@ static int lpc32xx_pm_enter(suspend_state_t state)
>  	void *iram_swap_area;
>  
>  	/* Allocate some space for temporary IRAM storage */
> -	iram_swap_area = kmalloc(lpc32xx_sys_suspend_sz, GFP_KERNEL);
> +	iram_swap_area = kmemdup((void *)TEMP_IRAM_AREA,
> +				 lpc32xx_sys_suspend_sz, GFP_KERNEL);
>  	if (!iram_swap_area) {
>  		printk(KERN_ERR
>  		       "PM Suspend: cannot allocate memory to save portion "
> @@ -95,10 +96,6 @@ static int lpc32xx_pm_enter(suspend_state_t state)
>  		return -ENOMEM;
>  	}
>  
> -	/* Backup a small area of IRAM used for the suspend code */
> -	memcpy(iram_swap_area, (void *) TEMP_IRAM_AREA,
> -		lpc32xx_sys_suspend_sz);
> -
>  	/*
>  	 * Copy code to suspend system into IRAM. The suspend code
>  	 * needs to run from IRAM as DRAM may no longer be available
