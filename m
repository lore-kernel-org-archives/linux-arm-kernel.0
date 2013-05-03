From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 03 May 2013 14:48:38 +0200
Subject: [PATCH 9/9] ARM: ux500: always select ABX500_CORE
In-Reply-To: <CACRpkdYgGVepjaGY=1HP-GxE0mzTozA0aaT=jPe=aCPb5ppi9A@mail.gmail.com>
References: <1367528578-518090-1-git-send-email-arnd@arndb.de>
 <15723843.9mConxltov@wuerfel>
 <CACRpkdYgGVepjaGY=1HP-GxE0mzTozA0aaT=jPe=aCPb5ppi9A@mail.gmail.com>
Message-ID: <1883078.Smcmxe7hlB@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 03 May 2013 14:13:20 Linus Walleij wrote:
> On Fri, May 3, 2013 at 1:28 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> > On Friday 03 May 2013 10:14:28 Linus Walleij wrote:
> 
> >> While I understand that from a compile-time point of view it does
> >> not seem nice, and all things would be separate units that you
> >> plug in, from a run-time and system architecture point of view it
> >> makes a lot of sense to select these. Worlds collide...
> (...)
> > My preference would be to make it user-selectable and enable it only in
> > the defconfig, but if that can damage the hardware, we should not actually
> > provide a named option.
> 
> Hm I'd lean towards the latter. However the AB8500 has subdrivers
> and *some* of these are optional, such as the RTC. And it'd be
> strange to have that depend on some totally unrelated config symbol
> like UX500_SOC_COMMON.
> 
> I think that in that case we should make AB8500_CORE a hidden
> (non-user selectable) bool so it is more logical.

Yes, makes sense.

> However any if these approaches will lead to unaestetic menuconfig
> with AB8500 suboptions appearing right in the MFD menu instead of
> being ordered under a AB8500_CORE node which is better for
> anyone actually trying to use menuconfig interactively.

Yes, I can see that. Right now we have:

   -*- ST-Ericsson ABX500 Mixed Signal Circuit register functions 
   [*]   ST-Ericsson AB3100 Mixed Signal Circuit core functions   
   [*]     ST-Ericsson AB3100 OTP functions                      
   -*-   ST-Ericsson AB8500 Mixed Signal Power Management chip
   [*]     ST-Ericsson AB8500 GPADC driver
   [*]       Enable debug info via debugfs
   -*- ST-Ericsson DB8500 Power Reset Control Management Unit

I think we can certainly eliminate the ABX500 option, this one can
just get selected by AB3100 and AB8500. The PRCMU can also
be silent because as you say it is always needed.

One possible reason to allow them to be selected is to enable
build-time coverage on other platforms, but at the moment, they
all depend on ARCH_U300|ARCH_U8500, presumably because until
very recently they would not actually build anywhere else.

The GPADC driver is interesting: it does not have its own user
interface (besides the debugging driver) and could just get selected
by the other drivers using its exported interfaces. It would
also be better to convert it to the standard IIO ADC interface,
but I don't know if that's realistic. This leavs the debugging
interface as the only sub-option. Do you know if that is
actually being used by developers, or is this one of those interfaces
that were created during bringup and then never touched again
after everything worked?

Regarding AB3100, I assume the relationship to U300 is similar to
that between DB8500 and AB8500. Are you able to boot a U300 system
without touching AB3100?

	Arnd
