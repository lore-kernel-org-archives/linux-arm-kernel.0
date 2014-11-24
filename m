From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Mon, 24 Nov 2014 13:22:14 +1100
Subject: linux-next: manual merge of the v4l-dvb tree with the arm-soc tree
Message-ID: <20141124132214.2f756b6a@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mauro,

Today's linux-next merge of the v4l-dvb tree got a conflict in
arch/arm/mach-omap2/devices.c between commit e7e42b9d2a7f ("ARM:
OMAP4+: Remove unused omap_l3_noc platform init") from the arm-soc tree
and commit 1b65729a186b ("[media] mach-omap2: remove deprecated
VIDEO_OMAP2 support") from the v4l-dvb tree.

I fixed it up (see below) and can carry the fix as necessary (no action
is required).

-- 
Cheers,
Stephen Rothwell                    sfr at canb.auug.org.au

diff --cc arch/arm/mach-omap2/devices.c
index 492ef1607115,1b623a06cdcd..000000000000
--- a/arch/arm/mach-omap2/devices.c
+++ b/arch/arm/mach-omap2/devices.c
@@@ -67,28 -67,40 +67,6 @@@ static int __init omap3_l3_init(void
  }
  omap_postcore_initcall(omap3_l3_init);
  
- #if defined(CONFIG_VIDEO_OMAP2) || defined(CONFIG_VIDEO_OMAP2_MODULE)
 -static int __init omap4_l3_init(void)
 -{
 -	int i;
 -	struct omap_hwmod *oh[3];
 -	struct platform_device *pdev;
 -	char oh_name[L3_MODULES_MAX_LEN];
--
- static struct resource omap2cam_resources[] = {
- 	{
- 		.start		= OMAP24XX_CAMERA_BASE,
- 		.end		= OMAP24XX_CAMERA_BASE + 0xfff,
- 		.flags		= IORESOURCE_MEM,
- 	},
- 	{
- 		.start		= 24 + OMAP_INTC_START,
- 		.flags		= IORESOURCE_IRQ,
 -	/* If dtb is there, the devices will be created dynamically */
 -	if (of_have_populated_dt())
 -		return -ENODEV;
 -
 -	/*
 -	 * To avoid code running on other OMAPs in
 -	 * multi-omap builds
 -	 */
 -	if (!cpu_is_omap44xx() && !soc_is_omap54xx())
 -		return -ENODEV;
 -
 -	for (i = 0; i < L3_MODULES; i++) {
 -		snprintf(oh_name, L3_MODULES_MAX_LEN, "l3_main_%d", i+1);
 -
 -		oh[i] = omap_hwmod_lookup(oh_name);
 -		if (!(oh[i]))
 -			pr_err("could not look up %s\n", oh_name);
--	}
- };
--
- static struct platform_device omap2cam_device = {
- 	.name		= "omap24xxcam",
- 	.id		= -1,
- 	.num_resources	= ARRAY_SIZE(omap2cam_resources),
- 	.resource	= omap2cam_resources,
- };
- #endif
 -	pdev = omap_device_build_ss("omap_l3_noc", 0, oh, 3, NULL, 0);
 -
 -	WARN(IS_ERR(pdev), "could not build omap_device for %s\n", oh_name);
 -
 -	return PTR_RET(pdev);
 -}
 -omap_postcore_initcall(omap4_l3_init);
--
  #if defined(CONFIG_IOMMU_API)
  
  #include <linux/platform_data/iommu-omap.h>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 819 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141124/0c4e081f/attachment.sig>
