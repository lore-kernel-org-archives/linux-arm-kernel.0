From: grinberg@compulab.co.il (Igor Grinberg)
Date: Mon, 19 Dec 2011 10:10:11 +0200
Subject: [PATCH] ARM: OMAP: avoid NULL pointer dereference when no PMIC
 is configured
In-Reply-To: <1324235628-26439-1-git-send-email-zonque@gmail.com>
References: <1324235628-26439-1-git-send-email-zonque@gmail.com>
Message-ID: <4EEEF163.7030608@compulab.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Daniel,

On 12/18/11 21:13, Daniel Mack wrote:
> Signed-off-by: Daniel Mack <zonque@gmail.com>
> Cc: Tony Lindgren <tony@atomide.com>
> ---
>  arch/arm/mach-omap2/vp.c |    5 +++++
>  1 files changed, 5 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/vp.c b/arch/arm/mach-omap2/vp.c
> index 66bd700..5407173 100644
> --- a/arch/arm/mach-omap2/vp.c
> +++ b/arch/arm/mach-omap2/vp.c
> @@ -41,6 +41,11 @@ void __init omap_vp_init(struct voltagedomain *voltdm)
>  	u32 val, sys_clk_rate, timeout, waittime;
>  	u32 vddmin, vddmax, vstepmin, vstepmax;
>  
> +	if (!voltdm->pmic) {
> +		pr_err("%s: No PMIC configured.\n", __func__, voltdm->name);

You are passing two parameters to pr_err(), but use only one...
Also, I don't know if this is the right thing to do here,
so Cc'ed Paul and Kevin.

> +		return;
> +	}
> +
>  	if (!voltdm->read || !voltdm->write) {
>  		pr_err("%s: No read/write API for accessing vdd_%s regs\n",
>  			__func__, voltdm->name);

-- 
Regards,
Igor.
