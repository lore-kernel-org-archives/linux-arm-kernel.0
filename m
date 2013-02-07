From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Thu, 7 Feb 2013 15:48:28 +1100
Subject: linux-next: manual merge of the arm-soc tree with the iommu tree
Message-ID: <20130207154828.57604e8aaeee23878c15c177@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

Today's linux-next merge of the arm-soc tree got a conflict in
arch/arm/mach-shmobile/setup-sh73a0.c between commit 9a27dee73f55 ("ARM:
mach-shmobile: sh73a0: Add IPMMU device") from the iommu tree and commit
486095331af0 ("ARM: mach-shmobile: sh73a0: Minimal setup using DT") from
the arm-soc tree.

I fixed it up (see below) and can carry the fix as necessary (no action
is required).

-- 
Cheers,
Stephen Rothwell                    sfr at canb.auug.org.au

diff --cc arch/arm/mach-shmobile/setup-sh73a0.c
index 36c2b2e,2ecd668..0000000
--- a/arch/arm/mach-shmobile/setup-sh73a0.c
+++ b/arch/arm/mach-shmobile/setup-sh73a0.c
@@@ -755,36 -780,7 +781,36 @@@ static struct platform_device pmu_devic
  	.resource	= pmu_resources,
  };
  
 +/* an IPMMU module for ICB */
 +static struct resource ipmmu_resources[] = {
 +	[0] = {
 +		.name	= "IPMMU",
 +		.start	= 0xfe951000,
 +		.end	= 0xfe9510ff,
 +		.flags	= IORESOURCE_MEM,
 +	},
 +};
 +
 +static const char * const ipmmu_dev_names[] = {
 +	"sh_mobile_lcdc_fb.0",
 +};
 +
 +static struct shmobile_ipmmu_platform_data ipmmu_platform_data = {
 +	.dev_names = ipmmu_dev_names,
 +	.num_dev_names = ARRAY_SIZE(ipmmu_dev_names),
 +};
 +
 +static struct platform_device ipmmu_device = {
 +	.name           = "ipmmu",
 +	.id             = -1,
 +	.dev = {
 +		.platform_data = &ipmmu_platform_data,
 +	},
 +	.resource       = ipmmu_resources,
 +	.num_resources  = ARRAY_SIZE(ipmmu_resources),
 +};
 +
- static struct platform_device *sh73a0_early_devices[] __initdata = {
+ static struct platform_device *sh73a0_early_devices_dt[] __initdata = {
  	&scif0_device,
  	&scif1_device,
  	&scif2_device,
@@@ -795,9 -791,11 +821,12 @@@
  	&scif7_device,
  	&scif8_device,
  	&cmt10_device,
+ };
+ 
+ static struct platform_device *sh73a0_early_devices[] __initdata = {
  	&tmu00_device,
  	&tmu01_device,
 +	&ipmmu_device,
  };
  
  static struct platform_device *sh73a0_late_devices[] __initdata = {
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130207/25be4564/attachment.sig>
