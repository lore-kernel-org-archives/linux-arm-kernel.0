From: peterz@infradead.org (Peter Zijlstra)
Date: Wed, 9 Jul 2014 12:57:21 +0200
Subject: [PATCH v3 04/12] sched: Allow all archs to set the power_orig
In-Reply-To: <1404144343-18720-5-git-send-email-vincent.guittot@linaro.org>
References: <1404144343-18720-1-git-send-email-vincent.guittot@linaro.org>
 <1404144343-18720-5-git-send-email-vincent.guittot@linaro.org>
Message-ID: <20140709105721.GT19379@twins.programming.kicks-ass.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 30, 2014 at 06:05:35PM +0200, Vincent Guittot wrote:
> power_orig is only changed for system with a SMT sched_domain level in order to
> reflect the lower capacity of CPUs. Heterogenous system also have to reflect an
> original capacity that is different from the default value.
> 
> Create a more generic function arch_scale_cpu_power that can be also used by
> non SMT platform to set power_orig.
> 
> The weak behavior of arch_scale_cpu_power is the previous SMT one in order to
> keep backward compatibility in the use of power_orig.
> 
> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> ---
>  kernel/sched/fair.c | 24 ++++++++++++++++--------
>  1 file changed, 16 insertions(+), 8 deletions(-)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 148b277..f0bba5f 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -5614,6 +5614,20 @@ unsigned long __weak arch_scale_smt_capacity(struct sched_domain *sd, int cpu)
>  	return default_scale_smt_capacity(sd, cpu);
>  }
>  
> +unsigned long __weak arch_scale_cpu_capacity(struct sched_domain *sd, int cpu)
> +{
> +	unsigned long weight = sd->span_weight;
> +
> +	if ((sd->flags & SD_SHARE_CPUCAPACITY) && weight > 1) {
> +		if (sched_feat(ARCH_CAPACITY))
> +			return arch_scale_smt_capacity(sd, cpu);
> +		else
> +			return default_scale_smt_capacity(sd, cpu);
> +	}
> +
> +	return SCHED_CAPACITY_SCALE;
> +}

The only caller of arch_scale_smt_capacity is now an arch_ function
itself; which makes it entirely redundant, no?

Also, sched_feat() and default_scale_smt_capability() aren't available
to arch implementations of this function and can thus not retain
semantics.

Seeing how we currently don't have any arch_scale_smt_capacity
implementations other than the default we can easily replace it entirely
with something like:

unsigned long __weak arch_scale_cpu_capacity()
{
	if ((sd->flags & SD_SHARE_CPUCAPACITY) && (sd->span_weight > 1))
		return sd->smt_gain / sd->span_weight;

	return SCHED_CAPACITY_SCALE;
}

Hmm?
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140709/56f24bf2/attachment.sig>
