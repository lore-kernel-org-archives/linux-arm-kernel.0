From: hpa@zytor.com (H. Peter Anvin)
Date: Mon, 14 Dec 2015 10:58:28 -0800
Subject: [PATCH v6 4/4] x86: mm: support ARCH_MMAP_RND_BITS.
In-Reply-To: <1449856338-30984-5-git-send-email-dcashman@android.com>
References: <1449856338-30984-1-git-send-email-dcashman@android.com>
 <1449856338-30984-2-git-send-email-dcashman@android.com>
 <1449856338-30984-3-git-send-email-dcashman@android.com>
 <1449856338-30984-4-git-send-email-dcashman@android.com>
 <1449856338-30984-5-git-send-email-dcashman@android.com>
Message-ID: <566F1154.7030703@zytor.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/11/15 09:52, Daniel Cashman wrote:
> From: dcashman <dcashman@google.com>
> 
> x86: arch_mmap_rnd() uses hard-coded values, 8 for 32-bit and 28 for
> 64-bit, to generate the random offset for the mmap base address.
> This value represents a compromise between increased ASLR
> effectiveness and avoiding address-space fragmentation. Replace it
> with a Kconfig option, which is sensibly bounded, so that platform
> developers may choose where to place this compromise. Keep default
> values as new minimums.
> 
> Signed-off-by: Daniel Cashman <dcashman@android.com>

OK, this is around the time when I make a lecture about the danger of
expecting the compiler to make certain transformations:

> diff --git a/arch/x86/mm/mmap.c b/arch/x86/mm/mmap.c
> index 844b06d..647fecf 100644
> --- a/arch/x86/mm/mmap.c
> +++ b/arch/x86/mm/mmap.c
> @@ -69,14 +69,14 @@ unsigned long arch_mmap_rnd(void)
>  {
>  	unsigned long rnd;
>  
> -	/*
> -	 *  8 bits of randomness in 32bit mmaps, 20 address space bits
> -	 * 28 bits of randomness in 64bit mmaps, 40 address space bits
> -	 */
>  	if (mmap_is_ia32())
> -		rnd = (unsigned long)get_random_int() % (1<<8);
> +#ifdef CONFIG_COMPAT
> +		rnd = (unsigned long)get_random_int() % (1 << mmap_rnd_compat_bits);
> +#else
> +		rnd = (unsigned long)get_random_int() % (1 << mmap_rnd_bits);
> +#endif
>  	else
> -		rnd = (unsigned long)get_random_int() % (1<<28);
> +		rnd = (unsigned long)get_random_int() % (1 << mmap_rnd_bits);
>  
>  	return rnd << PAGE_SHIFT;
>  }
> 

Now, you and I know that both variants can be implemented with a simple
AND, but I have a strong suspicion that once this is turned into a
variable, this will in fact be changed from an AND to a divide.

So I'd prefer to use the
"get_random_int() & ((1UL << mmap_rnd_bits) - 1)" construct instead.

	-hpa
