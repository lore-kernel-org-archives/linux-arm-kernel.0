From: broonie@kernel.org (Mark Brown)
Date: Tue, 4 Feb 2014 11:02:09 +0000
Subject: [PATCH v3 3/5] spi: sunxi: Add Allwinner A31 SPI controller driver
In-Reply-To: <20140204090926.GI25625@lukather>
References: <1391165752-1819-1-git-send-email-maxime.ripard@free-electrons.com>
 <1391165752-1819-4-git-send-email-maxime.ripard@free-electrons.com>
 <20140131124809.GE22609@sirena.org.uk>
 <20140131224704.GI2950@lukather>
 <20140204002110.GP22609@sirena.org.uk>
 <20140204090926.GI25625@lukather>
Message-ID: <20140204110209.GQ22609@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 04, 2014 at 10:09:26AM +0100, Maxime Ripard wrote:
> On Tue, Feb 04, 2014 at 12:21:10AM +0000, Mark Brown wrote:

> > It isn't awesome, no.  Ideally the runtime PM code would do this but
> > then you couldn't ifdef the operations which as far as I can tell is the
> > main thing people want from disabling it and it gets complicated for
> > devices that genuinely do power up on startup so here we are.

> We discussed it with Kevin on IRC, and he suggested that we move that
> pm_runtime initialization to the SPI core, but I guess that would also
> mean that all drivers shouldn't ifdef the operations, so that the core
> can call the runtime_resume callback directly.

No, that's not going to be robust - it means drivers can't do any power
sequencing of their own.

> However, I don't really get why any driver should be doing so, since
> you still need these functions to at least to the device
> suspend/resume in the probe/remove, and you don't really want to
> duplicate the code.

I don't think it's particularly useful to support disabling runtime PM
in the first place but some drivers do different things when doing
runtime management to those they do on first init - for example there
may be additional steps that only need to be done during first power up.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140204/9428cfc0/attachment.sig>
