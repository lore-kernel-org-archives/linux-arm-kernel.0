From: b.zolnierkie@samsung.com (Bartlomiej Zolnierkiewicz)
Date: Fri, 04 Apr 2014 18:09:53 +0200
Subject: [PATCH V2 17/17] ARM: exynos: config: Enable cpuidle
In-Reply-To: <1396618989-2897-18-git-send-email-daniel.lezcano@linaro.org>
References: <1396618989-2897-1-git-send-email-daniel.lezcano@linaro.org>
 <1396618989-2897-18-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <5825506.2ErDt1UQ5r@amdc1032>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On Friday, April 04, 2014 03:43:09 PM Daniel Lezcano wrote:
> The cpuidle driver is broken since v3.11 and now we are at v3.14.
> 
> Default the cpuidle driver to favorize a better detection next time.
> 
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> Reviewed-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  arch/arm/configs/exynos_defconfig |    1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/configs/exynos_defconfig b/arch/arm/configs/exynos_defconfig
> index 4ce7b70..6ed4b34 100644
> --- a/arch/arm/configs/exynos_defconfig
> +++ b/arch/arm/configs/exynos_defconfig
> @@ -132,3 +132,4 @@ CONFIG_DEBUG_INFO=y
>  CONFIG_DEBUG_USER=y
>  CONFIG_CRYPTO_SHA256=y
>  CONFIG_CRC_CCITT=y
> +CONFIG_CPU_IDLE=y

Sorry but I have to NAK this change.  There are three issues with AFTR
mode that should be resolved first before this patch can be merged:

* The upstream Exynos cpuidle code lacks support for secure firmware and
  it is used on i.e. Trats2 boards (Exynos4412).  Attempts to use AFTR on
  such hardware results in oops + lockup.

  I have patches adding secure firmware support to Exynos cpuidle driver
  but they depend on Tomasz Figa's PM changes which are not yet upstream.

* Somebody needs to verify that the current Exynos cpuidle driver works
  in the AFTR mode on Exynos5420 for which support has been added recently
  (I really doubt it looking at some internal trees).

* Some of our u-boot bootloader versions are incompatible with AFTR.  We
  have observed the problem happening on Trats board (Exynos4210) on which
  it can be fixed by using the upstream u-boot version and Universal C210
  board (Exynos4210 with broken SMP support) on which there is no upstream
  u-boot available (IIRC) and because of the broken SMP support enabling
  cpuidle results in attempt to enter AFTR during boot + immediate lockup.

  I know that this is mainly our problem but the issue is widespread on
  our targets and I believe that adding some workaround for it in cpuidle
  core would be beneficial for the whole cpuidle subsystem.  Namely there
  should be some way of telling cpuidle subsystem to either disable
  particular state(s) or limit the max available state.  I think that this
  can be also useful for testing and development of other cpuidle drivers.

For now please change this patch to add CONFIG_CPU_IDLE=n instead (since
the config option is "default y" it will be auto-enabled if there is no
entry in the defconfig)..

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
