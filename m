From: broonie@kernel.org (Mark Brown)
Date: Thu, 2 Oct 2014 18:54:09 +0100
Subject: [PATCH] ASoC: samsung: fix CDCLK handling
In-Reply-To: <542D7A6B.7010000@samsung.com>
References: <1412095211-4012-1-git-send-email-drake@endlessm.com>
 <542D7A6B.7010000@samsung.com>
Message-ID: <20141002175409.GX4273@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 02, 2014 at 06:16:43PM +0200, Sylwester Nawrocki wrote:
> [dropping unrelated addresses from Cc]

You've dropped Liam who's the other ASoC maintainer.

> Sorry for getting back late to this. Indeed we have a mess here.
> I mostly tested interaction between two CPU DAIs - the main and the
> overlay one (which is not supported in mainline yet).

The dual DAIs were supported in mainline when the code was merged...

> > Simplify the situation and solve the bug with the following approach:
> >  - as before, samsung_i2s_dai_probe() gates CDCLK by default
> >    (no need for smartq_wm8987 to do this as well)
> >  - platform drivers can gate/ungate CDCLK as necessary
> >    (currently only odroidx2 needs to do this)
> >  - i2s code has no other interaction with CDCLK

> I'm not an ASoC expert, but I'd say it would be better to modify
> the I2S module so there is no additional callbacks needed in
> the machine driver. This way all machine drivers using the CDCLK
> output could be simplified, not mentioning using simple-card.
> I'm not sure how to do it yet, I'm going to take a look at this
> over the weekend.

Yes, keeping this in the SoC side drivers seems all round better.
Perhaps the I2S driver should be exposing CDCLK as a clock via the clock
API?  Dunno if that'd help or not.  Or refcount.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141002/41636040/attachment.sig>
