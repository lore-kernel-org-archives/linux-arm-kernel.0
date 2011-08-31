From: rmallon@gmail.com (Ryan Mallon)
Date: Thu, 01 Sep 2011 09:30:06 +1000
Subject: [PATCH 01/24] fix default __strnlen_user macro
In-Reply-To: <1314826019-22330-2-git-send-email-msalter@redhat.com>
References: <1314826019-22330-1-git-send-email-msalter@redhat.com>
	<1314826019-22330-2-git-send-email-msalter@redhat.com>
Message-ID: <4E5EC3FE.10307@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/09/11 07:26, Mark Salter wrote:
> The existing __strnlen_user macro simply resolved to strnlen. However, the
> count returned by strnlen_user should include the NULL byte. This patch
> fixes the __strnlen_user macro to include the NULL byte in the count.
>
> Signed-off-by: Mark Salter<msalter@redhat.com>
> ---
>   include/asm-generic/uaccess.h |    2 +-
>   1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/include/asm-generic/uaccess.h b/include/asm-generic/uaccess.h
> index ac68c99..1d0fdf8 100644
> --- a/include/asm-generic/uaccess.h
> +++ b/include/asm-generic/uaccess.h
> @@ -289,7 +289,7 @@ strncpy_from_user(char *dst, const char __user *src, long count)
>    * Return 0 on exception, a value greater than N if too long
>    */
>   #ifndef __strnlen_user
> -#define __strnlen_user strnlen
> +#define __strnlen_user(s, n) (strnlen((s), (n)) + 1)
>   #endif

I don't think this is correct because if you hit maxlen you will add one 
to it. e.g. __strnlen_user("abcd\0", 3) would return 4 instead of 3.

It should probably be something like this:

#define __strnlen_user(s, n) ({		\
	size_t k = strnlen(s, n);	\
	k<  n ? k + 1 : n; })


I wonder if this change will break anything since it has been incorrect 
(according to the comment in uaccess.h@least) for a while. Why does 
__strnlen_user have different semantics to strnlen anway?

~Ryan
