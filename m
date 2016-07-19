From: borntraeger@de.ibm.com (Christian Borntraeger)
Date: Tue, 19 Jul 2016 11:21:13 +0200
Subject: [PATCH v3 02/11] mm: Hardened usercopy
In-Reply-To: <1468619065-3222-3-git-send-email-keescook@chromium.org>
References: <1468619065-3222-1-git-send-email-keescook@chromium.org>
 <1468619065-3222-3-git-send-email-keescook@chromium.org>
Message-ID: <578DF109.5030704@de.ibm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/15/2016 11:44 PM, Kees Cook wrote:
> +config HAVE_ARCH_LINEAR_KERNEL_MAPPING
> +	bool
> +	help
> +	  An architecture should select this if it has a secondary linear
> +	  mapping of the kernel text. This is used to verify that kernel
> +	  text exposures are not visible under CONFIG_HARDENED_USERCOPY.

I have trouble parsing this. (What does secondary linear mapping mean?)
So let me give an example below

> +
[...]
> +/* Is this address range in the kernel text area? */
> +static inline const char *check_kernel_text_object(const void *ptr,
> +						   unsigned long n)
> +{
> +	unsigned long textlow = (unsigned long)_stext;
> +	unsigned long texthigh = (unsigned long)_etext;
> +
> +	if (overlaps(ptr, n, textlow, texthigh))
> +		return "<kernel text>";
> +
> +#ifdef HAVE_ARCH_LINEAR_KERNEL_MAPPING
> +	/* Check against linear mapping as well. */
> +	if (overlaps(ptr, n, (unsigned long)__va(__pa(textlow)),
> +		     (unsigned long)__va(__pa(texthigh))))
> +		return "<linear kernel text>";
> +#endif
> +
> +	return NULL;
> +}

s390 has an address space for user (primary address space from 0..4TB/8PB) and a separate 
address space (home space from 0..4TB/8PB) for the kernel. In this home space the kernel
mapping is virtual containing the physical memory as well as vmalloc memory (creating aliases
into the physical one). The kernel text is mapped from _stext to _etext in this mapping.
So I assume this would qualify for HAVE_ARCH_LINEAR_KERNEL_MAPPING ?
