From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Fri, 19 Aug 2016 16:18:52 +0100
Subject: Linux 4.7 and Jornada 720 (SA-1100)
In-Reply-To: <8Tcq9pmbIfmjNv8%gof@news.chmurka.net>
References: <4Tcq736lIfmjNv8%gof@news.chmurka.net>
 <20160819102945.GK1041@n2100.armlinux.org.uk>
 <7Tcq9hpfIfmjNv8%gof@news.chmurka.net>
 <20160819132650.GO1041@n2100.armlinux.org.uk>
 <8Tcq9pmbIfmjNv8%gof@news.chmurka.net>
Message-ID: <20160819151852.GR1041@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 19, 2016 at 02:33:34PM +0000, Adam Wysocki wrote:
> Russell King - ARM Linux <linux@armlinux.org.uk> wrote:
> 
> > Looking at the board file, the jornada720 doesn't use sa11x0-fb at all.
> > It uses an Epson s1d13xxx device.  The defconfig for jornada720 has:
> 
> Another bingo - enabling this:
> 
> > CONFIG_FB_S1D13XXX=y
> 
> Solved the issue with console. Thanks!
> 
> > so if your configuration is derived from that, you should have the
> > driver already enabled.
> 
> Where is this board file and defconfig for Jornada? I wasn't aware of 
> their existence, so I did my config from scratch. Maybe comparing my 
> config to defconfig will solve the issue with CF card, too...

The cut-down configuration file is in arch/arm/configs/jornada720_defconfig,
but that's no use to compare against.  I'd suggest saving your existing
configuration file, switching to jornada720_defconfig, and then diffing
the result.  So, something like:

$ cp .config config-mine
$ make ARCH=arm jornada720_defconfig
$ diff -u .config config-mine | less

As jornada720_defconfig is rather old, I don't guarantee that it will
produce a working configuration file with current kernels as things
have changed over the years, but it should get you close.

> > I use my printascii() hack in printk() when I need early or lowlevel 
> > debugging rather than early printk.
> 
> Where does it print to? Serial port?

Yes.

> >> > However, if you're not even getting the "Uncompressing Linux... done, 
> >> > booting the kernel." line, that suggests the decompressor is not running, 
> >> > or is trying to access the wrong serial port.  The decompressor tries to 
> >> > find the first serial port out of serial 3, 1 and 2 which has been left 
> >> > enabled.
> >> 
> >> In this order? Maybe it tries to send its messages to the built-in modem 
> >> or IrDA port...
> > 
> > Yes, that order.
> 
> >From SA-1100 developers manual it seems that:
> 
> - serial 0 is the USB device controller
> - serial 1 is the SDLC/UART
> - serial 2 is the IrDA port
> - serial 3 is the UART (probably this one is routed externally)
> - serial 4 is the MCP / SSP (whatever it is)
> 
> So it should use UART... strange that it doesn't do it. Or maybe it does, 
> but on different baudrate than 115200 (but I would probably get garbage 
> then)...

All it does is look for the first enabled serial port, and write the
characters to the FIFO.  The idea is that the boot loader will have
setup one of the ports at the correct baud rate, and we don't need to
have device-specific hacks to select the correct port.

> Does it mean that if I enabled USB device and IrDA in the kernel, I would 
> have external serial port on ttySA2 instead of 0?

The whole ttySA to physical port is something of a mess - in the early
days, people insisted on having ttySA0 be the serial port wired up for
the console, with the other ttySA* devices assigned randomly to the
other UART ports (that's 1, 2, and 3, but not 0 and 4.)

Consequently, without digging through the code each time, there's no
easy way to determine the mapping of these ports.  In the case of
jornada720, arch/arm/mach-sa1100/jornada720.c defines these as:

        sa1100_register_uart(0, 3);
        sa1100_register_uart(1, 1);

which means ttySA0 -> serial 3, ttySA1 -> serial 1, ttySA2 is disabled.

Other platforms have the console on serial 1 rather than serial 3.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
