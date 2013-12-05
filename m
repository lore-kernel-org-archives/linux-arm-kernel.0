From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 6 Dec 2013 00:09:54 +0100
Subject: [RFC part2 PATCH 2/9] ARM64 / ACPI: Prefill cpu possible/present
 maps and map logical cpu id to APIC id
In-Reply-To: <CAL_JsqKF-_GCRR1d5Hs0F6pCMfLxUYkXAAp9hY7Ywuu1C+aZ0A@mail.gmail.com>
References: <1386088753-2850-1-git-send-email-hanjun.guo@linaro.org>
 <1386088753-2850-3-git-send-email-hanjun.guo@linaro.org>
 <CAL_JsqKF-_GCRR1d5Hs0F6pCMfLxUYkXAAp9hY7Ywuu1C+aZ0A@mail.gmail.com>
Message-ID: <201312060009.54801.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 04 December 2013, Rob Herring wrote:
> > index a0c2ca6..1428024 100644
> > --- a/arch/arm64/kernel/smp.c
> > +++ b/arch/arm64/kernel/smp.c
> > @@ -420,7 +420,9 @@ void __init smp_prepare_cpus(unsigned int max_cpus)
> >                 if (err)
> >                         continue;
> >
> > +#ifndef CONFIG_ACPI
> >                 set_cpu_present(cpu, true);
> > +#endif
> 
> Should this be moved to DT cpu topology related code?

More importantly, the #ifndef is certainly wrong here: It is important that you can
turn CONFIG_ACPI on or off without impacting the run-time code path for non-ACPI
systems. The snippet above breaks this because we no longer set the
cpu mask when ACPI is turned on but not used.

	Arnd
