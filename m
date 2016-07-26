From: timur@codeaurora.org (Timur Tabi)
Date: Tue, 26 Jul 2016 09:11:49 -0500
Subject: [PATCH v9 4/9] clocksource/drivers/arm_arch_timer: use readq to
 get 64-bit CNTVCT
In-Reply-To: <20160725163144.GE19209@arm.com>
References: <1469460427-8643-1-git-send-email-fu.wei@linaro.org>
 <1469460427-8643-5-git-send-email-fu.wei@linaro.org>
 <20160725153118.GD19209@arm.com>
 <CADyBb7ubKceQiB7+u7sSA=1+9_VMUrGjiabf_FkN2-n4rq7Kgg@mail.gmail.com>
 <20160725163144.GE19209@arm.com>
Message-ID: <57976FA5.2070802@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Will Deacon wrote:
> The kernel really needs to support both of those platforms :/
>
> For the memory-mapped counter registers, the architecture says:
>
>    `If the implementation supports 64-bit atomic accesses, then the
>     CNTV_CVAL register must be accessible as an atomic 64-bit value.'
>
> which is borderline tautological. If we take the generous reading that
> this means AArch64 CPUs can use readq (and I'm not completely
> comfortable with that assertion, particularly as you say that it breaks
> the model), then you still need to use readq_relaxed here to avoid a
> DSB. Furthermore, what are you going to do for AArch32? readq doesn't
> exist over there, and if you use the generic implementation then it's
> not atomic. In which case, we end up with the current code, as well as a
> readq_relaxed guarded by a questionable #ifdef that is known to break a
> supported platform for an unknown performance improvement. Hardly a big
> win.

I know Fu dropped this patch, and I don't want to kick a dead horse, but 
I was wondering if it would be okay to do this:

static u64 arch_counter_get_cntvct_mem(void)
{
#ifdef readq_relaxed
	return readq_relaxed(arch_counter_base + CNTVCT_LO);
#else
	u32 vct_lo, vct_hi, tmp_hi;

	do {
		vct_hi = readl_relaxed(arch_counter_base + CNTVCT_HI);
		vct_lo = readl_relaxed(arch_counter_base + CNTVCT_LO);
		tmp_hi = readl_relaxed(arch_counter_base + CNTVCT_HI);
	} while (vct_hi != tmp_hi);

	return ((u64) vct_hi << 32) | vct_lo;
#endif
}

readq and readq_relaxed are defined in arch/arm64/include/asm/io.h.  Why 
would the function exist if AArch64 CPUs can't use it?

Do we need something like ARCH_HAS_64BIT_ATOMIC_READ in order to decide 
whether readq is safe?

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the
Code Aurora Forum, hosted by The Linux Foundation.
