From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 28 Nov 2018 22:34:57 +0100
Subject: [PATCH v4 14/20] ARM: mmp/mmp2: use cpu_is_pj4() instead of
 cpu_is_mmp2()
In-Reply-To: <20181128175324.163202-15-lkundrak@v3.sk>
References: <20181128175324.163202-1-lkundrak@v3.sk>
 <20181128175324.163202-15-lkundrak@v3.sk>
Message-ID: <CAK8P3a2=itOMfHax1rpJEUKfBKeU=-hPnn1yA3V4r3Q9Hfhz8g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 28, 2018 at 6:54 PM Lubomir Rintel <lkundrak@v3.sk> wrote:
>
> The MMP2 platform uses the PJ4 CPU. The cpu_is_mmp2() macro is thus
> actually not useful at all and moreover gives the wrong result on
> MACH_MMP2_DT.
>
> The actual problem I aim to fix is that on a device-tree enabled system,
> the timer ends up being initialized incorrectly. In fact, it ticks like
> at rate that's 1/100 slower or so.
>
> Perhaps the other cpu_is_mmp2() uses are more benign, but still useless.

I think we still need the helper. If it's broken on some platforms,
it has to be fixed instead.

> @@ -104,7 +104,7 @@ void __init mmp2_init_irq(void)
>
>  static int __init mmp2_init(void)
>  {
> -       if (cpu_is_mmp2()) {
> +       if (cpu_is_pj4()) {
>  #ifdef CONFIG_CACHE_TAUROS2
>                 tauros2_init(0);
>  #endif
> diff --git a/arch/arm/mach-mmp/pm-mmp2.c b/arch/arm/mach-mmp/pm-mmp2.c
> index 17699be3bc3d..bcd5111ffb37 100644
> --- a/arch/arm/mach-mmp/pm-mmp2.c
> +++ b/arch/arm/mach-mmp/pm-mmp2.c
> @@ -220,7 +220,7 @@ static int __init mmp2_pm_init(void)
>  {
>         uint32_t apcr;
>
> -       if (!cpu_is_mmp2())
> +       if (!cpu_is_pj4())
>                 return -EIO;
>
>         suspend_set_ops(&mmp2_pm_ops);

These are both regular initcalls. On a multiplatform kernel, they
will be called unconditionally, and the cpu_is_mmp2() has to
guard code that would be wrong on other SoCs, including those
with a pj4 CPU (Armada XP, Dove, Berlin).

> diff --git a/arch/arm/mach-mmp/time.c b/arch/arm/mach-mmp/time.c
> index 96ad1db0b04b..0f49ac579a17 100644
> --- a/arch/arm/mach-mmp/time.c
> +++ b/arch/arm/mach-mmp/time.c
> @@ -163,7 +163,7 @@ static void __init timer_config(void)
>
>         __raw_writel(0x0, mmp_timer_base + TMR_CER); /* disable */
>
> -       ccr &= (cpu_is_mmp2()) ? (TMR_CCR_CS_0(0) | TMR_CCR_CS_1(0)) :
> +       ccr &= (cpu_is_pj4()) ? (TMR_CCR_CS_0(0) | TMR_CCR_CS_1(0)) :
>                 (TMR_CCR_CS_0(3) | TMR_CCR_CS_1(3));
>         __raw_writel(ccr, mmp_timer_base + TMR_CCR);
>

This looks correct, here we just need to ensure we are not on pj1.
Note: we should probably rename 'timer_init' to something that
that has 'mmp' in the name, the current name conflicts with
a function of the same name in mach-davinci, which is not yet
multiplatform, but hopefully will be one day.

        Arnd
