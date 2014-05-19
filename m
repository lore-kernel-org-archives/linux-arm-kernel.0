From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Mon, 19 May 2014 11:54:05 +0100
Subject: [PATCH 4/6] arm64: topology: add MPIDR-based detection
In-Reply-To: <5379D594.2000200@arm.com>
References: <1399063112-16917-1-git-send-email-broonie@kernel.org>
 <1399063112-16917-5-git-send-email-broonie@kernel.org>
 <53763DFC.8070309@arm.com> <20140516183915.GP22111@sirena.org.uk>
 <5379D594.2000200@arm.com>
Message-ID: <20140519105405.GC5935@e102568-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 19, 2014 at 10:57:40AM +0100, Sudeep Holla wrote:
> 
> 
> On 16/05/14 19:39, Mark Brown wrote:
> > On Fri, May 16, 2014 at 05:34:04PM +0100, Sudeep Holla wrote:
> >
> >> This is broken, IIRC Lorenzo commented on this in the previous version of the
> >> patch.
> >
> > Could you please be specific?  Lorenzo was concerned about overflow but
> > that ought to be addressed here.
> >
> 
> Ah, my bad. You are right, I took his comment on the shift to be different from
> overflow which is not the case.
> 
> >> Take a simple example of system with 2 Quad core clusters.
> >> The mpidr_hash.shift_aff[1] will be 6 as you need minimum 2 bits to represent
> >> aff[0]. So you will end up with second cluster with id = 4 instead of 1.
> >
> > This isn't a problem, the clusters can have any numbers so long as they
> > are distinct.  There is no other requirement.
> >
> 
> IIUC these topology information is exposed via sysfs. So it's good to have
> uniformity though they can have any number. As mentioned in the example, if the
> linearisation depend on aff[0], then this factor will not be uniform.
> 
> >> I am not sure if we need this serialization, but even if we need it you can't
> >> simply use the hash bits generated for MPIDR.Aff{3..0} serialization directly
> >> as is for serializing parts of it.
> >
> > Ah, now I look at what the hash is doing that is indeed directly useful
> > - we can mask or shift out the bits we don't want.  Equally well it just
> > looks like a preference?
> 
> Yes we can use the hash bits, but the way it's done in this patch needs fixing
> so that we can be more uniform(as its exposed via sysfs)
> 
> >
> > This does seem like something that could be dealt with incrementally.
> >
> 
> Sorry, I didn't mean to block this patch, I am just mentioning the possible
> issue with this patch.

Hash is used to save memory, if all we need is a unique identifier
we do not need the hash at all.

As to what should we use as cluster id, honestly I do not know.

I am quite tempted to use just three affinity levels for the moment
and fix it when need arises, after all on ARM we have aff2 completely
unused at the moment for the non-SMT systems (ie all ARM SMP systems in
the mainline) and we are not coalescing affinity 2 into affinity 1 in
any way.

So either you ignore aff3, or can do something like that (non-SMT):

cluster_id = MPIDR_EL1[39:32] << 16 | MPIDR_EL1[23:16] << 8 | MPIDR_EL1[15:8]

Also please remove the warning on the missing topology information, if
we fall back to MPIDR_EL1 we will always have a topology of sorts, as
borked as it might be, so that warning becomes useless, ie it is never
triggered.

Lorenzo
