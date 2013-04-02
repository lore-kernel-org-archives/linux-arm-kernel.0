From: kgene.kim@samsung.com (Kukjin Kim)
Date: Tue, 02 Apr 2013 19:44:22 +0900
Subject: [PATCH 3/3] ARM: EXYNOS5250: Register architected timers
In-Reply-To: <1363222742-15220-4-git-send-email-agraf@suse.de>
References: <1363222742-15220-1-git-send-email-agraf@suse.de>
 <1363222742-15220-4-git-send-email-agraf@suse.de>
Message-ID: <239701ce2f8f$093a2f40$1bae8dc0$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Alexander Graf wrote:
> 
> When running on an exynos 5250 SoC, we don't initialize the architected
> timers. The chip however supports architected timers.
> 
Yes, exynos5250 can support, mct(multi core timer) is used though.

> When we don't initialize them, KVM will try to access them and run into
> NULL pointer dereferences attempting to do so.
> 
Yes, right.

> This patch is really more of a hack than a real fix, but does get me
> working with KVM on Arndale.
> 
Hmm, if you think, this is _really_ a hack, you need to add some comments
about that for clearance, and since the mct.c file has been moved into
drivers/clocksource/, this should be re-worked.

BTW, I discussed about this with Thomas and Giridhar just now, we reached
this 3rd patch could be dropped because the correct way is to add a dts
node for arch timer which patch 2nd is already doing after 3.9-rc1 because
of CLOCKSOURCE_OF_DECLARE macro.

So if you' OK above, let me know so that I can take only 1st and 2nd
patches to support KVM on exynos5250.

Thanks.

- Kukjin

> Signed-off-by: Alexander Graf <agraf@suse.de>
> ---
>  arch/arm/mach-exynos/mct.c |    4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/arch/arm/mach-exynos/mct.c b/arch/arm/mach-exynos/mct.c
> index c9d6650..eefb8af 100644
> --- a/arch/arm/mach-exynos/mct.c
> +++ b/arch/arm/mach-exynos/mct.c
> @@ -482,4 +482,8 @@ void __init exynos4_timer_init(void)
>  	exynos4_timer_resources();
>  	exynos4_clocksource_init();
>  	exynos4_clockevent_init();
> +
> +	if (soc_is_exynos5250()) {
> +		arch_timer_of_register();
> +	}
>  }
> --
> 1.7.10.4
