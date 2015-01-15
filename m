From: will.deacon@arm.com (Will Deacon)
Date: Thu, 15 Jan 2015 11:36:33 +0000
Subject: [PATCH] arm64: kill off the libgcc dependency
In-Reply-To: <CAKv+Gu9Bp8-GARnuVkA0yehdMVS7X6ONv-OJvxHpAHzZH-LHMQ@mail.gmail.com>
References: <1421231934-31720-1-git-send-email-haokexin@gmail.com>
 <3138622.1rQcFu1jAj@wuerfel> <20150114114827.GH4050@arm.com>
 <2438951.7KFuXx85Hp@wuerfel>
 <CAKv+Gu-E=0Fm7woFSWcdBLfmxB+5diGtO91c2zy-t2M1_NTNeg@mail.gmail.com>
 <20150114133742.GI4050@arm.com>
 <20150115070730.GA23621@pek-khao-d1.corp.ad.wrs.com>
 <20150115095918.GA23475@arm.com>
 <CAKv+Gu9Bp8-GARnuVkA0yehdMVS7X6ONv-OJvxHpAHzZH-LHMQ@mail.gmail.com>
Message-ID: <20150115113633.GH23475@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 15, 2015 at 11:21:25AM +0000, Ard Biesheuvel wrote:
> On 15 January 2015 at 09:59, Will Deacon <will.deacon@arm.com> wrote:
> > On Thu, Jan 15, 2015 at 07:07:30AM +0000, Kevin Hao wrote:
> >> On Wed, Jan 14, 2015 at 01:37:42PM +0000, Will Deacon wrote:
> >> > On Wed, Jan 14, 2015 at 12:52:49PM +0000, Ard Biesheuvel wrote:
> >> > > IMO libgcc.a cannot be used at all in the kernel, as it is not built
> >> > > with -mgeneral-regs-only so we have no guarantee that it will leave
> >> > > the NEON registers alone.
> >> >
> >> > That's a very good point. In which case, we'd need to extend this patch
> >> > to implement the bitops that we currently rely on the __builtins for.
> >>
> >> Sorry, I am not sure I get what you mean. These builtin functions for bitops
> >> are not implemented in the libgcc, they are inlined in compiler. So why do
> >> we need to reimplement these bitops when removing the link with libgcc?
> >
> > I'm just relaying what the tools guys told us. Namely, that they don't
> > guarantee that they are inlined and could generate a branch to a libgcc
> > function. As Ard says, they could also use fpsimd registers, so whether
> > or not they are inlined is moot anyway.
> >
> 
> Which builtins are you referring to, exactly?

Things like __builtin_ctzl used by __ffs in
asm-generic/bitops/builtin-__ffs.h (included by our asm/bitops.h).

> ~/linux-2.6$ git grep __builtin arch/arm64
> arch/arm64/kernel/module.c:
> __builtin_return_address(0));
> arch/arm64/kernel/return_address.c:     frame.fp = (unsigned
> long)__builtin_frame_address(0);
> arch/arm64/kernel/stacktrace.c:         frame.fp = (unsigned
> long)__builtin_frame_address(0);
> arch/arm64/kernel/traps.c:              frame.fp = (unsigned
> long)__builtin_frame_address(0);
> arch/arm64/mm/ioremap.c:
> __builtin_return_address(0));
> arch/arm64/mm/ioremap.c:
> __builtin_return_address(0));
> 
> none of which would ever require library support, as far as I can
> judge, and the arm64 kernel builds fine with -fno-builtin added (i.e.,
> builtins can only be invoked explicitly using their __builtin- alias)
> and libgcc.a removed.

Catalin and I just spoke again with our tools engineers. Whilst they
don't guarantee the inlining, they *wouldn't* inline an implementation
using fpsimd registers into an application compiled with -mgeneral-regs-only
(at least, this would be a compiler bug).

So I've come full circle on this patch and now think it's the right thing
to do :) If, for any reason, a builtin isn't inlined then we will know
about it at link-time and can add our own implementation as and when we
need to. With the current state of mainline, we wouldn't know about the
use of fpsimd registers until silent data corruption started to occur.

For the original patch:

  Acked-by: Will Deacon <will.deacon@arm.com>

Will
