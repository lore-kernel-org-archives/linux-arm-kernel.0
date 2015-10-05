From: broonie@kernel.org (Mark Brown)
Date: Mon, 5 Oct 2015 15:21:11 +0100
Subject: [PATCH] ASoC: sun4i-codec: Rework and fix headphone routing
In-Reply-To: <20151005102550.GI2696@lukather>
References: <1443965896-6205-1-git-send-email-maxime.ripard@free-electrons.com>
 <20151005094435.GI12635@sirena.org.uk>
 <20151005102550.GI2696@lukather>
Message-ID: <20151005142111.GR12635@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 05, 2015 at 12:25:50PM +0200, Maxime Ripard wrote:
> On Mon, Oct 05, 2015 at 10:44:35AM +0100, Mark Brown wrote:
> > On Sun, Oct 04, 2015 at 03:38:16PM +0200, Maxime Ripard wrote:

> > > Most of the boards have their headphone jack directly connected to the
> > > matching pins of the SoCs. Since most of the time we will have the same
> > > routing path, it makes sense to put that in the driver, and only have a
> > > property describing whether that route is enabled or not.

> > What is the value in having just a dumb jack with no detection
> > configured?  It doesn't actually do anything...

> Well, it's how it's wired on most boards. The jack is directly
> connected to the SoC, without any detection mechanism, not even a
> GPIO, so we can only assume it's always there if we want it to work
> properly.

Sure, but what is the point of representing this in the driver?

> > > It also fixes the following warning messages that were seen so far:
> > > sun4i-codec 1c22c00.codec: ASoC: no sink widget found for Headphone Jack
> > > sun4i-codec 1c22c00.codec: ASoC: Failed to add route HP Left -> direct -> Headphone Jack
> > > sun4i-codec 1c22c00.codec: ASoC: no sink widget found for Headphone Jack
> > > sun4i-codec 1c22c00.codec: ASoC: Failed to add route HP Right -> direct -> Headphone Jack

> > Why are these routes being added separately to adding the jack?  Just
> > remove the broken routes.

> I'm not sure I understand here. The former DT bindings example was
> adding this route, which was broken because of the missing output
> widget for the headphone jack.

If those warnings are being seen whatever added the routes is buggy
as-is.

> My patch here adds both if the DT says that the headphone jack is
> actually used on that board, so it should fix both issues: no broken
> route, and no missing widgets. right?

It's not really a scalable binding - it's a boolean for this one
configuration, even adding a GPIO for detection isn't going to fit in
terribly neatly.  I'm trying to figure out if we even need a binding
here.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151005/bd3c255e/attachment.sig>
