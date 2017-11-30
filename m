From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Thu, 30 Nov 2017 21:21:49 +0900
Subject: [PATCH 2/3] kbuild: add cc-if-name-version and compiler-specific
 variants
In-Reply-To: <20171129000011.55235-3-samitolvanen@google.com>
References: <20171129000011.55235-1-samitolvanen@google.com>
 <20171129000011.55235-3-samitolvanen@google.com>
Message-ID: <CAK7LNAQg4+eyR-mggswxvkBSxrdwFTQ3A733cSs4965UzO0qgQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2017-11-29 9:00 GMT+09:00 Sami Tolvanen <samitolvanen@google.com>:
> This change adds macros for testing both compiler name and
> version. Current cc-version, cc-ifversion etc. macros that test
> gcc version are left unchanged to prevent compatibility issues
> with existing tests.
>
> Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
> ---
>  scripts/Kbuild.include | 31 +++++++++++++++++++++++++++++++
>  1 file changed, 31 insertions(+)
>
> diff --git a/scripts/Kbuild.include b/scripts/Kbuild.include
> index 065324a8046f..b6d7d347b203 100644
> --- a/scripts/Kbuild.include
> +++ b/scripts/Kbuild.include
> @@ -215,6 +215,37 @@ cc-disable-warning = $(call try-run-cached,\
>  # Expands to either gcc or clang
>  cc-name = $(call shell-cached,$(CC) -v 2>&1 | grep -q "clang version" && echo clang || echo gcc)
>
> +# __cc-version
> +# Returns compiler version
> +__cc-version = $(shell $(CONFIG_SHELL) $(srctree)/scripts/$(cc-name)-version.sh $(CC))
> +
> +# __cc-fullversion
> +# Returns full compiler version
> +__cc-fullversion = $(shell $(CONFIG_SHELL) \
> +       $(srctree)/scripts/$(cc-name)-version.sh -p $(CC))
> +
> +# cc-if-name-version
> +# Matches compiler name and version
> +# Usage:  EXTRA_CFLAGS += $(call cc-if-name-version, gcc, -lt, 0402, -O1)
> +cc-if-name-version = $(shell [ $(cc-name) == $(1) ] && [ $(__cc-version) $(2) $(3) ] && echo $(4) || echo $(5))


BTW, did this patch work in your test?

After applying this series, I saw "/bin/sh: 1: [: gcc: unexpected operator"


$ make ARCH=arm64  CROSS_COMPILE=aarch64-linux-gnu-   defconfig
/bin/sh: 1: [: gcc: unexpected operator
*** Default configuration is based on 'defconfig'
#
# configuration written to .config
#


I needed to change

[ $(cc-name) == $(1) ]

into

[ $(cc-name) = $(1) ]

to make it work.



> +# cc-if-name-fullversion
> +# Matches compiler name and full version
> +# Usage:  EXTRA_CFLAGS += $(call cc-if-name-fullversion, gcc, -lt, 040502, -O1)
> +cc-if-name-fullversion = $(shell [ $(cc-name) == $(1) ] && [ $(__cc-fullversion) $(2) $(3) ] && echo $(4) || echo $(5))

Ditto.

I fixed '==' into '=' to make this work as expected.




As for the macro names, maybe

__cc-ifversion, __cc-if-fullversion for consistency?




> +# gcc-ifversion
> +gcc-ifversion = $(call cc-if-name-version, gcc, $(1), $(2), $(3), $(4))
> +
> +# gcc-if-fullversion
> +gcc-if-fullversion = (call cc-if-name-fullversion, gcc, $(1), $(2), $(3), $(4))
> +
> +# clang-ifversion
> +clang-ifversion =  $(call cc-if-name-version, clang, $(1), $(2), $(3), $(4))
> +
> +# clang-if-fullversion
> +clang-if-fullversion = (call cc-if-name-fullversion, clang, $(1), $(2), $(3), $(4))
> +

I think you can do like follows to avoid code duplication.

# backward compatibility
cc-ifversion = $(gcc-ifversion)
cc-if-fullversion = $(gcc-if-fullversion)




>  # cc-version
>  cc-version = $(call shell-cached,$(CONFIG_SHELL) $(srctree)/scripts/gcc-version.sh $(CC))
>
> --
> 2.15.0.417.g466bffb3ac-goog
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kbuild" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Best Regards
Masahiro Yamada
