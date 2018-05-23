From: broonie@kernel.org (Mark Brown)
Date: Wed, 23 May 2018 09:29:08 +0100
Subject: [PATCH v3 1/2] regulator: dt-bindings: add QCOM RPMh regulator
 bindings
In-Reply-To: <CAD=FV=W=BquL5ojORz4HNP889s=-uNJ-QEzUfAxwXj2Oa3cGew@mail.gmail.com>
References: <41d5df73ddac772551d2966e0752bb0c357b1ded.1526088081.git.collinsd@codeaurora.org>
 <CAD=FV=XegPeFR8pdZM-YiBBJjrbej=C+2biBt4zJKnE90uTYZA@mail.gmail.com>
 <869aad59-1cc5-28ef-1fb5-4ef846696c40@codeaurora.org>
 <CAD=FV=U-QOQekUHj=ck57YJbTFdFjCAWr4t2A92x+fCNf+yV9A@mail.gmail.com>
 <dc1fbe9c-8973-1c4d-0fbd-809c1ec0a6be@codeaurora.org>
 <CAD=FV=XfSGs14VB464cvMGDNwGS4yvSXjN8itZLffm+Sj-D=ww@mail.gmail.com>
 <fb390ccb-927a-8449-05c3-8dcac964bfae@codeaurora.org>
 <CAD=FV=XARtQNo5Cyg78XuT26JUFgn=7BjWRnXPjP566=a-sF1w@mail.gmail.com>
 <a106c337-0713-e5d6-cb40-13e05f4d361d@codeaurora.org>
 <CAD=FV=W=BquL5ojORz4HNP889s=-uNJ-QEzUfAxwXj2Oa3cGew@mail.gmail.com>
Message-ID: <20180523082908.GB4828@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 22, 2018 at 05:08:45PM -0700, Doug Anderson wrote:

> So one client's vote for a voltage continues to be in effect even if
> that client votes to have the regulator disabled?  That seems
> fundamentally broken in RPMh.  I guess my take would be to work around

It's arguable either way - you could say that the client gets to specify
a safe range at all times or you could say that the machine constraints
should cover all cases where the hardware is idling.  Of course RPMh
is missing anything like the machine constraints (as we can see from all
the fixing up of undesirable hard coding we have to do) so it's kind of
pushed towards the first case.

> >> A) Turn off VMMC and VQMMC
> >> B) Program VMMC and VQMMC to defaults
> >> C) Turn on VMMC and VQMMC

> >> ...right now we bootup and pretend to Linux that VMMC and VQMMC start
> >> off, so step A) will be no-op.  Sigh.

> > Step A) would not work because the regulator's use_count would be 0 and
> > regulator_disable() can only be called successfully if use_count > 0.  The
> > call would have no impact and it would return an error.

> Are you sure regulator_force_disable() won't do the trick on most
> boards (which will report the regulator being enabled at bootup)?  I
> haven't tried it, but it seems like it might.

It does mean that things will go wrong if the regulator is shared.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180523/95a4e8ad/attachment-0001.sig>
