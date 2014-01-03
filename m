From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 3 Jan 2014 14:58:05 +0000
Subject: Question about =?iso-8859-1?Q?debuggin?=
 =?iso-8859-1?Q?g_Bad_mode_in_=E2?= handler detected
In-Reply-To: <1388760385.31617.2.camel@phoenix>
References: <1388760385.31617.2.camel@phoenix>
Message-ID: <20140103145805.GO7383@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 03, 2014 at 10:46:25PM +0800, Axel Lin wrote:
> I hit a "Bad mode in ? handler detected" oops.
> The first line of the message looks un-readable, so I print the reason
> index as well.  The reason index is "4", so it does not exist in the
> handler array.
> static const char *handler[]= { "prefetch abort", "data abort", "address exception", "interrupt" };
> I'd appreciate if someone can give me advices and comments to debug this.

Hmm, the 4th entry should be "undefined instruction".

You basically hit an undefined instruction while trying to enter interrupt
servicing very early on.

My guess is that you have some kind of vectored interrupt controller which
took told the CPU to jump to 0xa00.  It looks to me as if that's part of
the vectors page, and there's no code there.

(The unused portions of the vectors page are now filled with that
undefined instruction.)

-- 
FTTC broadband for 0.8mile line: 5.8Mbps down 500kbps up.  Estimation
in database were 13.1 to 19Mbit for a good line, about 7.5+ for a bad.
Estimate before purchase was "up to 13.2Mbit".
