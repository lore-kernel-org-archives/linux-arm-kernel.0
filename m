From: phil.edworthy@renesas.com (Phil Edworthy)
Date: Fri, 4 Apr 2014 13:14:44 +0000
Subject: mach header files
In-Reply-To: <CACxGe6u0_iMjoCWSw2x=ndEwwYCAaCqFO6OCGHvvuvVnBr2pjg@mail.gmail.com>
References: <77a25b9038764679b3bda0f3d4018ee1@HKXPR06MB168.apcprd06.prod.outlook.com>
 <CACxGe6sV7WpQeiGxjnmaatnCCzRBqU=O6qyuQXJd+RYt4QUXgg@mail.gmail.com>
 <2be18849c59e4e6686a5b038659279d4@HKXPR06MB168.apcprd06.prod.outlook.com>
 <CACxGe6u0_iMjoCWSw2x=ndEwwYCAaCqFO6OCGHvvuvVnBr2pjg@mail.gmail.com>
Message-ID: <645d041db09d4cf883ba178c695fe504@HKXPR06MB168.apcprd06.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Grant,

On: 04 April 2014 13:23, Grant wrote:
> On Fri, Apr 4, 2014 at 5:16 AM, Phil Edworthy <phil.edworthy@renesas.com>
> wrote:
> > Hi Grant,
> >
> > On: 04 April 2014 11:30, Grant wrote:
> >> On Fri, Apr 4, 2014 at 1:19 AM, Phil Edworthy
> <phil.edworthy@renesas.com>
> >> wrote:
> >> > Resent, hopefully without the automatic corporate signature appended
> >> this time...
> >> >
> >> > Hi,
> >> >
> >> > I am porting the kernel to a new device, for which I've created a new
> >> arch/arm/mach-... directory, and I also a clock driver that lives under
> >> driver/clk. Everything is all working fine, though I am now cleaning up the
> >> code and have a question about mach specific header files.
> >> >
> >> > The clock driver is completely specific to this device, but needs to read
> from
> >> a system register (just for external boot mode pins) to determine some
> PLL
> >> settings. This register is in a block of system registers which are also used
> by
> >> the mach code in arch/arm/mach-...
> >> >
> >> > Since the clock driver is specific to the mach, is there any point in
> specifying
> >> the address of this reg in the corresponding dtsi? The format and
> >> functionality described by this register would not be the same on any
> other
> >> device.
> >>
> >> Why would you not? The dts is a central place where the entire memory
> map
> >> layout of the device can be specified. If I were working on the board
> support,
> >> I would create a node for the register block and have the driver retrieve
> that
> >> node.
> >
> > Ok, that's a slightly different view to the one I had. I had thought that the
> dts would only contain information that could be changed from one platform
> to another.
> >
> >> > If I don't specify the address of the register in the dtsi, I think it would
> be
> >> best to have a common header file for all of the system registers. I've
> seen
> >> some drivers, e.g.  exynos-cpufreq.c, doing this by including files from
> mach-
> >> exynos/include/mach. Is that the right way to do this?
> >>
> >> You'd still want to have a header file for each of the register offsets within
> >> the block. You wouldn't want to itemize register offsets in the device tree
> >> node.
> >
> > You would put that include file in a mach-.../include/mach/ dir, right?
> 
> If it is used only by one driver, then it should go directly into that
> driver without a #include. For SoC defines, you'll need to check with
> the arm-soc maintainers. I *think* we're trying to get away from
> separate arch/arm/mach-* directories, but I'm slightly out of touch.
> You certainly should not do anything that breaks multiplatform builds.

This is where it gets tricky. The clock driver only wants to know about one reg in a block of general system control registers. There is very little input to the clock driver... the SoC code needs to access other registers in the system control block.

I think you are right about trying to avoid separate arch/arm/mach-* directories, which is what prompted my question. So, how best to handle this?

Arnd, I would appreciate your comments on this!

Thanks
Phil
