From: dave.martin@linaro.org (Dave Martin)
Date: Tue, 24 May 2011 18:13:31 +0100
Subject: [PATCH] ARM: Do not allow unaligned accesses when
	CONFIG_ALIGNMENT_TRAP
In-Reply-To: <BANLkTi=xLE9gP5YOdr9dR0DfsY1Ymzxu+w@mail.gmail.com>
References: <20110523111648.10474.78396.stgit@e102109-lin.cambridge.arm.com>
	<20110523132124.GI17672@n2100.arm.linux.org.uk>
	<1306229953.19557.14.camel@e102109-lin.cambridge.arm.com>
	<yw1xipt0p4i9.fsf@unicorn.mansr.com>
	<BANLkTi=xLE9gP5YOdr9dR0DfsY1Ymzxu+w@mail.gmail.com>
Message-ID: <20110524171331.GA2941@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 24, 2011 at 04:26:35PM +0100, Catalin Marinas wrote:
> 2011/5/24 M?ns Rullg?rd <mans@mansr.com>:
> > Catalin Marinas <catalin.marinas@arm.com> writes:
> >
> >> On Mon, 2011-05-23 at 14:21 +0100, Russell King - ARM Linux wrote:
> >>> On Mon, May 23, 2011 at 12:16:48PM +0100, Catalin Marinas wrote:
> >>> > Newer versions of gcc generate unaligned accesses by default, causing
> >>> > kernel panics when CONFIG_ALIGNMENT_TRAP is enabled. This patch adds the
> >>> > -mno-unaligned-access option to gcc.
> >>>
> >>> This description doesn't make sense. ?If we have alignment traps enabled,
> >>> then we _expect_ to fix up unaligned loads and stores.
> >>>
> >>> Therefore there should be no panic if CONFIG_ALIGNMENT_TRAP is enabled.
> >>>
> >>> So what's the _actual_ problem that this is trying to address? ?What's
> >>> the panic/oops look like? ?And that information should be in the commit
> >>> description _anyway_.
> >>
> >> Does the patch below look better?
> >>
> >> We cannot move alignment_init() earlier as we don't know how early the
> >> compiler would generate unaligned accesses. An alternative is some
> >> #ifdef's in head.S. Please let me know which variant you prefer.
> >
> > ifdefs may be ugly, but I don't see a better solution here. ?Crippling
> > the entire build to make a couple of lines slightly more aesthetically
> > pleasing doesn't seem right to me.
> 
> BTW, are we sure that the code generated with unaligned accesses is
> better? AFAIK, while processors support unaligned accesses, they may
> not always be optimal.

The code gcc generates to synthesise an unaligned access using aligned
accesses is pretty simplistic:

$ cat <<EOF | gcc -O2 -c unaligned.c && objdump -d unaligned.o
unsigned long readw(void *p)
{
	struct { unsigned long l; } __attribute__ (( __packed__ )) *s = p;

	return s->l;
}
EOF

00000000 <readw>:
   0:   7841            ldrb    r1, [r0, #1]
   2:   7803            ldrb    r3, [r0, #0]
   4:   7882            ldrb    r2, [r0, #2]
   6:   78c0            ldrb    r0, [r0, #3]
   8:   ea43 2301       orr.w   r3, r3, r1, lsl #8
   c:   ea43 4302       orr.w   r3, r3, r2, lsl #16
  10:   ea43 6000       orr.w   r0, r3, r0, lsl #24
  14:   4770            bx      lr
  16:   bf00            nop


For code which natively needs to read unaligned fields from data structures,
I sincerely doubt that the CPU will not beat the above code for efficiency...

So if there's code doing unaligned access to data structures for a good
reason, building with unaligned access support turned on in the compiler
seems a good idea, if that code might performance-critical for anything.


Most code should not be doing unaligned accesses even at the source level
though unless there's a good reason, since on average unaligned accesses
will not be quite as efficient as aligned accesses even if performed
natively by the CPU rather than being synthesised by the compiler.

Where are the observed faults coming from?  Maybe it's the faulting code
that's the problem here, not the compiler...

Cheers
---Dave
