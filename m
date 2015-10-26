From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 26 Oct 2015 20:16:11 +0000
Subject: [PATCH v2] arm64: Align .text section to PAGE_SIZE
In-Reply-To: <1445882989-10618-1-git-send-email-jeremy.linton@arm.com>
References: <1445882989-10618-1-git-send-email-jeremy.linton@arm.com>
Message-ID: <20151026201611.GI12277@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Oct 26, 2015 at 01:09:49PM -0500, Jeremy Linton wrote:
> v2:
> Use ALIGN_DEBUG_RO_MIN() instead of ALIGN() directly.
> 
> v1:

Move the v* stuff below the ---, there's no need for that in the
permanent commit message.

> It appears that 64k page kernel's die early, in a somewhat random set
> of locations when built without KVM. Most likely during memblock
> manipulations (depending on kernel debug options).
> 
> Normally when KVM is built into the kernel it has an explicit
> PAGE_SIZE alignment requirement and that forces the text section to be
> aligned to PAGE_SIZE. Without it, the alignment granularity is likely to
> be 4k.

Please replace these with a description of the issue as an effect of
CONFIG_DEBUG_RO_DATA && !CONFIG_DEBUG_ALIGN_RODATA, now that Ard figured
that out for us, so we don't have to figure it out again in future.

e.g.

A kernel built with DEBUG_RO_DATA && !CONFIG_DEBUG_ALIGN_RODATA doesn't
have .text aligned to a page boundary, though fixup_executable works at
page-genularity thanks to its use of create_mapping. If .text is not
page-aligned, the first page it exists in may be marked non-executable,
leading to failures when an attempt is made to execute code in said
page.

> This updates the linker script to assure that the the text section is

Nit: s/assure/ensure/

> aligned to a minimum of PAGE_SIZE regardless of build options.
> 
> Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
> ---
>  arch/arm64/kernel/vmlinux.lds.S | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/kernel/vmlinux.lds.S b/arch/arm64/kernel/vmlinux.lds.S
> index 8a5d97b..f3fc966 100644
> --- a/arch/arm64/kernel/vmlinux.lds.S
> +++ b/arch/arm64/kernel/vmlinux.lds.S
> @@ -91,7 +91,7 @@ SECTIONS
>  		_text = .;
>  		HEAD_TEXT
>  	}
> -	ALIGN_DEBUG_RO
> +	ALIGN_DEBUG_RO_MIN(PAGE_SIZE)

I'm in two minds about having a separate macro, as you suggested to save
space when !DEBUG_RO_DATA. I won't strongly push for it, though it would
be nice to not waste memory here if we don't have to.

Also, couldn't the same issue happen for other sections (e.g. rodata)?

Perhaps it would be better to have something like the following (with
PAGE_SHIFT sorted out to be includable in a linker script), so any
ALIGN_DEBUG_RO* correctly aligns things to whatever boundary is
required, and we don't need to over-align things in the !DEBUG_RO_DATA
case.

Thanks,
Mark.

---->8----
diff --git a/arch/arm64/kernel/vmlinux.lds.S b/arch/arm64/kernel/vmlinux.lds.S
index 9807333..4d77757 100644
--- a/arch/arm64/kernel/vmlinux.lds.S
+++ b/arch/arm64/kernel/vmlinux.lds.S
@@ -60,9 +60,12 @@ PECOFF_FILE_ALIGNMENT = 0x200;
 #define PECOFF_EDATA_PADDING
 #endif
 
-#ifdef CONFIG_DEBUG_ALIGN_RODATA
+#if defined(CONFIG_DEBUG_ALIGN_RODATA)
 #define ALIGN_DEBUG_RO                 . = ALIGN(1<<SECTION_SHIFT);
 #define ALIGN_DEBUG_RO_MIN(min)                ALIGN_DEBUG_RO
+#elif defined(CONFIG_DEBUG_RODATA)
+#define ALIGN_DEBUG_RO                 . = ALIGN(1<<PAGE_SHIFT);
+#define ALIGN_DEBUG_RO_MIN(min)                ALIGN_DEBUG_RO
 #else
 #define ALIGN_DEBUG_RO
 #define ALIGN_DEBUG_RO_MIN(min)                . = ALIGN(min);
