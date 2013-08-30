From: grant.likely@secretlab.ca (Grant Likely)
Date: Fri, 30 Aug 2013 14:43:25 +0100
Subject: [PATCH 14/16] Add strstr to compressed string.c for ARM.
In-Reply-To: <1376090777-20090-15-git-send-email-roy.franz@linaro.org>
References: <1376090777-20090-1-git-send-email-roy.franz@linaro.org>
 <1376090777-20090-15-git-send-email-roy.franz@linaro.org>
Message-ID: <20130830134325.51DC83E102A@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri,  9 Aug 2013 16:26:15 -0700, Roy Franz <roy.franz@linaro.org> wrote:
> The shared efi-stub-helper.c functions require a strstr
> implementation.
> Implementation copied from arch/x86/boot/string.c
> 
> Signed-off-by: Roy Franz <roy.franz@linaro.org>

Okay, but at some point arch/arm/boot/compressed/string.c should be
reworked into a common place.

Reviewed-by: Grant Likely <grant.likely@linaro.org>

> ---
>  arch/arm/boot/compressed/string.c |   21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
> 
> diff --git a/arch/arm/boot/compressed/string.c b/arch/arm/boot/compressed/string.c
> index 36e53ef..5397792 100644
> --- a/arch/arm/boot/compressed/string.c
> +++ b/arch/arm/boot/compressed/string.c
> @@ -111,6 +111,27 @@ char *strchr(const char *s, int c)
>  	return (char *)s;
>  }
>  
> +/**
> + * strstr - Find the first substring in a %NUL terminated string
> + * @s1: The string to be searched
> + * @s2: The string to search for
> + */
> +char *strstr(const char *s1, const char *s2)
> +{
> +	size_t l1, l2;
> +
> +	l2 = strlen(s2);
> +	if (!l2)
> +		return (char *)s1;
> +	l1 = strlen(s1);
> +	while (l1 >= l2) {
> +		l1--;
> +		if (!memcmp(s1, s2, l2))
> +			return (char *)s1;
> +		s1++;
> +	}
> +	return NULL;
> +}
>  #undef memset
>  
>  void *memset(void *s, int c, size_t count)
> -- 
> 1.7.10.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
