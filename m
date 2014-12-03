From: broonie@kernel.org (Mark Brown)
Date: Wed, 3 Dec 2014 20:03:07 +0000
Subject: [PATCH v2 2/2] ASoC: rockchip: i2s: add support for grabbing
 output clock to codec
In-Reply-To: <CAPz6YkXRmRzYpW7xuDsq69A9H-Qm2-j6t-a+B1w9+OLOPf_YnA@mail.gmail.com>
References: <1417531766-29669-1-git-send-email-jay.xu@rock-chips.com>
 <1417591118-18695-1-git-send-email-jay.xu@rock-chips.com>
 <1417591118-18695-3-git-send-email-jay.xu@rock-chips.com>
 <20141203192024.GL7712@sirena.org.uk>
 <CAPz6YkXRmRzYpW7xuDsq69A9H-Qm2-j6t-a+B1w9+OLOPf_YnA@mail.gmail.com>
Message-ID: <20141203200307.GM7712@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 03, 2014 at 11:38:13AM -0800, Sonny Rao wrote:
> On Wed, Dec 3, 2014 at 11:20 AM, Mark Brown <broonie@kernel.org> wrote:

> > I would expect that the clock for the CODEC should be managed by the
> > CODEC if at all possible - that seems more logical than having the CPU
> > I2S controller request and manage it if it's a separate clock.  Why add
> > this to the CPU side driver?

> This output clock has a mux and can either be a fixed 12Mhz output or
> can be derived from the same fractional divider which drives the i2s
> block.   I thought it was simpler to keep them all the same, but need
> to put ownership in the i2s in anticipation of the i2s driver setting
> it's own clock rate.

> If you think this is an implementation detail and this output clock
> should just be owned by the codec driver, even though I'm guessing it
> will just have to be the same as i2s, then I think we can drop this
> and make sure simple card (or whatever other codec driver) claims this
> clock.

simple-card obviously isn't a CODEC driver...  For generality I think
the clock does need to be exposed to the CODEC driver, otherwise this
will work differently to how other systems are working and we can't
substitute in a different clock on the CODEC side so easily if it
doesn't happen to use the output from the I2S block.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141203/0669b4e6/attachment.sig>
