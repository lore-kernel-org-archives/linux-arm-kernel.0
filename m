From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Fri, 23 Oct 2015 17:34:22 +0200
Subject: [PATCH] arm64: Align .text section to PAGE_SIZE
In-Reply-To: <1445610134-20528-1-git-send-email-jeremy.linton@arm.com>
References: <1445610134-20528-1-git-send-email-jeremy.linton@arm.com>
Message-ID: <CAKv+Gu_5YPiQOejsAUdVs7YbNJD4tFwuATYq6VNxuXbeRsoYkw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jeremy,

On 23 October 2015 at 16:22, Jeremy Linton <jeremy.linton@arm.com> wrote:
> It appears that 64k page kernel's die early, in a somewhat random set

nit: kernels

> of locations when built without KVM. Most likely during memblock
> manipulations (depending on kernel debug options).
>

It looks like fixup_executable() [with DEBUG_RODATA enabled] is the
culprit here: it calls create mapping() with a size that gets rounded
up to a multiple of PAGE_SIZE, which means the region that ends up
getting its exec bits cleared is larger than it should. Perhaps it is
better to fix that instead?

> Normally when KVM is built into the kernel it has an explicit
> PAGE_SIZE alignment requirement and that forces the text section to be
> aligned to PAGE_SIZE. Without it, the alignment granularity is likely to
> be 4k.
>
> This updates the linker script to assure that the the text section is
> aligned to a minimum of PAGE_SIZE regardless of build options.
>
> Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
> ---
>  arch/arm64/kernel/vmlinux.lds.S | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm64/kernel/vmlinux.lds.S b/arch/arm64/kernel/vmlinux.lds.S
> index 8a5d97b..bf7b972 100644
> --- a/arch/arm64/kernel/vmlinux.lds.S
> +++ b/arch/arm64/kernel/vmlinux.lds.S
> @@ -92,7 +92,7 @@ SECTIONS
>                 HEAD_TEXT
>         }
>         ALIGN_DEBUG_RO
> -       .text : {                       /* Real text segment            */
> +       .text ALIGN(PAGE_SIZE) : {      /* Real text segment            */
>                 _stext = .;             /* Text and read-only data      */
>                         __exception_text_start = .;
>                         *(.exception.text)
> --
> 2.4.3
>
>
