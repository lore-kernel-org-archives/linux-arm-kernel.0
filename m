From: olof@lixom.net (Olof Johansson)
Date: Sat, 12 May 2012 21:15:11 -0700
Subject: [PATCH] ARM: EXYNOS: fix the hotplug for Cortex-A15
In-Reply-To: <01a301cd2de0$7ebaada0$7c3008e0$%kim@samsung.com>
References: <01a301cd2de0$7ebaada0$7c3008e0$%kim@samsung.com>
Message-ID: <CAOesGMiMko9AEmwS7ZqJKxK2H6VA62TyLuMVRe00Tf=EjtYhNw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

As mentioned in your earlier git pull request:

On Wed, May 9, 2012 at 5:37 AM, Kukjin Kim <kgene.kim@samsung.com> wrote:
> From: Changhwan Youn <chaos.youn@samsung.com>
>
> The sequence of cpu_enter_lowpower() for Cortex-A15
> is different from the sequence for Cortex-A9.
> This patch implements cpu_enter_lowpower() for EXYNOS5
> SoC which has Cortex-A15 cores.
>
> Signed-off-by: Changhwan Youn <chaos.youn@samsung.com>
> Cc: Russell King <rmk+kernel@arm.linux.org.uk>
> Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
> ---
> Note, I didn't see common code for fix of hotplug for Cortex-A15.
> If any regarding patch, please kindly let me know, thanks.
>
> ?arch/arm/mach-exynos/hotplug.c | ? 39 +++++++++++++++++++++++++++++++++++++--
> ?1 files changed, 37 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm/mach-exynos/hotplug.c b/arch/arm/mach-exynos/hotplug.c
> index 9c17a0a..2a444b1 100644
> --- a/arch/arm/mach-exynos/hotplug.c
> +++ b/arch/arm/mach-exynos/hotplug.c

[..]
> @@ -112,7 +143,11 @@ void platform_cpu_die(unsigned int cpu)
> ? ? ? ?/*
> ? ? ? ? * we're ready for shutdown now, so do it
> ? ? ? ? */
> - ? ? ? cpu_enter_lowpower();
> + ? ? ? if (soc_is_exynos5250())
> + ? ? ? ? ? ? ? cpu_enter_lowpower_a15();
> + ? ? ? else
> + ? ? ? ? ? ? ? cpu_enter_lowpower_a9();
> +

This should be done by checking for the actual CPU in the system
instead of which SoC it is running on, otherwise you will need to over
time grow this list of SoCs that happen to have A15.


-Olof
