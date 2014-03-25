From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 26 Mar 2014 00:42:23 +0100
Subject: [PATCH 44/62] ARM: integrator: refine CPU selection
In-Reply-To: <CACRpkdYPvoobHqG4oQaJbrXDZQwYP6H9n7MSuXDt3MonNsC5jw@mail.gmail.com>
References: <1395257399-359545-1-git-send-email-arnd@arndb.de>
 <201403201148.16239.arnd@arndb.de>
 <CACRpkdYPvoobHqG4oQaJbrXDZQwYP6H9n7MSuXDt3MonNsC5jw@mail.gmail.com>
Message-ID: <4776688.CZBeEWFJox@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 25 March 2014 21:34:21 Linus Walleij wrote:
> On Thu, Mar 20, 2014 at 11:48 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> 
> > Nevermind, I'll drop this patch for now, I just had an idea to do it
> > better: Since Linus and I are trying to get Integrator and Realview
> > moved over into ARCH_MULTIPLATFORM anyway, I'll defer the CPU selection
> > question until that's done.
> 
> Integrator is blocked by one single thing: <mach/memory.h>
> bus_to_virt/virt_to_bus.
> 
> If we can get some consensus on Santosh's patches
> (or however we want to solve that) I'll do multiplatform for
> Integrator any day.

Yes, I know. My point is that once the two are multiplatform, we wouldn't
do the CPU selection patches like this anymore. Instead, I would just do

config CPU_ARM920T
	bool "Support ARM920T processor" if ARCH_MULTI_V4T
	...

config CPU_ARM926T
	bool "Support ARM920T processor" if ARCH_MULTI_V5
	...

...

In a multiplatform kernel, there is nothing wrong with just letting
users turn on arbitrary combinations of CPUs as long as they are
compatible at run-time (i.e. not v5+v7 combined). This will also let
you run qemu images using the MACH_VIRT target and any CPU emulation.

Of course, most platforms will still select the CPUs they actually
use, but you can always add more.

	Arnd
