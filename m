From: rostedt@goodmis.org (Steven Rostedt)
Date: Mon, 10 Dec 2012 09:02:48 -0500
Subject: [PATCH] ARM: ftrace: Ensure code modifications are synchronised
 across all cpus
In-Reply-To: <20121210112408.GC6988@mudshark.cambridge.arm.com>
References: <1354892111.13000.50.camel@linaro1.home>
 <1354894134.17101.44.camel@gandalf.local.home>
 <20121207162346.GW14363@n2100.arm.linux.org.uk>
 <1354898200.17101.50.camel@gandalf.local.home>
 <20121207164530.GX14363@n2100.arm.linux.org.uk>
 <1354900436.17101.58.camel@gandalf.local.home>
 <20121207181309.GY14363@n2100.arm.linux.org.uk>
 <1354905805.17101.86.camel@gandalf.local.home>
 <20121207190244.GB29618@mudshark.cambridge.arm.com>
 <1355137445.3386.7.camel@linaro1.home>
 <20121210112408.GC6988@mudshark.cambridge.arm.com>
Message-ID: <1355148168.17101.165.camel@gandalf.local.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2012-12-10 at 11:24 +0000, Will Deacon wrote:
> On Mon, Dec 10, 2012 at 11:04:05AM +0000, Jon Medhurst (Tixy) wrote:
> > On Fri, 2012-12-07 at 19:02 +0000, Will Deacon wrote:
> > > For ARMv7, there are small subsets of instructions for ARM and Thumb which
> > > are guaranteed to be atomic wrt concurrent modification and execution of
> > > the instruction stream between different processors:
> > > 
> > > Thumb:	The 16-bit encodings of the B, NOP, BKPT, and SVC instructions.
> > > ARM:	The B, BL, NOP, BKPT, SVC, HVC, and SMC instructions.
> > > 
> > 
> > So this means for things like kprobes which can modify arbitrary kernel
> > code we are going to need to continue to always use some form of
> > stop_the_whole_system() function?
> > 
> > Also, kprobes currently uses patch_text() which only uses stop_machine
> > for Thumb2 instructions which straddle a word boundary, so this needs
> > changing?
> 
> Yes; if you're modifying instructions other than those mentioned above, then
> you'll need to synchronise the CPUs, update the instructions, perform
> cache-maintenance on the writing CPU and then execute an isb on the
> executing core (this last bit isn't needed if you're going to go through an
> exception return to get back to the new code -- depends on how your
> stop/resume code works).

Yeah, kprobe optimizing will probably require stop_machine() always, as
it's modifying random code, or adding breakpoints into random places.
That's another adventure to deal with at another time.

> 
> For ftrace we can (hopefully) avoid a lot of this when we have known points
> of modification.

I'm also thinking about tracepoints which behave almost the same as
ftrace. They have nop place holders too. They happen to be 32bits too,
but may only need to be 16 bit. The way tracepoints work is with the use
of asm goto. For example we have:

arch/arm/include/asm/jump_label.h

#ifdef CONFIG_THUMB2_KERNEL
#define JUMP_LABEL_NOP	"nop.w"
#else
#define JUMP_LABEL_NOP	"nop"
#endif

static __always_inline bool arch_static_branch(struct static_key *key)
{
	asm goto("1:\n\t"
		 JUMP_LABEL_NOP "\n\t"
		 ".pushsection __jump_table,  \"aw\"\n\t"
		 ".word 1b, %l[l_yes], %c0\n\t"
		 ".popsection\n\t"
		 : :  "i" (key) :  : l_yes);

	return false;
l_yes:
	return true;
}

Tracepoints use the jump-label "static branch" logic, which uses a gcc
4.6 feature called asm goto. The asm goto allows the internal asm to
reference a label outside the asm stamement and the compiler is aware
that the asm statement may jump to that label. Thus the compiler treats
that asm statement as a possible branch to the given label and it wont
optimize required statements after the asm, if they are needed for the
jump to the label.

Now in include/linux/tracepoint.h we have:

	static inline void trace_##name(proto)				\
	{								\
		if (static_key_false(&__tracepoint_##name.key))		\
			__DO_TRACE(&__tracepoint_##name,		\
				TP_PROTO(data_proto),			\
				TP_ARGS(data_args),			\
				TP_CONDITION(cond),,);			\
	}								\

Where the static_key_false() is an "unlikely" version of the
static_branch() that tells gcc the result of the if statement goes into
the unlikely location (end of function perhaps).

But this doesn't guarantee that it becomes part of some if statement, so
this doesn't have all the limitations that ftrace mcount call has.

-- Steve
