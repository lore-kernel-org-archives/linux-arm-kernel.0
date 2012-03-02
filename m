From: jason@lakedaemon.net (Jason)
Date: Fri, 2 Mar 2012 10:36:14 -0500
Subject: [PATCH 4/4] ARM: kirkwood: convert orion-wdt to fdt.
In-Reply-To: <201203021456.47896.arnd@arndb.de>
References: <cover.1330625877.git.jason@lakedaemon.net>
 <20120302091510.GC29461@kw.sim.vm.gnt>
 <20120302141541.GE11986@titan.lakedaemon.net>
 <201203021456.47896.arnd@arndb.de>
Message-ID: <20120302153614.GG11986@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 02, 2012 at 02:56:47PM +0000, Arnd Bergmann wrote:
> On Friday 02 March 2012, Jason wrote:
> > Grr... good catch.  I originally had this in kirkwood-dreamplug.dts,
> > which is always 200000000.  That's not the case in kirkwood.dtsi.  What
> > I would like to do, and I haven't had time to look into it (I thought I
> > would tackle it later as a refinement :-( ), is a reference of some
> > sort, eg:
> > 
> > in kirkwood.dtsi:
> > 
> > / {
> >         compatible = "marvell,kirkwood";
> >         tclk:clock-frequency = <200000000>;
> > 
> >         wdt at fed20300 {
> >                 compatible = "marvell,orion-wdt";
> >                 reg = <0xfed20300 0x28>;
> >                 clock-frequency = &tclk;
> >         };
> > };
> > 
> > then, in kirkwood-foobar.dts
> > 
> > include "kirkwood.dtsi"
> > 
> > / {
> >         model = "foobar";
> >         compatible = "...";
> >         tclk:clock-frequency = <166000000>;
> > };
> > 
> > but I'm not sure if that would work.
> 
> That would make wdt at fed20300/clock-frequency a phandle pointing to the
> root property, which is not what we want here.

The 200000000 value is not the actual value used in most drivers [1],
but rather the speed of the system clock [2] (hence, my inclination to
make it a root property), the drivers have been pulling this number from
a global variable [3] and dividing/rounding it as needed for their own needs
[1].

Since it's derived from the SoC core [2], it would seem to make sense to
have a root "clock-frequency" in the board dts.  Am I missing something?
Is there a better way to do this?

> > In any case, the simplest answer is to set clock-frequency in
> > kirkwood-dreamplug.dts as a root node property, and then each driver
> > that needs tclk, requests the clock-frequency from the root node.
> > Hopefully, Grant can chime in on this one.
> 
> I think you can just pick a reasonable default value for
> wdt at fed20300/clock-frequency, and let the board override that
> by setting it to something else if necessary.

True, for now, I can just set clock-frequency for each device to the
exact same value and we'll polish later once we have a better idea of
the pattern it's following.

> I suppose this will also change a bit when kirkwood gets moved over to
> generic clk support in the future and starts using the clk binding
> instead of what you do now.

Yes, I don't want to over-think it, but I would like to make sure it's
in the correct place, since it is a global property of the board.

thanks for the review,

Jason.

[1] drivers/spi/spi-orion.c:110-117,500,501

# 110-117 ### orion_spi_baudrate_set()
        tclk_hz = orion_spi->tclk;

        /*
         * the supported rates are: 4,6,8...30
         * round up as we look for equal or less speed
         */
        rate = DIV_ROUND_UP(tclk_hz, speed);
        rate = roundup(rate, 2);
# 500-501 ### orion_spi_probe()
        spi->max_speed = DIV_ROUND_UP(spi->tclk, 4);
        spi->min_speed = DIV_ROUND_UP(spi->tclk, 30);
#############

[2] arch/arm/mach-kirkwood/common.c:320-332

# 320-332 ###
int kirkwood_tclk;

static int __init kirkwood_find_tclk(void)
{
        u32 dev, rev;

        kirkwood_pcie_id(&dev, &rev);

        if (dev == MV88F6281_DEV_ID || dev == MV88F6282_DEV_ID)
                if (((readl(SAMPLE_AT_RESET) >> 21) & 1) == 0)
                        return 200000000;

        return 166666667;
}
#############

[3] arch/arm/mach-kirkwood/common.c:235

# 235 ####### kirkwood_spi_init()
        orion_spi_init(SPI_PHYS_BASE, kirkwood_tclk);
#############
