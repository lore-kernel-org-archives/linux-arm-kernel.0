From: will.deacon@arm.com (Will Deacon)
Date: Wed, 15 Jun 2016 10:08:48 +0100
Subject: [PATCH] perf annotate: ARM64 support
In-Reply-To: <1465703902-13237-1-git-send-email-apinski@cavium.com>
References: <1465703902-13237-1-git-send-email-apinski@cavium.com>
Message-ID: <20160615090848.GB24029@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andrew,

[adding acme and Chris]

Thanks for this.

On Sat, Jun 11, 2016 at 08:58:22PM -0700, Andrew Pinski wrote:
> Add basic support to parse ARM64 assembly.
> 
> This:
> 
> * enables perf to correctly show the disassembly, rather than chopping
>   some constants off at the '#'.  '#' is not the comment character
>   for ARM64.
> 
> * allows perf to identify ARM64 instructions that branch to other parts
>   within the same function, thereby properly annotating them.
> 
> * allows perf to identify function calls, allowing called functions to
>   be followed in the annotated view.

It's probably worth working with Chris on this, since he was doing something
similar for AArch32:

  http://lkml.kernel.org/r/20160520094407.GB26584 at arm.com

Chris -- did you get a chance to re-spin that series?

Will

> Signed-off-by: Andrew Pinski <apinski@cavium.com>
> ---
>  tools/perf/util/annotate.c | 64 +++++++++++++++++++++++++++++++++++++++++++---
>  1 file changed, 61 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
> index 7e5a1e8..ea915e8 100644
> --- a/tools/perf/util/annotate.c
> +++ b/tools/perf/util/annotate.c
> @@ -65,7 +65,7 @@ static int call__parse(struct ins_operands *ops)
>  
>  	name++;
>  
> -#ifdef __arm__
> +#if defined(__arm__) || defined(__aarch64__)
>  	if (strchr(name, '+'))
>  		return -1;
>  #endif
> @@ -119,9 +119,22 @@ bool ins__is_call(const struct ins *ins)
>  
>  static int jump__parse(struct ins_operands *ops)
>  {
> -	const char *s = strchr(ops->raw, '+');
> +	const char *raw = ops->raw;
> +	const char *s;
> +#ifdef __aarch64__
> +	/* Skip over one or two commas so that cbz and tbz works. */
> +	const char *comma = strchr(raw, ',');
> +
> +	if (comma) {
> +		raw = comma + 1;
> +		comma = strchr(raw, ',');
> +		if (comma)
> +			raw = comma + 1;
> +	}
> +#endif
> +	s = strchr(raw, '+');
>  
> -	ops->target.addr = strtoull(ops->raw, NULL, 16);
> +	ops->target.addr = strtoull(raw, NULL, 16);
>  
>  	if (s++ != NULL)
>  		ops->target.offset = strtoull(s, NULL, 16);
> @@ -134,6 +147,25 @@ static int jump__parse(struct ins_operands *ops)
>  static int jump__scnprintf(struct ins *ins, char *bf, size_t size,
>  			   struct ins_operands *ops)
>  {
> +#ifdef __aarch64__
> +	const char *comma0 = strchr(ops->raw, ',');
> +
> +	if (comma0) {
> +		const char *comma1 = strchr(comma0 + 1, ',');
> +
> +		if (comma1)
> +			return scnprintf(bf, size,
> +					 "%-6.6s %.*s, %.*s, %" PRIx64,
> +					 ins->name,
> +					 (int)(comma0 - ops->raw), ops->raw,
> +					 (int)(comma1 - comma0 - 1), comma0 + 1,
> +					 ops->target.offset);
> +
> +		return scnprintf(bf, size, "%-6.6s %.*s, %" PRIx64, ins->name,
> +				 (int)(comma0 - ops->raw), ops->raw,
> +				 ops->target.offset);
> +	}
> +#endif
>  	return scnprintf(bf, size, "%-6.6s %" PRIx64, ins->name, ops->target.offset);
>  }
>  
> @@ -253,6 +285,8 @@ static int mov__parse(struct ins_operands *ops)
>  	target = ++s;
>  #ifdef __arm__
>  	comment = strchr(s, ';');
> +#elif defined(__aarch64__)
> +	comment = strstr(s, "//");
>  #else
>  	comment = strchr(s, '#');
>  #endif
> @@ -355,6 +389,29 @@ static struct ins_ops nop_ops = {
>  };
>  
>  static struct ins instructions[] = {
> +#ifdef __aarch64__
> +	{ .name = "b",     .ops  = &jump_ops, }, // might also be a call
> +	{ .name = "b.cc",  .ops  = &jump_ops, },
> +	{ .name = "b.cs",  .ops  = &jump_ops, },
> +	{ .name = "b.eq",  .ops  = &jump_ops, },
> +	{ .name = "b.ge",  .ops  = &jump_ops, },
> +	{ .name = "b.gt",  .ops  = &jump_ops, },
> +	{ .name = "b.hi",  .ops  = &jump_ops, },
> +	{ .name = "b.le",  .ops  = &jump_ops, },
> +	{ .name = "b.ls",  .ops  = &jump_ops, },
> +	{ .name = "b.lt",  .ops  = &jump_ops, },
> +	{ .name = "b.ne",  .ops  = &jump_ops, },
> +	{ .name = "b.pl",  .ops  = &jump_ops, },
> +	{ .name = "bl",    .ops  = &call_ops, },
> +	{ .name = "cbnz",  .ops  = &jump_ops, },
> +	{ .name = "cbz",   .ops  = &jump_ops, },
> +	{ .name = "dec",   .ops  = &dec_ops, },
> +	{ .name = "lock",  .ops  = &lock_ops, }, // fake one
> +	{ .name = "mov",   .ops  = &mov_ops, },
> +	{ .name = "nop",   .ops  = &nop_ops, },
> +	{ .name = "tbnz",  .ops  = &jump_ops, },
> +	{ .name = "tbz",   .ops  = &jump_ops, },
> +#else
>  	{ .name = "add",   .ops  = &mov_ops, },
>  	{ .name = "addl",  .ops  = &mov_ops, },
>  	{ .name = "addq",  .ops  = &mov_ops, },
> @@ -444,6 +501,7 @@ static struct ins instructions[] = {
>  	{ .name = "xadd",  .ops  = &mov_ops, },
>  	{ .name = "xbeginl", .ops  = &jump_ops, },
>  	{ .name = "xbeginq", .ops  = &jump_ops, },
> +#endif
>  };
>  
>  static int ins__key_cmp(const void *name, const void *insp)
> -- 
> 1.9.1
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
