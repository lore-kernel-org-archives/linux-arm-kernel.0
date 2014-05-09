From: broonie@kernel.org (Mark Brown)
Date: Fri, 9 May 2014 14:51:53 +0100
Subject: [PATCH] i2c: exynos5: Initialise Samsung High Speed I2C
 controller early
In-Reply-To: <CAHfPSqB5+mLiC07jbEpeUgW63pZVk700SkYGxToO7GRAsFm_nQ@mail.gmail.com>
References: <1398350916-885-1-git-send-email-ch.naveen@samsung.com>
 <20140424162558.GB12304@sirena.org.uk>
 <CAHfPSqB5+mLiC07jbEpeUgW63pZVk700SkYGxToO7GRAsFm_nQ@mail.gmail.com>
Message-ID: <20140509135153.GM12304@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 09, 2014 at 05:50:00PM +0530, Naveen Krishna Ch wrote:
> On 24 April 2014 21:55, Mark Brown <broonie@kernel.org> wrote:

> >> Such solution has been proposed by Mark Brown to fix the problem of
> >> the regulators not beeing available on the peripheral device probe():
> >> http://lists.infradead.org/pipermail/linux-arm-kernel/2010-March/011971.html

> > What specifically is this needed for?  We *should* be able to use
> > deferred probe for most things, but I know that not all subsystems are
> > able to yet.

> DRM related drivers like DP, FIMD, HDMI, Mixer wants to be probed ASAP
> during the boot.
> The real problem comes when, one of these drivers do a regulator_get().

> If the physical supply  is not enabled/hookedup the regulator_get() call
> assumes that physical supply is present and returns a
> "dummy_regulator" (But, not an error).

> Because of which, Display and several other devices fails to work.

These drivers are buggy, if they geniunely expect and handle a missing
supply then they should be using regulator_get_optional() to request the
regulator and even if they don't the use of subsys_initcall() is not
going to fix anything here - if a dummy regulator is going to be
returned the time things are probed won't make a difference.

> I2C, I2C_TUNNEL, SPI and DMA drivers are required as subsys_initcall()
> for similar reason.

What makes you say this?  Typically those drivers don't use regulators
at all.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140509/52180e66/attachment.sig>
