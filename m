From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 8 May 2018 12:30:44 +0100
Subject: [PATCH 1/2] arm64: signal: Report signal frame size to userspace
 via auxv
In-Reply-To: <1525776211-28169-2-git-send-email-Dave.Martin@arm.com>
References: <1525776211-28169-1-git-send-email-Dave.Martin@arm.com>
 <1525776211-28169-2-git-send-email-Dave.Martin@arm.com>
Message-ID: <20180508113043.elgvfz3dud2amcif@lakrids.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 08, 2018 at 11:43:30AM +0100, Dave Martin wrote:
> diff --git a/arch/arm64/include/asm/elf.h b/arch/arm64/include/asm/elf.h
> index fac1c4d..771c7a8 100644
> --- a/arch/arm64/include/asm/elf.h
> +++ b/arch/arm64/include/asm/elf.h
> @@ -24,6 +24,10 @@
>  #include <asm/ptrace.h>
>  #include <asm/user.h>
>  
> +#ifndef __ASSEMBLY__
> +#include <asm/processor.h> /* for get_minsigstksz(), used by ARCH_DLINFO */
> +#endif

This can live under the existing ifndef __ASSEMBLY__ block, where
ARCH_DLINFO lives.

[...]

> +/*
> + * Determine the stack space required for guaranteed signal devliery.
> + * This function is used to populate AT_MINSIGSTKSZ at process startup.
> + */
> +int get_minsigstksz(void)
> +{
> +	static __read_mostly atomic_t minsigstksz;
> +
> +	int ret;
> +	struct rt_sigframe_user_layout user;
> +
> +	ret = atomic_read(&minsigstksz);
> +	if (ret)
> +		return ret;
> +
> +	init_user_layout(&user);
> +	ret = setup_sigframe_layout(&user, true);
> +
> +	if (ret) {
> +		WARN_ON(1);
> +
> +		ret = SIGSTKSZ;
> +	} else {
> +		ret = sigframe_size(&user) +
> +			round_up(sizeof(struct frame_record), 16) +
> +			16; /* max alignment padding */
> +	}
> +
> +	/*
> +	 * The computed value (ret) is invariant, so its value can be
> +	 * safely stored irrespective of whether some other racing
> +	 * task got there first:
> +	 */
> +	atomic_set(&minsigstksz, ret);
> +	return ret;
> +}

Can we set up minsigstksz at some initcall time? that way get_minstksz()
can return minsigstksz with no conditionality at all.

Thanks,
Mark.
