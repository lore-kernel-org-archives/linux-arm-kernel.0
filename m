From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 24 Sep 2013 15:05:38 +0100
Subject: [PATCH] arm64: avoid multiple evaluation of ptr in
 get_user/put_user()
In-Reply-To: <524154C2.1080303@linaro.org>
References: <524154C2.1080303@linaro.org>
Message-ID: <20130924140537.GF25907@arm.com>
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

I think this should be:

	__typeof__(*(ptr)) __user *optr = (ptr);

Otherwise the patch looks fine. I can fix the above.

Thanks.

-- 
Catalin
