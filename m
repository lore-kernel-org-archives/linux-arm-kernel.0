From: broonie@kernel.org (Mark Brown)
Date: Wed, 23 Apr 2014 23:38:12 +0100
Subject: [PATCH 2/2] arm64: topology: add MPIDR-based detection
In-Reply-To: <20140423192228.GA21142@lc-sj1-5012.sj.broadcom.com>
References: <1398217214-12204-1-git-send-email-zlim@broadcom.com>
 <1398217214-12204-3-git-send-email-zlim@broadcom.com>
 <20140423103648.GM12304@sirena.org.uk>
 <20140423172720.GA18588@lc-sj1-5012.sj.broadcom.com>
 <20140423182611.GF12304@sirena.org.uk>
 <20140423192228.GA21142@lc-sj1-5012.sj.broadcom.com>
Message-ID: <20140423223812.GG12304@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 23, 2014 at 12:22:28PM -0700, Zi Shen Lim wrote:
> On Wed, Apr 23, 2014 at 07:26:11PM +0100, Mark Brown wrote:

> > When I was looking at this it wasn't sufficiently clear to me that the
> > cluster clustering would be well modelled by sockets as the scheduler
> > currently assumes them, nor what to do with additional levels of that
> > (the DT binding allows for infinite levels).  Punting and just putting
> > all clusters at the same level avoids active bugs and seems fairly
> > conservative.

> Sounds like you prefer "cluster of clusters" over "socket", correct?

I don't actually care that much, I guess I was using the hardware
terminology because I'm not sure how well it will map onto the current
Linux software model of what a socket is but if we decide it maps well
onto a socket that's fine also.

> In any case, with only 4 affinity levels defined in the arch, as long as
> we also have 4 variables to capture that information, we should be good,
> right?

> Anything more exotic not expressable by these 4 affinity levels in MPIDR
> will require additional information from other sources such as DT or ACPI.

Yes.  I'd really only thought it through properly for the DT case since
at the time Catalin was saying that it would not be possible to use
MPIDR.

> > > Perhaps we should just add a new 'socket_id' and that will accommodate
> > > all cases (up to aff3).

> > Not in the non-MT case where we've got two levels above the cluster ID
> > in affinity level 1 unless we just combine 2 and 3 (which would be
> > reasonable enough of course).

> Is the following an accurate description of your proposal for non-MT?

> 	thread_id   = -1
> 	core_id     = aff0
> 	cluster_id  = aff1
> 	clusters_id = combine(aff2,aff3)

Yes, exactly in the combining case - probably just shift one of them
left and or them together.  Otherwise just only have the cluster_id and
combine everything else into one (that's what the DT code does
effectively).
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140423/4dcff290/attachment.sig>
