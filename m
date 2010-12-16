From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 16 Dec 2010 10:14:45 +0000
Subject: [PATCH 04/13] ARM: pxa: convert sched_clock() to use new
	infrastructure
In-Reply-To: <20101216100523.GI1940@pengutronix.de>
References: <20101216092527.GL9937@n2100.arm.linux.org.uk>
	<E1PTA8m-00079T-Ce@rmk-PC.arm.linux.org.uk>
	<20101216100523.GI1940@pengutronix.de>
Message-ID: <20101216101444.GM9937@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 16, 2010 at 11:05:23AM +0100, Uwe Kleine-K?nig wrote:
> Hello Russell,
> 
> a very minor nit ...
> 
> On Thu, Dec 16, 2010 at 09:28:48AM +0000, Russell King - ARM Linux wrote:
> > +	return cyc_to_sched_clock(&cd, cyc, (u32)~0);
> The value of ~0 is compiler implementation defined, so in general
> ~((u32)0) is saver.  (Though I admit that on arm ~0 will probably always
> be -1, still I think using the save construct doesn't hurt here.)

I've been debating about using something like CLOCKSOURCE_MASK() here,
but haven't yet decided it to be worth it.  I also toyed with the idea
of storing the mask in the struct, but that adds extra expense when
it's not needed - everyone should know how many bits are in their
counter at build time, and if not, they shouldn't penalize those who do.
