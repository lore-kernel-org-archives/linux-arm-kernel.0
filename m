From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 10 Nov 2015 13:29:35 +0100
Subject: [PATCH v2 1/7] timekeeping: introduce __current_kernel_time64
In-Reply-To: <1447156675-7418-1-git-send-email-stefano.stabellini@eu.citrix.com>
References: <alpine.DEB.2.02.1511101131350.5676@kaball.uk.xensource.com>
 <1447156675-7418-1-git-send-email-stefano.stabellini@eu.citrix.com>
Message-ID: <4372800.FdTygmcuyo@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 10 November 2015 11:57:49 Stefano Stabellini wrote:
> __current_kernel_time64 returns a struct timespec64, without taking the
> xtime lock. Mirrors __current_kernel_time/current_kernel_time.
> 

Actually it doesn't mirror __current_kernel_time/current_kernel_time

> diff --git a/include/linux/timekeeping.h b/include/linux/timekeeping.h
> index ec89d84..b5802bf 100644
> --- a/include/linux/timekeeping.h
> +++ b/include/linux/timekeeping.h
> @@ -19,7 +19,8 @@ extern int do_sys_settimeofday(const struct timespec *tv,
>   */
>  unsigned long get_seconds(void);
>  struct timespec64 current_kernel_time64(void);
> -/* does not take xtime_lock */
> +/* do not take xtime_lock */
> +struct timespec64 __current_kernel_time64(void);
>  struct timespec __current_kernel_time(void);

Please change __current_kernel_time into a static inline function
while you are introducing the new one, to match the patch description ;-)

	Arnd
