From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 29 Jan 2015 11:01:16 +0100
Subject: [PATCH 3/3] cpufreq: exynos: allow modular build
In-Reply-To: <CAKohpom9L4jiMRGn3OaWyYM7iR3Ame4-LKG144yuHmRxCJud3g@mail.gmail.com>
References: <1422451015-390439-1-git-send-email-arnd@arndb.de>
 <1799972.nQ2Axu0CEJ@wuerfel>
 <CAKohpom9L4jiMRGn3OaWyYM7iR3Ame4-LKG144yuHmRxCJud3g@mail.gmail.com>
Message-ID: <2157802.ranbh8xTdL@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 29 January 2015 09:09:03 Viresh Kumar wrote:
> On 29 January 2015 at 01:31, Arnd Bergmann <arnd@arndb.de> wrote:
> 
> >>  config ARM_EXYNOS_CPUFREQ
> >> -     bool
> >> +     tristate "SAMSUNG EXYNOS CPUfreq Driver"
> >> +     depends on THERMAL
> >> +     default y
> >> +     help
> >> +       This adds the CPUFreq driver for Samsung EXYNOS platforms
> >> +
> >> +       If in doubt, say N.
> >
> > Now the option shows up on all systems that include Kconfig.arm,
> > in particular non-exynos machines that might not even be able
> > to build this.
> 
> I am sure I am wrong here, but want to know what I am missing.
> What about:
> 
> diff --git a/drivers/cpufreq/Kconfig.arm b/drivers/cpufreq/Kconfig.arm
> index c3c3cf52d2d9..f3ee05067a69 100644
> --- a/drivers/cpufreq/Kconfig.arm
> +++ b/drivers/cpufreq/Kconfig.arm
> @@ -27,7 +27,7 @@ config ARM_VEXPRESS_SPC_CPUFREQ
> 
>  config ARM_EXYNOS_CPUFREQ
>         tristate "SAMSUNG EXYNOS CPUfreq Driver"
> -       depends on THERMAL
> +       depends on THERMAL && ARCH_EXYNOS
>         default y
>         help
>           This adds the CPUFreq driver for Samsung EXYNOS platforms

That might be close enough to what we want. It would by default enable
ARM_EXYNOS_CPUFREQ for exynos based machines that do not use this driver
(e.g. 5440, which has a separate driver, or exynos3/exynos7), but that
can probably just be dealt with by disabling it in the user's defconfig.
If i'm reading exynos_cpufreq_probe right, it would actually compile
into an almost-empty file in this case and only kzalloc a few bytes
of memory and then print a warning message.

	Arnd
