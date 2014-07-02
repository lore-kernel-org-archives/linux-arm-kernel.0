From: Nathan_Lynch@mentor.com (Nathan Lynch)
Date: Wed, 2 Jul 2014 11:18:59 -0500
Subject: [PATCH v7 8/9] ARM: vdso initialization, mapping,
 and synchronization
In-Reply-To: <CALCETrUVa-Yt7qZpzkpiAGVf+sYeasNq_YS1MuH6CFfWCcW6BA@mail.gmail.com>
References: <1403493118-7597-1-git-send-email-nathan_lynch@mentor.com>
 <1403493118-7597-9-git-send-email-nathan_lynch@mentor.com>
 <53B1D8AC.7060104@mit.edu> <20140701090309.GC28164@arm.com>
 <53B2C178.30607@mentor.com> <20140701141541.GP28164@arm.com>
 <CALCETrWeTeeuz4vW6wrhtDrdg54O-hhFbspfKEEunRZ0zf7ZBg@mail.gmail.com>
 <20140702144050.GD24879@arm.com>
 <CALCETrUVa-Yt7qZpzkpiAGVf+sYeasNq_YS1MuH6CFfWCcW6BA@mail.gmail.com>
Message-ID: <53B430F3.9070804@mentor.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/02/2014 10:54 AM, Andy Lutomirski wrote:
> Caveat 2: (major) I'm kind of surprised that this, or the current
> code, works reliably.  You're doing something that I tried briefly for
> x86_64:
> 
>         _end = .;
>         PROVIDE(end = .);
> 
>         . = ALIGN(PAGE_SIZE);
>         PROVIDE(_vdso_data = .);
> 
> This sounds great, except that you're assuming that vdso_end -
> vdso_start == ALIGN(_end, PAGE_SIZE) - (vdso base address).
> 
> If you *fully* strip the vdso (eu-strip --strip-sections), then this
> is true: eu-strip --strip-sections outputs just the PT_LOAD piece of
> the vdso.  But any binutils-generated incompletely stripped ELF image
> contains a section table and possible non-allocatable sections at the
> end.  If these exceed the amount of unused space in the last PT_LOAD
> page, then they'll spill into the next page, and _vdso_data in the
> vdso will no longer match the address at which vdso.c loads it.  Boom!
> 
> I bet you're getting away with this because the whole arm64 vdso seems
> to be written in assembly, so it seems extremely unlikely to exceed
> one page minus a few hundred bytes.  But if you start adding
> complexity, you might get unlucky.

This is why I switched (in v5) the proposed 32-bit ARM VDSO to place the
data page before the code -- adding -frecord-gcc-switches to the
compiler flags was enough to break it.

I meant to call Will's attention to it at the time for arm64's sake, but
I guess it slipped my mind... sorry.
