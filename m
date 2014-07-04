From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 4 Jul 2014 10:34:02 +0100
Subject: Android and compatibility with deprecated armv7 instructions
In-Reply-To: <yw1x8uo9eax9.fsf@unicorn.mansr.com>
References: <20140703104135.GA28175@arm.com>
 <CACxGe6vmNamkAzvL8c5qaVEh9kvmTa=gEyr8KgBS1PW+KFc_=Q@mail.gmail.com>
 <20140703170558.GZ32514@n2100.arm.linux.org.uk>
 <20140703173226.GC17372@arm.com> <yw1xoax6dr67.fsf@unicorn.mansr.com>
 <20140703224753.GB21766@n2100.arm.linux.org.uk>
 <CAKv+Gu-taih4ZdWkmup5JVSeWhcYbatzoHqra+=+bdZorTBCvg@mail.gmail.com>
 <20140704082437.GA16404@arm.com>
 <CAKv+Gu9id59J-DP9tPLGXxsz5yFdfpCmypgRbtuccVUWLQSsdg@mail.gmail.com>
 <yw1x8uo9eax9.fsf@unicorn.mansr.com>
Message-ID: <20140704093401.GD21766@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 04, 2014 at 10:21:54AM +0100, M?ns Rullg?rd wrote:
> Ard Biesheuvel <ard.biesheuvel@linaro.org> writes:
> >>> foo:
> >>> @ args = 0, pretend = 0, frame = 0
> >>> @ frame_needed = 0, uses_anonymous_args = 0
> >>> @ link register save eliminated.
> >>>     mov ip, r0
> >>>     ldmia r1, {r0, r1, r2, r3}
> >>>     stmia ip, {r0, r1, r2, r3}
> >>>     bx lr
> >>>
> >>> won't it take just a single cast from some unaligned char* to struct
> >>> bar* to trigger this?
> >>
> >> Is this even allowed by the C ABI?
> 
> No.

Sort of.  It isn't that legal, but we /do/ have bits of kernel code
(particularly networking) which /do/ make use of this.  Whether it's
legal or not really doesn't come into it.

It falls into the same class as the additional padding of structures
which caused soo much pain in the early days, where many people used
structures to define the layout of data passed between different
systems, expecting (eg) a three char struct to have a size of 3 rather
than 4.

The general rule for "portable" userspace has traditionally been "if it
works on x86, then the code is correct."  Unfortunately, you can do lots
of things on x86 which aren't legal C.

> > The point is not whether the C ABI allows it, the point is whether
> > a) the current 32-bit ARM kernel allows it, and
> 
> Unfortunately, it does.  In my opinion, adding the unaligned emulation
> code was a mistake, and turning it on by default was a bigger mistake.

Different people have differing opinions, and the decision was made
more than 14 years ago.  Hindsight is also a wonderful tool that we
could all use, but the problem is that's non-causal, so unless you
have a tardis or a time machine...

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
