From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Mon, 11 Feb 2013 17:06:16 +1100
Subject: linux-next: manual merge of the arm-soc tree with the mfd tree
Message-ID: <20130211170616.73fd9fd30bb10c27a698ad4d@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

Today's linux-next merge of the arm-soc tree got a conflict in
arch/arm/mach-omap2/usb-host.c between commit 8a89e93237e1 ("mfd:
omap-usb-host: Consolidate OMAP USB-HS platform data") from the mfd tree
and commit c1d1cd597fc7 ("ARM: OMAP2+: omap_device: remove obsolete
pm_lats and early_device code") from the arm-soc tree.

I fixed it up (see below) and can carry the fix as necessary (no action
is required).

-- 
Cheers,
Stephen Rothwell                    sfr at canb.auug.org.au

diff --cc arch/arm/mach-omap2/usb-host.c
index 940aad4,99f04de..0000000
--- a/arch/arm/mach-omap2/usb-host.c
+++ b/arch/arm/mach-omap2/usb-host.c
@@@ -37,14 -37,11 +37,6 @@@
  #define	USBHS_UHH_HWMODNAME	"usb_host_hs"
  #define USBHS_TLL_HWMODNAME	"usb_tll_hs"
  
- static struct omap_device_pm_latency omap_uhhtll_latency[] = {
- 	  {
- 		.deactivate_func = omap_device_idle_hwmods,
- 		.activate_func	 = omap_device_enable_hwmods,
- 		.flags = OMAP_DEVICE_LATENCY_AUTO_ADJUST,
- 	  },
- };
- 
 -static struct usbhs_omap_platform_data		usbhs_data;
 -static struct usbtll_omap_platform_data		usbtll_data;
 -static struct ehci_hcd_omap_platform_data	ehci_data;
 -static struct ohci_hcd_omap_platform_data	ohci_data;
 -
  /* MUX settings for EHCI pins */
  /*
   * setup_ehci_io_mux - initialize IO pad mux for USBHOST
@@@ -511,9 -522,7 +503,7 @@@ void __init usbhs_init(struct usbhs_oma
  	}
  
  	pdev = omap_device_build(OMAP_USBTLL_DEVICE, bus_id, tll_hwm,
- 				pdata, sizeof(*pdata),
- 				omap_uhhtll_latency,
- 				ARRAY_SIZE(omap_uhhtll_latency), false);
 -				 &usbtll_data, sizeof(usbtll_data));
++				 pdata, sizeof(*pdata));
  	if (IS_ERR(pdev)) {
  		pr_err("Could not build hwmod device %s\n",
  		       USBHS_TLL_HWMODNAME);
@@@ -521,9 -530,7 +511,7 @@@
  	}
  
  	pdev = omap_device_build(OMAP_USBHS_DEVICE, bus_id, uhh_hwm,
- 				pdata, sizeof(*pdata),
- 				omap_uhhtll_latency,
- 				ARRAY_SIZE(omap_uhhtll_latency), false);
 -				&usbhs_data, sizeof(usbhs_data));
++				pdata, sizeof(*pdata));
  	if (IS_ERR(pdev)) {
  		pr_err("Could not build hwmod devices %s\n",
  		       USBHS_UHH_HWMODNAME);
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130211/6a734a75/attachment.sig>
