From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 24 Sep 2013 15:25:54 +0100
Subject: [PATCH] arm64: avoid multiple evaluation of ptr in
 get_user/put_user()
In-Reply-To: <524154C2.1080303@linaro.org>
References: <524154C2.1080303@linaro.org>
Message-ID: <20130924142553.GG25907@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 24, 2013 at 10:00:50AM +0100, AKASHI Takahiro wrote:
> get_user() is defined as a function macro in arm64, and trace_get_user()
> calls it as followed:
>      get_user(ch, ptr++);
> Since the second parameter occurs twice in the definition, 'ptr++' is
> unexpectedly evaluated twice and trace_get_user() will generate a bogus
> string from user-provided one. As a result, some ftrace sysfs operations,
> like "echo FUNCNAME > set_ftrace_filter," hit this case and eventually fail.
> This patch fixes the issue both in get_user() and put_user().
> 
> Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> ---
>   arch/arm64/include/asm/uaccess.h |   12 ++++++++----
>   1 file changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/uaccess.h b/arch/arm64/include/asm/uaccess.h
> index edb3d5c..bbeab83 100644
> --- a/arch/arm64/include/asm/uaccess.h
> +++ b/arch/arm64/include/asm/uaccess.h
> @@ -166,9 +166,11 @@ do {									\
>    #define get_user(x, ptr)						\
>   ({									\
> +	__typeof__(*(ptr)) *optr = (ptr);				\
> +									\
>   	might_fault();							\
> -	access_ok(VERIFY_READ, (ptr), sizeof(*(ptr))) ?			\
> -		__get_user((x), (ptr)) :				\
> +	access_ok(VERIFY_READ, optr, sizeof(*optr)) ?			\
> +		__get_user((x), optr) :					\
>   		((x) = 0, -EFAULT);					\
>   })
>   @@ -227,9 +229,11 @@ do {									\
>    #define put_user(x, ptr)						\
>   ({									\
> +	__typeof__(*(ptr)) *optr = (ptr);				\
> +									\
>   	might_fault();							\
> -	access_ok(VERIFY_WRITE, (ptr), sizeof(*(ptr))) ?		\
> -		__put_user((x), (ptr)) :				\
> +	access_ok(VERIFY_WRITE, optr, sizeof(*optr)) ?			\
> +		__put_user((x), optr) :					\
>   		-EFAULT;						\
>   })
>   -- 1.7.9.5

BTW, please use git send-email or other email client, the diff above is
heavily corrupted (too many spaces at the beginning of the line, removed
empty lines; I managed to fix it up this time but only because it was a
small patch).

-- 
Catalin
