From: dave.martin@linaro.org (Dave Martin)
Date: Tue, 29 Nov 2011 10:42:55 +0000
Subject: [RFC PATCH] ARM: Add generic instruction opcode manipulation
 helpers
In-Reply-To: <1322508033.2354.86.camel@computer2>
References: <1322220493-3251-1-git-send-email-dave.martin@linaro.org>
 <CAH+eYFBM36VqYAqZdiZnMP7AODh_SqYQWuoFDSyS3BDZDvHU5A@mail.gmail.com>
 <20111128174122.GG2465@localhost.localdomain>
 <1322508033.2354.86.camel@computer2>
Message-ID: <20111129104255.GA2829@localhost.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 28, 2011 at 07:20:33PM +0000, Tixy wrote:
> On Mon, 2011-11-28 at 17:41 +0000, Dave Martin wrote:
> > On Mon, Nov 28, 2011 at 10:29:14PM +0530, Rabin Vincent wrote:
> > > On Fri, Nov 25, 2011 at 16:58, Dave Martin <dave.martin@linaro.org> wrote:
> > > > +#ifdef CONFIG_CPU_ENDIAN_BE8
> > > > +#define __opcode_to_mem_arm(x) swab32(x)
> > > > +#define __opcode_to_mem_thumb16(x) swab16(x)
> > > > +#define __opcode_to_mem_thumb32(x) swahb32(x)
> > > > +#else
> > > > +#define __opcode_to_mem_arm(x) (x) ((u32)(x))
> > > > +#define __opcode_to_mem_thumb16(x) ((u16)(x))
> > > > +#define __opcode_to_mem_thumb32(x) swahw32(x)
> > > > +#endif
> > > 
> > > The current kprobes code does:
> > > 
> > > #ifndef __ARMEB__ /* Swap halfwords for little-endian */
> > >                 bkp = (bkp >> 16) | (bkp << 16);
> > > #endif
> > > 
> > > There seems to be a difference between your macros and that for the case
> > > __ARMEB__ + !CONFIG_CPU_ENDIAN_BE8.  Or is that combination not
> > > possible?
> > > 
> > 
> > For building the kernel, it is effectively impossible, since you can't
> > have Thumb-2 code on BE32 platforms.  The opcode_to_mem_thumb*()
> > definitions are currently "don't cares" for this configuration in
> > my RFC, but we should probably clarify how things should behave in this
> > case.
> > 
> > The kprobes code does not look correct for the big-endian case, since
> > the bytes are not swapped -- this will result in big-endian words or
> > halfwords in memory, which would be correct for BE32 but not for BE8
> > (where instructions are always little-endian).
> > 
> > So they're both wrong, in different ways if I've understood correctly.
> > 
> > 
> > I'm not exactly sure how we handle BE32, or whether we need to.  I
> > believe that for BE32 it would be correct to leave the canonical
> > instruction completely un-swapped, because instructions are natively
> > big-endian on those platforms.  Note that BE32 is only applicable to
> > older versions of the architecture, and so Thumb-2 is not applicable to
> > any BE32 platform, so the only situation where we would care is if
> > kprobes, ftrace or similar allows breakpoints or tracepoints to be set
> > in userspace Thumb code on these platforms.
> > 
> > I think that __ARMEB__ encompasses any big-endian target including BE8
> > and BE32, so we might need to be a bit careful about how we use it.
> > 
> > 
> > Rabin, did the __opcode_read stuff look useful for ftrace?  My idea
> > was to factor out the logic of how to read/write a whole instruction,
> > but my proposal may be overkill...
> > 
> > 
> > Tixy, do you have a view on these issues?
> 
> I had to read the ARM ARM, I wasn't aware of BE8 :-)

BE8 is "the" big-endianness, at least since about ARMv6.  It's the only
form of big-endianness applicable to any CPU running Thumb-2.

Do you care about being to able to set probes in Thumb user code when
the kernel is not Thumb-2, or do you simply not support that scenario
at all?  (Thinking about, I'm guessing we don't currently support that?)


> My view is that the the current kprobes code just doesn't handle BE8.
> Anywhere where it reads the original instruction, writes a breakpoint or
> restores the instruction would need to swap the byte order. To do that,
> the proposed mem_to_opcode/opcode_to_mem helpers would be useful.
> 
> However, the read/write a whole instruction functions do look a bit
> overkill. Especially if the number of places using these is small, due
> to factorisations like Rabin's __patch_text().

I'm inclined to agree -- it seemed worthwhile to see how possible it was,
but while the idea being abstracted is straightforward enough, trying to
do this kind of thing using the C preprocessor is like trying to build
a stepladder out of custard.

Cheers
---Dave
