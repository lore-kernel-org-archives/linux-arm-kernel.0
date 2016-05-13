From: will.deacon@arm.com (Will Deacon)
Date: Fri, 13 May 2016 10:24:20 +0100
Subject: [PATCH] arm64: fix current_thread_info()->addr_limit setup
In-Reply-To: <1463052414-29033-1-git-send-email-ynorov@caviumnetworks.com>
References: <1463052414-29033-1-git-send-email-ynorov@caviumnetworks.com>
Message-ID: <20160513092419.GA13689@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 12, 2016 at 02:26:54PM +0300, Yury Norov wrote:
> At elf loading in flush_old_exec() in fs/exec.c, generic code sets
> current_thread_info()->addr_limit to one that corresponds aarch64 value,
> and ignores compat mode there as corresponding status setup happens
> later on in load_elf_binary() by SET_PERSONALITY() macro. As result,
> compat task has wrong addr_limit, and it may cause various bugs.
> 
> This patch fixes it. It also fixes USER_DS macro to return different
> values depending on compat at runtime.
> 
> It was discovered during ilp32 development. See details here:
> https://lkml.org/lkml/2016/5/11/975

It looks like that thread is ongoing, with discussion around a generic
fix and a related issue with our TLS handling:

  https://lkml.org/lkml/2016/5/12/513
  https://lkml.org/lkml/2016/5/12/515

so I'm going to hold off on this until there's some agreement on the
right way forward. Whatever we end up doing, we should probably cc
stable too.

> Signed-off-by: Yury Norov <ynorov@caviumnetworks.com>
> ---
>  arch/arm64/include/asm/elf.h     | 11 +++++++++--
>  arch/arm64/include/asm/uaccess.h |  2 +-
>  2 files changed, 10 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/elf.h b/arch/arm64/include/asm/elf.h
> index 24ed037..fda75ce 100644
> --- a/arch/arm64/include/asm/elf.h
> +++ b/arch/arm64/include/asm/elf.h
> @@ -138,7 +138,10 @@ typedef struct user_fpsimd_state elf_fpregset_t;
>   */
>  #define ELF_PLAT_INIT(_r, load_addr)	(_r)->regs[0] = 0
>  
> -#define SET_PERSONALITY(ex)		clear_thread_flag(TIF_32BIT);
> +#define SET_PERSONALITY(ex) do {					\
> +	clear_thread_flag(TIF_32BIT);					\
> +	set_fs(TASK_SIZE_64);						\

You could just use USER_DS for both of the SET_PERSONALITY macros.

Will
