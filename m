From: jason@lakedaemon.net (Jason Cooper)
Date: Wed, 17 Jun 2015 21:39:26 +0000
Subject: [PATCH v2 1/3] net: mvneta: introduce compatible string
 "marvell, armada-xp-neta"
In-Reply-To: <20150617224312.3bfc80d9@free-electrons.com>
References: <1434547162-6275-1-git-send-email-simon.guinot@sequanux.org>
 <1434547162-6275-2-git-send-email-simon.guinot@sequanux.org>
 <55818E64.20007@free-electrons.com>
 <55818F10.8030304@free-electrons.com>
 <20150617170112.GD2917@io.lakedaemon.net>
 <20150617224312.3bfc80d9@free-electrons.com>
Message-ID: <20150617213926.GE2917@io.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hey Thomas,

On Wed, Jun 17, 2015 at 10:43:12PM +0200, Thomas Petazzoni wrote:
> On Wed, 17 Jun 2015 17:01:12 +0000, Jason Cooper wrote:
> 
> > I disagree with this.  We can't predict what incosistencies we'll discover in
> > the future.  We should only assign new compatible strings based on known IP
> > variations when we discover them.  This seems fraught with demons since we
> > can't predict the scope of affected IP blocks (some steppings of one SoC, three
> > SoCs plus two steppings of a fourth, etc)
> > 
> > imho, the 'future-proofing' lies in being specific as to the naming of the
> > compatible strings against known hardware variations at the time.
> 
> Except that this clearly doesn't work, and the case raised by Simon is
> a perfect illustration of why planning ahead is beneficial. 

Odd, I'd use that as an example of the process working.  ;-)  we have
everyone using 'armada-370-neta' for a given block.  We discovered that
the original IP block (on the 370s) had a limitation (no hw checksum
for greater than 1600 bytes).  A newer version of the IP block (XP)
doesn't have the limitation.

So we change the driver to honor the limit for the 370 compatible
string.  We create a new compatible string for xp where the block
doesn't have the limitation.

How did the process fail?

> We already had the issue several times on mvebu platforms, so it
> should really become the rule to have one compatible string specific
> to the actual SoC in the list of compatible strings.

Sorry, I'm just not a fan of guessing.  But I'll fall back to the DT
maintainers on this one.  if they are ok with it, then I'll drop my
objection.

> Not doing so requires breaking DT backward compatibility more often, so
> wanting DT backward compatibility and not wanting to plan ahead is a
> bit antagonist.

I'm not seeing where backwards compatibility was broken?  A device with
an old dtb booting a newer kernel gets a bugfix.  In the case of an XP
board with an old dtb (armada-370-neta), the hardware still works, but
not optimally.  Upgrading the dtb will enable hw checksumming for jumbo
packets.

thx,

Jason.
