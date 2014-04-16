From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 16 Apr 2014 11:12:43 +0100
Subject: [PATCH v7 2/2] ARM hibernation / suspend-to-disk
In-Reply-To: <1394016605-24120-3-git-send-email-sebastian.capella@linaro.org>
References: <1394016605-24120-1-git-send-email-sebastian.capella@linaro.org>
 <1394016605-24120-3-git-send-email-sebastian.capella@linaro.org>
Message-ID: <20140416101243.GA6952@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 05, 2014 at 02:50:05AM -0800, Sebastian Capella wrote:
> diff --git a/arch/arm/include/asm/memory.h b/arch/arm/include/asm/memory.h
> index 8756e4b..d32adbb 100644
> --- a/arch/arm/include/asm/memory.h
> +++ b/arch/arm/include/asm/memory.h
> @@ -291,6 +291,7 @@ static inline void *phys_to_virt(phys_addr_t x)
>   */
>  #define __pa(x)			__virt_to_phys((unsigned long)(x))
>  #define __va(x)			((void *)__phys_to_virt((phys_addr_t)(x)))
> +#define __pa_symbol(x)		__pa((unsigned long)(x))
>  #define pfn_to_kaddr(pfn)	__va((pfn) << PAGE_SHIFT)

I don't see the appropriate version on the mailing list, so I'll comment
here instead.  In 8011/1, you added here:

+#define virt_to_pfn(kaddr)      (__pa(kaddr) >> PAGE_SHIFT)

which conflicts with my solution (which fixes some rather horrid assembly
code).  You can find my change as e26a9e00afc4 (ARM: Better virt_to_page()
handling).  I can drop this from your patch, but it would be a good idea
if you could re-validate against v3.15-rc1.

Thanks.

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
