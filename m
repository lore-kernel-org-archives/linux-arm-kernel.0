From: marc.zyngier@arm.com (Marc Zyngier)
Date: Sun, 22 Apr 2018 18:07:28 +0100
Subject: [PATCH] serial: mvebu-uart: Fix local flags handling on termios
 update
In-Reply-To: <20180422155515.GC16141@n2100.armlinux.org.uk>
References: <20180422123346.15538-1-marc.zyngier@arm.com>
 <20180422155515.GC16141@n2100.armlinux.org.uk>
Message-ID: <20180422180728.42d7b354@why.wild-wind.fr.eu.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, 22 Apr 2018 16:55:16 +0100
Russell King - ARM Linux <linux@armlinux.org.uk> wrote:

> On Sun, Apr 22, 2018 at 01:33:46PM +0100, Marc Zyngier wrote:
> > Commit 68a0db1d7da2 reworked the baud rate selection, but also added
> > a (not so) subtle change in the way the local flags (c_lflag in the
> > termios structure) are handled, forcing the new flags to always be the
> > same as the old ones.
> > 
> > The reason for that particular change is both obscure and undocumented.
> > It also completely breaks userspace. Something as trivial as getty is
> > unusable:
> > 
> > <example>
> > 	Debian GNU/Linux 9 sy-borg ttyMV0
> > 
> > 	sy-borg login: root
> > 	root
> > 	[timeout]
> > 
> > 	Debian GNU/Linux 9 sy-borg ttyMV0
> > </example>
> > 
> > which is quite obvious in retrospect: getty cannot get in control of
> > the echo mode, is stuck in canonical mode, and times out without ever
> > seeing anything valid. It also begs the question of how this change was
> > ever tested.
> > 
> > The fix is pretty obvious: stop messing with c_lflag, and the world
> > will be a happier place.  
> 
> The c_iflag code also looks suspicious as well.  Apparently, the driver
> only supports INPCK and IGNPAR, but things such as ISTRIP, INLCR, IGNCR,
> ICRNL, IUCLC, IMAXBEL and IUTF8 are all software things done by the TTY
> layer and have nothing to do with the driver.

Indeed. I stuck with the most glaring issue (well, the one that
prevented me from using this particular box), but the whole termios
massaging is quite odd. Someone with a good understanding of the
intricacies of the TTY layer should definitely have a look at this.

	M.
-- 
Without deviation from the norm, progress is not possible.
