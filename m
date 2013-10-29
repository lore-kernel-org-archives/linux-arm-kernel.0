From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue, 29 Oct 2013 17:49:37 +0000
Subject: [PATCH] Make the 32-bit ARM get_user() and put_user() work for
 16-bit quantities
In-Reply-To: <1383065529-20001-1-git-send-email-wcohen@redhat.com>
References: <1383065529-20001-1-git-send-email-wcohen@redhat.com>
Message-ID: <526FF531.9080705@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi William,

On 29/10/13 16:52, William Cohen wrote:
> The 32-bit ARM does not have instructions to perform 16-bit loads or
> stores.  The __get_user_asm_half and __put_user_asm_half macros
> sythesize those operations.  However, in most cases the pointers
> passed into these macros are pointers to 16-bit types and the pointer
> arithmetic will end up pointing at the next 16-bit quantity rather
> than the second half (byte) of the 16-bit quantity.  The macros need
> to explicitly typecast the pointers as pointers to 8-bit quantities to
> make the pointer arithmetic work out properly.

So I'm a bit perplex here. Looks like nobody but __{ge,pu}t_user_err
calls these macros directly, and the sole users cast the pointer to an
unsigned long, for which the arithmetic ought to work properly.

What am I missing?

	M.

> Signed-off-by: William Cohen <wcohen@redhat.com>
> ---
>  arch/arm/include/asm/uaccess.h | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/arm/include/asm/uaccess.h b/arch/arm/include/asm/uaccess.h
> index 7e1f760..c2d9439 100644
> --- a/arch/arm/include/asm/uaccess.h
> +++ b/arch/arm/include/asm/uaccess.h
> @@ -277,16 +277,16 @@ do {									\
>  #define __get_user_asm_half(x,__gu_addr,err)			\
>  ({								\
>  	unsigned long __b1, __b2;				\
> -	__get_user_asm_byte(__b1, __gu_addr, err);		\
> -	__get_user_asm_byte(__b2, __gu_addr + 1, err);		\
> +	__get_user_asm_byte(__b1, (u8 *)(__gu_addr), err);	\
> +	__get_user_asm_byte(__b2, ((u8 *)(__gu_addr)) + 1, err);\
>  	(x) = __b1 | (__b2 << 8);				\
>  })
>  #else
>  #define __get_user_asm_half(x,__gu_addr,err)			\
>  ({								\
>  	unsigned long __b1, __b2;				\
> -	__get_user_asm_byte(__b1, __gu_addr, err);		\
> -	__get_user_asm_byte(__b2, __gu_addr + 1, err);		\
> +	__get_user_asm_byte(__b1, (u8 *)(__gu_addr), err);	\
> +	__get_user_asm_byte(__b2, ((u8 *)(__gu_addr)) + 1, err);\
>  	(x) = (__b1 << 8) | __b2;				\
>  })
>  #endif
> @@ -358,15 +358,15 @@ do {									\
>  #define __put_user_asm_half(x,__pu_addr,err)			\
>  ({								\
>  	unsigned long __temp = (unsigned long)(x);		\
> -	__put_user_asm_byte(__temp, __pu_addr, err);		\
> -	__put_user_asm_byte(__temp >> 8, __pu_addr + 1, err);	\
> +	__put_user_asm_byte(__temp, (u8 *)(__pu_addr), err);    \
> +	__put_user_asm_byte(__temp >> 8, ((u8 *)(__pu_addr)) + 1, err);\
>  })
>  #else
>  #define __put_user_asm_half(x,__pu_addr,err)			\
>  ({								\
>  	unsigned long __temp = (unsigned long)(x);		\
> -	__put_user_asm_byte(__temp >> 8, __pu_addr, err);	\
> -	__put_user_asm_byte(__temp, __pu_addr + 1, err);	\
> +	__put_user_asm_byte(__temp >> 8, (u8 *)(__pu_addr), err);\
> +	__put_user_asm_byte(__temp, ((u8 *)(__pu_addr)) + 1, err);\
>  })
>  #endif
>  
> 


-- 
Jazz is not dead. It just smells funny...
