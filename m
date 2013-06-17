From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 17 Jun 2013 15:31:24 +0800
Subject: [PATCH] ARM: smp_twd: twd_update_frequency need be run on all
 online CPUs
In-Reply-To: <1371079180-22344-1-git-send-email-r64343@freescale.com>
References: <1371079180-22344-1-git-send-email-r64343@freescale.com>
Message-ID: <20130617073120.GA4537@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 13, 2013 at 07:19:40AM +0800, Jason Liu wrote:
> When the local timer freq changed, the twd_update_frequency function
> should be run all the CPUs include itself, otherwise, the twd freq will
> not get updated and the local timer will not run correcttly.
> 
> smp_call_function will run functions on all other CPUs, but not include
> himself, this is not correct,use on_each_cpu instead to fix this issue.
> 
> Signed-off-by: Jason Liu <r64343@freescale.com>
> Cc: Russell King <linux@arm.linux.org.uk>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Rob Herring <rob.herring@calxeda.com>
> Cc: Shawn Guo <shawn.guo@linaro.org>

Acked-by: Shawn Guo <shawn.guo@linaro.org>

BTW, is there anything wrong with your mailer (git send-email command
line)?  I do not see people you put on Cc tag here show up in Cc of the
email.  And that might the be reason why people are not responding so
far.

Shawn

> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: stable at vger.kernel.org
> ---
>  arch/arm/kernel/smp_twd.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/kernel/smp_twd.c b/arch/arm/kernel/smp_twd.c
> index 90525d9..f6fd1d4 100644
> --- a/arch/arm/kernel/smp_twd.c
> +++ b/arch/arm/kernel/smp_twd.c
> @@ -120,7 +120,7 @@ static int twd_rate_change(struct notifier_block *nb,
>  	 * changing cpu.
>  	 */
>  	if (flags == POST_RATE_CHANGE)
> -		smp_call_function(twd_update_frequency,
> +		on_each_cpu(twd_update_frequency,
>  				  (void *)&cnd->new_rate, 1);
>  
>  	return NOTIFY_OK;
> -- 
> 1.7.10.4
> 
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
