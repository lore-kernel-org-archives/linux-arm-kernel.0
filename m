From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Sun, 22 Apr 2018 20:58:04 +0100
Subject: [PATCH] serial: mvebu-uart: Fix local flags handling on termios
 update
In-Reply-To: <20180422180728.42d7b354@why.wild-wind.fr.eu.org>
References: <20180422123346.15538-1-marc.zyngier@arm.com>
 <20180422155515.GC16141@n2100.armlinux.org.uk>
 <20180422180728.42d7b354@why.wild-wind.fr.eu.org>
Message-ID: <20180422195803.GD16141@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Apr 22, 2018 at 06:07:28PM +0100, Marc Zyngier wrote:
> On Sun, 22 Apr 2018 16:55:16 +0100
> Russell King - ARM Linux <linux@armlinux.org.uk> wrote:
> 
> > On Sun, Apr 22, 2018 at 01:33:46PM +0100, Marc Zyngier wrote:
> > > Commit 68a0db1d7da2 reworked the baud rate selection, but also added
> > > a (not so) subtle change in the way the local flags (c_lflag in the
> > > termios structure) are handled, forcing the new flags to always be the
> > > same as the old ones.
> > > 
> > > The reason for that particular change is both obscure and undocumented.
> > > It also completely breaks userspace. Something as trivial as getty is
> > > unusable:
> > > 
> > > <example>
> > > 	Debian GNU/Linux 9 sy-borg ttyMV0
> > > 
> > > 	sy-borg login: root
> > > 	root
> > > 	[timeout]
> > > 
> > > 	Debian GNU/Linux 9 sy-borg ttyMV0
> > > </example>
> > > 
> > > which is quite obvious in retrospect: getty cannot get in control of
> > > the echo mode, is stuck in canonical mode, and times out without ever
> > > seeing anything valid. It also begs the question of how this change was
> > > ever tested.
> > > 
> > > The fix is pretty obvious: stop messing with c_lflag, and the world
> > > will be a happier place.  
> > 
> > The c_iflag code also looks suspicious as well.  Apparently, the driver
> > only supports INPCK and IGNPAR, but things such as ISTRIP, INLCR, IGNCR,
> > ICRNL, IUCLC, IMAXBEL and IUTF8 are all software things done by the TTY
> > layer and have nothing to do with the driver.
> 
> Indeed. I stuck with the most glaring issue (well, the one that
> prevented me from using this particular box), but the whole termios
> massaging is quite odd. Someone with a good understanding of the
> intricacies of the TTY layer should definitely have a look at this.

Right, remember, I'm the author of the serial core layer (I took over
from tytso back in the 2.x era.)

POSIX requirements are:

  The tcsetattr() function shall return successfully if it
  was able to perform any of the requested actions, even if
  some of the requested actions could not be performed. It
  shall set all the attributes that the implementation
  supports as requested and leave all the attributes not
  supported by the implementation unchanged.

In other words, if the system does not support two stop bits, asking
for CSTOPB to be set results in CSTOPB being ignored but all other
supported modes being updated.  This is what the code in that commit
is trying to implement, but it forgets that the TTY layer implements
a whole load of termios modes that are not specific to the serial
driver.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 8.8Mbps down 630kbps up
According to speedtest.net: 8.21Mbps down 510kbps up
