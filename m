From: horms@verge.net.au (Simon Horman)
Date: Mon, 22 Apr 2013 13:57:58 +0900
Subject: [PATCH v2 2/4] ARM: shmobile: r8a7779: add VIN support
In-Reply-To: <5171DD05.6020400@cogentembedded.com>
References: <201304200232.33731.sergei.shtylyov@cogentembedded.com>
 <5171DD05.6020400@cogentembedded.com>
Message-ID: <20130422045758.GP15680@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Apr 20, 2013 at 04:10:45AM +0400, Sergei Shtylyov wrote:
> Hello.
> 
> On 04/20/2013 02:32 AM, Sergei Shtylyov wrote:
> 
> >From: Vladimir Barinov <vladimir.barinov@cogentembedded.com>
> >
> >Add VIN clocks and platform devices for R8A7779 SoC; add function to register
> >the VIN platform devices.
> >
> >Signed-off-by: Vladimir Barinov <vladimir.barinov@cogentembedded.com>
> >[Sergei: added 'id' parameter check to r8a7779_add_vin_device(), renamed some
> >variables.]
> >Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
> 
> [...]
> 
> >Index: renesas/arch/arm/mach-shmobile/setup-r8a7779.c
> >===================================================================
> >--- renesas.orig/arch/arm/mach-shmobile/setup-r8a7779.c
> >+++ renesas/arch/arm/mach-shmobile/setup-r8a7779.c
> >@@ -559,6 +559,33 @@ static struct resource ether_resources[]
> >  	},
> >  };
> >+#define R8A7779_VIN(idx) \
> >+static struct resource vin##idx##_resources[] = {		\
> >+	DEFINE_RES_MEM(0xffc50000 + 0x1000 * (idx), 0x1000),	\
> >+	DEFINE_RES_IRQ(gic_iid(0x5f + (idx))),			\
> >+};								\
> >+								\
> >+static struct platform_device_info vin##idx##_info = {		\
> 
>    Hm, probably should have marked this as '__initdata'... maybe
> the resources too.

That doesn't seem to be the case for other devices in
that or other shmobile files. Am I missing something
or should numerous other devices be updated?

> 
> >+	.parent		= &platform_bus,			\
> >+	.name		= "rcar_vin",				\
> >+	.id		= idx,					\
> >+	.res		= vin##idx##_resources,			\
> >+	.num_res	= ARRAY_SIZE(vin##idx##_resources),	\
> >+	.dma_mask	= DMA_BIT_MASK(32),			\
> >+}
> >
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
