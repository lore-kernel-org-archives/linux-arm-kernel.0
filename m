From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sun, 2 Oct 2011 16:21:55 +0100
Subject: [PATCH 01/11] ARM: export rtc_lock for nvram driver
In-Reply-To: <1317496920-7764-2-git-send-email-arnd@arndb.de>
References: <1317496920-7764-1-git-send-email-arnd@arndb.de>
	<1317496920-7764-2-git-send-email-arnd@arndb.de>
Message-ID: <20111002152155.GW11710@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Oct 01, 2011 at 09:21:50PM +0200, Arnd Bergmann wrote:
> The rtc_lock is used by both the nvram and rtc drivers, so
> we need to export it if at least one of the two is built,
> not just for the rtc driver.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  arch/arm/kernel/time.c |    6 ++----
>  1 files changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm/kernel/time.c b/arch/arm/kernel/time.c
> index cb634c3..5a54b95 100644
> --- a/arch/arm/kernel/time.c
> +++ b/arch/arm/kernel/time.c
> @@ -39,13 +39,11 @@
>   */
>  static struct sys_timer *system_timer;
>  
> -#if defined(CONFIG_RTC_DRV_CMOS) || defined(CONFIG_RTC_DRV_CMOS_MODULE)
> +#if defined(CONFIG_RTC_DRV_CMOS) || defined(CONFIG_RTC_DRV_CMOS_MODULE) || \
> +    defined(CONFIG_NVRAM) || defined(CONFIG_NVRAM_MODULE)
>  /* this needs a better home */
>  DEFINE_SPINLOCK(rtc_lock);
> -
> -#ifdef CONFIG_RTC_DRV_CMOS_MODULE
>  EXPORT_SYMBOL(rtc_lock);
> -#endif
>  #endif	/* pc-style 'CMOS' RTC support */

Some architectures always define this lock and export it irrespective of
the configuration.  Others define it, but never export it.  Some define
it but only export it for 32-bit builds.

One thing springs to mind here - why isn't there a symbol to enable the
presence of rtc_lock in the kernel?  A second related point is why is
this in arch code?
