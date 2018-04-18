From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Wed, 18 Apr 2018 13:17:39 +0100
Subject: 4.16 OMAP serial transmit corruption?
In-Reply-To: <CAOf5uwkybbUTnwvdAz9gDGo00oTgTirwJDjwqsLFWEukh70aEQ@mail.gmail.com>
References: <20180416151732.GU16141@n2100.armlinux.org.uk>
 <20180416154545.GA5671@atomide.com>
 <413b774b-d19f-3221-44d5-7992d3b8757f@ti.com>
 <da3be56b-29d3-72f3-5eba-d6a38ae500d0@ti.com>
 <20180418095950.GN10990@n2100.armlinux.org.uk>
 <CAOf5uw=+MeWs+6A-zuy+yq2fZJmoe8hoLPcY1NVi9nvDMOLd7g@mail.gmail.com>
 <20180418110033.GO10990@n2100.armlinux.org.uk>
 <CAOf5uwkybbUTnwvdAz9gDGo00oTgTirwJDjwqsLFWEukh70aEQ@mail.gmail.com>
Message-ID: <20180418121739.GP10990@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 18, 2018 at 01:45:12PM +0200, Michael Nazzareno Trimarchi wrote:
> Hi
> 
> On Wed, Apr 18, 2018 at 1:00 PM, Russell King - ARM Linux
> <linux@armlinux.org.uk> wrote:
> > On Wed, Apr 18, 2018 at 12:27:02PM +0200, Michael Nazzareno Trimarchi wrote:
> >> Hi
> >>
> >> On Wed, Apr 18, 2018 at 11:59 AM, Russell King - ARM Linux
> >> <linux@armlinux.org.uk> wrote:
> >> > On Wed, Apr 18, 2018 at 02:41:43PM +0530, Vignesh R wrote:
> >> >>
> >> >>
> >> >> On Tuesday 17 April 2018 02:50 PM, Vignesh R wrote:
> >> >> >
> >> >> >
> >> >> > On Monday 16 April 2018 09:15 PM, Tony Lindgren wrote:
> >> >> >> * Russell King - ARM Linux <linux@armlinux.org.uk> [180416 15:19]:
> >> >> >>> Hi,
> >> >> >>>
> >> >> >>> I'm not entirely sure what's going on, but I see corrupted characters
> >> >> >>> with the serial console on the OMAP4430 SDP board.  During boot,
> >> >> >>> everything seems fine, the problem appears to be userspace output.
> >> >> >>>
> >> >> >>> For example, if I edit a file, then quit vi:
> >> >> >>>
> >> >> >>> :q??%??B??Z?root at omap-4430sdp:~#
> >> >> >>
> >> >> >> I don't think I've seen that one. What I've seen few times is
> >> >> >> typing a key on the serial console echoing back the previous
> >> >> >> character typed while the new character won't get displayed
> >> >> >> until hitting keyboard again. Only rebooting the device seems
> >> >> >> to solve this. This is with 4430 ES2.3 revision.
> >> >> >>
> >> >> >> I wonder if we're missing some parts of errata i202 handling
> >> >> >> in omap_8250_mdr1_errataset()?
> >> >> >>
> >> >>
> >> >> I wonder if the extra read of MDR1 register at the beginning of
> >> >> omap_8250_mdr1_errataset() compared to omap-serial is the issue.
> >> >> errata i202 says access to MDR1 can cause data corruption.
> >> >> Assuming both reads and writes can cause glitch then, that read
> >> >> is not following advisory:
> >> >>
> >> >> I don't have SDP board so, could you verify if below diff helps:
> >> >>
> >> >>
> >> >> diff --git a/drivers/tty/serial/8250/8250_omap.c b/drivers/tty/serial/8250/8250_omap.c
> >> >> index 6aaa84355fd1..8ab9d0a1b1eb 100644
> >> >> --- a/drivers/tty/serial/8250/8250_omap.c
> >> >> +++ b/drivers/tty/serial/8250/8250_omap.c
> >> >> @@ -163,11 +163,6 @@ static void omap_8250_mdr1_errataset(struct uart_8250_port *up,
> >> >>                                      struct omap8250_priv *priv)
> >> >>  {
> >> >>         u8 timeout = 255;
> >> >> -       u8 old_mdr1;
> >> >> -
> >> >> -       old_mdr1 = serial_in(up, UART_OMAP_MDR1);
> >> >> -       if (old_mdr1 == priv->mdr1)
> >> >> -               return;
> >> >>
> >> >>         serial_out(up, UART_OMAP_MDR1, priv->mdr1);
> >> >>         udelay(2);
> >> >
> >> > That doesn't appear to help.
> >> >
> >> > Looking at the bitstream and comparing what should have been sent with
> >> > what was sent, there appears to be some correlation between the two.
> >> > It looks like the FTDI is not properly synchronised to the bitstream
> >> > coming from the OMAP4430.
> >> >
> >> > Setting two stop bits on both ends (OMAP4430 and FTDI) appears to
> >> > improve the issue, but not completely solve it.
> >>
> >> Are you sure about clock error above some tollerance?
> >
> > No idea at the moment.  Looking at the bitstream with a scope is the
> > next step, but it's not easy to do that with just two hands.  I also
> > need to find some way to trigger it reliably.
> >
> > Another cause could be that the UART pin is being held high/low for
> > some reason (maybe a pinmux problem.)
> >
> > Another interesting observation is that if I login over the network and
> > then do:
> >
> >         while :; do :; done &
> >         while :; do :; done &
> >
> 
> You can disable it. Anyway when uart from Ti go in idle mode that can loose
> the first char on receiving

That may be, but what happens on the OMAP receive side is not relevant.
This issue is about the OMAP4430 transmit side.

> > to occupy both CPUs, and then do:
> >
> >         dmesg | less
> >
> > on the console, the problem goes away.  If I only do one while loop,
> > the problem is present, but the corruption looks like it happens at a
> > different point in the serial stream.
> >
> > This would seem to point the blame away from clocks or pinmux, and back
> > to power management issues.
> >
> 
> Do you have statistics from the uart under proc?

You mean on the OMAP4430?

# cat /proc/tty/driver/OMAP-SERIAL
serinfo:1.0 driver revision:
0: uart:OMAP UART0 mmio:0x4806A000 irq:32 tx:0 rx:0
1: uart:OMAP UART1 mmio:0x4806C000 irq:33 tx:0 rx:0
2: uart:OMAP UART2 mmio:0x48020000 irq:34 tx:638807 rx:5406 RTS|CTS|DTR
3: uart:OMAP UART3 mmio:0x4806E000 irq:35 tx:0 rx:0

Of course, there won't be anything of interest there because I'm
talking about the *transmit* side on the OMAP4430 and there's no
way to detect or monitor errors in the transmit side.

The ftdi-sio driver on the host machine, which would be involved in
the receive, doesn't keep statistics and make them available through
/proc.  (Another reason why I hate usb-serial based development
boards.)

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 8.8Mbps down 630kbps up
According to speedtest.net: 8.21Mbps down 510kbps up
