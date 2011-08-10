From: jamie@jamieiles.com (Jamie Iles)
Date: Wed, 10 Aug 2011 12:49:07 +0100
Subject: [RFC PATCH] ARM: sched_clock: allow sched_clock to be selected
	at runtime
In-Reply-To: <1312910015-20043-1-git-send-email-marc.zyngier@arm.com>
References: <1312910015-20043-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <20110810114907.GA2680@pulham.picochip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marc,

On Tue, Aug 09, 2011 at 06:13:35PM +0100, Marc Zyngier wrote:
> sched_clock() is yet another blocker on the road to the single
> image. This patch implements an idea by Russell King:
> 
> http://www.spinics.net/lists/linux-omap/msg49561.html
> 
> Instead of asking the platform to implement both sched_clock()
> itself and the rollover callback, simply register a read()
> function, and let the ARM code care about sched_clock() itself,
> the conversion to ns and the rollover. sched_clock() uses
> this read() function as an indirection to the platform code.
> 
> This allow some simplifications and possibly some footprint gain
> when multiple platforms are compiled in. Among the drawbacks,
> the removal of the *_fixed_sched_clock optimization which could
> negatively impact some platforms (sa1100, tegra, versatile
> and omap).
> 
> Tested on 11MPCore, OMAP4 and Tegra.

Tested on my 1176 platform and works nicely.  However, shouldn't the 
read functions still be marked notrace so they don't appear in ftrace 
output?

On my (out of tree) platform, omitting notrace and having all of the 
ftrace bootup tests results in a hard lockup.  Annotating the read 
function resolves this.

Jamie
