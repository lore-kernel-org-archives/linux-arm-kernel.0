From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 12 Oct 2015 21:20:17 +0200
Subject: [PATCH] pxa: remove incorrect __init annotation on
 pxa27x_set_pwrmode
In-Reply-To: <87r3kz6hq9.fsf@belgarion.home>
References: <5287252.pkh9x0t1Y6@wuerfel> <874mhw6mj1.fsf@belgarion.home>
 <87r3kz6hq9.fsf@belgarion.home>
Message-ID: <5395757.goqVg4VzNo@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 12 October 2015 20:53:50 Robert Jarzmik wrote:
> Robert Jarzmik <robert.jarzmik@free.fr> writes:
> 
> > Arnd Bergmann <arnd@arndb.de> writes:
> >
> >> The z2 machine calls pxa27x_set_pwrmode() in order to power off
> >> the machine, but this function gets discarded early at boot because
> >> it is marked __init, as pointed out by kbuild:
> >>
> >> WARNING: vmlinux.o(.text+0x145c4): Section mismatch in reference from the function z2_power_off() to the function .init.text:pxa27x_set_pwrmode()
> >> The function z2_power_off() references
> >> the function __init pxa27x_set_pwrmode().
> >> This is often because z2_power_off lacks a __init
> >> annotation or the annotation of pxa27x_set_pwrmode is wrong.
> >>
> >> This removes the __init section modifier to fix rebooting and the
> >> build error.
> >>
> >> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> >> Fixes: ba4a90a6d86a ("ARM: pxa/z2: fix building error of pxa27x_cpu_suspend() no longer available")
> >> ---
> >> This is a fix for an old bug, I'd just put it into 4.4
> >>
> >> It showed up now because section mismatches now produce errors instead
> >> of warnings.
> >
> > Hi Arnd,
> >
> > I already have this queued for 4.4 from Thierry's patch in :
> >   http://www.spinics.net/lists/arm-kernel/msg449414.html
> >
> > Yet your patch is more complete, as it deals also with the header in pxa27x.h
> > and has the fixes tag.
> >
> > Now I'm wondering if I should enhance Thierry's patch with yours and keeping
> > your signoff with your permission, or drop Thierry's one to replace by yours (I
> > don't know if it's sane behavior to drop an already queued patch ...)
> 
> Actually, I've rethought it over and Thierry's patch approach looks somehow more
> appealing to me. What Thierry did is that he modified the _use_ of
> pxa27x_set_pwrmode() to be called from a __init annonated function. While your
> patch makes pxa27x_set_pwrmode() non __init.
> 
> It looks to me the powermode should be initialized once and for all in the
> machine init code. So unless I've overseen something, I'll keep Thierry's patch.

Ah, sorry. I should have looked at the link you sent.

Thierry's patch indeed looks much nicer if that works, but I'm not entirely
sure if it is safe or not. Only two other pxa27x machines set the PWRMODE_DEEPSLEEP
flag, so it looks like there is a reason for some machines not to set it.
The z2 in particular never did, except in the powerdown handler. So if it
is unable to wake up reliably from DEEPSLEEP, that may be a reason to use
that flag only in the poweroff function but not during normal operation.

	Arnd
