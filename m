From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 15 Sep 2015 17:19:54 +0100
Subject: [PATCH 2/2] arm64: compat: fix vfp save/restore across signal
 handlers in big-endian
In-Reply-To: <1442316997-32282-2-git-send-email-will.deacon@arm.com>
References: <1442316997-32282-1-git-send-email-will.deacon@arm.com>
 <1442316997-32282-2-git-send-email-will.deacon@arm.com>
Message-ID: <20150915161954.GH14287@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 15, 2015 at 12:36:37PM +0100, Will Deacon wrote:
> @@ -235,10 +253,15 @@ static int compat_preserve_vfp_context(struct compat_vfp_sigframe __user *frame)
>  	/*
>  	 * Now copy the FP registers. Since the registers are packed,
>  	 * we can copy the prefix we want (V0-V15) as it is.
> -	 * FIXME: Won't work if big endian.
>  	 */
> -	err |= __copy_to_user(&frame->ufp.fpregs, fpsimd->vregs,
> -			      sizeof(frame->ufp.fpregs));
> +	for (i = 0; i < ARRAY_SIZE(frame->ufp.fpregs); i++) {
> +		union __fpsimd_vreg vreg = {
> +			.raw = fpsimd->vregs[i >> 1],
> +		};
> +
> +		__put_user_error(vreg.lo, &frame->ufp.fpregs[i++], err);
> +		__put_user_error(vreg.hi, &frame->ufp.fpregs[i], err);
> +	}

Nitpick: I find it easier to read as (same for the other hunk):

	for (i = 0; i < ARRAY_SIZE(frame->ufp.fpregs); i += 2) {
		...

		__put_user_error(vreg.lo, &frame->ufp.fpregs[i], err);
		__put_user_error(vreg.hi, &frame->ufp.fpregs[i + 1], err);
	}

It's up to you. Anyway:

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>

-- 
Catalin
