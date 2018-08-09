From: Dave.Martin@arm.com (Dave Martin)
Date: Thu, 9 Aug 2018 11:19:14 +0100
Subject: [RFC PATCH 09/16] KVM: arm64: Allow ID registers to by
 dynamically read-as-zero
In-Reply-To: <CAFEAcA_9JDzj3NSrJcR6fkVm=Cuy71B_te+PUDJgDvV1gkDLSQ@mail.gmail.com>
References: <1529593060-542-1-git-send-email-Dave.Martin@arm.com>
 <1529593060-542-10-git-send-email-Dave.Martin@arm.com>
 <20180806130324.GA5985@e113682-lin.lund.arm.com>
 <20180807110958.GC9097@e103592.cambridge.arm.com>
 <20180807193512.GH5985@e113682-lin.lund.arm.com>
 <20180808091111.GL9097@e103592.cambridge.arm.com>
 <CAFEAcA_9JDzj3NSrJcR6fkVm=Cuy71B_te+PUDJgDvV1gkDLSQ@mail.gmail.com>
Message-ID: <20180809101911.GM9097@e103592.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 08, 2018 at 03:03:31PM +0100, Peter Maydell wrote:
> On 8 August 2018 at 10:11, Dave Martin <Dave.Martin@arm.com> wrote:
> > At its heart, I'm trying to abstract out the special behaviour of
> > all unallocated ID registers, so that we can decide at runtime which
> > ones to hide fro the guest: within the ID register block, each
> > unallocated register becomes RAZ, not UNDEFINED as would be the case
> > for other system registers, so we need to capture both behaviours.
> 
> I think a better way to think of the ID register block is
> that all the registers in it *are* allocated. It's just that
> some of them are specified as RAZ/WI (because no bits in
> them have been given meaning yet). Then you retain the
> straightforward "unallocated == UNDEF". (In the Arm ARM
> the gaps in the ID register block are documented as
> "reserved, RAZ", not "unallocated".)

Sure, I'm not arguing against that.  Your viewpoint does mean that
"enabling"/"disabling" a system register needs to do different things
depending on whether it's an ID register or not: in the latter case,
disabling it makes it unallocated; in the former case it doesn't but
makes the register read as zero.

I think my attempt to conflate the two behaviours was not helpful.

The way the existing code was structured was not helpful for solving
this either, which is one reason I ended up with my approach, but I will
take another look and see if I can some up with something a bit more
sane.

Cheers
---Dave
