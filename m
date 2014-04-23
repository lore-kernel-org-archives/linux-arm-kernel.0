From: broonie@kernel.org (Mark Brown)
Date: Wed, 23 Apr 2014 19:26:11 +0100
Subject: [PATCH 2/2] arm64: topology: add MPIDR-based detection
In-Reply-To: <20140423172720.GA18588@lc-sj1-5012.sj.broadcom.com>
References: <1398217214-12204-1-git-send-email-zlim@broadcom.com>
 <1398217214-12204-3-git-send-email-zlim@broadcom.com>
 <20140423103648.GM12304@sirena.org.uk>
 <20140423172720.GA18588@lc-sj1-5012.sj.broadcom.com>
Message-ID: <20140423182611.GF12304@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 23, 2014 at 10:27:20AM -0700, Zi Shen Lim wrote:

> Or is it likely that some folks may opt to skip aff2, and simply use aff3?
> Mark, is there precedence for such usage of affinity levels?

Not that I'm aware of at the minute myself but of course this code may
end up running on some enterprise distribution with an extended support
time with hardware that isn't even on the drawing board now.

> > I had been intending to just combine all the bits from affinitly levels
> > above the CPU number into a single number until we know what to do with
> > them individually.  We shouldn't just ignore them.

> I agree we shouldn't ignore aff3 if someone is already using it.

> I'm not sure how combining them into a single number helps with topology.
> We already started out with a cpuid, no?

It will at least ensure that all clusters get assigned a unique ID and
we don't end up discarding some of the information and coming out with
two identically numbered clusters which then have identically numbered
CPUs inside of them which doesn't seem clever.

When I was looking at this it wasn't sufficiently clear to me that the
cluster clustering would be well modelled by sockets as the scheduler
currently assumes them, nor what to do with additional levels of that
(the DT binding allows for infinite levels).  Punting and just putting
all clusters at the same level avoids active bugs and seems fairly
conservative.

> Perhaps we should just add a new 'socket_id' and that will accommodate
> all cases (up to aff3).

Not in the non-MT case where we've got two levels above the cluster ID
in affinity level 1 unless we just combine 2 and 3 (which would be
reasonable enough of course).
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140423/73faad4d/attachment.sig>
