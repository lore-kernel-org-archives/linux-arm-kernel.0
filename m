From: ynvich@gmail.com (Sergei Ianovich)
Date: Mon, 02 Dec 2013 15:46:22 +0400
Subject: [PATCH 05/11] serial: support for 16550 serial ports on LP-8x4x
In-Reply-To: <20131202084845.GD3942@xps8300>
References: <1385879185-22455-1-git-send-email-ynvich@gmail.com>
 <1385879185-22455-6-git-send-email-ynvich@gmail.com>
 <20131202084845.GD3942@xps8300>
Message-ID: <1385984782.12531.26.camel@host5.omatika.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2013-12-02 at 10:48 +0200, Heikki Krogerus wrote:
> On Sun, Dec 01, 2013 at 10:26:18AM +0400, Sergei Ianovich wrote:
> > The patch adds support for 3 additional LP-8x4x built-in serial
> > ports.
> > 
> > The device can also host up to 8 extension cards with 4 serial ports
> > on each card for a total of 35 ports. However, I don't have
> > the hardware to test extension cards, so they are not supported, yet.

> > --- a/arch/arm/mach-pxa/include/mach/lp8x4x.h
> > +++ b/arch/arm/mach-pxa/include/mach/lp8x4x.h
> > @@ -50,6 +50,12 @@
> >  #define LP8X4X_CLRFALLINT	LP8X4X_P2V(0x1700901a)
> >  #define LP8X4X_RWRTC		LP8X4X_P2V(0x1700901c)
> >  #define LP8X4X_SRAMBANK		0x1700901e
> > +#define LP8X4X_TTYS0_QUIRK	0x17009030
> > +#define LP8X4X_TTYS1_QUIRK	0x17009032
> > +#define LP8X4X_TTYS2_QUIRK	0x17009034
> > +#define LP8X4X_TTYS0_IOMEM	0x17009050
> > +#define LP8X4X_TTYS1_IOMEM	0x17009060
> > +#define LP8X4X_TTYS2_IOMEM	0x17009070
> > +
> > +static void lp8x4x_set_termios(struct uart_port *port,
> > +		struct ktermios *termios, struct ktermios *old)
> > +{
> 
> <snip>
> 
> > +static int request_and_remap(int i)
> > +{
> > +	if (!request_mem_region(extra_mem[i], 1, "serial"))
> > +		return -EBUSY;
> > +
> > +	lp8x4x_data[i].private_data = ioremap(extra_mem[i], 1);
> > +	if (lp8x4x_data[i].private_data)
> > +		return 0;
> > +
> > +	release_mem_region(extra_mem[i], 1);
> > +	return -ENODEV;

> Instead of registering a platform device for serial8250 here, you need
> to simply register a platform driver for something like lp8x4x_serial.
> The platform code will to registers the platform devices for it. You
> will use serial8250_register_8250_port() in your probe to register a
> new port. Use 8250_em.c and 8250_dw.c under drivers/tty/serial/8250/
> as an example.
> 
> You don't need to introduce plat_serial8250_port so you won't need
> the QUIRK_PORT stuff. You deliver the iomem and the irq as normal
> resources that the driver uses when you create the platform device.
> That of course also means the driver does not need to care about the
> instances. The platform code will generate a platform device for as
> many ports you have and set to resources accordingly.

8250_core.c doesn't use platform infrastructure to request and map IO
memory. There will be a conflict (and an error in
serial8250_request_std_resource()), if main IO memory is requested by
the platform device, won't it?
