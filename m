From: boris.ostrovsky@oracle.com (Boris Ostrovsky)
Date: Tue, 19 May 2015 09:57:19 -0400
Subject: [PATCH] xen: fix building on ARM with CONFIG_HIBERNATE_CALLBACKS
In-Reply-To: <3837965.uXvcfKiP40@wuerfel>
References: <3837965.uXvcfKiP40@wuerfel>
Message-ID: <555B413F.7020509@oracle.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/19/2015 08:58 AM, Arnd Bergmann wrote:
> A recent bug fix for x86 broke Xen on ARM for the case that
> CONFIG_HIBERNATE_CALLBACKS is enabled:
>
> drivers/built-in.o: In function `do_suspend':
> /git/arm-soc/drivers/xen/manage.c:134: undefined reference to `xen_arch_suspend'
> drivers/built-in.o:(.debug_addr+0xc3f4): undefined reference to `xen_arch_suspend'
>
> It is not clear to me what needs to be done here, but this
> patch avoids the build error by adding a stub for the
> missing function.

This is already fixed in Xen staging tree.

Thanks.
-boris

>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Fixes: 2b953a5e99 ("xen: Suspend ticks on all CPUs during suspend")
> ---
> Please review, and submit an alternate patch if this one turns
> out to be incorrect.
>
> diff --git a/include/xen/xen-ops.h b/include/xen/xen-ops.h
> index 0ce4f32017ea..034dc8acd47e 100644
> --- a/include/xen/xen-ops.h
> +++ b/include/xen/xen-ops.h
> @@ -13,7 +13,13 @@ void xen_arch_post_suspend(int suspend_cancelled);
>   
>   void xen_timer_resume(void);
>   void xen_arch_resume(void);
> +#ifdef CONFIG_X86
>   void xen_arch_suspend(void);
> +#else
> +static inline void xen_arch_suspend(void)
> +{
> +}
> +#endif
>   
>   void xen_resume_notifier_register(struct notifier_block *nb);
>   void xen_resume_notifier_unregister(struct notifier_block *nb);
>
