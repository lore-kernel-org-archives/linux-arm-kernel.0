From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 19 Jan 2010 23:11:11 +0000
Subject: [RFC 06/18] arm: msm: implement proper dmb() for 7x27
In-Reply-To: <20100119211244.GH1323@shareable.org>
References: <1263250057-26692-1-git-send-email-dwalker@codeaurora.org>
	<1263250057-26692-7-git-send-email-dwalker@codeaurora.org>
	<20100111233924.GL7925@n2100.arm.linux.org.uk>
	<1263253516.26505.42.camel@c-dwalke-linux.qualcomm.com>
	<20100112000142.GO7925@n2100.arm.linux.org.uk>
	<20100119172835.GC1323@shareable.org>
	<20100119180424.GC1886@n2100.arm.linux.org.uk>
	<20100119211244.GH1323@shareable.org>
Message-ID: <20100119231111.GA5891@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 19, 2010 at 09:12:44PM +0000, Jamie Lokier wrote:
> Fair enough.  Is it like this?
> 
>    1. Data ends up in cache lines from access via the cached mapping.
>    2. Access via the strongly ordered mapping may still look at the cache,
>       because it's easier that way and it's not supposed to have any data.
>    3. Cache effectively intercepts the access.
>    4. Bus does not see strongly ordered access.

Yes, that's one possible scenario.

> Isn't the above sequence of events you described earlier even _more_
> likely to occur when there are simultaneous cacheable and
> non-cacheable mappings?

I guess it depends how the access hardware is designed - and what
effect an access resulting in a device or strongly ordered type access
(thereby having one set of ordering requirements) has when it hits a
cache line, which will have different ordering requirements.

With ARMv6 and above, it's no longer just about cache policy, as with
previous CPUs.  There's ordering requirements to ensure that (eg) device
accesses occur on the busses in program order rather than out of order,
and this will require hardware - which could be confused by a device
access hitting the cache.

The difference between this and differing cache policies, the ordering
requirement is the same.

(ISTR ARM Ltd's architecture folk know about the problem Linux has with
cache policies, and although this requirement is written into the arch
manual, they're aware that Linux will have major problems with it.  I
believe the only unpredictability that results from this that a NC
region may end up with cache lines allocated, which may or may not be
hit.  That's not to say that it _won't_ become a problem with later
ARM CPUs, but let's pray that when it does, we have coherent DMA
support.)
