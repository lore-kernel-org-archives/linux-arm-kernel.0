From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Wed, 18 Apr 2018 13:47:25 +0100
Subject: 4.16 OMAP serial transmit corruption?
In-Reply-To: <20180418110033.GO10990@n2100.armlinux.org.uk>
References: <20180416151732.GU16141@n2100.armlinux.org.uk>
 <20180416154545.GA5671@atomide.com>
 <413b774b-d19f-3221-44d5-7992d3b8757f@ti.com>
 <da3be56b-29d3-72f3-5eba-d6a38ae500d0@ti.com>
 <20180418095950.GN10990@n2100.armlinux.org.uk>
 <CAOf5uw=+MeWs+6A-zuy+yq2fZJmoe8hoLPcY1NVi9nvDMOLd7g@mail.gmail.com>
 <20180418110033.GO10990@n2100.armlinux.org.uk>
Message-ID: <20180418124725.GQ10990@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 18, 2018 at 12:00:33PM +0100, Russell King - ARM Linux wrote:
> On Wed, Apr 18, 2018 at 12:27:02PM +0200, Michael Nazzareno Trimarchi wrote:
> > Hi
> > 
> > On Wed, Apr 18, 2018 at 11:59 AM, Russell King - ARM Linux
> > <linux@armlinux.org.uk> wrote:
> > > On Wed, Apr 18, 2018 at 02:41:43PM +0530, Vignesh R wrote:
> > >>
> > >>
> > >> On Tuesday 17 April 2018 02:50 PM, Vignesh R wrote:
> > >> >
> > >> >
> > >> > On Monday 16 April 2018 09:15 PM, Tony Lindgren wrote:
> > >> >> * Russell King - ARM Linux <linux@armlinux.org.uk> [180416 15:19]:
> > >> >>> Hi,
> > >> >>>
> > >> >>> I'm not entirely sure what's going on, but I see corrupted characters
> > >> >>> with the serial console on the OMAP4430 SDP board.  During boot,
> > >> >>> everything seems fine, the problem appears to be userspace output.
> > >> >>>
> > >> >>> For example, if I edit a file, then quit vi:
> > >> >>>
> > >> >>> :q??%??B??Z?root at omap-4430sdp:~#
> > >> >>
> > >> >> I don't think I've seen that one. What I've seen few times is
> > >> >> typing a key on the serial console echoing back the previous
> > >> >> character typed while the new character won't get displayed
> > >> >> until hitting keyboard again. Only rebooting the device seems
> > >> >> to solve this. This is with 4430 ES2.3 revision.
> > >> >>
> > >> >> I wonder if we're missing some parts of errata i202 handling
> > >> >> in omap_8250_mdr1_errataset()?
> > >> >>
> > >>
> > >> I wonder if the extra read of MDR1 register at the beginning of
> > >> omap_8250_mdr1_errataset() compared to omap-serial is the issue.
> > >> errata i202 says access to MDR1 can cause data corruption.
> > >> Assuming both reads and writes can cause glitch then, that read
> > >> is not following advisory:
> > >>
> > >> I don't have SDP board so, could you verify if below diff helps:
> > >>
> > >>
> > >> diff --git a/drivers/tty/serial/8250/8250_omap.c b/drivers/tty/serial/8250/8250_omap.c
> > >> index 6aaa84355fd1..8ab9d0a1b1eb 100644
> > >> --- a/drivers/tty/serial/8250/8250_omap.c
> > >> +++ b/drivers/tty/serial/8250/8250_omap.c
> > >> @@ -163,11 +163,6 @@ static void omap_8250_mdr1_errataset(struct uart_8250_port *up,
> > >>                                      struct omap8250_priv *priv)
> > >>  {
> > >>         u8 timeout = 255;
> > >> -       u8 old_mdr1;
> > >> -
> > >> -       old_mdr1 = serial_in(up, UART_OMAP_MDR1);
> > >> -       if (old_mdr1 == priv->mdr1)
> > >> -               return;
> > >>
> > >>         serial_out(up, UART_OMAP_MDR1, priv->mdr1);
> > >>         udelay(2);
> > >
> > > That doesn't appear to help.
> > >
> > > Looking at the bitstream and comparing what should have been sent with
> > > what was sent, there appears to be some correlation between the two.
> > > It looks like the FTDI is not properly synchronised to the bitstream
> > > coming from the OMAP4430.
> > >
> > > Setting two stop bits on both ends (OMAP4430 and FTDI) appears to
> > > improve the issue, but not completely solve it.
> > 
> > Are you sure about clock error above some tollerance?
> 
> No idea at the moment.  Looking at the bitstream with a scope is the
> next step, but it's not easy to do that with just two hands.  I also
> need to find some way to trigger it reliably.
> 
> Another cause could be that the UART pin is being held high/low for
> some reason (maybe a pinmux problem.)
> 
> Another interesting observation is that if I login over the network and
> then do:
> 
> 	while :; do :; done &
> 	while :; do :; done &
> 
> to occupy both CPUs, and then do:
> 
> 	dmesg | less
> 
> on the console, the problem goes away.  If I only do one while loop,
> the problem is present, but the corruption looks like it happens at a
> different point in the serial stream.
> 
> This would seem to point the blame away from clocks or pinmux, and back
> to power management issues.
> 
> I've also tried mimicking the less output with a stand-alone program,
> and that doesn't exhibit the problem - I've tried with various initial
> delays between program start and first output, but this doesn't seem
> to have much effect.  So it seems to need rather precise timing.
> 
> stracing less does change where the corruption happens in the output,
> which also suggests a timing related cause.

Okay, I think I'm getting somewhere...  `less' does an ioctl(, TCSETS, )
after outputting a screenful in order to change c_iflag and c_lflag.
The differences are:

	c_iflag 0x1500 -> 0x1000
	c_lflag 0x083b -> 0x0831

Other settings are kept the same.

The iflag changes are IXON | ICRNL, and the lflag changes are
ECHO | ICANON.  Reproducing those changes in my test program shows
the same corruption.

Removing the lflag changes makes no difference.  Removing the ICRNL
also makes no difference - the problem is still there.  Removing
the IXON change and the problem vanishes.

Given that the serial driver rewrites the entire UART configuration
on a termios change that affects any hardware settings, this is
rather expected to happen.

So, the question becomes whether userspace is acting correctly - and
I'd say no.  Looking at _real_ `less' (iow, not the busybox version
that I seem to have on the OMAP4430) it doesn't do this fiddling with
termios settings just before waiting for input.  Moreover, I can't see
_any_ reason for `less' of any kind to be fiddling with IXON.

There is the remaining question about the proper behaviour of setting
termios modes while there is a transmit operation in progress - I know
of several programs that do this.  A TCSETS operation is defined to
occur "immediately" by the spec, but is it reasonable to change the
modes mid-transmission of a character (which _will_ corrupt the
character), or should they be changed at a character boundary (or at
whatever character boundary the hardware is capable of.)

I note that if DMA is enabled, 8250_omap delays a TCSETS operation
until DMA has completed, so I suspect that the problem I'm seeing
will go away if I enable DMA.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 8.8Mbps down 630kbps up
According to speedtest.net: 8.21Mbps down 510kbps up
