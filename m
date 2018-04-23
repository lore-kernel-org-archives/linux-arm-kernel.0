From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Mon, 23 Apr 2018 18:39:04 +0100
Subject: [PATCH] serial: mvebu-uart: Fix local flags handling on termios
 update
In-Reply-To: <20180423150406.GE16141@n2100.armlinux.org.uk>
References: <20180422123346.15538-1-marc.zyngier@arm.com>
 <20180422155515.GC16141@n2100.armlinux.org.uk>
 <20180422180728.42d7b354@why.wild-wind.fr.eu.org>
 <20180422195803.GD16141@n2100.armlinux.org.uk>
 <20180423150406.GE16141@n2100.armlinux.org.uk>
Message-ID: <20180423173904.GG16141@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 23, 2018 at 04:04:06PM +0100, Russell King - ARM Linux wrote:
> On Sun, Apr 22, 2018 at 08:58:04PM +0100, Russell King - ARM Linux wrote:
> > On Sun, Apr 22, 2018 at 06:07:28PM +0100, Marc Zyngier wrote:
> > > On Sun, 22 Apr 2018 16:55:16 +0100
> > > Russell King - ARM Linux <linux@armlinux.org.uk> wrote:
> > > 
> > > > On Sun, Apr 22, 2018 at 01:33:46PM +0100, Marc Zyngier wrote:
> > > > > Commit 68a0db1d7da2 reworked the baud rate selection, but also added
> > > > > a (not so) subtle change in the way the local flags (c_lflag in the
> > > > > termios structure) are handled, forcing the new flags to always be the
> > > > > same as the old ones.
> > > > > 
> > > > > The reason for that particular change is both obscure and undocumented.
> > > > > It also completely breaks userspace. Something as trivial as getty is
> > > > > unusable:
> > > > > 
> > > > > <example>
> > > > > 	Debian GNU/Linux 9 sy-borg ttyMV0
> > > > > 
> > > > > 	sy-borg login: root
> > > > > 	root
> > > > > 	[timeout]
> > > > > 
> > > > > 	Debian GNU/Linux 9 sy-borg ttyMV0
> > > > > </example>
> > > > > 
> > > > > which is quite obvious in retrospect: getty cannot get in control of
> > > > > the echo mode, is stuck in canonical mode, and times out without ever
> > > > > seeing anything valid. It also begs the question of how this change was
> > > > > ever tested.
> > > > > 
> > > > > The fix is pretty obvious: stop messing with c_lflag, and the world
> > > > > will be a happier place.  
> > > > 
> > > > The c_iflag code also looks suspicious as well.  Apparently, the driver
> > > > only supports INPCK and IGNPAR, but things such as ISTRIP, INLCR, IGNCR,
> > > > ICRNL, IUCLC, IMAXBEL and IUTF8 are all software things done by the TTY
> > > > layer and have nothing to do with the driver.
> > > 
> > > Indeed. I stuck with the most glaring issue (well, the one that
> > > prevented me from using this particular box), but the whole termios
> > > massaging is quite odd. Someone with a good understanding of the
> > > intricacies of the TTY layer should definitely have a look at this.
> > 
> > Right, remember, I'm the author of the serial core layer (I took over
> > from tytso back in the 2.x era.)
> > 
> > POSIX requirements are:
> > 
> >   The tcsetattr() function shall return successfully if it
> >   was able to perform any of the requested actions, even if
> >   some of the requested actions could not be performed. It
> >   shall set all the attributes that the implementation
> >   supports as requested and leave all the attributes not
> >   supported by the implementation unchanged.
> > 
> > In other words, if the system does not support two stop bits, asking
> > for CSTOPB to be set results in CSTOPB being ignored but all other
> > supported modes being updated.  This is what the code in that commit
> > is trying to implement, but it forgets that the TTY layer implements
> > a whole load of termios modes that are not specific to the serial
> > driver.
> 
> I've just been talking to Jon Nettleton about this, and it seems that
> he reported the exact same bug that you've found to Marvell a while
> back, yet it seems that the bug was still propagated into mainline.

Erm...

I wonder if anyone has _really_ looked at the commit?

+       baud = uart_get_baud_rate(port, termios, old, 0, 230400);
+       if (mvebu_uart_baud_rate_set(port, baud)) {
+               /* No clock available, baudrate cannot be changed */
+               if (old)
+                       baud = uart_get_baud_rate(port, old, NULL, 0, 230400);
+       } else {
+               tty_termios_encode_baud_rate(termios, baud, baud);
+               uart_update_timeout(port, termios->c_cflag, baud);
+       }

What is the effect if mvebu_uart_baud_rate_set() returns non-zero?  We
get the baud rate for the _old_ termios correctly, but then what do we
do with it?  "baud" is not used by this function after this point, so
what's the point of making that second call to uart_get_baud_rate()?

uart_get_baud_rate() already contains the logic to select the supported
baud rate from the new or old termios depending on the supplied
capabilities.

If there is no UART clock provided, then the above quite simply becomes
a complete no-op.

The whole thing can be simplified to:

	if (!IS_ERR(mvuart->clk)) {
		baud = uart_get_baud_rate(port, termios, old, 0, 230400);
		mvebu_uart_baud_rate_set(port, baud);
		tty_termios_encode_baud_rate(termios, baud, baud);
		uart_update_timeout(port, termios->c_cflag, baud);
	}

and the conditional in mvebu_uart_baud_rate_set() removed.

However, I suspect that the real intention of the code is actually
this:

	if (!IS_ERR(mvuart->clk)) {
		baud = uart_get_baud_rate(port, termios, old, 0, 230400);
		mvebu_uart_baud_rate_set(port, baud);
	} else {
		baud = uart_get_baud_rate(port, old, NULL, 0, 230400);
	}

	tty_termios_encode_baud_rate(termios, baud, baud);
	uart_update_timeout(port, termios->c_cflag, baud);

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 8.8Mbps down 630kbps up
According to speedtest.net: 8.21Mbps down 510kbps up
