From: olof@lixom.net (Olof Johansson)
Date: Mon, 3 Feb 2014 18:05:11 -0800
Subject: [RFC/RFT 2/2] ARM: keystone: Install hooks for dma address
 translation routines
In-Reply-To: <1391470107-15927-3-git-send-email-santosh.shilimkar@ti.com>
References: <1391470107-15927-1-git-send-email-santosh.shilimkar@ti.com>
 <1391470107-15927-3-git-send-email-santosh.shilimkar@ti.com>
Message-ID: <CAOesGMgzsx3gE6cT-nMTJfnO1T5pvfTr8HA6tVGv8svF_kCYjg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Feb 3, 2014 at 3:28 PM, Santosh Shilimkar
<santosh.shilimkar@ti.com> wrote:
> Keystone platforms have their physical memory mapped at an address
> outside the 32-bit physical range.  A Keystone machine with 16G of RAM
> would find its memory at 0x0800000000 - 0x0bffffffff.
> The system interconnect allows to perform DMA transfers from first 2G of
> physical memory (0x08 0000 0000 to 08 7FFF FFFF) which aliased in
> hardware to the 32-bit addressable space (0x80000000 - 0xffffffff),
> because DMA HW supports only 32-bits addressing.
>
> Hence, add arch hooks for dma address translation routines.
>
> Cc: Russell King <linux@arm.linux.org.uk>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Nicolas Pitre <nicolas.pitre@linaro.org>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Olof Johansson <olof@lixom.net>
> Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> ---
>  arch/arm/mach-keystone/keystone.c |   31 +++++++++++++++++++++++++++++++
>  1 file changed, 31 insertions(+)
>
> diff --git a/arch/arm/mach-keystone/keystone.c b/arch/arm/mach-keystone/keystone.c
> index 1b43a27..54dae03 100644
> --- a/arch/arm/mach-keystone/keystone.c
> +++ b/arch/arm/mach-keystone/keystone.c
> @@ -14,6 +14,7 @@
>  #include <linux/init.h>
>  #include <linux/of_platform.h>
>  #include <linux/of_address.h>
> +#include <linux/dma-mapping.h>
>
>  #include <asm/setup.h>
>  #include <asm/mach/map.h>
> @@ -53,6 +54,28 @@ static phys_addr_t keystone_virt_to_idmap(unsigned long x)
>         return (phys_addr_t)(x) - CONFIG_PAGE_OFFSET + KEYSTONE_LOW_PHYS_START;
>  }
>
> +static unsigned long keystone_dma_pfn_offset __read_mostly;
> +
> +static dma_addr_t keystone_pfn_to_dma(struct device *dev, unsigned long pfn)
> +{
> +       return PFN_PHYS(pfn - keystone_dma_pfn_offset);
> +}
> +
> +static unsigned long keystone_dma_to_pfn(struct device *dev, dma_addr_t addr)
> +{
> +       return PFN_DOWN(addr) + keystone_dma_pfn_offset;
> +}
> +
> +static void *keystone_dma_to_virt(struct device *dev, dma_addr_t addr)
> +{
> +       return phys_to_virt(addr + PFN_PHYS(keystone_dma_pfn_offset));
> +}
> +
> +static dma_addr_t keystone_virt_to_dma(struct device *dev, void *addr)
> +{
> +       return virt_to_phys(addr) - PFN_PHYS(keystone_dma_pfn_offset);
> +}
> +
>  static void __init keystone_init_meminfo(void)
>  {
>         bool lpae = IS_ENABLED(CONFIG_ARM_LPAE);
> @@ -89,6 +112,14 @@ static void __init keystone_init_meminfo(void)
>         /* Populate the arch idmap hook */
>         arch_virt_to_idmap = keystone_virt_to_idmap;
>
> +       /* Populate the arch DMA hooks */
> +       keystone_dma_pfn_offset = PFN_DOWN(KEYSTONE_HIGH_PHYS_START -
> +                                          KEYSTONE_LOW_PHYS_START);
> +       __arch_pfn_to_dma = keystone_pfn_to_dma;
> +       __arch_dma_to_pfn = keystone_dma_to_pfn;
> +       __arch_dma_to_virt = keystone_dma_to_virt;
> +       __arch_virt_to_dma = keystone_virt_to_dma;

Is this truly a static window, or is it going through an IOMMU that
just happens to have an identity mapping setup per default?

PPC servers use "ibm,dma-window" to describe the assigned dma address
space for busses/devices, but the window itself doesn't contain any
information about the physical address mapping (since it goes through
an iommu after that). It likely doesn't fit this particular use case,
but it's something we should look at as a base in case we need to
start looking at bindings for this instead of coding it per SoC. We'll
know more once we've seen what a few of the implementations out there
are.


-Olof
