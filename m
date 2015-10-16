From: sboyd@codeaurora.org (Stephen Boyd)
Date: Fri, 16 Oct 2015 13:04:17 -0700
Subject: [GIT PULL] qcom SoC changes for 4.4 *RESEND*
In-Reply-To: <6622700.vqj78zoFs4@wuerfel>
References: <1444860627-8258-1-git-send-email-agross@codeaurora.org>
 <5294153.vxTnuIq2gr@wuerfel> <56212C3E.8010603@codeaurora.org>
 <6622700.vqj78zoFs4@wuerfel>
Message-ID: <20151016200417.GC16437@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/16, Arnd Bergmann wrote:
> On Friday 16 October 2015 09:56:30 Stephen Boyd wrote:
> > 
> > Can you share your .config? It looks like there are stubs for these, so
> > I'm lost how we got undefined references.
> > 
> http://pastebin.com/HtrC510p
> 
> The problem is CONFIG_HWSPINLOCK=m && CONFIG_QCOM_SMEM=y. Sorry for sending
> an incomplete patch description, I had not noticed those wrapper functions.
> 
> My patch fixes the issue, but does not allow you to build QCOM_SMEM without
> HWSPINLOCK. If we want that configuration to be valid, we need one of
> the two changes below:
> 
> diff --git a/drivers/soc/qcom/Kconfig b/drivers/soc/qcom/Kconfig
> index eec76141d9b9..cae0ffa19bca 100644
> --- a/drivers/soc/qcom/Kconfig
> +++ b/drivers/soc/qcom/Kconfig
> @@ -22,7 +22,7 @@ config QCOM_PM
>  config QCOM_SMEM
>  	tristate "Qualcomm Shared Memory Manager (SMEM)"
>  	depends on ARCH_QCOM
> -	depends on HWSPINLOCK
> +	depends on HWSPINLOCK && !HWSPINLOCK

What does this mean? Is it missing an =m?

>  	help
>  	  Say y here to enable support for the Qualcomm Shared Memory Manager.
>  	  The driver provides an interface to items in a heap shared among all
> diff --git a/include/linux/hwspinlock.h b/include/linux/hwspinlock.h
> index 859d673d98c8..cdfd9fd2ba11 100644
> --- a/include/linux/hwspinlock.h
> +++ b/include/linux/hwspinlock.h
> @@ -59,7 +59,7 @@ struct hwspinlock_pdata {
>  	int base_id;
>  };
>  
> -#if defined(CONFIG_HWSPINLOCK) || defined(CONFIG_HWSPINLOCK_MODULE)
> +#if IS_REACHABLE(CONFIG_HWSPINLOCK)
>  
>  int hwspin_lock_register(struct hwspinlock_device *bank, struct device *dev,
>  		const struct hwspinlock_ops *ops, int base_id, int num_locks);
> 

I'd prefer this patch. Is there some way to capture that
QCOM_SMEM must be a module if HWSPINLOCK is a module unless we're
doing a compile test, in which case we don't care?

I guess that would just be:

	depends on HWSPINLOCK || COMPILE_TEST

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
