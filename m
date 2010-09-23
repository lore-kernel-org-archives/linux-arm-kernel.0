From: johnstul@us.ibm.com (john stultz)
Date: Thu, 23 Sep 2010 12:48:51 -0700
Subject: [PATCH 1/8] posix clocks: introduce a syscall for clock tuning.
In-Reply-To: <b94ef1cd9c04ef3ad5964408bd0af7251add78de.1285261534.git.richard.cochran@omicron.at>
References: <cover.1285261533.git.richard.cochran@omicron.at>
	<b94ef1cd9c04ef3ad5964408bd0af7251add78de.1285261534.git.richard.cochran@omicron.at>
Message-ID: <1285271331.2587.56.camel@localhost.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2010-09-23 at 19:31 +0200, Richard Cochran wrote:
> A new syscall is introduced that allows tuning of a POSIX clock. The
> syscall is implemented for four architectures: arm, blackfin, powerpc,
> and x86.
> 
> The new syscall, clock_adjtime, takes two parameters, the clock ID,
> and a pointer to a struct timex. The semantics of the timex struct
> have been expanded by one additional mode flag, which allows an
> absolute offset correction. When specificied, the clock offset is
> immediately corrected by adding the given time value to the current
> time value.


So I'd still split this patch up a little bit more.

1) Patch that implements the ADJ_SETOFFSET  (*and its implementation*)
in do_adjtimex.

2) Patch that adds the new syscall and clock_id multiplexing.

3) Patches that wire it up to the rest of the architectures (there's
still a bunch missing here).



And one little nit in the code:

> diff --git a/kernel/posix-timers.c b/kernel/posix-timers.c
> index 9ca4973..446b566 100644
> --- a/kernel/posix-timers.c
> +++ b/kernel/posix-timers.c
> @@ -197,6 +197,14 @@ static int common_timer_create(struct k_itimer *new_timer)
>  	return 0;
>  }
> 
> +static inline int common_clock_adj(const clockid_t which_clock, struct timex *t)
> +{
> +	if (CLOCK_REALTIME == which_clock)
> +		return do_adjtimex(t);
> +	else
> +		return -EOPNOTSUPP;
> +}


Would it make sense to point to the do_adjtimex() in the k_clock
definition for CLOCK_REALTIME rather then conditionalizing it here?



thanks
-john
