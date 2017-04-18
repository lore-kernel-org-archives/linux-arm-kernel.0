From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 18 Apr 2017 18:01:18 +0100
Subject: [PATCH] fs: Preventing READ_IMPLIES_EXEC Propagation
In-Reply-To: <2414e3b3-03f6-bd6c-5aa4-ad58c66b5aa5@huawei.com>
References: <1492088223-98232-1-git-send-email-zhangshaokun@hisilicon.com>
 <2414e3b3-03f6-bd6c-5aa4-ad58c66b5aa5@huawei.com>
Message-ID: <20170418170118.GH27592@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 13, 2017 at 08:33:52PM +0800, dongbo (E) wrote:
> From: Dong Bo <dongbo4@huawei.com>
> 
> In load_elf_binary(), once the READ_IMPLIES_EXEC flag is set,
> the flag is propagated to its child processes, even the elf
> files are marked as not requiring executable stack. It may
> cause superfluous operations on some arch, e.g.
> __sync_icache_dcache on aarch64 due to a PROT_READ mmap is
> also marked as PROT_EXEC.
> 
> Signed-off-by: Dong Bo <dongbo4@huawei.com>
> ---
>  fs/binfmt_elf.c       | 2 ++
>  fs/binfmt_elf_fdpic.c | 2 ++
>  2 files changed, 4 insertions(+)
> 
> diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
> index 5075fd5..c52e670 100644
> --- a/fs/binfmt_elf.c
> +++ b/fs/binfmt_elf.c
> @@ -863,6 +863,8 @@ static int load_elf_binary(struct linux_binprm *bprm)
>  	SET_PERSONALITY2(loc->elf_ex, &arch_state);
>  	if (elf_read_implies_exec(loc->elf_ex, executable_stack))
>  		current->personality |= READ_IMPLIES_EXEC;
> +	else
> +		current->personality &= ~READ_IMPLIES_EXEC;
>   	if (!(current->personality & ADDR_NO_RANDOMIZE) && randomize_va_space)
>  		current->flags |= PF_RANDOMIZE;
> diff --git a/fs/binfmt_elf_fdpic.c b/fs/binfmt_elf_fdpic.c
> index cf93a4f..c4bc4d0 100644
> --- a/fs/binfmt_elf_fdpic.c
> +++ b/fs/binfmt_elf_fdpic.c
> @@ -354,6 +354,8 @@ static int load_elf_fdpic_binary(struct linux_binprm *bprm)
>  		set_personality(PER_LINUX);
>  	if (elf_read_implies_exec(&exec_params.hdr, executable_stack))
>  		current->personality |= READ_IMPLIES_EXEC;
> +	else
> +		current->personality &= ~READ_IMPLIES_EXEC;
>   	setup_new_exec(bprm);

That's affecting most architectures with a risk of ABI breakage. We
could do it on arm64 only, though I'm not yet clear on the ABI
implications (at a first look, there shouldn't be any). This follows the
x86_64 approach but unfortunately we haven't done it on arm64 from the
start:

diff --git a/arch/arm64/include/asm/elf.h b/arch/arm64/include/asm/elf.h
index 5d1700425efe..5941e7f6ae60 100644
--- a/arch/arm64/include/asm/elf.h
+++ b/arch/arm64/include/asm/elf.h
@@ -142,6 +142,7 @@ typedef struct user_fpsimd_state elf_fpregset_t;
 ({									\
 	clear_bit(TIF_32BIT, &current->mm->context.flags);		\
 	clear_thread_flag(TIF_32BIT);					\
+	current->personality &= ~READ_IMPLIES_EXEC;			\
 })
 
 /* update AT_VECTOR_SIZE_ARCH if the number of NEW_AUX_ENT entries changes */

-- 
Catalin
