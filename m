From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 26 Feb 2013 11:11:30 +0000
Subject: Multi-platform, and secure-only ARM errata workarounds
In-Reply-To: <201302261048.06644.arnd@arndb.de>
References: <512BF81A.3080700@wwwdotorg.org> <20130226103114.GA16875@arm.com>
 <20130226103503.GB16875@arm.com> <201302261048.06644.arnd@arndb.de>
Message-ID: <20130226111130.GC16875@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 26, 2013 at 10:48:06AM +0000, Arnd Bergmann wrote:
> On Tuesday 26 February 2013, Catalin Marinas wrote:
> > On Tue, Feb 26, 2013 at 10:31:14AM +0000, Catalin Marinas wrote:
> > > On Tue, Feb 26, 2013 at 10:23:26AM +0000, Arnd Bergmann wrote:
> > > > On Monday 25 February 2013, Stephen Warren wrote:
> > > > > Is there any other alternative I'm not seeing? Having the kernel
> > > > > suddenly become incompatible with any currently extant bootloader when I
> > > > > enable CONFIG_MULTIPLATFORM doesn't seem like a great idea.
> > > > 
> > > > Could we make those errata be run-time enabled only when not booting
> > > > in secure mode?
> > > 
> > > There is no easy way to detect whether Linux booted in secure mode,
> > > unless we add some information in the DT. But I wouldn't add S vs NS
> > > information, rather which errata need to be enabled by the kernel.
> > 
> > Another difficulty - parsing the DT is done later while some workarounds
> > are enabled before the MMU (or require the MMU to be disabled
> > temporarily).
> 
> Can we do it easily after detecting the machine_desc? Maybe we could
> add a bit mask of errata to the struct.

On DT platforms we detect the machine_desc after the MMU has been
initialised. Some errata workarounds currently go to __v7_setup and many
of them can't be enabled from non-secure mode. You would need to
simulate a lower power mode or reset to briefly disable the MMU.

Usually the workaround (setting implementation defined bits) is needed
for secondary CPUs as well, but at least at that point we have more
information.

-- 
Catalin
