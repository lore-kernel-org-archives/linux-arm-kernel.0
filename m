From: will.deacon@arm.com (Will Deacon)
Date: Fri, 27 Sep 2013 12:06:19 +0100
Subject: [PATCH v2] ARM: include: asm: use 'long long' instead of 'u64'
 within atomic.h
In-Reply-To: <5244148F.6080405@asianux.com>
References: <523D7DC7.8030603@asianux.com>
 <20130924093041.GB15119@mudshark.cambridge.arm.com>
 <5242498F.8060407@asianux.com>
 <20130925160746.GC14502@mudshark.cambridge.arm.com>
 <5243953E.6010405@asianux.com>
 <20130926100422.GE2855@mudshark.cambridge.arm.com>
 <5244148F.6080405@asianux.com>
Message-ID: <20130927110618.GB9520@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 26, 2013 at 12:03:43PM +0100, Chen Gang wrote:
> On 09/26/2013 06:04 PM, Will Deacon wrote:
> > On Thu, Sep 26, 2013 at 03:00:30AM +0100, Chen Gang wrote:
> >> On 09/26/2013 12:07 AM, Will Deacon wrote:
> >>> On Wed, Sep 25, 2013 at 03:25:19AM +0100, Chen Gang wrote:
> >>>> atomic* value is signed value, and atomic* functions need also process
> >>>> signed value (parameter value, and return value), so 32-bit arm need
> >>>> use 'long long' instead of 'u64'.
> >>>>
> >>>> After replacement, it will also fix a bug for atomic64_add_negative():
> >>>> "u64 is never less than 0".
> >>>>
> >>>> The modifications are:
> >>>>
> >>>>   in vim, use "1,% s/\<u64\>/long long/g" command.
> >>>>   remove '__aligned(8)' which is useless for 64-bit.
> >>>>   be sure of 80 column limitation after replacement.
> >>>>
> >>>>
> >>>> Signed-off-by: Chen Gang <gang.chen@asianux.com>
> >>>
> >>> Looks better to me, thanks. While you're here, we could also replace the use
> >>> of `unsigned long' with `int' for the 32-bit atomics, then the whole header
> >>> is consistent with the generic types.
> >>>
> >>> Will
> >>>
> >>>
> >>
> >> Hmm... at least, it seems we can let "use 'int' for 32-bit atomics" in
> >> another patch.
> > 
> > Sure, it can be a follow-up to this one.
> > 
> 
> OK, if it is really a useful patch too, I will follow-up.

It's a cosmetic change to bring the signedness of our 32-bit atomics in-line
with your proposal for 64-bit atomics.

> 'unsigned long' can be used as a register related variable, it is always
> 32-bit under 32-bit machine, and always 64-bit under 64-bit machine.

Not necessarily (c.f. ILP32).

> So can use it for both arm and arm64, for arm, it can not cause issue,
> and for arm64, it is also OK (if changed to 'int' under arm64, may cause
> real issue).

arm and arm64 have different instructions sets. There's no way the inline
assembly used to implement the atomic operations can be made portable
between them.

Will
