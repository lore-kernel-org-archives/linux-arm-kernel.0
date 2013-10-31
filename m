From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Thu, 31 Oct 2013 19:18:54 +1100
Subject: linux-next: manual merge of the arm-soc tree with the devicetree tree
Message-ID: <20131031191854.f182b66eaf9e03d78e18e27f@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

Today's linux-next merge of the arm-soc tree got a conflict in
arch/arm/mach-integrator/pci_v3.c between commit 16b84e5a505c ("of/irq:
Create of_irq_parse_and_map_pci() to consolidate arch code") from the
devicetree tree and commit d7057e1de8d6 ("ARM: integrator: delete
non-devicetree boot path") from the arm-soc tree.

I fixed it up (see below) and can carry the fix as necessary (no action
is required).

-- 
Cheers,
Stephen Rothwell                    sfr at canb.auug.org.au

diff --cc arch/arm/mach-integrator/pci_v3.c
index a87e510fe0c4,c9c5a33bc802..000000000000
--- a/arch/arm/mach-integrator/pci_v3.c
+++ b/arch/arm/mach-integrator/pci_v3.c
@@@ -809,21 -808,22 +808,6 @@@ static u8 __init pci_v3_swizzle(struct 
  	return pci_common_swizzle(dev, pinp);
  }
  
- static int irq_tab[4] __initdata = {
- 	IRQ_AP_PCIINT0,	IRQ_AP_PCIINT1,	IRQ_AP_PCIINT2,	IRQ_AP_PCIINT3
- };
- 
- /*
-  * map the specified device/slot/pin to an IRQ.  This works out such
-  * that slot 9 pin 1 is INT0, pin 2 is INT1, and slot 10 pin 1 is INT1.
-  */
- static int __init pci_v3_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
 -static int __init pci_v3_map_irq_dt(const struct pci_dev *dev, u8 slot, u8 pin)
--{
- 	int intnr = ((slot - 9) + (pin - 1)) & 3;
 -	struct of_irq oirq;
 -	int ret;
--
- 	return irq_tab[intnr];
 -	ret = of_irq_map_pci(dev, &oirq);
 -	if (ret) {
 -		dev_err(&dev->dev, "of_irq_map_pci() %d\n", ret);
 -		/* Proper return code 0 == NO_IRQ */
 -		return 0;
 -	}
 -
 -	return irq_create_of_mapping(oirq.controller, oirq.specifier,
 -				     oirq.size);
--}
--
  static struct hw_pci pci_v3 __initdata = {
  	.swizzle		= pci_v3_swizzle,
  	.setup			= pci_v3_setup,
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131031/f9064be7/attachment.sig>
