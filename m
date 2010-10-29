From: greg@kroah.com (Greg KH)
Date: Fri, 29 Oct 2010 13:58:29 -0700
Subject: [stable] Patch Upstream: oprofile, ARM: Release resources on
	failure
In-Reply-To: <201010212105.o9LL57t9019586@hera.kernel.org>
References: <201010212105.o9LL57t9019586@hera.kernel.org>
Message-ID: <20101029205829.GC29104@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


This patch doesn't apply to the .35 or .36 stable tree
If someone wants it applied there, please email the backport
to stable at kernel.org

thanks,

greg k-h

> commit: 81771974ae49bf79aab60c42eac7a6d730a9ef2b
> From: Robert Richter <robert.richter@amd.com>
> Date: Wed, 29 Sep 2010 16:52:25 +0200
> Subject: [PATCH] oprofile, ARM: Release resources on failure
> 
> This patch fixes a resource leak on failure, where the
> oprofilefs and some counters may not released properly.
> 
> Signed-off-by: Robert Richter <robert.richter@amd.com>
> Acked-by: Will Deacon <will.deacon@arm.com>
> Cc: linux-arm-kernel at lists.infradead.org
> Cc: <stable@kernel.org> # .35.x
> LKML-Reference: <20100929145225.GJ13563@erda.amd.com>
> Signed-off-by: Ingo Molnar <mingo@elte.hu>
> ---
>  drivers/oprofile/oprofile_perf.c |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/oprofile/oprofile_perf.c b/drivers/oprofile/oprofile_perf.c
> index ebb40cb..f3d3df2 100644
> --- a/drivers/oprofile/oprofile_perf.c
> +++ b/drivers/oprofile/oprofile_perf.c
> @@ -84,6 +84,7 @@ static int op_create_counter(int cpu, int event)
>  	if (IS_ERR(pevent)) {
>  		ret = PTR_ERR(pevent);
>  	} else if (pevent->state != PERF_EVENT_STATE_ACTIVE) {
> +		perf_event_release_kernel(pevent);
>  		pr_warning("oprofile: failed to enable event %d "
>  				"on CPU %d\n", event, cpu);
>  		ret = -EBUSY;
> 
> _______________________________________________
> stable mailing list
> stable at linux.kernel.org
> http://linux.kernel.org/mailman/listinfo/stable
