From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 28 Jul 2016 12:09:25 +0200
Subject: Why do we need reset_control_get_optional() ?
In-Reply-To: <1469698980.12835.18.camel@pengutronix.de>
References: <CAK7LNAQnitMMp5wMXXvVeS-UFF=Fo9m=M1hL=5f4=RF8JYCnGg@mail.gmail.com>
 <1469698980.12835.18.camel@pengutronix.de>
Message-ID: <5955443.3UvZHD6laK@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday, July 28, 2016 11:43:00 AM CEST Philipp Zabel wrote:
> > I want to deprecate _optional variants in the following steps:
> > 
> > [1] Add "depends on RESET_CONTROLLER" to drivers
> >     for which reset_control is mandatory.
> > 
> >     We can find those driver easily by grepping
> >     the reference to non-optional reset_control_get().
> 
> Since we have the stubs, the RESET_CONTROLLER dependency is only at
> runtime, not at build time.
> 
> I think Arnd wanted to move this in the opposite direction and remove
> the configurable RESET_CONTROLLER symbol. Maybe we should let all
> drivers that currently request non-optional resets have:
>         depends on (ARCH_HAS_)RESET_CONTROLLER || COMPILE_TEST
> ?

There are various ways to improve the current situation.

I think it's important that a driver that has an optional
reset line behaves in exactly the same way whether the reset
subsystem is enabled or disabled when no reset line is
provided for a machine.

When a driver requires a reset line, we can either have a
build-time failure when the reset subsystem is disabled
(enforcing the Kconfig dependency), or cause a runtime
failure if either there is no reset line or the subsystem
is disabled.

In my experimental patch, I make the _optional functions
return NULL if no "resets" property is provided but return
an error if there are reset lines but the subsystem is
disabled, i.e. an optional reset must be used if it's in the
DT, but can be ignored otherwise.

	Arnd
