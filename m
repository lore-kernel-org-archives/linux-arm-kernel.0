From: broonie@kernel.org (Mark Brown)
Date: Wed, 13 May 2015 12:09:15 +0100
Subject: [PATCH] RFC: mmc: core: Increase delay for voltage to stabilize
 from 3.3V to 1.8V
In-Reply-To: <1431467171-12937-1-git-send-email-dianders@chromium.org>
References: <1431467171-12937-1-git-send-email-dianders@chromium.org>
Message-ID: <20150513110915.GG3066@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 12, 2015 at 02:46:11PM -0700, Doug Anderson wrote:
> Since the regulator used for the SDMMC IO voltage is not expected to
> draw a lot of current, most systems will probably use an inexpensive
> LDO for it.  LDO regulators apparently have the feature that they
> don't actively drive the voltage down--they wait for other components
> in the system to drag the voltage down.  Thus they will transition
> faster under heavy loads and slower under light loads.

What a LDO is doing is basically just charging up a capacitor - the
regulation consists of monitoring the voltage on the capacitor and
opening a transistor to charge the capacitor when the voltage droops too
much.

> From experimental evidence, we've seen the voltage change fail if the
> card doesn't detect that the voltage fell to less than about 2.3V when
> we turn on the clock.  On one device (that admittedly had a 47K CMD
> pullup instead of a 10K CMD pullup) we saw that the voltage was just
> about 2.3V after 5ms and thus the voltage change would sometimes fail.
> Doubling the delay gave margin and made the voltage change work 100%
> of the time, despite the slightly weaker CMD pull.

> At the moment submitting this as an RFC patch since my problem _could_
> be fixed by increasing the pull strength (or using a smaller
> capacitor).  However being a little bit more lenient to strange
> hardware could also be a good thing.

Right, and this is probably going beyond the delays that the regulator
API is handling since it's not something the regulator hardware is
actively managing.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150513/1f30bf2b/attachment.sig>
