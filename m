From: broonie@kernel.org (Mark Brown)
Date: Tue, 19 May 2015 12:16:02 +0100
Subject: [alsa-devel] [PATCH 1/4] ASoC: rockchip: add rockchip machine
 driver
In-Reply-To: <555659DB.9010204@metafoo.de>
References: <1431422797-31903-1-git-send-email-zhengxing@rock-chips.com>
 <1431422797-31903-2-git-send-email-zhengxing@rock-chips.com>
 <20150512192215.GZ3066@sirena.org.uk>
 <55535035.5070608@rock-chips.com>
 <20150513164250.GB2761@sirena.org.uk>
 <CAEUnVG5+PqhkZ4TBMnfdbUr66-EaLVGDEewJ_=XZnfbvBEn13w@mail.gmail.com>
 <CAEUnVG5nkagx7CZC3t=-oOAyXOBaxxVynBxaGMf0NJpfr9ZVbA@mail.gmail.com>
 <555659DB.9010204@metafoo.de>
Message-ID: <20150519111602.GG2761@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 15, 2015 at 10:40:59PM +0200, Lars-Peter Clausen wrote:

> I think the proper way to support this is come up with the concept of jack
> detection providers and consumers. A component can register a jack detection
> provider just like it can register a DAI. And then in the board driver you'd
> just link the jack detection logic to the jack using the usual approach,
> which is also used for DAIs (e.g. of node or device name). The core would
> then take care of calling a enable callback or whatever is required to setup
> the jack detection logic in the driver.

Yes, nobody has really cared about it since we started pushing things
out of the card init into the device level.  We would also need to add a
way to force microphone biases on for devices where that's not a part of
the jack detection IP.

> This would also nicely solve the issue with the GPIO jack detectors, where
> we currently can't really handle -EPROBE_DEFER. The GPIO would be requested
> by a jack detection provider which can request them before the card is
> registered rather than having to do the requesting in the card's init
> callback.

Cards should be able to do their requesting in their probe function
prior to registering with the core even without anything else, though
that needs a bit or refactoring too.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150519/3c2c2463/attachment.sig>
