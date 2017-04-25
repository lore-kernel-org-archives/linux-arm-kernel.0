From: will.deacon@arm.com (Will Deacon)
Date: Tue, 25 Apr 2017 17:53:21 +0100
Subject: [PATCH] arm64: Preventing READ_IMPLIES_EXEC propagation
In-Reply-To: <d4205c8c-c8cd-ef35-a6bd-3444a7b3ac48@huawei.com>
References: <1493102296-229934-1-git-send-email-zhangshaokun@hisilicon.com>
 <d4205c8c-c8cd-ef35-a6bd-3444a7b3ac48@huawei.com>
Message-ID: <20170425165320.GT24484@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 25, 2017 at 02:11:29PM +0800, dongbo (E) wrote:
> From: Dong Bo <dongbo4@huawei.com>
> 
> Once the READ_IMPLIES_EXEC flag is set on arm64, the flag is
> propagated to its child processes, even the ELF files are
> marked as not requiring executable stack.
> 
> Signed-off-by: Dong Bo <dongbo4@huawei.com>
> ---
>  arch/arm64/include/asm/elf.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm64/include/asm/elf.h b/arch/arm64/include/asm/elf.h
> index 5d17004..5941e7f 100644
> --- a/arch/arm64/include/asm/elf.h
> +++ b/arch/arm64/include/asm/elf.h
> @@ -142,6 +142,7 @@
>  ({									\
>  	clear_bit(TIF_32BIT, &current->mm->context.flags);		\
>  	clear_thread_flag(TIF_32BIT);					\
> +	current->personality &= ~READ_IMPLIES_EXEC;			\
>  })
>   /* update AT_VECTOR_SIZE_ARCH if the number of NEW_AUX_ENT entries changes */

This looks good to me:

Acked-by: Will Deacon <will.deacon@arm.com>

We might also want a comment in the compat code to say that we inherit
the flag to follow the arch/arm/ behaviour.

Anyway, I'd like to see this sit in -next for a bit, so would rather hold
this off until 4.12.

Will
