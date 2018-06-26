From: mathieu.desnoyers@efficios.com (Mathieu Desnoyers)
Date: Tue, 26 Jun 2018 12:11:52 -0400 (EDT)
Subject: [PATCH 3/3] rseq/selftests: Add support for arm64
In-Reply-To: <20180626151427.GF23375@arm.com>
References: <1529949285-11013-1-git-send-email-will.deacon@arm.com>
 <1529949285-11013-4-git-send-email-will.deacon@arm.com>
 <501929863.3051.1529950210436.JavaMail.zimbra@efficios.com>
 <20180626151427.GF23375@arm.com>
Message-ID: <1763491947.3520.1530029512923.JavaMail.zimbra@efficios.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



----- On Jun 26, 2018, at 11:14 AM, Will Deacon will.deacon at arm.com wrote:

> Hi Mathieu,
> 
> On Mon, Jun 25, 2018 at 02:10:10PM -0400, Mathieu Desnoyers wrote:
>> ----- On Jun 25, 2018, at 1:54 PM, Will Deacon will.deacon at arm.com wrote:
>> > +#define __RSEQ_ASM_DEFINE_TABLE(label, version, flags, start_ip,		\
>> > +				post_commit_offset, abort_ip)			\
>> > +	"	.pushsection	__rseq_table, \"aw\"\n"				\
>> > +	"	.balign	32\n"							\
>> > +	__rseq_str(label) ":\n"							\
>> > +	"	.long	" __rseq_str(version) ", " __rseq_str(flags) "\n"	\
>> > +	"	.quad	" __rseq_str(start_ip) ", "				\
>> > +			  __rseq_str(post_commit_offset) ", "			\
>> > +			  __rseq_str(abort_ip) "\n"				\
>> > +	"	.popsection\n"
>> > +
>> > +#define RSEQ_ASM_DEFINE_TABLE(label, start_ip, post_commit_ip, abort_ip)	\
>> > +	__RSEQ_ASM_DEFINE_TABLE(label, 0x0, 0x0, start_ip,			\
>> > +				(post_commit_ip - start_ip), abort_ip)
>> > +
>> > +#define RSEQ_ASM_STORE_RSEQ_CS(label, cs_label, rseq_cs)			\
>> > +	RSEQ_INJECT_ASM(1)							\
>> > +	"	adrp	" RSEQ_ASM_TMP_REG ", " __rseq_str(cs_label) "\n"	\
>> > +	"	add	" RSEQ_ASM_TMP_REG ", " RSEQ_ASM_TMP_REG		\
>> > +			", :lo12:" __rseq_str(cs_label) "\n"			\
>> > +	"	str	" RSEQ_ASM_TMP_REG ", %[" __rseq_str(rseq_cs) "]\n"	\
>> > +	__rseq_str(label) ":\n"
>> > +
>> > +#define RSEQ_ASM_DEFINE_ABORT(label, abort_label)				\
>> > +	"	.pushsection	__rseq_failure, \"ax\"\n"			\
>> > +	"	.long 	"	__rseq_str(RSEQ_SIG) "\n"			\
>> > +	__rseq_str(label) ":\n"							\
>> > +	"	b	%l[" __rseq_str(abort_label) "]\n"			\
>> > +	"	.popsection\n"
>> 
>> Thanks Will for porting rseq to arm64 !
> 
> That's ok, it was good fun :)
> 
> I'm going to chat with our compiler guys to see if there's any room for
> improving the flexibility in the critical section, since having a temporary
> in the clobber list is pretty grotty.

Let me know how it goes!

> 
>> I notice you are using the instructions
>> 
>>   adrp
>>   add
>>   str
>> 
>> to implement RSEQ_ASM_STORE_RSEQ_CS(). Did you compare
>> performance-wise with an approach using a literal pool
>> near the instruction pointer like I did on arm32 ?
> 
> I didn't, no. Do you have a benchmark to hand so I can give this a go?

see tools/testing/selftests/rseq/param_test_benchmark --help

It's a stripped-down version of param_test, without all the code for
delay loops and testing checks.

Example use for counter increment with 4 threads, doing 5G counter
increments per thread:

time ./param_test_benchmark -T i -t 4 -r 5000000000

> The two reasons I didn't go down this route are:
> 
> 1. It introduces data which is mapped as executable. I don't have a
>   specific security concern here, but the way things have gone so far
>   this year, I've realised that I'm not bright enough to anticipate
>   these things.

So far I've been able to dig up that "pure code" or "execute only" code
is explicitly requested by compiler flags (-mno-pc-relative-literal-loads
on aarch64, -mpure-code on arm32 when the moon cycle is aligned). It's a
shame that it's not more standard, or that there does not appear to be any
preprocessor define available to test this within code.

I'm all for allowing end users to chose whether they want to use literal
pools in code or not, but I think it should be configurable at compile
time, and we should make it similar on arm32 and arm64. Given that compilers
don't emit preprocessor define, perhaps we need to introduce our own
RSEQ_NO_PC_RELATIVE_LITERAL_LOADS (or perhaps a shorter name ?) define to
select behavior at compile-time.

> 2. It introduces a branch over the table on the fast path, which is likely
>   to have a relatively higher branch misprediction cost on more advanced
>   CPUs.

Hrm, wait a second... I see that your comparison of the cpu number requires:

+#define RSEQ_ASM_OP_CMPEQ32(var, expect, label)                                        \
+        "        ldr        " RSEQ_ASM_TMP_REG32 ", %[" __rseq_str(var) "]\n"        \
+        "        sub        " RSEQ_ASM_TMP_REG32 ", " RSEQ_ASM_TMP_REG32                \
+                        ", %w[" __rseq_str(expect) "]\n"                        \
+        "        cbnz        " RSEQ_ASM_TMP_REG32 ", " __rseq_str(label) "\n"

because the abort code is emitted in a separate section:

+#define RSEQ_ASM_DEFINE_ABORT(label, abort_label)                                \
+        "        .pushsection        __rseq_failure, \"ax\"\n"                        \
+        "        .long         "        __rseq_str(RSEQ_SIG) "\n"                        \
+        __rseq_str(label) ":\n"                                                        \
+        "        b        %l[" __rseq_str(abort_label) "]\n"                        \
+        "        .popsection\n"

Like I did on x86. But the cbnz instruction requires the branch target to be
within +/- 1MB from the instruction (http://infocenter.arm.com/help/index.jsp?topic=/com.arm.doc.den0024a/ch06s04.html),
which clearly is not guaranteed when you place the abort label in a separate
section.

Also, using cbnz to jump to a label that is outside of the assembly
(e.g. %l[error1]) does not ensure that the branch target is within
1MB of the code.

I've had assembler issues on arm32 due to those kind of constraints
when integrating rseq headers into larger code-bases.

So, one way to fix the fast-path so cpu number comparison can branch
to a close location is to put the abort code near the fast-path, and
you end up having to unconditionally jump over the abort code from
the fast-path on success. So once you bite the bullet and jump over
abort, you just have to ensure you place the struct rseq_cs data
near the abort code, so you end up jumping over both at the same time.

> 
> I also find it grotty that we emit two tables so that debuggers can cope,
> but that's just a cosmetic nit.
> 
>> With that approach, this ends up being simply
>> 
>>   adr
>>   str
>> 
>> which provides significantly better performance on my test
>> platform over loading a pointer targeting a separate data
>> section.
> 
> My understanding is that your test platform is based on Cortex-A7, so I'd
> be wary about concluding too much about general performance from that CPU
> since its a pretty straightforward in-order design.

I did benchmarks on our Wandboard (Cortex A9) as well as the Cubietruck. I
could only use perf to do detailed breakdown of the fast-path overhead on
the Cubie because I could not get it to work on our Wandboard, but overall
speed was better on Wandboard as well (as I recall) with the literal pool.

Thanks,

Mathieu


-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
