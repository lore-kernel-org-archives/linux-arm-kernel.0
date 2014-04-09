From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 9 Apr 2014 09:17:05 +0100
Subject: memcpy alignment for DEVICE_nGnRnE
In-Reply-To: <20140408233937.GA2100@codeaurora.org>
References: <53072343.4080505@marvell.com> <20140221105307.GE25363@localhost>
 <20140408003547.GA18321@codeaurora.org>
 <20140408114949.GB21054@arm.com>
 <20140408233937.GA2100@codeaurora.org>
Message-ID: <20140409081705.GB13737@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 09, 2014 at 12:39:37AM +0100, Michael Bohan wrote:
> On Tue, Apr 08, 2014 at 12:49:49PM +0100, Catalin Marinas wrote:
> > On Tue, Apr 08, 2014 at 01:35:47AM +0100, Michael Bohan wrote:
> > > How should we handle Device Memory with copy_from_user / copy_to_user?
> > > Should we follow the same scheme and create
> > > copy_from_user_io / copy_to_user_io, or rather enforce that the stock
> > > routines handle alignment?
> > 
> > We have generic copy_from_user_toio() and copy_to_user_fromio(). Are
> > these what you need? As with the memcpy_(to|from)io, they can be further
> > optimised.
> 
> It seems these existing routines are in sound. Were you thinking
> the right approach would be to move them out of sound and make
> them per-arch defined?

If you have a use-case outside of the sound subsystem, they can be made
more generic.

> What about the other two use cases: copy_from_user_fromio and
> copy_to_user_toio? Are those reasonable to add? These two APIs
> would cover the use case I had in mind.

What's the use case for these?

> Then what about the strange but possible use case where both the
> source and destination pointers are iomem? This same question
> applies for memcpy_fromio / memcpy_toio as well.

You can come up with many combinations but we first need to see a real
use of them, eliminate the alternatives and only then look at adding new
API.

> The implementations of copy_from_user_toio and
> copy_to_user_fromio are currently doing a second copy, so that
> seems bad for performance. We'd probably want to improve these as
> well if others are in agreement.

Yes, as I said they are not optimised (but good enough as a start).

-- 
Catalin
