From: james.morse@arm.com (James Morse)
Date: Wed, 11 Oct 2017 16:34:58 +0100
Subject: [PATCH 2/3] arm64: vdso: replace gettimeofday.S with arm
 vgettimeofday.C
In-Reply-To: <20170911161907.112856-1-salyzyn@android.com>
References: <20170911161907.112856-1-salyzyn@android.com>
Message-ID: <59DE3A22.7040002@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,

On 11/09/17 17:18, Mark Salyzyn wrote:
> Take an effort to recode the arm64 vdso code from assembler to C
> previously submitted by Andrew Pinski <apinski@cavium.com>, rework
> it for use in both arm and arm64, overlapping any optimizations
> for each architecture.
> 
> apinski at cavium.com writes in the original patch:
> 
> This allows the compiler to optimize the divide by 1000 and remove
> the other divides.
> 
> On ThunderX, gettimeofday improves by 32%.  On ThunderX 2,
> gettimeofday improves by 18%.

Great! How was this tested? (I can compare the numbers for Juno and Seattle)


> Note I noticed a bug in the old implementation of __kernel_clock_getres;
> it was checking only the lower 32bits of the pointer; this would work
> for most cases but could fail in a few.

Is there a separate patch for this? Once we change it to C we can't easily
backport fixes.


I can't get my head round what vgettimeofday.c looks like after your previous
patch, some comments on the rest of it:

> diff --git a/arch/arm64/kernel/vdso/Makefile b/arch/arm64/kernel/vdso/Makefile
> index 62c84f7cb01b..6c127964ee62 100644
> --- a/arch/arm64/kernel/vdso/Makefile
> +++ b/arch/arm64/kernel/vdso/Makefile
> @@ -5,16 +5,21 @@
>  # Heavily based on the vDSO Makefiles for other archs.
>  #
>  
> -obj-vdso := gettimeofday.o note.o sigreturn.o
> +obj-vdso := vgettimeofday.o note.o sigreturn.o
>  
>  # Build rules
>  targets := $(obj-vdso) vdso.so vdso.so.dbg
>  obj-vdso := $(addprefix $(obj)/, $(obj-vdso))
>  
> -ccflags-y := -shared -fno-common -fno-builtin
> +ccflags-y := -shared -fno-common -fno-builtin -fno-stack-protector
> +ccflags-y += -DDISABLE_BRANCH_PROFILING
>  ccflags-y += -nostdlib -Wl,-soname=linux-vdso.so.1 \
>  		$(call cc-ldoption, -Wl$(comma)--hash-style=sysv)

> +# Force -O2 to avoid libgcc dependencies
> +CFLAGS_REMOVE_vgettimeofday.o = -pg -Os
> +CFLAGS_vgettimeofday.o = -O2 -mcmodel=tiny

How is this -O2=!libgcc enforced? Is it just co-incidence and works with today's
compilers?

We already have -nostdlib -fno-builtin -fno-common, are these not enough?

I assume that if this goes wrong we will get a link error due to:
d67703a8a69e ("arm64: kill off the libgcc dependency")


>  # Disable gcov profiling for VDSO code
>  GCOV_PROFILE := n

Once this is in C I think we need these too:
> KASAN_SANITIZE := n
> UBSAN_SANITIZE := n
> KCOV_INSTRUMENT := n


> @@ -48,15 +53,9 @@ endef
>  include/generated/vdso-offsets.h: $(obj)/vdso.so.dbg FORCE
>  	$(call if_changed,vdsosym)
>  
> -# Assembly rules for the .S files
> -$(obj-vdso): %.o: %.S FORCE
> -	$(call if_changed_dep,vdsoas)

Doesn't this break if_changed_dep for the other S files? (notes.S, sigreturn.S
vdso.S)


>  # Actual build commands
>  quiet_cmd_vdsold = VDSOL   $@
>        cmd_vdsold = $(CC) $(c_flags) -Wl,-n -Wl,-T $^ -o $@
> -quiet_cmd_vdsoas = VDSOA   $@
> -      cmd_vdsoas = $(CC) $(a_flags) -c -o $@ $<
>  
>  # Install commands for the unstripped file
>  quiet_cmd_vdso_install = INSTALL $@

> diff --git a/arch/arm64/kernel/vdso/datapage.h b/arch/arm64/kernel/vdso/datapage.h
> new file mode 100644
> index 000000000000..e627e4f4ed93
> --- /dev/null
> +++ b/arch/arm64/kernel/vdso/datapage.h
> @@ -0,0 +1,58 @@
> +/*
> + * Userspace implementations of __get_datapage
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program.  If not, see <http://www.gnu.org/licenses/>.
> + */
> +
> +#ifndef __VDSO_DATAPAGE_H
> +#define __VDSO_DATAPAGE_H
> +
> +#include <linux/types.h>
> +#include <asm/vdso_datapage.h>
> +
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
> +	asm("" : "=r"(ret) : "0"(&_vdso_data));
> +	return ret;
> +}

... so this is a case where its still better to have an asm __get_datapage ?

Will distant-future:gcc do a better job of this? I'm worried that
near-future:gcc will see through your empty-string and perform the same
'optimisation'.


Thanks,

James
