From: oberpar@linux.vnet.ibm.com (Peter Oberparleiter)
Date: Mon, 15 Feb 2016 15:34:21 +0100
Subject: [PATCH 4/5] gcov: disable tree-loop-im to reduce stack usage
In-Reply-To: <1455293187-179811-5-git-send-email-arnd@arndb.de>
References: <1455293187-179811-1-git-send-email-arnd@arndb.de>
 <1455293187-179811-5-git-send-email-arnd@arndb.de>
Message-ID: <56C1E1ED.1020205@linux.vnet.ibm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12.02.2016 17:06, Arnd Bergmann wrote:
> Enabling CONFIG_GCOV_PROFILE_ALL produces us a lot of warnings like
> 
> lib/lz4/lz4hc_compress.c: In function 'lz4_compresshcctx':
> lib/lz4/lz4hc_compress.c:514:1: warning: the frame size of 1504 bytes is larger than 1024 bytes [-Wframe-larger-than=]
> 
> After some investigation, I found that this behavior started with gcc-4.9,
> and opened https://gcc.gnu.org/bugzilla/show_bug.cgi?id=69702.
> A suggested workaround for it is to use the -fno-tree-loop-im
> flag that turns off one of the optimization stages in gcc, so the
> code runs a little slower but does not use excessive amounts
> of stack.
> 
> We could make this conditional on the gcc version, but I could not
> find an easy way to do this in Kbuild and the benefit would be
> fairly small, given that most of the gcc version in production are
> affected now.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

-fno-tree-loop-im seems to have been available for long enough in GCC
(starting with GCC4) to make this part of the default gcov compile flags.

Acked-by: Peter Oberparleiter <oberpar@linux.vnet.ibm.com>

> ---
>  Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Makefile b/Makefile
> index 352f55ccc54e..6bb89728a9d1 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -364,7 +364,7 @@ AFLAGS_MODULE   =
>  LDFLAGS_MODULE  =
>  CFLAGS_KERNEL	=
>  AFLAGS_KERNEL	=
> -CFLAGS_GCOV	= -fprofile-arcs -ftest-coverage
> +CFLAGS_GCOV	= -fprofile-arcs -ftest-coverage -fno-tree-loop-im
>  CFLAGS_KCOV	= -fsanitize-coverage=trace-pc
> 
> 


-- 
Peter Oberparleiter
Linux on z Systems Development - IBM Germany
