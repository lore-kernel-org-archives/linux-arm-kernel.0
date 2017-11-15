From: keescook@chromium.org (Kees Cook)
Date: Wed, 15 Nov 2017 13:48:52 -0800
Subject: [PATCH v2 03/18] kbuild: move gcc-version.sh to cc-version.sh and
 add clang support
In-Reply-To: <20171115213428.22559-4-samitolvanen@google.com>
References: <20171115213428.22559-1-samitolvanen@google.com>
 <20171115213428.22559-4-samitolvanen@google.com>
Message-ID: <CAGXu5jL0B18ijuFxySBzcOtju3DL-UZfb39mWLxww5SJ5P3Feg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 15, 2017 at 1:34 PM, Sami Tolvanen <samitolvanen@google.com> wrote:
> Signed-off-by: Sami Tolvanen <samitolvanen@google.com>

It might make sense to split this patch: do the move and refactoring,
then add clang support.

Though, won't this confuse some tests? A lot of cc-version tests are
expecting only gcc, yes?

-Kees

> ---
>  scripts/Kbuild.include |  4 ++--
>  scripts/cc-version.sh  | 45 +++++++++++++++++++++++++++++++++++++++++++++
>  scripts/gcc-version.sh | 33 ---------------------------------
>  3 files changed, 47 insertions(+), 35 deletions(-)
>  create mode 100755 scripts/cc-version.sh
>  delete mode 100755 scripts/gcc-version.sh
>
> diff --git a/scripts/Kbuild.include b/scripts/Kbuild.include
> index 584d6cecd7c0..de41ab74121e 100644
> --- a/scripts/Kbuild.include
> +++ b/scripts/Kbuild.include
> @@ -143,11 +143,11 @@ cc-disable-warning = $(call try-run,\
>  cc-name = $(shell $(CC) -v 2>&1 | grep -q "clang version" && echo clang || echo gcc)
>
>  # cc-version
> -cc-version = $(shell $(CONFIG_SHELL) $(srctree)/scripts/gcc-version.sh $(CC))
> +cc-version = $(shell $(CONFIG_SHELL) $(srctree)/scripts/cc-version.sh $(CC))
>
>  # cc-fullversion
>  cc-fullversion = $(shell $(CONFIG_SHELL) \
> -       $(srctree)/scripts/gcc-version.sh -p $(CC))
> +       $(srctree)/scripts/cc-version.sh -p $(CC))
>
>  # cc-ifversion
>  # Usage:  EXTRA_CFLAGS += $(call cc-ifversion, -lt, 0402, -O1)
> diff --git a/scripts/cc-version.sh b/scripts/cc-version.sh
> new file mode 100755
> index 000000000000..6d085a8a07e8
> --- /dev/null
> +++ b/scripts/cc-version.sh
> @@ -0,0 +1,45 @@
> +#!/bin/sh
> +# SPDX-License-Identifier: GPL-2.0
> +#
> +# cc-version [-p] cc-command
> +#
> +# Prints the compiler version of `command' in a canonical 4-digit form
> +# such as `0295' for gcc-2.95, `0303' for gcc-3.3, etc.
> +#
> +# With the -p option, prints the patchlevel as well, for example `029503' for
> +# gcc-2.95.3, `030301' for gcc-3.3.1, etc.
> +#
> +
> +if [ "$1" = "-p" ] ; then
> +       with_patchlevel=1;
> +       shift;
> +fi
> +
> +compiler="$*"
> +
> +if [ ${#compiler} -eq 0 ]; then
> +       echo "Error: No compiler specified."
> +       printf "Usage:\n\t$0 <cc-command>\n"
> +       exit 1
> +fi
> +
> +clang=$(echo __clang__ | $compiler -E -x c - | tail -n1)
> +
> +if [ "$clang" == "1" ]; then
> +       major_macro="__clang_major__"
> +       minor_macro="__clang_minor__"
> +       patchlevel_macro="__clang_patchlevel__"
> +else
> +       major_macro="__GNUC__"
> +       minor_macro="__GNUC_MINOR__"
> +       patchlevel_macro="__GNUC_PATCHLEVEL__"
> +fi
> +
> +MAJOR=$(echo $major_macro | $compiler -E -x c - | tail -n 1)
> +MINOR=$(echo $minor_macro | $compiler -E -x c - | tail -n 1)
> +if [ "x$with_patchlevel" != "x" ] ; then
> +       PATCHLEVEL=$(echo $patchlevel_macro | $compiler -E -x c - | tail -n 1)
> +       printf "%02d%02d%02d\\n" $MAJOR $MINOR $PATCHLEVEL
> +else
> +       printf "%02d%02d\\n" $MAJOR $MINOR
> +fi
> diff --git a/scripts/gcc-version.sh b/scripts/gcc-version.sh
> deleted file mode 100755
> index 11bb909845e7..000000000000
> --- a/scripts/gcc-version.sh
> +++ /dev/null
> @@ -1,33 +0,0 @@
> -#!/bin/sh
> -# SPDX-License-Identifier: GPL-2.0
> -#
> -# gcc-version [-p] gcc-command
> -#
> -# Prints the gcc version of `gcc-command' in a canonical 4-digit form
> -# such as `0295' for gcc-2.95, `0303' for gcc-3.3, etc.
> -#
> -# With the -p option, prints the patchlevel as well, for example `029503' for
> -# gcc-2.95.3, `030301' for gcc-3.3.1, etc.
> -#
> -
> -if [ "$1" = "-p" ] ; then
> -       with_patchlevel=1;
> -       shift;
> -fi
> -
> -compiler="$*"
> -
> -if [ ${#compiler} -eq 0 ]; then
> -       echo "Error: No compiler specified."
> -       printf "Usage:\n\t$0 <gcc-command>\n"
> -       exit 1
> -fi
> -
> -MAJOR=$(echo __GNUC__ | $compiler -E -x c - | tail -n 1)
> -MINOR=$(echo __GNUC_MINOR__ | $compiler -E -x c - | tail -n 1)
> -if [ "x$with_patchlevel" != "x" ] ; then
> -       PATCHLEVEL=$(echo __GNUC_PATCHLEVEL__ | $compiler -E -x c - | tail -n 1)
> -       printf "%02d%02d%02d\\n" $MAJOR $MINOR $PATCHLEVEL
> -else
> -       printf "%02d%02d\\n" $MAJOR $MINOR
> -fi
> --
> 2.15.0.448.gf294e3d99a-goog
>



-- 
Kees Cook
Pixel Security
