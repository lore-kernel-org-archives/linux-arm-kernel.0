From: broonie@kernel.org (Mark Brown)
Date: Mon, 19 May 2014 17:12:17 +0100
Subject: [PATCH 4/6] arm64: topology: add MPIDR-based detection
In-Reply-To: <20140519141323.GA2917@e102568-lin.cambridge.arm.com>
References: <1399063112-16917-1-git-send-email-broonie@kernel.org>
 <1399063112-16917-5-git-send-email-broonie@kernel.org>
 <53763DFC.8070309@arm.com> <20140516183915.GP22111@sirena.org.uk>
 <5379D594.2000200@arm.com>
 <20140519105405.GC5935@e102568-lin.cambridge.arm.com>
 <20140519123314.GU12304@sirena.org.uk>
 <20140519141323.GA2917@e102568-lin.cambridge.arm.com>
Message-ID: <20140519161217.GX12304@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 19, 2014 at 03:13:24PM +0100, Lorenzo Pieralisi wrote:

> Using the pseudo code above is as useful as using the hashing algorithm,
> they both provide you with a unique id and that's all we need for the
> topology.

> The original code was using the hash shifts the wrong way, which could
> lead to incorrect behaviour.

Ah, OK.  I misremembered.

> If ignoring affinity levels is silly, then we have to fix ARM 32 bit
> code too, since there on ALL SMP ARM systems in the mainline, affinity
> level 2 *is* ignored (since they are not SMT systems).

I think someone should, yes, though I'd be a bit surprised if anyone
ever actually makes 32 bit ARM hardware where it makes any difference.

> Having said that, I really think that for the time being we should use three
> affinity levels (for topology purposes) as ARM 32 does and be done with this
> stuff.

> To be 100% precise, I think the best way to do it is to add another
> topology level (ie "book" in the kernel or whatever you want to call it for
> ARM, which I think is unused) and update the parsing code and data structure
> accordingly so that if two clusters have the same id but belong to different
> "books" (aff2 or aff3 - depending on SMT) the sibling masks are still correct.

> Documentation/cputopology.txt

> We will cross that bridge when we come to it instead of lumping affinity
> levels together, that's my opinion.

Right, that's about what I'm saying - I don't think we should actually
do anything to describe a multi-level topology to the scheduler since
it's not clear to me if the physical realities of such systems system
will map on to what the scheduler thinks it's modelling well, or for
that matter if the scheduler won't have a better model or be capable of
automatically tuning this stuff without explicit information from the
architecture by the time anyone gets around to making such hardware.

The only reason for paying attention at all at present is to ensure that
we don't do something actively broken and squash clusters together
should we encounter such a system - we do the same thing that the DT
code, we just ignore the heirachy and report everything as a flat
topology.

> > I'll add something to this patch - the warning is needed if the DT code
> > gets merged without this and it seems this one still going round the
> > loop.  :/

> Yes but *this* patch is bumping the log level not the other ones and what I
> am saying is that when this code patch gets merged that warning is useless (ie
> never triggered - cluster id can't be == -1) unless I am missing something
> here.

Right, if we have the MPIDR support then it should be removed.  It's
useful if we get the DT without MPIDR but not otherwise - once we can
parse MPIDRs for most SoCs there should be very little reason to ever
bother with the DT binding.

> Do not bother, use three affinity levels and be done with that, we will
> deal with aff3 (and aff2) when time comes.

This would leave the MPIDR support worse than DT which seems retrograde
especially given that it's so simple to differentiate the clusters.  The
only issue with that appears to be about precisely how to make up the
cluster numbers which is a cosmetic one.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140519/c0589cf4/attachment.sig>
