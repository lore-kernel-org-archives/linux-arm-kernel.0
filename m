From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 8 Jan 2014 20:57:54 +0000
Subject: [PATCH RFC 2/3] ARM: kernel: add support for cpu cache information
In-Reply-To: <1389209168-17189-3-git-send-email-sudeep.holla@arm.com>
References: <1389209168-17189-1-git-send-email-sudeep.holla@arm.com>
 <1389209168-17189-3-git-send-email-sudeep.holla@arm.com>
Message-ID: <20140108205754.GN27432@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 08, 2014 at 07:26:07PM +0000, Sudeep Holla wrote:
> +#if __LINUX_ARM_ARCH__ < 7 /* pre ARMv7 */
> +
> +#define MAX_CACHE_LEVEL		1	/* Only 1 level supported */
> +#define CTR_CTYPE_SHIFT		24
> +#define CTR_CTYPE_MASK		(1 << CTR_CTYPE_SHIFT)
> +
> +static inline unsigned int get_ctr(void)
> +{
> +	unsigned int ctr;
> +	asm volatile ("mrc p15, 0, %0, c0, c0, 1" : "=r" (ctr));
> +	return ctr;
> +}
> +
> +static enum cache_type get_cache_type(int level)
> +{
> +	if (level > MAX_CACHE_LEVEL)
> +		return CACHE_TYPE_NOCACHE;
> +	return get_ctr() & CTR_CTYPE_MASK ?
> +		CACHE_TYPE_SEPARATE : CACHE_TYPE_UNIFIED;

So, what do we do for CPUs that don't implement the CTR?  Just return
random rubbish based on decoding the CPU Identity register as if it
were the cache type register?

-- 
FTTC broadband for 0.8mile line: 5.8Mbps down 500kbps up.  Estimation
in database were 13.1 to 19Mbit for a good line, about 7.5+ for a bad.
Estimate before purchase was "up to 13.2Mbit".
