From: mark.rutland@arm.com (Mark Rutland)
Date: Thu, 10 Mar 2016 17:00:33 +0000
Subject: [PATCH 1/2] ARM64:VDSO: Improve gettimeofday, don't use udiv
In-Reply-To: <CAKv+Gu90LOYRKWR8svKhqn6T9qQ-A=VB7iP7wM6oz=MyCs7CJA@mail.gmail.com>
References: <1457898620-1867-1-git-send-email-apinski@cavium.com>
 <1457898620-1867-2-git-send-email-apinski@cavium.com>
 <CAKv+Gu90LOYRKWR8svKhqn6T9qQ-A=VB7iP7wM6oz=MyCs7CJA@mail.gmail.com>
Message-ID: <20160310170032.GA11413@svinekod>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 14, 2016 at 07:55:38AM +0100, Ard Biesheuvel wrote:
> On 13 March 2016 at 20:50, Andrew Pinski <apinski@cavium.com> wrote:
> > +        movk    x13, 0xe353, lsl 16
> > +        lsr     x11, x11, 3
> > +        movk    x13, 0x9ba5, lsl 32
> > +        movk    x13, 0x20c4, lsl 48
> > +       /* x13 = 0x20c49ba5e353f7cf */
> 
> Could we clean this up a bit? Something along the lines of
> 
> .set m, 0x20c49ba5e353f7cf
> movz x13,#:abs_g3:m
> movk x13, #:abs:g2_nc:m
> movk x13, #:abs_g1_nc:m
> movk x13, #:abs_g0_nc:m
> 
> Actually, the movz/movk sequence should probably be implemented as a
> macro in asm/assembler.h, with parameters for the register and the
> symbol name.

Agreed.

> I think Mark proposed such a patch at some point

That would be [1], which needs the relocations fixed up [2,3] to match the
above.

I didn't respin that as it turned out to be unnecessary at the time, but I'm
more than happy for someone to pick it up.

Mark.

[1] http://lists.infradead.org/pipermail/linux-arm-kernel/2016-January/397563.html
[2] http://lists.infradead.org/pipermail/linux-arm-kernel/2016-January/397572.html
[3] http://lists.infradead.org/pipermail/linux-arm-kernel/2016-January/397573.html
