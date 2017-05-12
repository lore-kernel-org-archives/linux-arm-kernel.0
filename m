From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 12 May 2017 17:57:24 +0100
Subject: [RFC PATCH v2 4/6] arm64: signal: Allocate extra sigcontext
 space as needed
In-Reply-To: <1492016495-19689-4-git-send-email-Dave.Martin@arm.com>
References: <1492016239-19511-1-git-send-email-Dave.Martin@arm.com>
 <1492016495-19689-1-git-send-email-Dave.Martin@arm.com>
 <1492016495-19689-4-git-send-email-Dave.Martin@arm.com>
Message-ID: <20170512165724.GB8387@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Dave,

On Wed, Apr 12, 2017 at 06:01:13PM +0100, Dave P Martin wrote:
> --- a/arch/arm64/include/uapi/asm/sigcontext.h
> +++ b/arch/arm64/include/uapi/asm/sigcontext.h
> @@ -80,4 +80,31 @@ struct esr_context {
>  	__u64 esr;
>  };
>  
> +/*
> + * Pointer to extra space for additional structures that don't fit in
> + * sigcontext.__reserved[].  Note:
> + *
> + * 1) fpsimd_context, esr_context and extra_context must be placed in
> + * sigcontext.__reserved[] if present.  They cannot be placed in the
> + * extra space.  Any other record can be placed either in the extra
> + * space or in sigcontext.__reserved[].
> + *
> + * 2) There must not be more than one extra_context.
> + *
> + * 3) If extra_context is present, it must be followed immediately in
> + * sigcontext.__reserved[] by the terminating null _aarch64_ctx (i.e.,
> + * extra_context must be the last record in sigcontext.__reserved[]
> + * except for the terminator).
> + *
> + * 4) The extra space must itself be terminated with a null
> + * _aarch64_ctx.
> + */

IIUC, if we need to save some state that doesn't fit in what's left of
sigcontext.__reserved[] (e.g. SVE with 1024-bit vector length), we
ignore the available space and go for a memory block following the end
of sigcontext.__reserved[] + 16. Is there a reason we can't store the
new state across the end of sigcontext.__reserved[] and move fp/lr at
the end of the new frame? I'm not sure the fp/lr position immediately
after __reserved[] counts as ABI.

> +#define EXTRA_MAGIC	0x45585401
> +
> +struct extra_context {
> +	struct _aarch64_ctx head;
> +	void __user *data;	/* 16-byte aligned pointer to extra space */
"__user" is a kernel-only attribute, we shouldn't expose it in a uapi
header.

> +	__u32 size;		/* size in bytes of the extra space */
> +};

Do we need the size of the extra space? Can we not infer it anyway by
walking the contexts save there? Surely we don't expect more than one
extra context.

-- 
Catalin
