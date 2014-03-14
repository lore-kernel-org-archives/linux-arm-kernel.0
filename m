From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 14 Mar 2014 15:01:10 +0000
Subject: PL310 errata workarounds
In-Reply-To: <20140314144835.GP21483@n2100.arm.linux.org.uk>
References: <20140314144835.GP21483@n2100.arm.linux.org.uk>
Message-ID: <20140314150110.GQ21483@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 14, 2014 at 02:48:35PM +0000, Russell King - ARM Linux wrote:
> While looking at the now rather horrid L2C-2x0 code, there's some really
> serious questions that have to be asked about some of these errata.
> 
> 588369 affects PL310 up to and including R1P0, but is fixed in R2P0.
> 	This erratum requires a clean+invalidate request to be split into
> 	a separate clean request followed by an invalidate request.  This
> 	must be done with the debug register set to 0x03.
> 
> 	If the debug register is not set to 0x03, then it's effectively
> 	a separate clean operation followed by a separate invalidate
> 	operation.
> 
> 727915 affects PL310 up to and including R3P0, but is fixed in R3P1.
> 	This erratum concerns writes which may be discarded as a result
> 	of a clean+invalidate request, particularly when a write hits
> 	the cache line being requested between the clean stage and the
> 	invalidate stage.
> 
> Now, let's say that we have a PL310 R3P3 cache.  Linux is configured with
> both workarounds enabled.  This has the effect that we never use the
> clean+invalidate request.
> 
> However, Rob's patch in 74ddcdb868a8 (ARM: 7608/1: l2x0: Only set
> .set_debug on PL310 r3p0 and earlier) has the effect that we no longer
> to the debug dance on such a cache.
> 
> This means we're still splitting the clean+invalidate sequence into two
> separate operations, so there's room for a write to hit the cache line
> between the two operations and, therefore, be lost.
> 
> So, do we actually care about 727915, because through applying Rob's
> change, we've effectively re-exposed the problem which this erratum
> refers to on all L2 cache controllers where this is actually fixed,
> and it's been like this for 14 months without any reported issue.

Another point here is... we don't even need 727915 at all: 727915 is
about the clean+invalidate by WAY request, not clean+invalidate by PA.
So really we should rip out references to this erratum because it's
not applicable.

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
