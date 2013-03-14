From: cdall@cs.columbia.edu (Christoffer Dall)
Date: Wed, 13 Mar 2013 20:26:24 -0700
Subject: [kvmarm] [PATCH 3/3] ARM: EXYNOS5250: Register architected timers
In-Reply-To: <1363222742-15220-4-git-send-email-agraf@suse.de>
References: <1363222742-15220-1-git-send-email-agraf@suse.de>
 <1363222742-15220-4-git-send-email-agraf@suse.de>
Message-ID: <CAEDV+gLmwa__PQ3cNaqmycAekMGY3QwvEkL2AB6gMt7n9Sxujg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 13, 2013 at 5:59 PM, Alexander Graf <agraf@suse.de> wrote:
> When running on an exynos 5250 SoC, we don't initialize the architected
> timers. The chip however supports architected timers.
>
> When we don't initialize them, KVM will try to access them and run into
> NULL pointer dereferences attempting to do so.
>
> This patch is really more of a hack than a real fix, but does get me
> working with KVM on Arndale.
>
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
>         exynos4_timer_resources();
>         exynos4_clocksource_init();
>         exynos4_clockevent_init();
> +
> +       if (soc_is_exynos5250()) {
> +               arch_timer_of_register();
> +       }
>  }

I did something similar a while back:
https://github.com/columbia/linux-kvm-arm/commit/2a368f711893e8fb5fe5cf9e237a7631277f3fd1

But I'm not sure how exactly is the right way for exynos. The other
patches look good to me (you can find some very similar work around
that very commit in my tree).

-Christoffer
