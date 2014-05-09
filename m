From: broonie@kernel.org (Mark Brown)
Date: Fri, 9 May 2014 15:54:25 +0100
Subject: [PATCH] i2c: exynos5: Initialise Samsung High Speed I2C
 controller early
In-Reply-To: <CAHfPSqDSTyQXPT-NCZ2hE01qpdmaR54tbWCUYC_zSDGFp58+7g@mail.gmail.com>
References: <1398350916-885-1-git-send-email-ch.naveen@samsung.com>
 <20140424162558.GB12304@sirena.org.uk>
 <CAHfPSqB5+mLiC07jbEpeUgW63pZVk700SkYGxToO7GRAsFm_nQ@mail.gmail.com>
 <20140509135153.GM12304@sirena.org.uk>
 <CAHfPSqDSTyQXPT-NCZ2hE01qpdmaR54tbWCUYC_zSDGFp58+7g@mail.gmail.com>
Message-ID: <20140509145425.GP12304@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 09, 2014 at 08:12:47PM +0530, Naveen Krishna Ch wrote:
> On 9 May 2014 19:21, Mark Brown <broonie@kernel.org> wrote:
> > On Fri, May 09, 2014 at 05:50:00PM +0530, Naveen Krishna Ch wrote:

> >> DRM related drivers like DP, FIMD, HDMI, Mixer wants to be probed ASAP
> >> during the boot.
> >> The real problem comes when, one of these drivers do a regulator_get().

> >> If the physical supply  is not enabled/hookedup the regulator_get() call
> >> assumes that physical supply is present and returns a
> >> "dummy_regulator" (But, not an error).

> >> Because of which, Display and several other devices fails to work.

> > These drivers are buggy, if they geniunely expect and handle a missing
> > supply then they should be using regulator_get_optional() to request the
> > regulator and even if they don't the use of subsys_initcall() is not
> > going to fix anything here - if a dummy regulator is going to be
> > returned the time things are probed won't make a difference.

...

> If all the I2C, SPI, DMA, I2C_TUNNEL, DRM based LCD are all mod_probes()
> DRM drivers are probing a head of the PMIC probe. Which is causing the
> display drivers to get "dummy_regulators" instead of the real supplies.

No, it really won't - I have no idea what you are doing but it's not
mainline.  If you are getting dummy regulators then you don't have a
supply present at all and probe ordering isn't going to make a blind
bit of difference.

Please provide a specific technical description of the problem you are
seeing in mainline.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140509/79947d24/attachment-0001.sig>
