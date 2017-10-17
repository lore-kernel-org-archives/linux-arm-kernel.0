From: will.deacon@arm.com (Will Deacon)
Date: Tue, 17 Oct 2017 11:37:39 +0100
Subject: [PATCH 1/4] kbuild: allow global override of CC instrumentation
In-Reply-To: <20171016132440.38098-2-mark.rutland@arm.com>
References: <20171016132440.38098-1-mark.rutland@arm.com>
 <20171016132440.38098-2-mark.rutland@arm.com>
Message-ID: <20171017103739.GB22140@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 16, 2017 at 02:24:37PM +0100, Mark Rutland wrote:
> Currently, we have a number of compiler instrumentation features, each
> with its own overrides to disable instrumentation of a file or
> directory.
> 
> In a few cases, there are files with special ABI requirements, for which
> we need to avoid all instrumentation. Having to apply each override
> manually is tedious, and error-prone as new instrumentation features are
> introduced.
> 
> To make matters easier, this patch adds a new CC_INSTRUMENT override,
> allowing instrumentation to be avoided for certain files or directories.
> This can also be overridden on a per-file or per-directory basis, to
> allow opting in to some instrumentation.
> 
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> Cc: Andrey Konovalov <adech.fo@gmail.com>
> Cc: Andrey Ryabinin <aryabinin@virtuozzo.com>
> Cc: Dmitry Vyukov <dvyukov@google.com>
> Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
> Cc: Michal Marek <mmarek@suse.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: linux-kbuild at vger.kernel.org
> ---
>  scripts/Makefile.lib | 17 +++++++++++++----
>  1 file changed, 13 insertions(+), 4 deletions(-)
> 
> diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
> index 5e975fee0f5b..c7d71f482b57 100644
> --- a/scripts/Makefile.lib
> +++ b/scripts/Makefile.lib
> @@ -109,6 +109,15 @@ orig_a_flags   = $(KBUILD_CPPFLAGS) $(KBUILD_AFLAGS) $(KBUILD_SUBDIR_ASFLAGS) \
>  _a_flags       = $(filter-out $(AFLAGS_REMOVE_$(basetarget).o), $(orig_a_flags))
>  _cpp_flags     = $(KBUILD_CPPFLAGS) $(cppflags-y) $(CPPFLAGS_$(@F))
>  
> +# Each of the compiler instrumentation features below can be selectively
> +# enabled or disable for files or directoies. In decreasing order of

Should be "disabled". Also, typo: "directoies".

> +# predence, each option foo is controlled by:

Typo: "predence"

> +# FOO_obj.o := [yn]
> +# CC_INSTRUMENT_obj.o := [yn]
> +# FOO := [yn]
> +# CC_INSTRUMENT := [yn]
> +# FOO_all := [yn]

I'm not sure it's worth mentioning FOO_all here: for KASAN it's just 'y'
and for the others it's driven by a CONFIG option that would be better
controlled using Kconfig rather than in Makefiles.

Otherwise,

Acked-by: Will Deacon <will.deacon@arm.com>

Will
