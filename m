From: will.deacon@arm.com (Will Deacon)
Date: Tue, 26 Jun 2018 16:14:27 +0100
Subject: [PATCH 3/3] rseq/selftests: Add support for arm64
In-Reply-To: <501929863.3051.1529950210436.JavaMail.zimbra@efficios.com>
References: <1529949285-11013-1-git-send-email-will.deacon@arm.com>
 <1529949285-11013-4-git-send-email-will.deacon@arm.com>
 <501929863.3051.1529950210436.JavaMail.zimbra@efficios.com>
Message-ID: <20180626151427.GF23375@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mathieu,

On Mon, Jun 25, 2018 at 02:10:10PM -0400, Mathieu Desnoyers wrote:
> ----- On Jun 25, 2018, at 1:54 PM, Will Deacon will.deacon at arm.com wrote:
> > +#define __RSEQ_ASM_DEFINE_TABLE(label, version, flags, start_ip,		\
> > +				post_commit_offset, abort_ip)			\
> > +	"	.pushsection	__rseq_table, \"aw\"\n"				\
> > +	"	.balign	32\n"							\
> > +	__rseq_str(label) ":\n"							\
> > +	"	.long	" __rseq_str(version) ", " __rseq_str(flags) "\n"	\
> > +	"	.quad	" __rseq_str(start_ip) ", "				\
> > +			  __rseq_str(post_commit_offset) ", "			\
> > +			  __rseq_str(abort_ip) "\n"				\
> > +	"	.popsection\n"
> > +
> > +#define RSEQ_ASM_DEFINE_TABLE(label, start_ip, post_commit_ip, abort_ip)	\
> > +	__RSEQ_ASM_DEFINE_TABLE(label, 0x0, 0x0, start_ip,			\
> > +				(post_commit_ip - start_ip), abort_ip)
> > +
> > +#define RSEQ_ASM_STORE_RSEQ_CS(label, cs_label, rseq_cs)			\
> > +	RSEQ_INJECT_ASM(1)							\
> > +	"	adrp	" RSEQ_ASM_TMP_REG ", " __rseq_str(cs_label) "\n"	\
> > +	"	add	" RSEQ_ASM_TMP_REG ", " RSEQ_ASM_TMP_REG		\
> > +			", :lo12:" __rseq_str(cs_label) "\n"			\
> > +	"	str	" RSEQ_ASM_TMP_REG ", %[" __rseq_str(rseq_cs) "]\n"	\
> > +	__rseq_str(label) ":\n"
> > +
> > +#define RSEQ_ASM_DEFINE_ABORT(label, abort_label)				\
> > +	"	.pushsection	__rseq_failure, \"ax\"\n"			\
> > +	"	.long 	"	__rseq_str(RSEQ_SIG) "\n"			\
> > +	__rseq_str(label) ":\n"							\
> > +	"	b	%l[" __rseq_str(abort_label) "]\n"			\
> > +	"	.popsection\n"
> 
> Thanks Will for porting rseq to arm64 !

That's ok, it was good fun :)

I'm going to chat with our compiler guys to see if there's any room for
improving the flexibility in the critical section, since having a temporary
in the clobber list is pretty grotty.

> I notice you are using the instructions
> 
>   adrp
>   add
>   str
> 
> to implement RSEQ_ASM_STORE_RSEQ_CS(). Did you compare
> performance-wise with an approach using a literal pool
> near the instruction pointer like I did on arm32 ?

I didn't, no. Do you have a benchmark to hand so I can give this a go?
The two reasons I didn't go down this route are:

1. It introduces data which is mapped as executable. I don't have a
   specific security concern here, but the way things have gone so far
   this year, I've realised that I'm not bright enough to anticipate
   these things.

2. It introduces a branch over the table on the fast path, which is likely
   to have a relatively higher branch misprediction cost on more advanced
   CPUs.

I also find it grotty that we emit two tables so that debuggers can cope,
but that's just a cosmetic nit.

> With that approach, this ends up being simply
> 
>   adr
>   str
> 
> which provides significantly better performance on my test
> platform over loading a pointer targeting a separate data
> section.

My understanding is that your test platform is based on Cortex-A7, so I'd
be wary about concluding too much about general performance from that CPU
since its a pretty straightforward in-order design.

Will
