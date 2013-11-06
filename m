From: magnus.damm@gmail.com (Magnus Damm)
Date: Thu, 7 Nov 2013 06:57:29 +0900
Subject: [PATCH 2/3] ARM: shmobile: Remove non-existent LOCAL_TIMERS
In-Reply-To: <1383768243-11466-1-git-send-email-shc_work@mail.ru>
References: <1383768243-11466-1-git-send-email-shc_work@mail.ru>
Message-ID: <CANqRtoT8CmxKtT0x1REg3VnhkuuZZvRzxLHiQpBFWsgXZx8xcA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Alex,

On Thu, Nov 7, 2013 at 5:04 AM, Alexander Shiyan <shc_work@mail.ru> wrote:
>
> Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
> ---
>  arch/arm/mach-shmobile/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm/mach-shmobile/Kconfig b/arch/arm/mach-shmobile/Kconfig
> index a4a4b75..2de4fb8 100644
> --- a/arch/arm/mach-shmobile/Kconfig
> +++ b/arch/arm/mach-shmobile/Kconfig
> @@ -4,7 +4,7 @@ config ARCH_SHMOBILE_MULTI
>         select CPU_V7
>         select GENERIC_CLOCKEVENTS
>         select HAVE_ARM_SCU if SMP
> -       select HAVE_ARM_TWD if LOCAL_TIMERS
> +       select HAVE_ARM_TWD if SMP
>         select HAVE_SMP
>         select ARM_GIC
>         select MIGHT_HAVE_CACHE_L2X0

Thanks for your patch. I'm not sure if I 100% agree with the change
above, but it may be correct depending on what is expected of the TWD
driver.

In mach-shmobile we have a couple of Cortex-A9 SoCs with one or more
CPU cores. What I can tell by the Linux TWD driver only SMP operation
is supported. This seems different from the Cortex-A15/A7 architected
timer that also supports UP mode.

We use our Renesas-specific timers for single core and multi core
operation and opt-in with local timers when those are enabled by the
kernel configuration and DT and/or C support code. TWD is used in
SMP-mode only today. If possible I'd also like to use the TWD for UP
operation on the Cortex-A9 single core SoCs, but the above change is
not really aligned with that. Perhaps my expectation is too high, I'm
not sure.

Has anyone use TWD with single core Cortex-A9 or multi-core Cortex-A9
in UP mode? Is there a software or hardware limitation why it can't be
used with a single mode?

Cheers,

/ magnus
