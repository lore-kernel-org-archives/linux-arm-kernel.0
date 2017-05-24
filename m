From: keescook@google.com (Kees Cook)
Date: Wed, 24 May 2017 09:16:51 -0700
Subject: [PATCH 4/5] arm64: ascii armor the arm64 boot init stack canary
In-Reply-To: <20170524155751.424-5-riel@redhat.com>
References: <20170524155751.424-1-riel@redhat.com>
 <20170524155751.424-5-riel@redhat.com>
Message-ID: <CAGXu5j+b2UfdPs1yoweAy=jAFj9UQMGYYy1EjQUCi3JNjZD90A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 24, 2017 at 8:57 AM,  <riel@redhat.com> wrote:
> From: Rik van Riel <riel@redhat.com>
>
> Use the ascii-armor canary to prevent unterminated C string overflows
> from being able to successfully overwrite the canary, even if they
> somehow obtain the canary value.
>
> Inspired by execshield ascii-armor and Daniel Micay's linux-hardened tree.
>
> Signed-off-by: Rik van Riel <riel@redhat.com>

Acked-by: Kees Cook <keescook@chromium.org>

-Kees

> ---
>  arch/arm64/include/asm/stackprotector.h | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/arm64/include/asm/stackprotector.h b/arch/arm64/include/asm/stackprotector.h
> index fe5e287dc56b..b86a0865ddf1 100644
> --- a/arch/arm64/include/asm/stackprotector.h
> +++ b/arch/arm64/include/asm/stackprotector.h
> @@ -30,6 +30,7 @@ static __always_inline void boot_init_stack_canary(void)
>         /* Try to get a semi random initial value. */
>         get_random_bytes(&canary, sizeof(canary));
>         canary ^= LINUX_VERSION_CODE;
> +       canary &= CANARY_MASK;
>
>         current->stack_canary = canary;
>         __stack_chk_guard = current->stack_canary;
> --
> 2.9.3
>



-- 
Kees Cook
Pixel Security
