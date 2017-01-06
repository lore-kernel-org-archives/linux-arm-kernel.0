From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Fri, 6 Jan 2017 11:58:21 +0000
Subject: [PATCH net-next v4 0/4] Fix OdroidC2 Gigabit Tx link issue
In-Reply-To: <CAGm1_kvZ4dQrJ89qYU5wLGU1NR=j9xyWUm2mgYtq3F1+bo1OCg@mail.gmail.com>
References: <1480348229-25672-1-git-send-email-jbrunet@baylibre.com>
 <049b1efc-3bad-92e0-45ef-0563dc5d81de@gmail.com>
 <20170105232508.GU14217@n2100.armlinux.org.uk>
 <CAGm1_kvZ4dQrJ89qYU5wLGU1NR=j9xyWUm2mgYtq3F1+bo1OCg@mail.gmail.com>
Message-ID: <20170106115821.GY14217@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 06, 2017 at 06:42:24AM +0100, Yegor Yefremov wrote:
> On Fri, Jan 6, 2017 at 12:25 AM, Russell King - ARM Linux
> <linux@armlinux.org.uk> wrote:
> > Another concern with this patch is that the existing phylib "set_eee"
> > code is horribly buggy - it just translates the modes from userspace
> > into the register value and writes them directly to the register with
> > no validation.  So it's possible to set modes in the register that the
> > hardware doesn't support, and have them advertised to the link partner.
> >
> > I have a patch which fixes that, restricting (as we do elsewhere) the
> > advert according to the EEE supported capabilities retrieved from the
> > PCS - maybe the problem here is that the PCS doesn't support support
> > EEE in 1000baseT mode?
> >
> > Out of interest, which PHY is used on this platform?
> >
> > On the SolidRun boards, they're using AR8035, and have suffered this
> > occasional link drop problem.  What has been found is that it seems to
> > be to do with the timing parameters, and it seemed to only be 1000bT
> > that was affected.  I don't remember off hand exactly which or what
> > the change was they made to stabilise it though, but I can probabily
> > find out tomorrow.
> 
> I have different boards with am335x and AR8035 and we had occasional
> link drop with both 100 and 1000 speeds.

AR8035 has "Smart EEE", which is a PHY specific thing... it's not
entirely 802.3 compliant as it doesn't involve the MAC.

The Smart EEE control registers are in the PCS MMD - some of this
is from people's memories:

- 0x805b is the TX wakeup timer.  Lower 8 bits for 100base-Tx and
  upper 8 bits for 1000base-T.

- 0x805c and 0x805d.
  The LPI timer is 24 bit, with the lower 16 bits in 0x805c and the
  upper 8 in 0x805d.  0x805d bit 8 appears to be the Smart EEE enable bit.

What was found was setting the 1000base-T wakeup timer to the same as
the 100base-Tx avoided the problems we were seeing, which was only
with 1000base-T.  (Whether that's because 100base-Tx hasn't been as well
tested, I don't know.)  SR ended up with 0x1717 in 0x805b.

I'd suggest playing around with that register to see if extending the
wakeup time has any beneficial effect.

Also, I suspect Smart EEE shouldn't be enabled if you have an EEE
capable MAC (in which case 0x805d bit 8 should be clear.)  I think,
however, it defaults to enabled.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
