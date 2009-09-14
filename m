From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 14 Sep 2009 15:09:09 +0100
Subject: LDREX/STREX and pre-emption on SMP hardware
In-Reply-To: <1252930881.16853.99.camel@pc1117.cambridge.arm.com>
References: <1250870319.10642.23.camel@pc1117.cambridge.arm.com>
	<1250890146.29685.18.camel@david-laptop>
	<1251128692.28977.17.camel@pc1117.cambridge.arm.com>
	<1251134043.31975.23.camel@david-laptop>
	<1251135709.28977.40.camel@pc1117.cambridge.arm.com>
	<20090914014353.GA4762@shareable.org>
	<20090914100056.GC16644@n2100.arm.linux.org.uk>
	<1252922773.16853.62.camel@pc1117.cambridge.arm.com>
	<1252928832.16853.96.camel@pc1117.cambridge.arm.com>
	<1252930881.16853.99.camel@pc1117.cambridge.arm.com>
Message-ID: <20090914140908.GD21580@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 14, 2009 at 01:21:21PM +0100, Catalin Marinas wrote:
> And here's an untested patch to clear the exclusive monitor on the
> exception return path. If you are OK with the idea, I'll do some testing
> before pushing it for upstream:

However, a plain STR is not guaranteed to change the state of the
exclusive monitor - it is implementation defined whether STR does
or not.

This is true for both the local and global exclusive monitors.  This
means that if you use STR on a location which is being used by
exclusive access instructions on another CPU:

	CPU0	CPU1
	LDREX
		STR
	STREX

results in the STR getting lost since the STREX can complete.

Basically, don't use STR on exclusive access locations - it's
certainly unsafe in a SMP environment.
