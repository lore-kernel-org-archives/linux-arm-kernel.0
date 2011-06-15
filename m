From: w.sang@pengutronix.de (Wolfram Sang)
Date: Wed, 15 Jun 2011 12:53:18 +0200
Subject: sdhci-esdhc-imx -- MMC 10x slower than it should be
In-Reply-To: <20110615094001.GA21137@pma.sysgo.com>
References: <20110615094001.GA21137@pma.sysgo.com>
Message-ID: <20110615105318.GB3097@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

> We are seeing issues with sdhci-esdhc-imx in 2.6.39; performance is
> not what it should be; it is about 10x lower in fact.

Which SoC? 25/35/51/53?

> ...any idea what this comment means? I'd like to eventualy support
> 8BITBUS...

8-Bit bus is not specified in the standard, so it cannot be detected.
Check other drivers where they use MMC_CAP_8_BIT_DATA.

> Part of the problem is that esdhc_writeb_le() does translation of bits
> into breescale format; but readb() does not do translation back, and
> core code uses read-modify-write on the register, for example when
> turning on the LED. What to do there? Translate back? Add shadow
> variable? Get rid of read-modify-write?

Probably the least ugly solution :/

> Any ideas why it is slow?

Your board polls for card-detect, Shawn recently sent a series which
lets you fix that for mx5.

ADMA is marked broken in mainline, cause it didn't work with a number of
cards. Richard sent a patch recently.

Both series could need some more testing :)

Regards,

   Wolfram

-- 
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 198 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20110615/36f9c9d0/attachment.sig>
