From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 26 Jul 2016 18:54:47 +0100
Subject: [PATCH v15 04/10] arm64: Kprobes with single stepping support
In-Reply-To: <ce78f577-d14a-7b12-c96f-a6ebd8866283@linaro.org>
References: <1467995754-32508-1-git-send-email-dave.long@linaro.org>
 <1467995754-32508-5-git-send-email-dave.long@linaro.org>
 <578FA238.3050206@arm.com> <5790F960.5050007@linaro.org>
 <57910528.7070902@arm.com> <57911590.50305@linaro.org>
 <20160722101617.GA17821@e104818-lin.cambridge.arm.com>
 <57924104.1080202@linaro.org>
 <20160725171350.GE2423@e104818-lin.cambridge.arm.com>
 <ce78f577-d14a-7b12-c96f-a6ebd8866283@linaro.org>
Message-ID: <20160726175447.GA28376@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 26, 2016 at 10:50:08AM +0100, Daniel Thompson wrote:
> On 25/07/16 18:13, Catalin Marinas wrote:
> >You get more unexpected side effects by not saving/restoring the whole
> >stack. We looked into this on Friday and came to the conclusion that
> >there is no safe way for kprobes to know which arguments passed on the
> >stack should be preserved, at least not with the current API.
> >
> >Basically the AArch64 PCS states that for arguments passed on the stack
> >(e.g. they can't fit in registers), the caller allocates memory for them
> >(on its own stack) and passes the pointer to the callee. Unfortunately,
> >the frame pointer seems to be decremented correspondingly to cover the
> >arguments, so we don't really have a way to tell how much to copy.
> >Copying just the caller's stack frame isn't safe either since a
> >callee/caller receiving such argument on the stack may passed it down to
> >a callee without copying (I couldn't find anything in the PCS stating
> >that this isn't allowed).
> 
> The PCS[1] seems (at least to me) to be pretty clear that "the
> address of the first stacked argument is defined to be the initial
> value of SP".
> 
> I think it is only the return value (when stacked via the x8
> pointer) that can be passed through an intermediate function in the
> way described above. Isn't it OK for a jprobe to clobber this
> memory? The underlying function will overwrite whatever the jprobe
> put there anyway.
> 
> Am I overlooking some additional detail in the PCS?

I suspect that the "initial value of SP" is simply meant to be relative to the
base of the region of stack reserved for callee parameters. While it also uses
the phrase "current stack-pointer value", I suspect that this is overly
prescriptive.

In practice, GCC allocates callee parameters *above* the frame record
for the caller, which is above the SP and FP. e.g. with:

----
#define NLARGE 128

struct large {
	unsigned long v[NLARGE];
};

unsigned long __attribute__ ((noinline)) large_func(const struct large l)
{
	return l.v[0];
}

int main(int argc, char *argv[])
{
	struct large l = {
		.v = { 1, },
	};
	return large_func(l);
}
----

Which yields the following assembly:

----
00000000004005d0 <large_func>:
  4005d0:       f81f0ff3        str     x19, [sp,#-16]!
  4005d4:       aa0003f3        mov     x19, x0
  4005d8:       f9400260        ldr     x0, [x19]
  4005dc:       f84107f3        ldr     x19, [sp],#16
  4005e0:       d65f03c0        ret

00000000004005e4 <main>:
  4005e4:       d12043ff        sub     sp, sp, #0x810
  4005e8:       a9bf7bfd        stp     x29, x30, [sp,#-16]!
  4005ec:       910003fd        mov     x29, sp
  4005f0:       b9041fa0        str     w0, [x29,#1052]
  4005f4:       f9020ba1        str     x1, [x29,#1040]
  4005f8:       911083a0        add     x0, x29, #0x420
  4005fc:       d2808001        mov     x1, #0x400                      // #1024
  400600:       aa0103e2        mov     x2, x1
  400604:       52800001        mov     w1, #0x0                        // #0
  400608:       97ffff92        bl      400450 <memset@plt>
  40060c:       d2800020        mov     x0, #0x1                        // #1
  400610:       f90213a0        str     x0, [x29,#1056]
  400614:       910043a0        add     x0, x29, #0x10
  400618:       911083a1        add     x1, x29, #0x420
  40061c:       d2808002        mov     x2, #0x400                      // #1024
  400620:       97ffff84        bl      400430 <memcpy@plt>
  400624:       910043a0        add     x0, x29, #0x10
  400628:       97ffffea        bl      4005d0 <large_func>
  40062c:       a8c17bfd        ldp     x29, x30, [sp],#16
  400630:       912043ff        add     sp, sp, #0x810
  400634:       d65f03c0        ret
----

Please ignore the redundant copy GCC generates and copies; I can't seem
to convince it to not do that. The important part is that at 400614 the
argument to the function is the address immediately above the frame
record for main.

In local testing, it seems that additional locals can appear between the
frame record and argument.

Given this, callees can't rely on any relationship between their initial sp and
stacked arguments. Given that, I see no reason why an intermediary could not
simply pass the pointer on while creating further intermediary stack frames.

Thanks,
Mark.
