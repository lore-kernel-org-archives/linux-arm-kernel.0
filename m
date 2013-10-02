From: will.deacon@arm.com (Will Deacon)
Date: Wed, 2 Oct 2013 11:41:58 +0100
Subject: [PATCH 2/2] ARM: include: asm: use 'int' instead of 'unsigned
 long' for normal register variables within atomic.h
In-Reply-To: <524ABA20.6060106@asianux.com>
References: <20130926100422.GE2855@mudshark.cambridge.arm.com>
 <5244148F.6080405@asianux.com>
 <20130927110618.GB9520@mudshark.cambridge.arm.com>
 <5247A1D1.6080505@asianux.com> <5247A1FA.4030305@asianux.com>
 <5247A3FC.9020508@asianux.com>
 <20130930161149.GI26036@mudshark.cambridge.arm.com>
 <524A2DE7.8040208@asianux.com>
 <20131001090119.GA17629@mudshark.cambridge.arm.com>
 <524ABA20.6060106@asianux.com>
Message-ID: <20131002104158.GD28311@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 01, 2013 at 01:03:44PM +0100, Chen Gang wrote:
> On 10/01/2013 05:01 PM, Will Deacon wrote:
> > On Tue, Oct 01, 2013 at 03:05:27AM +0100, Chen Gang wrote:
> >> OK, thanks. That means: "arm means arm 32-bit, arm64 means arm 64-bit.
> >> The current Linux kernel main line does not support arm 16-bit".
> >>
> >> Since "bringing our atomic_t ... with the atomic_t type definition", can
> >> we use 'atomic_t" instead of 'unsigned long'?
> >>
> >> And can we use 'atomic64_t" instead of 'unsigned long' in atomic64_*()?
> > 
> > That's probably a bit dodgy, since they are typedefs to compound types
> > which, if ever extended, would fall to bits if we tried to pack them into a
> > single register.
> > 
> 
> Excuse me, my English is not quite well, I guess your meaning is: "in
> 'atomic.h', for arm/arm64, let register variables type equal to related
> atomic type: use 64-bit type if 'atomic64_t', 32-bit type if 'atomic_t'.

Sorry, I think I've confused you. This should be a simple change:

  On ARM:

  - The atomic_t typedef is a struct containing an int.
  - The atomic64_t typedef is a struct containing a long long.

  On arm64:

  - The atomic_t typedef is a struct containing an int.
  - The atomic64_t typedef is a struct containing a long.

Now, your first patch made the handling of atomic64_t on ARM use long long
instead of u64. That's good, because it fixes a signedness bug.

The second patch is just a clean-up, because our atomic_* functions on ARM
interchangeably use int and unsigned long when working with atomic_t types.
This can be tidied up by using int whenever we are reading or writing an
atomic_t, thus matching the type definition for that structure member.

So, for example, atomic_add does not need changing because it always uses
int to hold the atomic_t variable (the unsigned long holds the status
returned from the strex instruction). atomic_cmpxchg, however, loads the
atomic_t into oldval, so that should be int.

Given that this patch doesn't gain us anything in terms of functionality,
feel free to ignore it and I can take a look when there's a rainy day (which
should be real soon now). I also need to take a closer look at
atomic_clear_mask for arm64, because it looks broken to me.

Will
