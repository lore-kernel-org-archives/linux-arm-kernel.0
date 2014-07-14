From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 14 Jul 2014 20:55:53 +0200
Subject: [PATCH] cpuidle: big.LITTLE: add MCPM dependency
In-Reply-To: <53C42522.9060907@linaro.org>
References: <4345351.RJRQd7ghCF@wuerfel> <53C42522.9060907@linaro.org>
Message-ID: <6876751.hCLZ4zM0XT@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 14 July 2014 20:44:50 Daniel Lezcano wrote:
> > --- a/drivers/cpuidle/Kconfig.arm
> > +++ b/drivers/cpuidle/Kconfig.arm
> > @@ -10,6 +10,7 @@ config ARM_ARMADA_370_XP_CPUIDLE
> >   config ARM_BIG_LITTLE_CPUIDLE
> >       bool "Support for ARM big.LITTLE processors"
> >       depends on ARCH_VEXPRESS_TC2_PM || ARCH_EXYNOS
> > +     depends on MCPM
> 
> Why do we want to depend on MCPM ? If I want to enable the cpuidle 
> driver, the Kconfig should select the dependencies instead of letting 
> the user to figure out what dependency is missing in order to enable the 
> cpuidle option, no ?
> 
> +       select MCPM
> 

MCPM is a user-selectable option, which doesn't mix well with 'select'.

If you want to use 'select' here, better also change

	bool "Multi-Cluster Power Management"

to just

	bool

in the ARM global Kconfig. The normal way to deal with these dependencies
though is to have platforms 'select' the features they allow and have
device drivers 'depends on' the same symbol.

	Arnd
