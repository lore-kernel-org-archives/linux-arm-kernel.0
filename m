From: keescook@chromium.org (Kees Cook)
Date: Wed, 28 Mar 2018 05:00:03 -0700
Subject: [PATCH v2 2/2] arm64: uaccess: Fix omissions from usercopy
 whitelist
In-Reply-To: <1522230649-22008-3-git-send-email-Dave.Martin@arm.com>
References: <1522230649-22008-1-git-send-email-Dave.Martin@arm.com>
 <1522230649-22008-3-git-send-email-Dave.Martin@arm.com>
Message-ID: <CAGXu5j+MLqg+GgTuMneYVxScXyvsCJeNczcv_a2t8pen2h0-nA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 28, 2018 at 2:50 AM, Dave Martin <Dave.Martin@arm.com> wrote:
> When the hardend usercopy support was added for arm64, it was
> concluded that all cases of usercopy into and out of thread_struct
> were statically sized and so didn't require explicit whitelisting
> of the appropriate fields in thread_struct.
>
> Testing with usercopy hardening enabled has revealed that this is
> not the case for certain ptrace regset manipulation calls on arm64.
> This occurs because the sizes of usercopies associated with the
> regset API are dynamic by construction, and because arm64 does not
> always stage such copies via the stack: indeed the regset API is
> designed to avoid the need for that by adding some bounds checking.
>
> This is currently believed to affect only the fpsimd and TLS
> registers.
>
> Because the whitelisted fields in thread_struct must be contiguous,
> this patch groups them together in a nested struct.  It is also
> necessary to be able to determine the location and size of that
> struct, so rather than making the struct anonymous (which would
> save on edits elsewhere) or adding an anonymous union containing
> named and unnamed instances of the same struct (gross), this patch
> gives the struct a name and makes the necessary edits to code that
> references it (noisy but simple).
>
> Care is needed to ensure that the new struct does not contain
> padding (which the usercopy hardening would fail to protect).
>
> For this reason, the presence of tp2_value is made unconditional,
> since a padding field would be needed there in any case.  This pads
> up to the 16-byte alignment required by struct user_fpsimd_state.
>
> Reported-by: Mark Rutland <mark.rutland@arm.com>
> Fixes: 9e8084d3f761 ("arm64: Implement thread_struct whitelist for hardened usercopy")
> Signed-off-by: Dave Martin <Dave.Martin@arm.com>

Acked-by: Kees Cook <keescook@chromium.org>

Awesome! :)

-Kees

-- 
Kees Cook
Pixel Security
