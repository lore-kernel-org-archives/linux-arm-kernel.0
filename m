From: b-cousson@ti.com (Cousson, Benoit)
Date: Thu, 1 Mar 2012 15:08:10 +0100
Subject: [PATCH] ARM: OMAP: hwmod: Use sysc_fields->srst_shift and get
 rid of hardcoded SYSC_TYPE2_SOFTRESET_MASK
In-Reply-To: <1330609674-20826-1-git-send-email-rnayak@ti.com>
References: <1330609674-20826-1-git-send-email-rnayak@ti.com>
Message-ID: <4F4F82CA.7040607@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 3/1/2012 2:47 PM, Rajendra Nayak wrote:
> This is useful when we have broken type2 compliant IPs' where
> the softreset shift is not the same as SYSC_TYPE2_SOFTRESET_SHIFT
> and hence is overridden using sysc_fields->srst_shift.
>
> We have atleast one such instance now with onchip keypad on OMAP5

Nit: space is missing.

> which has a different softreset shift as compared to other type2
> IPs'.

A broken IP again :-)

That's anyway a good fix since the srst_shift was already configurable, 
so having a hard-coded mask was wrong or at least error prone for non 
standard IP.

> Signed-off-by: Rajendra Nayak<rnayak@ti.com>
> Cc: Paul Walmsley<paul@pwsan.com>
> Cc: Benoit Cousson<b-cousson@ti.com>
> Cc: Balaji TK<balajitk@ti.com>
> Tested-by: Sourav Poddar<sourav.poddar@ti.com>
> ---
> Paul,
>
> I based the patch on top of your reset/data cleanup series
> for hwmod. So its based on 'hwmod_data_cleanup_3.4' branch.
>
> regards,
> Rajendra
>
>   arch/arm/mach-omap2/omap_hwmod.c |    8 +++++---
>   1 files changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
> index 3462dc5..6aadba2 100644
> --- a/arch/arm/mach-omap2/omap_hwmod.c
> +++ b/arch/arm/mach-omap2/omap_hwmod.c
> @@ -1524,7 +1524,7 @@ static int _read_hardreset(struct omap_hwmod *oh, const char *name)
>    */
>   static int _ocp_softreset(struct omap_hwmod *oh)
>   {
> -	u32 v;
> +	u32 v, softrst_mask;
>   	int c = 0;
>   	int ret = 0;
>
> @@ -1559,11 +1559,13 @@ static int _ocp_softreset(struct omap_hwmod *oh)
>   						    oh->class->sysc->syss_offs)
>   				&  SYSS_RESETDONE_MASK),
>   				  MAX_MODULE_SOFTRESET_WAIT, c);
> -	else if (oh->class->sysc->sysc_flags&  SYSC_HAS_RESET_STATUS)
> +	else if (oh->class->sysc->sysc_flags&  SYSC_HAS_RESET_STATUS) {
> +		softrst_mask = (0x1<<  oh->class->sysc->sysc_fields->srst_shift);
>   		omap_test_timeout(!(omap_hwmod_read(oh,
>   						     oh->class->sysc->sysc_offs)
> -				&  SYSC_TYPE2_SOFTRESET_MASK),
> +				&  softrst_mask),
>   				  MAX_MODULE_SOFTRESET_WAIT, c);
> +	}
>
>   	if (c == MAX_MODULE_SOFTRESET_WAIT)
>   		pr_warning("omap_hwmod: %s: softreset failed (waited %d usec)\n",

Acked-by: Benoit Cousson<b-cousson@ti.com>

Thanks,
Benoit
