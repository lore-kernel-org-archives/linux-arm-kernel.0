From: sonnyrao@chromium.org (Sonny Rao)
Date: Wed, 10 Dec 2014 14:43:54 -0800
Subject: arm64 hitting BUG in arch_timer.h
In-Reply-To: <1418245000.23374.26.camel@t520.localdomain>
References: <1418245000.23374.26.camel@t520.localdomain>
Message-ID: <CAPz6YkXcerUiLc3dQG0URSuioiLsAwcTLkDTivD4JU9YQsdR+Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 10, 2014 at 12:56 PM, Mark Salter <msalter@redhat.com> wrote:
> Using Linus' tree from this morning, I am hitting:
>
>    [    0.000000] BUG: failure at ./arch/arm64/include/asm/arch_timer.h:112/arch_counter_get_cntpct!
>
> This is triggered by commit 0b46b8a718 ("clocksource: arch_timer: Fix
> code to use physical timers when requested") which addresses an armv7
> problem. Arm64 wants to always use a virtual timer. I used this to avoid
> the BUG and get a booting kernel:
>
> diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch
> index 71846f9..4d8a01e 100644
> --- a/drivers/clocksource/arm_arch_timer.c
> +++ b/drivers/clocksource/arm_arch_timer.c
> @@ -468,7 +468,7 @@ static void __init arch_counter_register(unsigned type)
>
>         /* Register the CP15 based counter if we have one */
>         if (type & ARCH_CP15_TIMER) {
> -               if (arch_timer_use_virtual)
> +               if (IS_ENABLED(CONFIG_ARM64) || arch_timer_use_virtual)
>                         arch_timer_read_counter = arch_counter_get_cntvct;
>                 else
>                         arch_timer_read_counter = arch_counter_get_cntpct;
>
>

Yes Catalin has prepared a similar patch:
https://patchwork.kernel.org/patch/5468031/
