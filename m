From: keescook@google.com (Kees Cook)
Date: Wed, 24 May 2017 09:35:38 -0700
Subject: [PATCH 5/5] sh64: ascii armor the sh64 boot init stack canary
In-Reply-To: <20170524123446.78510066@annuminas.surriel.com>
References: <20170524155751.424-1-riel@redhat.com>
 <20170524123446.78510066@annuminas.surriel.com>
Message-ID: <CAGXu5jJafqLN7b7kPYYsY8pP1tig8O8TsFkWvWeHG5mT3Gz1rw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 24, 2017 at 9:34 AM, Rik van Riel <riel@redhat.com> wrote:
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
>  arch/sh/include/asm/stackprotector.h | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/sh/include/asm/stackprotector.h b/arch/sh/include/asm/stackprotector.h
> index d9df3a76847c..141515a43b78 100644
> --- a/arch/sh/include/asm/stackprotector.h
> +++ b/arch/sh/include/asm/stackprotector.h
> @@ -19,6 +19,7 @@ static __always_inline void boot_init_stack_canary(void)
>         /* Try to get a semi random initial value. */
>         get_random_bytes(&canary, sizeof(canary));
>         canary ^= LINUX_VERSION_CODE;
> +       canary &= CANARY_MASK;
>
>         current->stack_canary = canary;
>         __stack_chk_guard = current->stack_canary;
>



-- 
Kees Cook
Pixel Security
