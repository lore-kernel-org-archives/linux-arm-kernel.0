From: Alan.Hayward@arm.com (Alan Hayward)
Date: Wed, 20 Sep 2017 10:59:55 +0000
Subject: [PATCH v2 14/28] arm64/sve: Backend logic for setting the vector
 length
In-Reply-To: <1504198860-12951-15-git-send-email-Dave.Martin@arm.com>
References: <1504198860-12951-1-git-send-email-Dave.Martin@arm.com>
 <1504198860-12951-15-git-send-email-Dave.Martin@arm.com>
Message-ID: <FC5BA359-D37C-493C-87CD-146B83D3CCB5@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

(Resending without disclaimer)

> On 31 Aug 2017, at 18:00, Dave Martin <Dave.Martin@arm.com> wrote:

> 
> +int sve_set_vector_length(struct task_struct *task,
> +			  unsigned long vl, unsigned long flags)
> +{
> +	WARN_ON(task == current && preemptible());
> +
> +	if (flags & ~(unsigned long)(PR_SVE_VL_INHERIT |
> +				     PR_SVE_SET_VL_ONEXEC))
> +		return -EINVAL;
> +
> +	if (!sve_vl_valid(vl))
> +		return -EINVAL;
> +
> +	/*
> +	 * Clamp to the maximum vector length that VL-agnostic SVE code can
> +	 * work with.  A flag may be assigned in the future to allow setting
> +	 * of larger vector lengths without confusing older software.
> +	 */
> +	if (vl > SVE_VL_ARCH_MAX)
> +		vl = SVE_VL_ARCH_MAX;
> +
> +	vl = find_supported_vector_length(vl);
> +


Given, sve_set_vector_length is called when setting the vector length in
PTRACE_SETREGSET, it looks to me like if you set VL to a value that?s not
supported by the hardware, then it?s going to round down to the previous value.
Is that correct? I?m not sure if that?s explained in the docs?

What happens if you give a vl value lower than the min supported value in the
hardware?


> +/*
> + * All vector length selection from userspace comes through here.
> + * We're on a slow path, so some sanity-checks are included.
> + * If things go wrong there's a bug somewhere, but try to fall back to a
> + * safe choice.
> + */
> +static unsigned int find_supported_vector_length(unsigned int vl)
> +{
> +	int bit;
> +	int max_vl = sve_max_vl;
> +
> +	if (WARN_ON(!sve_vl_valid(vl)))
> +		vl = SVE_VL_MIN;
> +
> +	if (WARN_ON(!sve_vl_valid(max_vl)))
> +		max_vl = SVE_VL_MIN;
> +
> +	if (vl > max_vl)
> +		vl = max_vl;
> +
> +	bit = find_next_bit(sve_vq_map, SVE_VQ_MAX,
> +			    vq_to_bit(sve_vq_from_vl(vl)));
> +	return sve_vl_from_vq(bit_to_vq(bit));
> +}
> +


Thanks,
Alan.
