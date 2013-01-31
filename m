From: t-kristo@ti.com (Tero Kristo)
Date: Thu, 31 Jan 2013 11:00:29 +0200
Subject: OMAP4 PM bootloader dependency problems
In-Reply-To: <alpine.DEB.2.00.1301301706580.17105@utopia.booyaka.com>
References: <alpine.DEB.2.00.1301220229140.25789@utopia.booyaka.com>
 <alpine.DEB.2.00.1301301706580.17105@utopia.booyaka.com>
Message-ID: <1359622829.10415.40.camel@sokoban>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2013-01-30 at 17:15 +0000, Paul Walmsley wrote:
> Hi Tero et al.,
> 
> On Tue, 22 Jan 2013, Paul Walmsley wrote:
> 
> > As we've discussed, there are known bootloader dependencies with the OMAP4 
> > PM retention idle code, introduced in v3.8.  Boards booted with u-boot 
> > versions even as recent as 2011 won't enter retention idle correctly; for 
> > example:
> > 
> >     http://www.pwsan.com/omap/testlogs/test_v3.8-rc4/20130120122039/pm/4430es2panda/4430es2panda_log.txt
> 
> ...
> 
> > Barring that, what I'd like to see is a patch for v3.8-rc fixes that adds 
> > a warning, printed to the kernel console, during boot.  The warning should 
> > state that the OMAP4 PM code only works with certain bootloaders, and 
> > should identify the minimum u-boot release needed for OMAP4 full-chip 
> > retention idle to work.
> 
> Any progress on this one?  Time is getting very short to get this into 
> v3.8-rc fixes, and it's important to get this into v3.8 so we don't 
> have users expecting chip power management to work correctly with most 
> u-boot versions that are out in the field.
> 
> All we should need for v3.8-rc are a few pr_warn()s that execute during 
> OMAP4 PM init, noting that the OMAP4 chip power management doesn't work 
> correctly with many bootloaders, due to missing code in the kernel to 
> properly reset and initialize some devices, and noting the first u-boot 
> version that is known to work correctly.

Personally I don't like too much to have just extra spam during boot,
which in many cases is even unnecessary (e.g. people who actually have
good u-boot in use.) Personally I would like to have some sort of test
during boot which detects broken PM and maybe prevents core idle
completely if this is the case. Alternatively we can add extra info to
the failed suspend dump and mention a good u-boot to try out (v2012-07
or newer.)

If we could detect boot loader version from kernel side, that would work
also.

-Tero

> 
> Otherwise there's a very real risk that folks out there will waste lots of 
> time trying to figure out why power management doesn't work as they 
> expect.   To respect our users, we shouldn't put them in that situation.
> 
> 
> - Paul
