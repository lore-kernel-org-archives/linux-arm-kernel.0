From: Elliott@hp.com (Elliott, Robert (Server Storage))
Date: Tue, 25 Nov 2014 00:53:19 +0000
Subject: [PATCH RESEND v8] iopoll: Introduce memory-mapped IO polling
 macros
In-Reply-To: <1416860092-11620-1-git-send-email-mitchelh@codeaurora.org>
References: <1416860092-11620-1-git-send-email-mitchelh@codeaurora.org>
Message-ID: <94D0CD8314A33A4D9D801C0FE68B4029593C5E1F@G9W0745.americas.hpqcorp.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



> -----Original Message-----
> From: linux-kernel-owner at vger.kernel.org [mailto:linux-kernel-
> owner at vger.kernel.org] On Behalf Of Mitchel Humpherys
> Sent: Monday, 24 November, 2014 2:15 PM
...
> From: Matt Wagantall <mattw@codeaurora.org>
> 
> It is sometimes necessary to poll a memory-mapped register until its value
> satisfies some condition. Introduce a family of convenience macros that do
> this. Tight-looping, sleeping, and timing out can all be accomplished
> using these macros.
> 
...
> +#define readx_poll_timeout(op, addr, val, cond, sleep_us, timeout_us)	\
> +({ \
> +	ktime_t timeout = ktime_add_us(ktime_get(), timeout_us); \
> +	might_sleep_if(sleep_us); \
> +	for (;;) { \
> +		(val) = op(addr); \
> +		if (cond) \
> +			break; \
> +		if (timeout_us && ktime_compare(ktime_get(), timeout) > 0) {
> \
> +			(val) = op(addr); \
> +			break; \
> +		} \
> +		if (sleep_us) \
> +			usleep_range((sleep_us >> 2) + 1, sleep_us); \

The hpsa SCSI driver used to use usleep_range in a loop like 
that, but we found that it caused scheduler problems during
boots because it uses TASK_UNINTERRUPTIBLE:
[    9.260668] [sched_delayed] sched: RT throttling activated

msleep() worked much better.

---
Rob Elliott    HP Server Storage
