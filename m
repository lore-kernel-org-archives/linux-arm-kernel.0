From: broonie@kernel.org (Mark Brown)
Date: Wed, 28 May 2014 10:44:54 +0100
Subject: [PATCH v2 1/4] devicetree: bindings: Properly document micrel
 ks8851 SPI chips
In-Reply-To: <5385063F.30407@codeaurora.org>
References: <1400875040-13269-1-git-send-email-sboyd@codeaurora.org>
 <1400875040-13269-2-git-send-email-sboyd@codeaurora.org>
 <20140524124858.GR22111@sirena.org.uk>
 <5385063F.30407@codeaurora.org>
Message-ID: <20140528094454.GH12304@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 27, 2014 at 02:40:15PM -0700, Stephen Boyd wrote:
> On 05/24/14 05:48, Mark Brown wrote:

> > That said it looks like this is intended to be a supply for an external
> > PHY rather than the device itself, but even so my original question
> > about it being able to operate without power still applies.  Looking at
> > the code it's certainly not doing any of the handling of a missing
> > supply that I would associate with using _optional().

> I agree, both supplies don't look optional. Unfortunately
> efm32gg-dk3750.dts doesn't look to be listing any supply, and this
> driver only recently got support for the VDD_A3.3 supply that the omap
> board uses (adding Uwe for any comments on efm setup). I presume on
> these boards VDD_IO is tied to some always on power source that software
> doesn't want to deal with. Nishant, what's VDD_IO connected to on omap?

> What's the proper solution here? Should we use regulator_get() and check
> for EPROBE_DEFER and ignore other errors?

As an implementation extension if no supply is specified at all the
regulator API will happily substitute in a dummy if the board is using
DT or ACPI, or if it has specified full constraints.

> Should the get_optional() variant just drop the "Other consumers will
> be... " part and should the get_exclusive() variant say "obtain this
> regulator while this reference is held" ?

Yes.

> From: Stephen Boyd <sboyd@codeaurora.org>
> Subject: [PATCH] regulator: Fix regulator_get_{optional,exclusive}()
>  documentation

Documentation/SubmittingPatches.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140528/d1b26f8b/attachment.sig>
