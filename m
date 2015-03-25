From: Dave.Martin@arm.com (Dave Martin)
Date: Wed, 25 Mar 2015 10:46:14 +0000
Subject: [PATCH] ARM: force linker to use PIC veneers
In-Reply-To: <CAKv+Gu9NeqOTjUux9S7p5o89T1tc9ACraC0D53Y=CCTNzZXKMg@mail.gmail.com>
References: <1427192184-31261-1-git-send-email-ard.biesheuvel@linaro.org>
 <20150324122239.GB3579@e103592.cambridge.arm.com>
 <CAKv+Gu-MpvAnkEd2L_OPGpDv5cnCZACvzuQ9LbG8O5kjDRQUwQ@mail.gmail.com>
 <20150324135439.GC3579@e103592.cambridge.arm.com>
 <CAKv+Gu9NeqOTjUux9S7p5o89T1tc9ACraC0D53Y=CCTNzZXKMg@mail.gmail.com>
Message-ID: <20150325104603.GA3560@e103592.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 24, 2015 at 06:35:56PM +0100, Ard Biesheuvel wrote:
> On 24 March 2015 at 14:54, Dave Martin <Dave.Martin@arm.com> wrote:
> > On Tue, Mar 24, 2015 at 01:50:40PM +0100, Ard Biesheuvel wrote:

[...]

> >> > On Tue, Mar 24, 2015 at 11:16:24AM +0100, Ard Biesheuvel wrote:
> >> >> When building a very large kernel, it is up to the linker to decide
> >> >> when and where to insert stubs to allow calls to functions that are
> >> >> out of range for the ordinary b/bl instructions.
> >> >>
> >> >> However, since the kernel is built as a position dependent binary,
> >> >> these stubs (aka veneers) may contain absolute addresses, which will
> >> >> break such veneer assisted far calls performed with the MMU off.
> >> >>
> >> >> For instance, the call from __enable_mmu() in the .head.text section
> >> >> to __turn_mmu_on() in the .idmap.text section may be turned into
> >> >> something like this:
> >> >>
> >> >> c0008168 <__enable_mmu>:
> >> >> c0008168:       f020 0002       bic.w   r0, r0, #2
> >> >> c000816c:       f420 5080       bic.w   r0, r0, #4096
> >> >> c0008170:       f000 b846       b.w     c0008200 <____turn_mmu_on_veneer>
> >> >> [...]
> >> >> c0008200 <____turn_mmu_on_veneer>:
> >> >> c0008200:       4778            bx      pc
> >> >> c0008202:       46c0            nop
> >> >> c0008204:       e59fc000        ldr     ip, [pc]
> >> >> c0008208:       e12fff1c        bx      ip
> >> >> c000820c:       c13dfae1        teqgt   sp, r1, ror #21
> >> >> [...]
> >> >> c13dfae0 <__turn_mmu_on>:
> >> >> c13dfae0:       4600            mov     r0, r0
> >> >> [...]
> >> >>
> >> >> After adding --pic-veneer to the LDFLAGS, the veneer is emitted like
> >> >> this instead:
> >> >>
> >> >> c0008200 <____turn_mmu_on_veneer>:
> >> >> c0008200:       4778            bx      pc
> >> >> c0008202:       46c0            nop
> >> >> c0008204:       e59fc004        ldr     ip, [pc, #4]
> >> >> c0008208:       e08fc00c        add     ip, pc, ip
> >> >> c000820c:       e12fff1c        bx      ip
> >> >> c0008210:       013d7d31        teqeq   sp, r1, lsr sp
> >> >> c0008214:       00000000        andeq   r0, r0, r0
> >> >>
> >> >> Note that this particular example is best addressed by moving
> >> >> .head.text and .idmap.text closer together, but this issue could
> >> >> potentially affect any code that needs to execute with the
> >> >> MMU off.
> >> >>
> >> >> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>

[...]

> >> The primary concern is that you can't really check whether any
> >> problematic veneers have been emitted, unless all code that may run
> >> with the MMU off is moved to the idmap.text section.
> >
> > That's a valid argument.
> >
> > Come to think of it, I can't think of a good reason why we don't
> > pass --use-blx to the linker for THUMB2_KERNEL.  I think that would
> > at least make these sequences a bit less painful by getting rid of
> > the "bx pc" stuff.
> >
> 
> Well, passing --use-blx doesn't seem to have the desired effect. I
> still get these
> 
> c0181ba8 <___raw_spin_lock_veneer>:
> c0181ba8:       4778            bx      pc
> c0181baa:       46c0            nop                     ; (mov r8, r8)
> [...]

Hmmm, you seem to be right.

Thumb has no bx <label> instruction, and veneers introduced by ld are
always ARM code, so this looks tricky to avoid without patching ld.

As you observe, this only impacts large kernels anyway.

So,

Reviewed-by: Dave Martin <Dave.Martin@arm.com>

Cheers
---Dave
