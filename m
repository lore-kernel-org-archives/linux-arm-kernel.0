From: david.vrabel@citrix.com (David Vrabel)
Date: Fri, 13 Nov 2015 10:42:20 +0000
Subject: [Xen-devel] [PATCH v4 7/7] xen/x86: support XENPF_settime64
In-Reply-To: <1447349448-22610-7-git-send-email-stefano.stabellini@eu.citrix.com>
References: <alpine.DEB.2.02.1511121726370.526@kaball.uk.xensource.com>
 <1447349448-22610-7-git-send-email-stefano.stabellini@eu.citrix.com>
Message-ID: <5645BE8C.6050109@citrix.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/11/15 17:30, Stefano Stabellini wrote:
> Try XENPF_settime64 first, if it is not available fall back to
> XENPF_settime32.
> 
> No need to call __current_kernel_time() when all the info needed are
> already passed via the struct timekeeper * argument.
> 
> Return NOTIFY_BAD in case of errors.
[...]
> @@ -123,9 +124,13 @@ static int xen_pvclock_gtod_notify(struct notifier_block *nb,
>  	static struct timespec next_sync;
>  
>  	struct xen_platform_op op;
> -	struct timespec now;
> +	struct timespec64 now;
> +	struct timekeeper *tk = priv;
> +	static bool settime64_supported = true;
> +	int ret;
>  
> -	now = __current_kernel_time();
> +	now.tv_sec = tk->xtime_sec;
> +	now.tv_nsec = (long)(tk->tkr_mono.xtime_nsec >> tk->tkr_mono.shift);

I think you should introduce __current_kernel_time64() or make
tk_xtime() available.

John, what do you think?

David
