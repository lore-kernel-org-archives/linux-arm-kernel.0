From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Sat, 25 Feb 2012 13:27:06 +0000
Subject: [PATCH 6/6] ASoC: fsl: check property 'compatible' for the
 machine name
In-Reply-To: <20120225130943.GB25201@S2101-09.ap.freescale.net>
References: <1329979644-31046-1-git-send-email-shawn.guo@linaro.org>
 <1330092582-21180-1-git-send-email-shawn.guo@linaro.org>
 <1330092582-21180-7-git-send-email-shawn.guo@linaro.org>
 <20120224141207.GI5450@opensource.wolfsonmicro.com>
 <20120225012845.GF24268@S2101-09.ap.freescale.net>
 <20120225114227.GB3167@opensource.wolfsonmicro.com>
 <20120225130943.GB25201@S2101-09.ap.freescale.net>
Message-ID: <20120225132705.GA3412@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Feb 25, 2012 at 09:09:53PM +0800, Shawn Guo wrote:

> DT aware IMX platforms.  From his POV, one big reason of why imx-ssi
> was created is that ARM/IMX did not support DT before while fsl_ssi was
> born to support DT only.  Since ARM/IMX starts supporting DT, fsl_ssi
> should be reused there.

No, that's not really a major reason - the big issue was more the lack
of any support from Freescale for the i.MX in mainline at that time and
the lack of any information on the similarities or differences between
the IP implementations in the two processor families, there's quite a
few quirks in the SSI register interface and it wasn't clear what was
shared and what wasn't.  It was more important to get things working in
mainline, the hope was that someone would come along later and merge if
that was possible (which you're now doing!).

> I'm personally fine with either reusing fsl_ssi or adding DT support
> into imx-ssi.  I do not see any problem with reusing fsl_ssi so far,
> but I can quickly turn around to adding new binding for imx-ssi if
> you are strong on this position.

Nobody's suggesting that they don't get merged if they really are the
same IP and can use the same code.  The device tree bindings are (and
should be) a really small proportion of the code.

> > Note that it's purely the bit where the machine driver is instantiated
> > from the SSI (which is just one or two of several properties) that I'm
> > talking about here, the bindings for the SSI itself look good.

> Hmm, there is no SSI binding property contributing to instantiating
> the machine driver.  It looks /model property for the device name used
> to instantiate the machine driver, which I personally think is fine.

The CODEC binding for the machine driver is part of the SSI binding, and
a mandatory one at that.  It looks like the code should be refactored to
register the SSI unconditionally and then optionally also register a
machine driver if there's a CODEC property present.  That way existing
systems should continue to work fine with their current bindings and new
ones can use the modern binding style.

Just using the plain machine name can get a bit inconvenient when you
get reference designs cloned which share the audio but differ in other
ways - the nVidia WM8903 driver is a good example of this, there's a
large number of boards that are definitely distinct boards but are very
similar from an audio point of view.  You'd have to add all the
machines to the machine driver compatible list.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120225/73011a5c/attachment.sig>
