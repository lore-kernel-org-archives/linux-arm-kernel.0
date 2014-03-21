From: broonie@kernel.org (Mark Brown)
Date: Fri, 21 Mar 2014 11:32:02 +0000
Subject: [PATCH 1/3] arm64: topology: Add support for topology DT bindings
In-Reply-To: <20140320180836.GA3307@red-moon>
References: <1395252139-16239-1-git-send-email-broonie@kernel.org>
 <20140320112650.GA1408@red-moon>
 <20140320134357.GE11706@sirena.org.uk>
 <20140320180836.GA3307@red-moon>
Message-ID: <20140321113202.GJ11706@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 20, 2014 at 06:08:36PM +0000, Lorenzo Pieralisi wrote:

> > > This ifdef can be removed, CONFIG_OF is always selected for arm64 and
> > > the !CONFIG_OF path

> > This has been present since the very first time these patches were
> > posted but hasn't been mentioned as being a problem previously.

> I am sorry, I missed it, doing my best to help you get it through.

Please try to consider this from a submitter point of view; it is quite
frustrating every time something that has been around for a while and
fairly obvious gets identified as a new issue, it makes it hard to have
confidence that addressing review comments is moving closer to getting
things accepted.

> Worse or better, it has to be consistent. Either you leave them
> everywhere (but there is a coding style, it is for a reason) or you
> remove them everywhere (there are other nested paths where it is removed
> in the patch). Do not take it as a nitpick please, I just want the code to
> be consistent.

Hrm, I couldn't actually find any other examples where the if is an edge
statement in a block.

> DT (cpu-map) takes precedence though. Yes, instead of resetting the
> topology, falling back to MPIDR_EL1 is acceptable if either there are
> broken bindings or cpus with missing topology information.

Quite; and hopefully in most cases the hardware designers will set MPIDR
sensibly and so the DT could just omit the topology information entirely
since it's redundant.

> Honestly, it is not up to the kernel to validate DT, since this adds
> complexity, but I think that a big fat WARN_ON on missing or broken
> topology information would help fix firmware at early stages.

I dunno, we're now doing active things like insisting on at least one
level of cluster node which definitely seem to push us into actively
looking for problems where there's no real ambiguity about what's meant.
Though we're not currently doing any WARN_ON()s...

> I know, it is complex, there is little we can do about that and it is
> code run just at cold boot and freed later so I deem that acceptable.

It's not that anything is really complex (the requirements keep on
evolving but nothing is particularly hard), it's that we could most
likely have had something useful for people already.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140321/ff5568d6/attachment.sig>
