From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Sat, 11 Jan 2014 15:27:39 -0500 (EST)
Subject: [PATCH] Harden OABI epoll_wait() against trinity
In-Reply-To: <20140111154902.GK15937@n2100.arm.linux.org.uk>
References: <20140111154902.GK15937@n2100.arm.linux.org.uk>
Message-ID: <alpine.LFD.2.10.1401111527160.28907@knanqh.ubzr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, 11 Jan 2014, Russell King - ARM Linux wrote:

> While running trinity on the OMAP4430 SDP, an issue was noticed with
> the OABI epoll helper causing memory allocation failure warnings.
> 
> There are two issues here - the first is what happens when a very
> large number of events is passed, but the user address does not allow
> them to be stored.  This is simple to address, since we can just use
> access_ok() to verify that the memory is writable.
> 
> The second is what happens when the user address is valid, but still
> a large number of events has been passed.  This can still cause
> kmalloc() to fail.  So, let it fail, but without warning, thereby
> causing userspace to be given an ENOMEM error.
> 
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

Acked-by: Nicolas Pitre <nico@linaro.org>


> ---
>  arch/arm/kernel/sys_oabi-compat.c |    6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/kernel/sys_oabi-compat.c b/arch/arm/kernel/sys_oabi-compat.c
> index 3e94811..4e34405 100644
> --- a/arch/arm/kernel/sys_oabi-compat.c
> +++ b/arch/arm/kernel/sys_oabi-compat.c
> @@ -277,7 +277,11 @@ asmlinkage long sys_oabi_epoll_wait(int epfd,
>  
>  	if (maxevents <= 0 || maxevents > (INT_MAX/sizeof(struct epoll_event)))
>  		return -EINVAL;
> -	kbuf = kmalloc(sizeof(*kbuf) * maxevents, GFP_KERNEL);
> +
> +	if (!access_ok(VERIFY_WRITE, events, maxevents * sizeof(*events)))
> +		return -EFAULT;
> +
> +	kbuf = kmalloc(sizeof(*kbuf) * maxevents, GFP_KERNEL | __GFP_NOWARN);
>  	if (!kbuf)
>  		return -ENOMEM;
>  	fs = get_fs();
> 
> -- 
> FTTC broadband for 0.8mile line: 5.8Mbps down 500kbps up.  Estimation
> in database were 13.1 to 19Mbit for a good line, about 7.5+ for a bad.
> Estimate before purchase was "up to 13.2Mbit".
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
