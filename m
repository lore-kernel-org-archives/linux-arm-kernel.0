From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 18 Sep 2015 15:55:38 +0200
Subject: [PATCH 0/5] ARM: sunxi: Introduce CHIP support
In-Reply-To: <13485899.XsimukeSAF@wuerfel>
References: <1442566130-3497-1-git-send-email-maxime.ripard@free-electrons.com>
 <2353279.QTDzFUHVnF@wuerfel> <20150918121905.GO4684@lukather>
 <13485899.XsimukeSAF@wuerfel>
Message-ID: <20150918135538.GS4684@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 18, 2015 at 03:18:57PM +0200, Arnd Bergmann wrote:
> On Friday 18 September 2015 14:19:05 Maxime Ripard wrote:
> > 
> > There's actually two issues that are pretty orthogonal:
> > 
> >   * the fact that the regulator to power the wifi chip needs to be
> >     enabled before it enumerates and the driver is probed. The MMC
> >     pwrseq stuff seems to fix that, even if it doesn't really fit in
> >     the usual DT model.
> 
> Ok. If there is anything missing in the pwrseq implementation or
> binding at the moment, you'll have to work with Ulf to get it to
> drive your hardware then.

Yep.

> >   * The fact that that regulator on this board is actually two
> >     regulators in parallel that needs to be controlled in parallel
> >     too. Here, it will probably require a new regulator driver to
> >     combine two regulators into one.
> 
> I don't yet understand what it means to control them in parallel.
> Do you mean the hardware uses two outputs to support a higher
> current than you could do with one?

Yes.

> How critical is the timing? Would it be enough if the mmc
> code knew how to set more than one regulator and do them
> one at a time?

I don't think it's critical as in both should happen exactly at the
same time (but I've not really tried it either, so I'm not 100% sure).

And I don't think it's something the MMC core should deal with. The
device itself has a single pin to provide its power, it's the board
that is wired that way. The way I was seeing it was more that I needed
to create a regulator driver that would take two inputs, that the mmc
core would use. Last time I discussed it with Mark (Brown), it semes
like he was open to the idea, so I just need to find some time to do
just that.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150918/cf968413/attachment-0001.sig>
