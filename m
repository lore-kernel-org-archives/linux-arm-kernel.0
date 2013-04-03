From: tixy@linaro.org (Jon Medhurst (Tixy))
Date: Wed, 03 Apr 2013 10:11:52 +0100
Subject: [PATCH] ARM: kprobes: fix test coverage missing failures
In-Reply-To: <CA+KhAHaguOmS+iq3URLg2WAROD37cGqni1NC8xbsucKYRf6Mrg@mail.gmail.com>
References: <1364871884-28252-1-git-send-email-kpark3469@gmail.com>
 <1364912353.3650.91.camel@linaro1.home>
 <CA+KhAHaguOmS+iq3URLg2WAROD37cGqni1NC8xbsucKYRf6Mrg@mail.gmail.com>
Message-ID: <1364980312.3561.7.camel@linaro1.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2013-04-03 at 11:00 +0900, Keun-O Park wrote:
> On Tue, Apr 2, 2013 at 11:19 PM, Jon Medhurst (Tixy) <tixy@linaro.org> wrote:
> > On Tue, 2013-04-02 at 12:04 +0900, kpark3469 at gmail.com wrote:
> >> From: Sahara <keun-o.park@windriver.com>
> >>
> >> If kprobe tests run on ARMv6k or ARMv6, there're a number of test
> >> coverage missing failures like:
> >
> > The tests only fail (return an error code) for the coverage tests when
> > compiled for ARMv7 because, obviously, that's the only architecture that
> > can cover all the combinations of instructions. Perhaps we should just
> > disabled the coverage tests pre-ARMv7 kernels to avoid the noisy output
> > you see.
> >
> > I think the best way to look at it is that the coverage tests are test
> > code for the test code, and should only be of concern to people updating
> > the test code.
> >
> > If we go down the route that this patch follows of conditional
> > compilation then we are making the main kernel code more messy in order
> > to support test code and I'm not sure that is a good idea. It will be
> > much worse should someone want to do the same for ARMv5.
> >
> > There is also the problem that once you #ifdef things for ARMv6 then you
> > need an ARMv6 system to test that combination of data structures,
> > whereas at the moment an ARMv7 board will cover everything.
> >
> > --
> > Tixy
> 
> Hi Jon,
> I see. You're worried about the main kernel code being tainted by adding more
> test code for test. To keep the clean decode table without #ifdef,
> most modified codes in
> arch/arm/kernel/kprobes-arm.c may be removed. architectures without
> But, in order to keep consistency supporting 'nop', I think at least we still
> need to add patches for 'nop' in arch/arm/kernel/kprobes-test.c and
> kprobes-test.h.
> It doesn't look good 'nop' is used by default like TEST_INSTRUCTION()
> while TEST('nop') is
> excluded in kprobe_arm_test_cases.

I hate to sound overly awkward, but I'm not sure I agree with this
either :-) When building for architectures without a proper NOP
instructions the assembler will treat it as a pseudo-instruction
equivalent to MOV R0,R0 in ARM code and MOV R8,R8 in Thumb code. So it
doesn't seem worth adding an explicit macro to do this if the assembler
already does it anyway.

-- 
Tixy
