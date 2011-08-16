From: hartleys@visionengravers.com (H Hartley Sweeten)
Date: Tue, 16 Aug 2011 11:19:24 -0500
Subject: [PATCH v2] amba: consolidate PrimeCell magic
In-Reply-To: <1313484514-25412-1-git-send-email-linus.walleij@stericsson.com>
References: <1313484514-25412-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <ADE657CA350FB648AAC2C43247A983F001F3884BB0A3@AUSP01VMBX24.collaborationhost.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday, August 16, 2011 1:49 AM, Linus Walleij wrote:
>
> Since two drivers use the PrimeCell scheme without using the
> amba_bus driver logic, let's break the magic lookups out as
> static inlines in the <linux/amba/bus.h> header so we get
> some consolidation anyway. Delete the primecell ID check in
> common/pl330.c since it is only used from the amba_bus driver
> in drivers/dma, which is already doing the same check when
> probing in drivers/amba/bus.c.
>
> Cc: Jassi Brar <jassisinghbrar@gmail.com>
> Cc: Kukjin Kim <kgene.kim@samsung.com>
> Cc: Viresh Kumar <viresh.kumar@st.com>
> Cc: Boojin Kim <boojin.kim@samsung.com>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---

[snip]

>  include/linux/amba/bus.h     |   26 ++++++++++++++++++++++++++

[snip]

> diff --git a/include/linux/amba/bus.h b/include/linux/amba/bus.h
> index fcbbe71..008cfcf 100644
> --- a/include/linux/amba/bus.h
> +++ b/include/linux/amba/bus.h
> @@ -19,6 +19,7 @@
>  #include <linux/err.h>
>  #include <linux/resource.h>
>  #include <linux/regulator/consumer.h>
> +#include <linux/io.h>
>  
>  #define AMBA_NR_IRQS	2
>  #define AMBA_CID	0xb105f00d
> @@ -94,4 +95,29 @@ void amba_release_regions(struct amba_device *);
>  #define amba_manf(d)	AMBA_MANF_BITS((d)->periphid)
>  #define amba_part(d)	AMBA_PART_BITS((d)->periphid)
>  
> +/*
> + * Inlines to extract the PID and CID for a certain PrimeCell. These are at
> + * offset -0x20 and -0x10 from the end of the I/O region respectively.
> + */
> +static inline u32 amba_get_magic(void __iomem *base, u32 size, u8 offset)
> +{
> +	u32 magic;
> +	int i;
> +
> +	for (magic = 0, i = 0; i < 4; i++)
> +		magic |= (readl(base + size - offset + 4 * i) & 255)
> +			<< (i * 8);
> +	return magic;
> +}
> +
> +static inline u32 amba_get_pid(void __iomem *base, u32 size)
> +{
> +	return amba_get_magic(base, size, 0x20);
> +}
> +
> +static inline u32 amba_get_cid(void __iomem *base, u32 size)
> +{
> +	return amba_get_magic(base, size, 0x10);
> +}
> +
>  #endif

Hmm..  Could this also be used in arch/arm/common/vic.c vic_init()?

Here's the relevant code from that function:

	unsigned int i;
	u32 cellid = 0;
	enum amba_vendor vendor;

	/* Identify which VIC cell this one is, by reading the ID */
	for (i = 0; i < 4; i++) {
		u32 addr = ((u32)base & PAGE_MASK) + 0xfe0 + (i * 4);
		cellid |= (readl(addr) & 0xff) << (8 * i);
	}
	vendor = (cellid >> 12) & 0xff;
	printk(KERN_INFO "VIC @%p: id 0x%08x, vendor 0x%02x\n",
	       base, cellid, vendor);

	switch(vendor) {

Regards,
Hartley
