From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Thu, 28 Jul 2016 13:00:49 +0200
Subject: Why do we need reset_control_get_optional() ?
In-Reply-To: <CAK7LNAQ0nCQymq+M+FTUXoK7yBj_5CJp9nqDjO3u5wcnckXtmw@mail.gmail.com>
References: <CAK7LNAQnitMMp5wMXXvVeS-UFF=Fo9m=M1hL=5f4=RF8JYCnGg@mail.gmail.com>
 <1469698980.12835.18.camel@pengutronix.de> <5955443.3UvZHD6laK@wuerfel>
 <CAK7LNAQ0nCQymq+M+FTUXoK7yBj_5CJp9nqDjO3u5wcnckXtmw@mail.gmail.com>
Message-ID: <1469703649.12835.34.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Donnerstag, den 28.07.2016, 19:52 +0900 schrieb Masahiro Yamada:
> Hi Arnd,
> 
> 
> 2016-07-28 19:09 GMT+09:00 Arnd Bergmann <arnd@arndb.de>:
> > On Thursday, July 28, 2016 11:43:00 AM CEST Philipp Zabel wrote:
> >> > I want to deprecate _optional variants in the following steps:
> >> >
> >> > [1] Add "depends on RESET_CONTROLLER" to drivers
> >> >     for which reset_control is mandatory.
> >> >
> >> >     We can find those driver easily by grepping
> >> >     the reference to non-optional reset_control_get().
> >>
> >> Since we have the stubs, the RESET_CONTROLLER dependency is only at
> >> runtime, not at build time.
> >>
> >> I think Arnd wanted to move this in the opposite direction and remove
> >> the configurable RESET_CONTROLLER symbol. Maybe we should let all
> >> drivers that currently request non-optional resets have:
> >>         depends on (ARCH_HAS_)RESET_CONTROLLER || COMPILE_TEST
> >> ?
> >
> > There are various ways to improve the current situation.
> >
> > I think it's important that a driver that has an optional
> > reset line behaves in exactly the same way whether the reset
> > subsystem is enabled or disabled when no reset line is
> > provided for a machine.
> >
> > When a driver requires a reset line, we can either have a
> > build-time failure when the reset subsystem is disabled
> > (enforcing the Kconfig dependency), or cause a runtime
> > failure if either there is no reset line or the subsystem
> > is disabled.
> 
> Yes.  I am suggesting the "enforcing the Kconfig dependency".
> 
> "I will let you build this driver, but it would never work"
> is not the right thing to do, I think.

We'd loose randconfig build coverage though. I think allowing to build
unusable drivers in COMPILE_TEST scenarios is ok.

> > In my experimental patch, I make the _optional functions
> > return NULL if no "resets" property is provided but return
> > an error if there are reset lines but the subsystem is
> > disabled, i.e. an optional reset must be used if it's in the
> > DT, but can be ignored otherwise.
> 
> I do not like this idea.
> 
> reset_control_get() (or variants) should not return NULL, it is ambiguous.
> It should return ERR_PTR(-ENOENT) if no "resets" property.
> 
> I only want two types for functions that return a pointer.
> 
> [1] return a valid pointer on success, or return NULL on failure
>     (for example, kmalloc())
> [2] return a valid pointer on success, or return error pointer on failure
>    (many of _register() functions)
> 
> Mixing [1] and [2] will be a mess.

I too would prefer to keep that as-is. The reset_control_get_optional
stub could return -ENOENT if there is no resets device tree property.

regards
Philipp
