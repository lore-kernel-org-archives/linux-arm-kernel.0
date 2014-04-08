From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Tue, 08 Apr 2014 16:00:17 +0200
Subject: mach header files
In-Reply-To: <20140404152041.6b06bd85@skate>
References: <77a25b9038764679b3bda0f3d4018ee1@HKXPR06MB168.apcprd06.prod.outlook.com>
 <645d041db09d4cf883ba178c695fe504@HKXPR06MB168.apcprd06.prod.outlook.com>
 <20140404152041.6b06bd85@skate>
Message-ID: <4261016.NOmSY7hXBc@avalon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Friday 04 April 2014 15:20:41 Thomas Petazzoni wrote:
> On Fri, 4 Apr 2014 13:14:44 +0000, Phil Edworthy wrote:
> > > If it is used only by one driver, then it should go directly into
> > > that driver without a #include. For SoC defines, you'll need to
> > > check with the arm-soc maintainers. I *think* we're trying to get
> > > away from separate arch/arm/mach-* directories, but I'm slightly
> > > out of touch. You certainly should not do anything that breaks
> > > multiplatform builds.
> > 
> > This is where it gets tricky. The clock driver only wants to know
> > about one reg in a block of general system control registers. There
> > is very little input to the clock driver... the SoC code needs to
> > access other registers in the system control block.
> > 
> > I think you are right about trying to avoid separate arch/arm/mach-*
> > directories, which is what prompted my question. So, how best to
> > handle this?
> 
> I believe there are two solutions here:
> 
>  * Have a driver in arch/arm/mach-foo/ for your "system control block"
>    that exposes a small API used by your clock driver in drivers/clk/.
>    The issue is of course always: where to put the header files for
>    this small API.
> 
>  * Have both your clock driver and your system control block driver map
>    the registers they need, even if some of those registers are the
>    same. Then you can use atomic_io_modify() from both drivers to
>    atomically make changes to these registers. This is typically OK if
>    you don't have any performance sensitive usage of those registers
>    (atomic_io_modify accesses are protected by a global spinlock). This
>    is the solution we've used between the Armada watchdog and Armada
>    clocksource drivers, which require accessing a shared register, even
>    though those two drivers are completely unrelated.

Just for what it's worth, we've solved this problem on R-Car Gen2 by passing 
the boot mode using a direct explicit call from platform code to the clock 
driver. See rcar_gen2_clocks_init() in drivers/clk/shmobile/clk-rcar-gen2.c 
and arch/arm/mach-shmobile/setup-rcar-gen2.c.

If we want to get rid of that I'd go for the first option, as the boot mode 
register is really not part of the clock IP core and should not be listed as a 
memory resource in its DT node.

-- 
Regards,

Laurent Pinchart
