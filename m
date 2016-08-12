From: mark.rutland@arm.com (Mark Rutland)
Date: Fri, 12 Aug 2016 12:41:11 +0100
Subject: [RFC] arm64: Enforce gettimeofday vdso structure read ordering
In-Reply-To: <8375bf253e2f9034e5c5943e68876935@codeaurora.org>
References: <20160811153744.3212-1-cov@codeaurora.org>
 <20160811155409.GE8232@arm.com>
 <8375bf253e2f9034e5c5943e68876935@codeaurora.org>
Message-ID: <20160812114111.GA21484@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, Aug 11, 2016 at 03:39:11PM -0400, bdegraaf at codeaurora.org wrote:
> Sorry, this is my first go at proper email etiquette. I think I've
> got it now.

Please just reply inline, with the previous email '>' prefixed, as with
this reply. Most mail clients do this for plain text email, and there
are plenty of examples in the archive.

This style makes it clear who said what, even when arbitrary liens (of
unnecessary context) are removed.

> ------------------------------------------------------------------------------
> "Can you explain the problem that you're fixing here, please?"
> ------------------------------------------------------------------------------
> Since your question included only the vdso_data structure itself and the
> vdso.c file changes, I'm assuming that's what you meant by "here."
> I moved tb_seq_count to the start of the vdso_data structure because
> of the
> nature of the ldar/strl instructions, which do not support offsets.
> This avoided the extra math to locate the structure offset, while at
> the same
> time using the same base pointer for the structure.  ia64 does something
> similar and also puts this as the first field.  I moved the use_syscall
> field up next to it just to keep most elements aligned according to
> their
> width. That "use_syscall" is the first element used in the logic was an
> additional reason I decided to move that one in particular.

This explains what has *changed*, but not *why*.

The title of this commit implies that this is enforcing something that
wasn't previously enforced. That makes is sound like a bug fix of some
sort, yet the bug is not described.

Is this a bug fix? If so, can you describe what goes wrong with the
current code?

Or is this an optimisation? Or a rework for other reasons?

> --- a/arch/arm64/include/asm/vdso_datapage.h
> +++ b/arch/arm64/include/asm/vdso_datapage.h
> @@ -21,6 +21,8 @@
>  #ifndef __ASSEMBLY__
> 
>  struct vdso_data {
> +    __u32 tb_seq_count;    /* Timebase sequence counter */
> +    __u32 use_syscall;
>      __u64 cs_cycle_last;    /* Timebase at clocksource init */
>      __u64 raw_time_sec;    /* Raw time */
>      __u64 raw_time_nsec;
> @@ -30,14 +32,12 @@ struct vdso_data {
>      __u64 xtime_coarse_nsec;
>      __u64 wtm_clock_sec;    /* Wall to monotonic time */
>      __u64 wtm_clock_nsec;
> -    __u32 tb_seq_count;    /* Timebase sequence counter */
>      /* cs_* members must be adjacent and in this order (ldp
> accesses) */
>      __u32 cs_mono_mult;    /* NTP-adjusted clocksource multiplier */
>      __u32 cs_shift;        /* Clocksource shift (mono = raw) */
>      __u32 cs_raw_mult;    /* Raw clocksource multiplier */
>      __u32 tz_minuteswest;    /* Whacky timezone stuff */
>      __u32 tz_dsttime;
> -    __u32 use_syscall;
>  };
> 
> ----------------------------------------------------------------------------
> As to vdso.c, I changed the instructions used to access tb_seq_count
> (both
> in vdso.c and the gettimeofday.S file) to the load-acquire/store-release
> instructions because those instructions seem to be designed for this
> particular scenario: their "one-way" barriers enforce the order we need,
> on top of eliminating the explicit barriers.
> ----------------------------------------------------------------------------

As Will pointed out, the use of acquire/release one-way barriers doesn't
provide the guarantee you need. Two half barriers do not always combine
to form a full barrier.

For example, see commit 8e86f0b409a44193 ("arm64: atomics: fix use of
acquire + release for full barrier semantics), which fixes a similar
misuse of acquire/release to the example below.

> -    ++vdso_data->tb_seq_count;
> -    smp_wmb();
> +    tmp = smp_load_acquire(&vdso_data->tb_seq_count);
> +    ++tmp;
> +    smp_store_release(&vdso_data->tb_seq_count, tmp);
> 
> "This looks busted -- the writes to vdso_data can be reordered
> before the
> update of tb_seq_count.
> 
> /confused
> 
> Will"
> 
> --------------------------------------------------------------------------
> 
> Hopefully, this more detailed explanation helps make things clearer.

As will points out (and as covered in the description of commit
8e86f0b409a44193), the use of half-barriers allows accesses to be pulled
into the critical section, where they can be reordered w.r.t. each
other.

The data update after the release can be reordered before the release
(but not the acquire). As it can be moved before the release, the new
data can be seen with the old seq count. Similar applies to the other
end, after the update, with acquire/release swapped - the updated seq
count can be seen before the data update.

So to another observer, the updates of the data can be observed in an
arbitrary order w.r.t. the seq count.

Thanks,
Mark.
