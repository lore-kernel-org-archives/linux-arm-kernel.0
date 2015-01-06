From: broonie@kernel.org (Mark Brown)
Date: Tue, 6 Jan 2015 18:06:19 +0000
Subject: [PATCH v2 06/16] ASoC: samsung: i2s: Move clk enable to the
 platform driver probe()
In-Reply-To: <1418997336-17777-7-git-send-email-s.nawrocki@samsung.com>
References: <1418997336-17777-1-git-send-email-s.nawrocki@samsung.com>
 <1418997336-17777-7-git-send-email-s.nawrocki@samsung.com>
Message-ID: <20150106180619.GN2634@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 19, 2014 at 02:55:26PM +0100, Sylwester Nawrocki wrote:
> Gating the I2S bus clock in the driver's runtime PM callbacks has
> currently really no effect since the clock is being enabled
> in the DAI's probe() and thus is permanently turned on. Now we just
> move the enable to the platform driver's probe(), which doesn't
> change the situation much. It will allow us to register a clock
> provider already in samsung_i2s_probe() function.

That doesn't sound quite right - the normal idiom for this stuff is to
enable on probe, mark the device as active then if runtime PM is enabled
it can idle the device and turn off the clock.  That way if runtime PM
is disabled things continue to run.  I've not checked to see if this is
actually happening correctly all the way through but that's what's
supposed to happen and means that enabling in the probe should still
result in working clock management.

It will as things currently stand be broken for the dual DAI case so
this is a fix for that (the dual DAI case will double enable if both
links are in use) but the analysis isn't quite correct.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150106/2ff93937/attachment.sig>
