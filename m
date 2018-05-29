From: will.deacon@arm.com (Will Deacon)
Date: Tue, 29 May 2018 21:42:31 +0100
Subject: [PATCH v5 2/2] arm64: signal: Report signal frame size to
 userspace via auxv
In-Reply-To: <1527261428-6662-3-git-send-email-Dave.Martin@arm.com>
References: <1527261428-6662-1-git-send-email-Dave.Martin@arm.com>
 <1527261428-6662-3-git-send-email-Dave.Martin@arm.com>
Message-ID: <20180529204230.GG591@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Dave,

Cheers for respinning this. Just one observation below, which I only just
thought about.

On Fri, May 25, 2018 at 04:17:08PM +0100, Dave Martin wrote:
> Stateful CPU architecture extensions may require the signal frame
> to grow to a size that exceeds the arch's MINSIGSTKSZ #define.
> However, changing this #define is an ABI break.
> 
> To allow userspace the option of determining the signal frame size
> in a more forwards-compatible way, this patch adds a new auxv entry
> tagged with AT_MINSIGSTKSZ, which provides the maximum signal frame
> size that the process can observe during its lifetime.
> 
> If AT_MINSIGSTKSZ is absent from the aux vector, the caller can
> assume that the MINSIGSTKSZ #define is sufficient.  This allows for
> a consistent interface with older kernels that do not provide
> AT_MINSIGSTKSZ.
> 
> The idea is that libc could expose this via sysconf() or some
> similar mechanism.
> 
> There is deliberately no AT_SIGSTKSZ.  The kernel knows nothing
> about userspace's own stack overheads and should not pretend to
> know.

[...]

> diff --git a/arch/arm64/include/asm/elf.h b/arch/arm64/include/asm/elf.h
> index fac1c4d..8cf112b 100644
> --- a/arch/arm64/include/asm/elf.h
> +++ b/arch/arm64/include/asm/elf.h
> @@ -121,6 +121,9 @@
>  
>  #ifndef __ASSEMBLY__
>  
> +#include <linux/bug.h>
> +#include <asm/processor.h> /* for signal_minsigstksz, used by ARCH_DLINFO */
> +
>  typedef unsigned long elf_greg_t;
>  
>  #define ELF_NGREG (sizeof(struct user_pt_regs) / sizeof(elf_greg_t))
> @@ -148,6 +151,14 @@ typedef struct user_fpsimd_state elf_fpregset_t;
>  do {									\
>  	NEW_AUX_ENT(AT_SYSINFO_EHDR,					\
>  		    (elf_addr_t)current->mm->context.vdso);		\
> +									\
> +	/*								\
> +	 * Should always be nonzero unless there's a kernel bug.	\
> +	 * If we haven't determined a sensible value to give to		\
> +	 * userspace, omit the entry:					\
> +	 */								\
> +	if (likely(signal_minsigstksz))					\
> +		NEW_AUX_ENT(AT_MINSIGSTKSZ, signal_minsigstksz);	\
>  } while (0)

I think this is the desired behaviour, but now I'm worried that we're forced
to have AT_VECTOR_SIZE_ARCH defined as 2 and, whilst you're correct that the
ELF loader deals with this gracefuly, the FDPIC loader looks a lot less
robust (in particular, my reading is that it decrements the stack pointer
and then pushes these entries in reverse order by overloading NEW_AUX_ENT).
There's also some checkpoint save/restore code in kernel/sys.c that looks
like it could end up with uninitialised stack for the omitted entry.

Can we spit out an AT_IGNORE entry as an else clause if signal_minsigstksz
is zero?

Will
