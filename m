From: kesavan.abhilash@gmail.com (Abhilash Kesavan)
Date: Mon, 21 Apr 2014 21:27:13 +0530
Subject: [PATCH 1/5] ARM: bL_switcher: Don't enable bL switcher on systems
 without CCI
In-Reply-To: <alpine.LFD.2.11.1404161524050.980@knanqh.ubzr>
References: <1397239311-27717-1-git-send-email-a.kesavan@samsung.com>
 <1397239311-27717-2-git-send-email-a.kesavan@samsung.com>
 <alpine.LFD.2.11.1404111406210.980@knanqh.ubzr>
 <CAM4voanduaJ32ztj6ZDMOPXNd9W6Ttwae_PQ68VGxPKZEsj3kA@mail.gmail.com>
 <alpine.LFD.2.11.1404161524050.980@knanqh.ubzr>
Message-ID: <CAM4voamv7CrGpnM_HgTsSU6jvb3TffC0BKKrvNh-VHj+u9EKOQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Nicolas,

On Thu, Apr 17, 2014 at 1:48 AM, Nicolas Pitre <nicolas.pitre@linaro.org> wrote:
> On Thu, 17 Apr 2014, Abhilash Kesavan wrote:
>
>> Hi Nicolas,
>>
>> On Fri, Apr 11, 2014 at 11:44 PM, Nicolas Pitre
>> <nicolas.pitre@linaro.org> wrote:
>> > On Fri, 11 Apr 2014, Abhilash Kesavan wrote:
>> >
>> >> From: Andrew Bresticker <abrestic@chromium.org>
>> >>
>> >> Do not enable the big.LITTLE switcher on systems that do not have an
>> >> ARM CCI (cache-coherent interconnect) present.  Since the CCI is used
>> >> to maintain cache coherency between multiple clusters and peripherals,
>> >> it is unlikely that a system without CCI would support big.LITTLE.
>> >>
>> >> Signed-off-by: Andrew Bresticker <abrestic@chromium.org>
>> >> Signed-off-by: Abhilash Kesavan <a.kesavan@samsung.com>
>> >
>> > The b.L switcher depends on MCPM, and it also expects only 2 clusters
>> > which is evaluated at run time or it bails out.
>> >
>> > There might be in theory other ways than the CCI to enforce coherency
>> > between clusters.  And that should all be encapsulated by the MCPM
>> > layer.  The switcher module should not be concerned at all by the
>> > underlying hardware mechanism.
>> >
>> > So if the goal is to determine at run time whether or not the switcher
>> > should be activated in a multi-config kernel, then the criteria should
>> > be whether or not MCPM is initialized, and not if there is a CCI.
>>
>> Yes, we have a multi-SoC enabled kernel (with MCPM and BL_SWITCHER
>> configs enabled); one SoC has a single cluster while the other is a
>> dual cluster. We wanted a run-time check to prevent bL_switcher from
>> running on the single cluster one and zeroed in on CCI. But, I get
>> your point as to why CCI should not be used as a distinguishing factor
>> for switcher initialization.
>>
>> For now, I can use the no_bL_switcher parameter to disable it on
>> certain platforms. However, can you elaborate on the MCPM
>> initialization check you suggested ?
>
> Here's what I mean:
>
> ----- >8
>
> From: Nicolas Pitre <nicolas.pitre@linaro.org>
> Date: Wed, 16 Apr 2014 15:43:59 -0400
> Subject: [PATCH] ARM: bL_switcher: fix validation check before its activation
>
> The switcher should not depend on MAX_CLUSTER which is a build time
> limit to  determine ifit should be activated or not. In a multiplatform
> kernel binary it is possible to have dual-cluster and quad-cluster
> platforms configured in. In that case MAX_CLUSTER should be 4 and that
> shouldn't prevent the switcher from working if the kernel is booted on a
> b.L dual-cluster system.
>
> In bL_switcher_halve_cpus() we already have a runtime validation check
> to make sure we're dealing with only two clusters, so booting on a quad
> cluster system will be caught and switcher activation aborted.
>
> However, the b.L switcher must ensure the MCPM layer is initialized on
> the booted hardware before doing anything.  The mcpm_is_available()
> function is added to that effect.
>
> Signed-off-by: Nicolas Pitre <nico@linaro.org>

Thank you for the explanation and patch. I have tested this on our
multi-platform configuration and it works fine - activating the
switcher on one SoC and not on the other.

Even though it is not the case now, could we have a scenario where we
may use mcpm for only secondary core boot-up on one SoC and for
switching on another ? I would then have mcpm ops populated for both
but still want bL switcher activated for only one of them.

Regards,
Abhilash
>
> diff --git a/arch/arm/common/bL_switcher.c b/arch/arm/common/bL_switcher.c
> index 5774b6ea7a..f01c0ee0c8 100644
> --- a/arch/arm/common/bL_switcher.c
> +++ b/arch/arm/common/bL_switcher.c
> @@ -797,10 +797,8 @@ static int __init bL_switcher_init(void)
>  {
>         int ret;
>
> -       if (MAX_NR_CLUSTERS != 2) {
> -               pr_err("%s: only dual cluster systems are supported\n", __func__);
> -               return -EINVAL;
> -       }
> +       if (!mcpm_is_available())
> +               return -ENODEV;
>
>         cpu_notifier(bL_switcher_hotplug_callback, 0);
>
> diff --git a/arch/arm/common/mcpm_entry.c b/arch/arm/common/mcpm_entry.c
> index 1e361abc29..86fd60fefb 100644
> --- a/arch/arm/common/mcpm_entry.c
> +++ b/arch/arm/common/mcpm_entry.c
> @@ -48,6 +48,11 @@ int __init mcpm_platform_register(const struct mcpm_platform_ops *ops)
>         return 0;
>  }
>
> +bool mcpm_is_available(void)
> +{
> +       return (platform_ops) ? true : false;
> +}
> +
>  int mcpm_cpu_power_up(unsigned int cpu, unsigned int cluster)
>  {
>         if (!platform_ops)
> diff --git a/arch/arm/include/asm/mcpm.h b/arch/arm/include/asm/mcpm.h
> index 608516ebab..a5ff410dcd 100644
> --- a/arch/arm/include/asm/mcpm.h
> +++ b/arch/arm/include/asm/mcpm.h
> @@ -54,6 +54,13 @@ void mcpm_set_early_poke(unsigned cpu, unsigned cluster,
>   */
>
>  /**
> + * mcpm_is_available - returns whether MCPM is initialized and available
> + *
> + * This returns true or false accordingly.
> + */
> +bool mcpm_is_available(void);
> +
> +/**
>   * mcpm_cpu_power_up - make given CPU in given cluster runable
>   *
>   * @cpu: CPU number within given cluster
