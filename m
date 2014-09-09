From: cminyard@mvista.com (Corey Minyard)
Date: Tue, 09 Sep 2014 13:21:20 -0500
Subject: [PATCH] ipmi: work around gcc-4.9 build warning
In-Reply-To: <58708252.p9ogO3naVQ@wuerfel>
References: <58708252.p9ogO3naVQ@wuerfel>
Message-ID: <540F4520.9090308@mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I'd prefer to fix gcc, but I understand.  This change is probably better
in general, anyway.

Queued for 3.18.  Thanks.

-corey

On 08/23/2014 02:04 PM, Arnd Bergmann wrote:
> Building ipmi on arm with gcc-4.9 results in this warning
> for an allmodconfig build:
>
> drivers/char/ipmi/ipmi_si_intf.c: In function 'ipmi_thread':
> include/linux/time.h:28:5: warning: 'busy_until.tv_sec' may be used uninitialized in this function [-Wmaybe-uninitialized]
>   if (lhs->tv_sec > rhs->tv_sec)
>      ^
> drivers/char/ipmi/ipmi_si_intf.c:1007:18: note: 'busy_until.tv_sec' was declared here
>   struct timespec busy_until;
>                   ^
>
> The warning is bogus and this case can not occur. Apparently
> this is a false positive resulting from gcc getting a little
> smarter about tracking assignments but not smart enough. Marking
> the ipmi_thread_busy_wait function as inline gives the gcc
> optimization logic enough information to figure out for itself
> that the case cannot happen, which gets rid of the warning
> without adding any fake initialization.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>
> diff --git a/drivers/char/ipmi/ipmi_si_intf.c b/drivers/char/ipmi/ipmi_si_intf.c
> index 5d665680ae33..539ff0db52fc 100644
> --- a/drivers/char/ipmi/ipmi_si_intf.c
> +++ b/drivers/char/ipmi/ipmi_si_intf.c
> @@ -965,9 +965,9 @@ static inline int ipmi_si_is_busy(struct timespec *ts)
>  	return ts->tv_nsec != -1;
>  }
>  
> -static int ipmi_thread_busy_wait(enum si_sm_result smi_result,
> -				 const struct smi_info *smi_info,
> -				 struct timespec *busy_until)
> +static inline int ipmi_thread_busy_wait(enum si_sm_result smi_result,
> +					const struct smi_info *smi_info,
> +					struct timespec *busy_until)
>  {
>  	unsigned int max_busy_us = 0;
>  
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
