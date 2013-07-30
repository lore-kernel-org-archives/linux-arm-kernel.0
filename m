From: broonie@kernel.org (Mark Brown)
Date: Tue, 30 Jul 2013 18:24:13 +0100
Subject: [PATCH 0/5] Optional regulator support
In-Reply-To: <864nbcte4j.fsf@void.printf.net>
References: <20130730114502.GQ9858@sirena.org.uk>
 <864nbcte4j.fsf@void.printf.net>
Message-ID: <20130730172413.GW9858@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 30, 2013 at 01:40:28PM +0100, Chris Ball wrote:
> On Tue, Jul 30 2013, Mark Brown wrote:

> > Right now all the MMC users are converted over as-is, though it does
> > look like drivers such as sdhci really ought to be insisting on having a
> > regulator for VMMC in the same way that the MMC core helper does (and
> > indeed in that case it looks like it ought to be converted over to the
> > core code).

> I didn't follow this part -- I don't think the MMC core insists on a
> VMMC regulator, and I don't think sdhci should either, because e.g.
> an x86 laptop isn't going to have one.  What am I missing?

You're missing the fact that there will be a VMMC regulator there since
the card needs power to function, it just might not be one that software
knows about or can control.  If it's one that software can control
that's not mapped in properly (eg, because the driver for the regulator
wasn't loaded) then obviously that's a serious problem and power saving
features in the regulator API may for example turn off the supply even
if it's on by default since they can't tell it's in use.

As things stand the expectation for x86 type systems is that MMC
controllers attached via PCI or USB ought to be setting up a fixed
regulator so that the consumer part can proceed without ignoring errors
that might be serious on other systems.  It's probably not a bad idea to
do this anyway though hopefully in the future this work will make it
less needed.  For embedded systems the system integration ought to be
doing the same thing, normally as part of the configuration of the PMIC.

The goal of this series is to make it much easier for the regulator core
to transparently support such systems where the regulators aren't
visible to software by transparently stubbing out normal supplies that
really must be present somehow for the hardware to operate without
confusing things by also stubbing out suppies that may be missing in
normal operation.  This is the problem for the existing stubbing support
- it works well for normal supplies but it means that any consumer that
wants to handle a supply that's not there can't tell it's missing.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130730/60357bc9/attachment-0001.sig>
