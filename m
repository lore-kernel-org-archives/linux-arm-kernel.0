From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 30 Oct 2017 14:15:17 +0000
Subject: [PATCH v3 05/12] arm: vdso: do calculations outside reader loops
In-Reply-To: <20171027222543.57279-1-salyzyn@android.com>
References: <20171027222543.57279-1-salyzyn@android.com>
Message-ID: <20171030141517.25ex2os47cyvah2z@lakrids.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 27, 2017 at 03:25:40PM -0700, Mark Salyzyn wrote:
> In variable timer reading loops, pick up just the values until all
> are synchronized, then outside of loop pick up cntvct and perform
> calculations to determine final offset, shifted and multiplied
> output value.

So this is all about moving the computation out of the loop, which
sounds sensible...

> +#ifdef ARCH_CLOCK_FIXED_MASK
> +	static const u64 mask = ARCH_CLOCK_FIXED_MASK;
> +#else
> +	u64 mask;
> +#endif

... but this wasn't mentioned, and ARCH_CLOCK_FIXED_MASK doesn't seem to
be defined as of this patch.

It looks like an orthogonal change that should be introduced in a
separate patch.

> +
> +	typeof(((struct vdso_data *)vd)->xtime_clock_sec) sec;

Why do we need to do this typeof() magic?

Can't we settle on a consistent type across arches, or have a typedef in
a header?

Thanks,
Mark.
