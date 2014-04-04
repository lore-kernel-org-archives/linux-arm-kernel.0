From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Fri, 4 Apr 2014 15:20:41 +0200
Subject: mach header files
In-Reply-To: <645d041db09d4cf883ba178c695fe504@HKXPR06MB168.apcprd06.prod.outlook.com>
References: <77a25b9038764679b3bda0f3d4018ee1@HKXPR06MB168.apcprd06.prod.outlook.com>
 <CACxGe6sV7WpQeiGxjnmaatnCCzRBqU=O6qyuQXJd+RYt4QUXgg@mail.gmail.com>
 <2be18849c59e4e6686a5b038659279d4@HKXPR06MB168.apcprd06.prod.outlook.com>
 <CACxGe6u0_iMjoCWSw2x=ndEwwYCAaCqFO6OCGHvvuvVnBr2pjg@mail.gmail.com>
 <645d041db09d4cf883ba178c695fe504@HKXPR06MB168.apcprd06.prod.outlook.com>
Message-ID: <20140404152041.6b06bd85@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Phil Edworthy,

On Fri, 4 Apr 2014 13:14:44 +0000, Phil Edworthy wrote:

> > If it is used only by one driver, then it should go directly into
> > that driver without a #include. For SoC defines, you'll need to
> > check with the arm-soc maintainers. I *think* we're trying to get
> > away from separate arch/arm/mach-* directories, but I'm slightly
> > out of touch. You certainly should not do anything that breaks
> > multiplatform builds.
> 
> This is where it gets tricky. The clock driver only wants to know
> about one reg in a block of general system control registers. There
> is very little input to the clock driver... the SoC code needs to
> access other registers in the system control block.
> 
> I think you are right about trying to avoid separate arch/arm/mach-*
> directories, which is what prompted my question. So, how best to
> handle this?

I believe there are two solutions here:

 * Have a driver in arch/arm/mach-foo/ for your "system control block"
   that exposes a small API used by your clock driver in drivers/clk/.
   The issue is of course always: where to put the header files for
   this small API.

 * Have both your clock driver and your system control block driver map
   the registers they need, even if some of those registers are the
   same. Then you can use atomic_io_modify() from both drivers to
   atomically make changes to these registers. This is typically OK if
   you don't have any performance sensitive usage of those registers
   (atomic_io_modify accesses are protected by a global spinlock). This
   is the solution we've used between the Armada watchdog and Armada
   clocksource drivers, which require accessing a shared register, even
   though those two drivers are completely unrelated.

Best regards,

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
