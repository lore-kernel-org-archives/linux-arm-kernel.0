From: jeremy.kerr@canonical.com (Jeremy Kerr)
Date: Mon, 23 Aug 2010 22:36:45 +0800
Subject: [PATCH 2/3] arm: return both physical and virtual addresses
	from addruart
In-Reply-To: <20100823100519.GA8018@pengutronix.de>
References: <1282553423.737985.983362819420.0.gpush@pororo>
	<1282553423.739278.339711204256.2.gpush@pororo>
	<20100823100519.GA8018@pengutronix.de>
Message-ID: <1282574205.2845.47.camel@pororo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Uwe,

> > +		.macro	addruart_current, rx, tmp1, tmp2
> > +		addruart	\tmp1, \tmp2
> > +		mrc		p15, 0, \rx, c1, c0
> > +		tst		\rx, #1
> > +		moveq		\rx, \tmp1
> > +		movne		\rx, \tmp2
> > +		.endm
> Don't you need to depend on MMU somehow to do this in generic code?
> 

Yeah, it would make sense to have a separate paths for CONFIG_MMU/!
CONFIG_MMU (the latter just using \tmp1).

Although, What will the mrc instruction do if there is no MMU? if it
doesn't cause an exception, we can assume that the platform's addruart
macro will return the same address in both registers and the existing
code will just work.

Cheers,


Jeremy
