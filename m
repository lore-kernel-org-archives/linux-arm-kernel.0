From: phil.edworthy@renesas.com (Phil Edworthy)
Date: Fri, 4 Apr 2014 13:52:53 +0000
Subject: mach header files
In-Reply-To: <4379667.784l7DtcMU@wuerfel>
References: <77a25b9038764679b3bda0f3d4018ee1@HKXPR06MB168.apcprd06.prod.outlook.com>
 <CACxGe6sV7WpQeiGxjnmaatnCCzRBqU=O6qyuQXJd+RYt4QUXgg@mail.gmail.com>
 <4379667.784l7DtcMU@wuerfel>
Message-ID: <0bbbadf628a64ee5be8ede870d421a57@SIXPR06MB173.apcprd06.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

On 04 April 2014 14:24, Arnd wrote:
> On Friday 04 April 2014 03:29:54 Grant Likely wrote:
> > On Fri, Apr 4, 2014 at 1:19 AM, Phil Edworthy
> <phil.edworthy@renesas.com> wrote:
> > > Resent, hopefully without the automatic corporate signature appended
> this time...
> > >
> > > I am porting the kernel to a new device, for which I've created a new
> > > arch/arm/mach-... directory, and I also a clock driver that lives under
> > > driver/clk. Everything is all working fine, though I am now cleaning up
> > > the code and have a question about mach specific header files.
> 
> I'm glad you are asking while you are still in the process of cleaning
> up your code, because you need to know the rules for new platforms.
> Basically at this point we expect zero code in arch/arm/mach-* for a new
> platform. You are absolutely required to have DT based probing and
> multiplatform support, and the latter also means that there are no
> mach/*.h header files that are visible to device drivers.
> 
> We still make the occasional exception for adding code in the mach-*
> directory, but we are getting pretty close to the state where this
> is not needed for new platforms, and all the existing uses are for
> things that can eventually get cleaned up.
> If you think you need an exception here, please explain what you
> are doing, and we can see if there is a better way to do that already.

Ok, that's what I suspected about the mach header files.

I didn't realise about the expectation that there is no arch/arm/mach-* for new platforms. At the moment I have only a small amount of platform code:
1. SMP holding pen code (as there is no power control for the second core), though I have recently seen patches to provide a generic solution for this.
2. Firmware calls (via struct firmware_ops) for set_cpu_boot_addr and cpu_boot. This falls back to directly accessing registers in the system control block, if the firmware fails. This is useful when developing the system when no firmware exists yet.
3. A write to a system control register to switch the pl011 uart from DMA single requests, to DMA burst requests.
 
> > > The clock driver is completely specific to this device, but needs to read
> > > from a system register (just for external boot mode pins) to determine
> some
> > > PLL settings. This register is in a block of system registers which are
> > > also used by the mach code in arch/arm/mach-...
> > >
> > > Since the clock driver is specific to the mach, is there any point in
> > > specifying the address of this reg in the corresponding dtsi? The format
> > > and functionality described by this register would not be the same on any
> other device.
> >
> > Why would you not? The dts is a central place where the entire memory
> > map layout of the device can be specified. If I were working on the
> > board support, I would create a node for the register block and have
> > the driver retrieve that node.
> 
> Right. More specifically, this case is often handled using the
> drivers/mfd/syscon.c
> driver, which exports a "regmap" pointer that can be used by drivers to
> access
> those registers. The driver will need to look up the regmap through a
> phandle
> in DT, and it can either use a hardcoded offset into the regmap to get
> to the specific register it needs, or it can look up the offset from DT
> as well. Which of the two you pick depends on the particular needs of the
> device.
> 
> > > If I don't specify the address of the register in the dtsi, I think it
> > > would be best to have a common header file for all of the system
> registers.
> > > I've seen some drivers, e.g.  exynos-cpufreq.c, doing this by including
> files
> > > from mach-exynos/include/mach. Is that the right way to do this?
> 
> You have managed to pick the perfect example: The exynos cpufreq driver is
> the
> one that is currently blocking support for multiplatform exynos builds
> because
> it uses header files from the platform code. Because of this, we are actually
> planning to throw out that driver entirely in the next merge window.
> 
> In short, definitely the wrong way.
I had pretty much realised that, but saw the exynos code and wanted to check. I'm glad I asked!

Thanks
Phil
