From: Suzuki.Poulose@arm.com (Suzuki K Poulose)
Date: Tue, 30 Aug 2016 11:15:42 +0100
Subject: [RFC PATCH 2/3] arm64: cpufeature: constify arm64_ftr_regs array
In-Reply-To: <1472231742-13387-3-git-send-email-ard.biesheuvel@linaro.org>
References: <1472231742-13387-1-git-send-email-ard.biesheuvel@linaro.org>
 <1472231742-13387-3-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <1555bf25-a086-ae32-1dae-e84782b97380@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 26/08/16 18:15, Ard Biesheuvel wrote:
> Constify the arm64_ftr_regs array, by moving the mutable arm64_ftr_reg
> fields out of the array itself. This also streamlines the bsearch, since
> the entire array can be covered by fewer cachelines. Moving the payload
> out of the array also allows us to have special explicitly defined
> struct instance in case other code needs to refer to it directly.
>
> Note that this replaces the runtime sorting of the array with a runtime
> BUG() check whether the array is sorted correctly in the code.
>
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>

Ard,

Thanks a lot for the nice, quick cleanup !

> +	int i;
> +
> +	/* Check that the array is sorted so that we can do the binary search */
> +	for (i = 1; i < ARRAY_SIZE(arm64_ftr_regs); i++)


> +		if (arm64_ftr_regs[i].sys_id < arm64_ftr_regs[i - 1].sys_id)
> +			BUG();

minor nit: We could do :
	for (i = 1; i < ARRAY_SIZE(arm64_ftr_regs); i++)
		BUG_ON(!(arm64_ftr_regs[i].sys_id < arm64_ftr_regs[i - 1].sys_id));


The entire series looks good to me. For the series :

Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>

Suzuki
