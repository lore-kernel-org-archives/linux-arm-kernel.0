From: mark.rutland@arm.com (Mark Rutland)
Date: Fri, 1 Dec 2017 13:31:59 +0000
Subject: [PATCH v2 10/18] arm64: entry: Add exception trampoline page for
 exceptions from EL0
In-Reply-To: <1512059986-21325-11-git-send-email-will.deacon@arm.com>
References: <1512059986-21325-1-git-send-email-will.deacon@arm.com>
 <1512059986-21325-11-git-send-email-will.deacon@arm.com>
Message-ID: <20171201133159.qphu3mc3uybm46js@lakrids.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 30, 2017 at 04:39:38PM +0000, Will Deacon wrote:
> +	.macro tramp_ventry, regsize = 64
> +	.align	7
> +1:
> +	.if	\regsize == 64
> +	msr	tpidrro_el0, x30
> +	.endif
> +	tramp_map_kernel	x30
> +	ldr	x30, =vectors
> +	prfm	plil1strm, [x30, #(1b - tramp_vectors)]
> +	msr	vbar_el1, x30
> +	add	x30, x30, #(1b - tramp_vectors)
> +	isb
> +	br	x30
> +	.endm

It might be worth a comment that the real vectors will restore x30 from
tpiddro_el0, since as-is, it looks like we're corrupting the value.

Otherwise, this looks good to me.

Thanks,
Mark.
