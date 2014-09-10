From: broonie@kernel.org (Mark Brown)
Date: Wed, 10 Sep 2014 15:31:44 +0100
Subject: Unable to boot mainline on snow chromebook since 3.15
In-Reply-To: <CAOesGMipX3MV6sMWLuY=D+bQ6qe8P17YFbTFwZOHPeSc3Pw9Cg@mail.gmail.com>
References: <CAD=FV=VfioJf9VYoSYL0QBk-bN93-Ecx3=0n9hb5Q4rcx43-_g@mail.gmail.com>
 <540C202E.2060009@collabora.co.uk> <540C7F5B.6070307@gmail.com>
 <540C83DE.10505@collabora.co.uk> <540C8577.2070907@gmail.com>
 <20140908112112.GK26030@arm.com>
 <CACxGe6v40wMSW8LJRtyZ3C6PinRMcQM-Zog+XpTJ-QG3HHJknw@mail.gmail.com>
 <CAD=FV=VAqzvJQDQMjjeQ1p5okyDzE=ff_sguObZxh59qbzcaTQ@mail.gmail.com>
 <CACxGe6t_ex1bU=CvTpXR4VJgNf1hAq33hr6ykbHy_sMXEk4h-g@mail.gmail.com>
 <CAOesGMipX3MV6sMWLuY=D+bQ6qe8P17YFbTFwZOHPeSc3Pw9Cg@mail.gmail.com>
Message-ID: <20140910143144.GF7960@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 10, 2014 at 06:06:46AM -0700, Olof Johansson wrote:
> On Mon, Sep 8, 2014 at 12:40 PM, Grant Likely <grant.likely@secretlab.ca> wrote:

> > Well, lets see... We've got a real user complaining about a platform
> > that used to work on mainline, and no longer does. The only loophole
> > for ignoring breakage is if there nobody cares that it is broken. That
> > currently isn't the case. So even though it's based on a patch that
> > has "DO NOT SUBMIT" in large friendly letters on the front cover, it
> > doesn't change the situation that mainline has a regression.

> Yeah, I'm with you on this Grant, it doesn't matter what the patch is
> labelled as.

> One way to deal with this could be to add a quirk at boot time --
> looking for the simplefb and if found, modifies the regulators to keep
> them on. That'd go in the kernel, not in firmware.

Well, we should also be fixing simplefb to manage the resources it uses
though that doesn't clean up after the broken DTs that are currently
deployed.

As well as the regulators we'll also need to fix the clocks.  If we're
going to start adding these fixups perhaps we want to consider having a
wrapper stage that deals with rewriting DTs prior to trying to use them?
I'm not sure if it makes much difference but there's overlap with other
tools like the ATAGs conversion wrapper and building separately would
let the fixup code run early without directly going into the early init
code (which seems a bit scary).

> Much better would have been if the DRM changes worked when they
> landed, so that the migration form simplefb to drm was invisible to
> the user. Or at least, to get them working ASAP since they're still
> broken. :(

As far as I can tell the problem here is coming from the decision to
have simplefb use resources without knowing about them - can we agree
that this is a bad idea?
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140910/f2ef9bdd/attachment-0001.sig>
