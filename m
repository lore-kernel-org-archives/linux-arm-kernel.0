From: broonie@kernel.org (Mark Brown)
Date: Tue, 20 May 2014 19:45:10 +0100
Subject: [PATCH 1/2] arm64: topology: Tell the scheduler about the
 relative power of cores
In-Reply-To: <20140520173727.GD28293@arm.com>
References: <1400545421-28067-1-git-send-email-broonie@kernel.org>
 <20140520173727.GD28293@arm.com>
Message-ID: <20140520184510.GN12304@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 20, 2014 at 06:37:27PM +0100, Catalin Marinas wrote:
> On Tue, May 20, 2014 at 01:23:40AM +0100, Mark Brown wrote:
> > In heterogeneous systems like big.LITTLE systems the scheduler will be
> > able to make better use of the available cores if we provide power numbers
> > to it indicating their relative performance. Do this by parsing the CPU
> > nodes in the DT.

> Last time we discussed these two patches, my understanding was that the
> mainline scheduler doesn't behave any better on big.LITTLE with this
> additional information, unless you also have additional out of tree b.L

That wasn't my recollection and I'm certainly seeing code in the current
scheduler which appears to make use of the information though I cannot
claim any depth of understanding.  It's possible you're recalling some
offline/other conversation with people more involved in the scheduler
though?  

The issue I'm aware of with this is the one called out in the changelog
- it could do odd things with loads that try to saturate all cores with
one thread per core, but then I'm not clear that such loads are going to
work effectively on a big.LITTLE system anyway (either some jobs get
packed on a big core or some jobs run a lot slower on little cores).  My
understanding was that more typical workloads with load spread over more
tasks should tend to do better with this.

The biggest win with the out of tree patches is that they have some idea
of the power tradeoffs with the two clusters and actively push to
exploit them.

> MP patches. Vincent is also cleaning up some of the cpu_power usage in
> the scheduler.

> So unless there are clear benefits in providing such information to the
> mainline scheduler, I don't plan to merge them for the time being (I'm

The main thing I'm seeing here is consistency between ARMv8 and ARMv7
big.LITTLE implementations - there's readily available ARMv7 big.LITTLE
hardware out there so I would expect that much of the work on the
scheduler will continue to focus on ARMv7.  Keeping ARMv8 consistent
with ARMv7 should avoid nasty surprises there.

Unless I'm completely misreading the code I'm looking at in fair.c I
suspect I could come up with benchmarks that showed an impact but I'm
not sure that's too useful unless there's something you're particularly
interested in, this sort of thing always has an element of taste.

It would be nice to at least merge the parsing code in the first patch,
without the performance numbers in the table from the second patch it
won't have any practical impact but it's less diff to carry around and
easier for people to experiment with when doing in tree work (including
possibly setting other parameters as a result of parsing).  Does that
seem reasonable?

> also not convinced of the numbers in the second patch, they need some
> benchmarking on real hardware).

I'm sure we can all have confidence in the published performance
numbers!  More seriously as I've said before I think you're overthinking
the importance of their accuracy, though as that change is so small it's
a bit less of a concern for diff to carry about.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140520/1d0de466/attachment.sig>
