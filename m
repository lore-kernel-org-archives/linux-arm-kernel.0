From: alex.bennee@linaro.org (Alex =?utf-8?Q?Benn=C3=A9e?=)
Date: Wed, 25 Jul 2018 14:58:29 +0100
Subject: [RFC PATCH 07/16] arm64/sve: Enable SVE state tracking for
 non-task contexts
In-Reply-To: <1529593060-542-8-git-send-email-Dave.Martin@arm.com>
References: <1529593060-542-1-git-send-email-Dave.Martin@arm.com>
 <1529593060-542-8-git-send-email-Dave.Martin@arm.com>
Message-ID: <87a7qfto1m.fsf@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Dave Martin <Dave.Martin@arm.com> writes:

> The current FPSIMD/SVE context handling support for non-task (i.e.,
> KVM vcpu) contexts does not take SVE into account.  This means that
> only task contexts can safely use SVE at present.
>
> In preparation for enabling KVM guests to use SVE, it is necessary
> to keep track of SVE state for non-task contexts too.
>
> This patch adds the necessary support, removing assumptions from
> the context switch code about the location of the SVE context
> storage.
>
> When binding a vcpu context, its vector length is arbitrarily
> specified as sve_max_vl for now.  In any case, because TIF_SVE is
> presently cleared at vcpu context bind time, the specified vector
> length will not be used for anything yet.  In later patches TIF_SVE
> will be set here as appropriate, and the appropriate maximum vector
> length for the vcpu will be passed when binding.
<snip>
> --- a/arch/arm64/kernel/fpsimd.c
> +++ b/arch/arm64/kernel/fpsimd.c
> @@ -121,6 +121,8 @@
>   */
>  struct fpsimd_last_state_struct {
>  	struct user_fpsimd_state *st;
> +	void *sve_state;
> +	unsigned int sve_vl;
>  };

> -	struct user_fpsimd_state *st = __this_cpu_read(fpsimd_last_state.st);
> +	struct fpsimd_last_state_struct const *last =
> +		this_cpu_ptr(&fpsimd_last_state);
<snip>
> @@ -1074,6 +1082,8 @@ void fpsimd_bind_state_to_cpu(struct user_fpsimd_state *st)
>  	WARN_ON(!in_softirq() && !irqs_disabled());
>
>  	last->st = st;
> +	last->sve_state = sve_state;
> +	last->sve_vl = sve_vl;
>  }

I'm suffering a little cognitive dissonance with the use of last here
because isn't it really the state as it is now - as we bind to the cpu?

Anyway not super relevant to this patch as the name has already been
chosen so:

Reviewed-by: Alex Benn?e <alex.bennee@linaro.org>

--
Alex Benn?e
