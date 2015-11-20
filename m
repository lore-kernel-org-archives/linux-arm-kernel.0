From: mark.rutland@arm.com (Mark Rutland)
Date: Fri, 20 Nov 2015 20:15:56 +0000
Subject: [PATCH] [PATCH] arm64: Boot failure on m400 with new cont PTEs
In-Reply-To: <20151119112923.GA24570@leverpostej>
References: <1447858999-26665-1-git-send-email-jeremy.linton@arm.com>
 <20151118152044.GD10644@leverpostej> <564CA29A.9050905@arm.com>
 <20151118162932.GA13355@leverpostej> <564CB1DA.4090304@arm.com>
 <20151118180434.GB13355@leverpostej> <564CD206.9040402@arm.com>
 <20151119112923.GA24570@leverpostej>
Message-ID: <20151120201556.GE14942@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 19, 2015 at 11:31:34AM +0000, Mark Rutland wrote:
> On Wed, Nov 18, 2015 at 01:31:18PM -0600, Jeremy Linton wrote:
> > On 11/18/2015 12:04 PM, Mark Rutland wrote:
> > 
> > >You're racing against other parts of the CPU (the page table walker(s),
> > >I-caches, etc). The flushing only minimises the window for a race, and
> > >does not prevent the race from being possible.
> > >
> > >Given that the envelope is constantly pushing forward w.r.t. how
> > >aggressive CPUs may be in this area, we need to fix the issue by
> > >reasoning against what the architecture guarantees us.
> > 	Its also not suppose to fault on speculative access, and to me that
> > means page table walks/etc that are the result of speculative
> > access.
> 
> I was under the impression that TLB conflict abort could be delivered
> for asynchronous events (e.g. speculative I-cache fetches rather than
> for speculative execution of already fetched instructions).
> 
> Having looked at the ARM ARM, I appear to have been mistaken. As you
> say, it appears that TLB conflict aborts are always delivered
> synchronously.

Having invesitgated further, while we may not encounter (synchronous)
TLB conflict aborts, we may still encounter (asynchronous) issues from
conflicting TLB entries.

Per the ARM ARM, if the TLB contains multiple entries for the same
address, the result of a translation may be some amalgamation of said
entries (where the amalgamation could be an arbitrary function of all of
said matching entries).

Thus page table walks and *-cache fetches may use completely erroneous
addresses and/or attributes, asynchronous to the instruction stream, and
as a result of this may change the state of MMIO peripherals, trigger
SError, etc.

This is a much scarier proposition than the TLB conflict aborts.

Thanks,
Mark.
