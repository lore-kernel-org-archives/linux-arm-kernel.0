From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 22 Mar 2017 16:20:35 +0000
Subject: [RFC PATCH v2 11/41] arm64/sve: Expand task_struct for Scalable
 Vector Extension state
In-Reply-To: <1490194274-30569-12-git-send-email-Dave.Martin@arm.com>
References: <1490194274-30569-1-git-send-email-Dave.Martin@arm.com>
 <1490194274-30569-12-git-send-email-Dave.Martin@arm.com>
Message-ID: <20170322162035.GB19950@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 22, 2017 at 02:50:41PM +0000, Dave Martin wrote:
> This patch expands task_struct to accommodate the Scalable Vector
> Extension state.
> 
> The extra space is not used for anything yet.

[...]

> +#ifdef CONFIG_ARM64_SVE
> +
> +static void *__sve_state(struct task_struct *task)
> +{
> +	return (char *)task + ALIGN(sizeof(*task), 16);
> +}
> +
> +static void *sve_pffr(struct task_struct *task)
> +{
> +	unsigned int vl = sve_get_vl();
> +
> +	BUG_ON(vl % 16);
> +	return (char *)__sve_state(task) + 34 * vl;
> +}

Can we mnemonicise the magic numbers for these?

That, and some comment regarding how the task_struct and sve state are
organised in memory, as that's painful to reverse-engineer.

> +
> +#else /* ! CONFIG_ARM64_SVE */
> +
> +/* Dummy declarations for usage protected with IS_ENABLED(CONFIG_ARM64_SVE): */
> +extern void *__sve_state(struct task_struct *task);
> +extern void *sve_pffr(struct task_struct *task);
> +
> +#endif /* ! CONFIG_ARM64_SVE */

The usual pattern is to make these static inlines, with a BUILD_BUG() if
calls are expected/required to be optimised away entirely.

Thanks,
Mark.
