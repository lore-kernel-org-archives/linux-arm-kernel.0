From: broonie@kernel.org (Mark Brown)
Date: Wed, 14 Dec 2016 17:40:53 +0000
Subject: [PATCH v2 2/2] mfd: axp20x: Fix AXP806 access errors on cold boot
In-Reply-To: <CAGb2v66vggNNfFrAiNKKGXY0ayiG1qh5tcRok2NLTRkVHWKFeg@mail.gmail.com>
References: <20161123031616.10114-1-wens@csie.org>
 <20161123031616.10114-3-wens@csie.org>
 <20161209112018.GL3625@dell.home>
 <20161213164742.4ztisstxifatlm5a@sirena.org.uk>
 <CAGb2v66vggNNfFrAiNKKGXY0ayiG1qh5tcRok2NLTRkVHWKFeg@mail.gmail.com>
Message-ID: <20161214174053.qsm6umlgtdivevwt@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 14, 2016 at 09:52:31PM +0800, Chen-Yu Tsai wrote:

> What this patch does is make sure the registers match, to guarantee
> access, and then reinitialize the regmap cache to get rid of any
> stale data.

So what you're saying is that previous writes may have been ignored?

> > If the chip has been reset then you'd want to reset the cache too.  I've
> > no idea if that's needed here or not though, it depends what happens to
> > the global state of the chip when this reconfiguration happens.

> It is not a reset in the general sense. I suppose a better way would
> be to do an explicit write to the register first, then initialize
> the regmap. I'd have to export the write function from the RSB bus
> driver first though.

Surely just doing a write immediately after initializing the regmap
would have the same effect?  That'd ensure that the hardware has the
desired value before there are any other writes.  But I might be missing
something here.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161214/082576db/attachment.sig>
