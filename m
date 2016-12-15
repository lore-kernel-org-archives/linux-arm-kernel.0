From: mark.rutland@arm.com (Mark Rutland)
Date: Thu, 15 Dec 2016 11:55:09 +0000
Subject: [PATCH] boot-wrapper: configure: fix file detection when
 cross-compiling
In-Reply-To: <20161122151501.16643-1-andre.przywara@arm.com>
References: <20161122151501.16643-1-andre.przywara@arm.com>
Message-ID: <20161215115509.GC21758@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 22, 2016 at 03:15:01PM +0000, Andre Przywara wrote:
> The autotools documentation states that CHECKFILES cannot be used when
> cross-compiling[1], because it's meant to check files in the target
> system, not on the build host. When just giving --host on the configure
> command line, the script detects cross compilation rather late; and as the
> file test just happens to execute earlier, this works anyway.
> However if one gives both --host and --build, cross compilation is
> detected very early and ./configure complains:
> 
> checking for /src/linux-arm64... configure: error: cannot check for file existence when cross compiling
> 
> So replace the checkfile macro usage with a simple "test -f" call (which
> is the recommended way of checking for files on the build host) and output
> proper error messages.
> 
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> 
> [1] https://www.gnu.org/software/autoconf/manual/autoconf.html#Files

This looks fine to me. Does this conflict with the Xen patches at all?

To make it easier to pick these all up, could you please fold this into
the Xen series as a preparatory patch?

Thanks,
Mark.

> ---
>  configure.ac | 23 ++++++++++++++++++-----
>  1 file changed, 18 insertions(+), 5 deletions(-)
> 
> diff --git a/configure.ac b/configure.ac
> index ab8f5b3..e0daec4 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -41,12 +41,25 @@ AC_ARG_WITH([dtb],
>  	[KERN_DTB="$withval"])
>  
>  # Ensure that the user has provided us with a sane kernel dir.
> -m4_define([CHECKFILES], [KERN_DIR,
> -	KERN_DTB,
> -	KERN_IMAGE])
> +if ! test -d $KERN_DIR; then
> +	AC_MSG_ERROR([Could not find Linux kernel dir $KERN_DIR.])
> +fi
> +
> +AC_MSG_CHECKING([whether DTB file exists])
> +if ! test -f $KERN_DTB; then
> +	AC_MSG_RESULT([no])
> +	AC_MSG_ERROR([You need to specify a valid DTB file, could not find: $KERN_DTB])
> +else
> +	AC_MSG_RESULT([yes])
> +fi
>  
> -m4_foreach([checkfile], [CHECKFILES],
> -	[AC_CHECK_FILE([$checkfile], [], AC_MSG_ERROR([No such file or directory: $checkfile]))])
> +AC_MSG_CHECKING([whether kernel image exists])
> +if ! test -f $KERN_IMAGE; then
> +	AC_MSG_RESULT([no])
> +	AC_MSG_ERROR([You need to compile a kernel first, could not find: $KERN_IMAGE])
> +else
> +	AC_MSG_RESULT([yes])
> +fi
>  
>  AC_SUBST([KERNEL_IMAGE], [$KERN_IMAGE])
>  AC_SUBST([KERNEL_DTB], [$KERN_DTB])
> -- 
> 2.9.0
> 
