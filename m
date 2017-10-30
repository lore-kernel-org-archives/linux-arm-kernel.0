From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 30 Oct 2017 14:30:37 +0000
Subject: [PATCH v3 10/12] arm64: vdso: replace gettimeofday.S with global
 vgettimeofday.C
In-Reply-To: <20171027222728.58317-1-salyzyn@android.com>
References: <20171027222728.58317-1-salyzyn@android.com>
Message-ID: <20171030143036.6ornj4ngloiinhw4@lakrids.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Fri, Oct 27, 2017 at 03:27:10PM -0700, Mark Salyzyn wrote:
> +/*
> + * AArch64 implementation of arch_counter_get_cntvct() suitable for vdso
> + */
> +static __always_inline notrace u64 __arch_counter_get(void)

Can we give the VDSO helpers some common prefix, e.g. use arch_vdso_*
and call this arch_vdo_read_counter()?

That would make it clear that this isn't a pointless copy of existing
helpers, and having a consistent naming prefix would be nicer as more
stuff gets added to the generic VDSO.

> +{
> +	u64 res;
> +
> +	/* Read the virtual counter. */
> +	isb();
> +	asm volatile("mrs %0, cntvct_el0" : "=r" (res) :: "memory");
> +
> +	return res;
> +}

This can be simplified to:

	isb();
	return read_sysreg(cntvct_el0);

[...]

> +/*
> + * We use the hidden visibility to prevent the compiler from generating a GOT
> + * relocation. Not only is going through a GOT useless (the entry couldn't and
> + * mustn't be overridden by another library), it does not even work: the linker
> + * cannot generate an absolute address to the data page.
> + *
> + * With the hidden visibility, the compiler simply generates a PC-relative
> + * relocation (R_ARM_REL32), and this is what we need.
> + */
> +extern const struct vdso_data _vdso_data __attribute__((visibility("hidden")));
> +
> +static inline const struct vdso_data *__get_datapage(void)
> +{
> +	const struct vdso_data *ret;
> +	/*
> +	 * This simply puts &_vdso_data into ret. The reason why we don't use
> +	 * `ret = &_vdso_data` is that the compiler tends to optimise this in a
> +	 * very suboptimal way: instead of keeping &_vdso_data in a register,
> +	 * it goes through a relocation almost every time _vdso_data must be
> +	 * accessed (even in subfunctions). This is both time and space
> +	 * consuming: each relocation uses a word in the code section, and it
> +	 * has to be loaded at runtime.
> +	 *
> +	 * This trick hides the assignment from the compiler. Since it cannot
> +	 * track where the pointer comes from, it will only use one relocation
> +	 * where __get_datapage() is called, and then keep the result in a
> +	 * register.
> +	 */

Has anyone reported this to upstream GCC?

It would be nice to minimize the set of bodges we have to carry
forever. They tend to bit us in the end.

> +	asm("" : "=r"(ret) : "0"(&_vdso_data));
> +	return ret;
> +}
> +
> +/* We can only guarantee 56 bits of precision. */
> +#define ARCH_CLOCK_FIXED_MASK (~(0xff00ull << 48))

Can't we use:

	BITMASK_ULL(55, 0);

... ?

Thanks,
Mark.
