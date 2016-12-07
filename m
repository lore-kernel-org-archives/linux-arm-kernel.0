From: nathan_lynch@mentor.com (Nathan Lynch)
Date: Wed, 7 Dec 2016 12:51:01 -0600
Subject: [RFC PATCH v3 07/11] arm64: compat: Add a 32-bit vDSO
In-Reply-To: <20161206160353.14581-8-kevin.brodsky@arm.com>
References: <20161206160353.14581-1-kevin.brodsky@arm.com>
 <20161206160353.14581-8-kevin.brodsky@arm.com>
Message-ID: <87r35jmv3e.fsf@wedge.i-did-not-set--mail-host-address--so-tickle-me>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kevin,

Kevin Brodsky <kevin.brodsky@arm.com> writes:
> diff --git a/arch/arm64/kernel/vdso32/vgettimeofday.c b/arch/arm64/kernel/vdso32/vgettimeofday.c
> new file mode 100644
> index 000000000000..53c3d1f82b26
> --- /dev/null
> +++ b/arch/arm64/kernel/vdso32/vgettimeofday.c

As I said at LPC last month, I'm not excited to have arch/arm's
vgettimeofday.c copied into arch/arm64 and tweaked; I'd rather see this
part of the implementation shared between arch/arm and arch/arm64
somehow, even if there's not an elegant way to do so.

The situation which must be avoided is one where the arch/arm64 compat
VDSO incompatibly diverges from the arch/arm VDSO.  That becomes much
less likely if there's only one copy of the userspace-exposed code to
maintain.


[...]

> +/*
> + * We use the hidden visibility to prevent the compiler from generating a GOT
> + * relocation. Not only is going through a GOT useless (the entry couldn't and
> + * musn't be overridden by another library), it does not even work: the linker
> + * cannot generate an absolute address to the data page.
> + *
> + * With the hidden visibility, the compiler simply generates a PC-relative
> + * relocation (R_ARM_REL32), and this is what we need.
> + */
> +extern const struct vdso_data _vdso_data __attribute__((visibility("hidden")));
> +
> +static inline const struct vdso_data *get_vdso_data(void)
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
> +	 * where get_vdso_data() is called, and then keep the result in a
> +	 * register.
> +	 */
> +	asm("mov %0, %1" : "=r"(ret) : "r"(&_vdso_data));
> +	return ret;
> +}

I think this is an instructive case: this code looks like an improvement
over how the arch/arm VDSO accesses the data page.  Enhancements like
this (not to mention fixes) shouldn't require a patch-per-architecture;
things inevitably get out of sync and it's more of a maintenance burden
in the long term.
