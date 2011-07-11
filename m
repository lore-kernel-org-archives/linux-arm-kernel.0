From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Mon, 11 Jul 2011 16:46:15 -0700
Subject: [PATCH] OMAP2+: PM: fix watchdog boot when runtime PM is disabled
In-Reply-To: <1310426484-30083-1-git-send-email-khilman@ti.com>
References: <1310426484-30083-1-git-send-email-khilman@ti.com>
Message-ID: <4E1B8B47.3020904@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 7/11/2011 4:21 PM, Kevin Hilman wrote:
> Fix boot crash in watchdog driver when runtime PM is disabled.
>
> When runtime PM is disabled, devices should be left enabled so that
> all device accesses in drivers will succeed even though the runtime PM
> get/put calls are noops.
>
> This is already the case for all devices, but the WDT init has its
> own hwmod postsetup which was not taking this into account.
>
> This fixes a boot crash where the first device access in the WDT probe
> function would crash a booting kernel.
>
> Cc: Paul Walmsley<paul@pwsan.com>
> Signed-off-by: Kevin Hilman<khilman@ti.com>
> ---
> Tony, as this is a boot crash, it should probably be queued for v3.0.
> However, since OMAP2PLUS_TYPICAL always enables runtime PM, this is
> unlikely to be seen unless specifically testing with runtime PM disabled.
>
This patch is exactly same as the one I submitted on Jan 5, 2011 for
the same issue. Here is the patchwork link for the same.

https://patchwork.kernel.org/patch/453481/

Paul had a valid concern about the boot-loader leaving the watchdog
enabled. More on this in below thread.

http://www.spinics.net/lists/arm-kernel/msg110937.html


>   arch/arm/mach-omap2/io.c |    4 ++++
>   1 files changed, 4 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/io.c b/arch/arm/mach-omap2/io.c
> index 441e79d..95c08aa 100644
> --- a/arch/arm/mach-omap2/io.c
> +++ b/arch/arm/mach-omap2/io.c
> @@ -395,7 +395,11 @@ void __init omap2_init_common_infrastructure(void)
>   	 * XXX ideally we could detect whether the MPU WDT was currently
>   	 * enabled here and make this conditional
>   	 */
> +#ifdef CONFIG_PM_RUNTIME
>   	postsetup_state = _HWMOD_STATE_DISABLED;
> +#else
> +	postsetup_state = _HWMOD_STATE_ENABLED;
> +#endif
>   	omap_hwmod_for_each_by_class("wd_timer",
>   				     _set_hwmod_postsetup_state,
>   				&postsetup_state);
