From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 21 Jun 2013 16:00:04 +0200
Subject: [PATCH v12 05/11] edma: config: Enable config options for EDMA
In-Reply-To: <CAD=GYpb54bitcg0gnfhzxbvig3etRPY6fs=FOQu5nYkio5NRZw@mail.gmail.com>
References: <1371762407-24544-1-git-send-email-joelagnel@ti.com>
 <51C427E1.2000800@ti.com>
 <CAD=GYpb54bitcg0gnfhzxbvig3etRPY6fs=FOQu5nYkio5NRZw@mail.gmail.com>
Message-ID: <201306211600.04986.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 21 June 2013, Joel A Fernandes wrote:
> >> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> >> index b1c66a4..7d58cd9 100644
> >> --- a/arch/arm/Kconfig
> >> +++ b/arch/arm/Kconfig
> >> @@ -841,6 +841,7 @@ config ARCH_DAVINCI
> >>       select HAVE_IDE
> >>       select NEED_MACH_GPIO_H
> >>       select TI_PRIV_EDMA
> >> +     select DMADEVICES
> >
> > It is generally a bad idea to force select on something that can be
> > enabled using menuconfig. Unless used carefully, select causes "unmet
> > direct dependency" warnings which folks are already fighting hard to
> > fix. This leads to what Russell referred in the past as "select madness" [1]
> 
> Are you concerned with bloat issues? I know your point of view but the idea
> was to build these options by default for these platforms even though
> in some cases
> it might not be used. I have seen folks including myself select the wrong
> option. Having the build system automatically select the correct option for the
> most common cases can be very useful I feel and not require manual
> configuration.

For defaults, you should use the defconfig, not 'select' in Kconfig.

A lot of the 'select' statements are actually wrong because they
do not take dependencies into account where A selects B but not C,
and B depends on C, which leads to broken builds when C is disabled
by a user (or randconfig).

You should only ever use 'select' from platforms on silent options
that are not themselves user selectable like the above 'HAVE_IDE'
and 'NEED_MACH_GPIO_H'.

	Arnd
