From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 25 Sep 2012 10:41:00 +0100
Subject: [PATCHv5 02/10] ARM: OMAP3+: voltage: add support for
 voltagedomain usecounts
In-Reply-To: <1348565565-14744-3-git-send-email-t-kristo@ti.com>
References: <1348565565-14744-1-git-send-email-t-kristo@ti.com>
 <1348565565-14744-3-git-send-email-t-kristo@ti.com>
Message-ID: <20120925094100.GK31374@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 25, 2012 at 12:32:37PM +0300, Tero Kristo wrote:
> diff --git a/arch/arm/mach-omap2/powerdomain.c b/arch/arm/mach-omap2/powerdomain.c
> index ba49029..ca54aec 100644
> --- a/arch/arm/mach-omap2/powerdomain.c
> +++ b/arch/arm/mach-omap2/powerdomain.c
> @@ -1475,10 +1477,16 @@ int pwrdm_state_switch(struct powerdomain *pwrdm)
>   */
>  void pwrdm_clkdm_enable(struct powerdomain *pwrdm)
>  {
> +	unsigned long flags;
> +
>  	if (!pwrdm)
>  		return;
>  
> -	atomic_inc(&pwrdm->usecount);
> +	if (atomic_inc_return(&pwrdm->usecount) == 1) {
> +		spin_lock_irqsave(&pwrdm->lock, flags);
> +		voltdm_pwrdm_enable(pwrdm->voltdm.ptr);
> +		spin_unlock_irqrestore(&pwrdm->lock, flags);
> +	}

This looks like the classic "I like atomic types because they have magic
properties" brain-deadness.

What would happen to users of this if you had this sequence:

pwrdm->usecount starts off as 1.

Thread0				Thread1
atomic_inc_return() (returns 1)
				atomic_inc_return() (returns 2)
				starts using stuff in power domain
spin_lock_irqsave()
voltdm_pwrdm_enable()
spin_unlock_irqrestore()

?
