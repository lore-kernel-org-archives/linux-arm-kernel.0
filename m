From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 16 Oct 2015 13:34:26 +0200
Subject: Need help with device tree formation
In-Reply-To: <loom.20151016T121454-619@post.gmane.org>
References: <loom.20151016T121454-619@post.gmane.org>
Message-ID: <3760709.3HqJjr2Sog@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 16 October 2015 11:27:15 bharat kumar gogada wrote:
> nwl_pcie: pcie at fd0e0000 {
>                         #address-cells = >;
>                         #size-cells = <2>;    
>                         compatible = "xlnx,nwl-pcie-2.11";
>                         #interrupt-cells = <1>;
>                         interrupt-controller;  
>                         msi-controller;
>                         device_type = "pci";
>                         interrupt-parent = <&gic>;
>                         interrupts = < 0 118 4    
>                                        0 116 4    
>                                        0 115 4          // MSI_1 [63...32]
>                                        0 114 4 >;       // MSI_0 [31...0]
>                         interrupt-names = "misc", "intx", "msi_1", "msi_0";    
>                         interrupt-map-mask = <0x0 0x0 0x0 0x7>;
>                         interrupt-map = <0x0 0x0 0x0 0x1 &gic 0x0 116 0x4 
>                                          0x0 0x0 0x0 0x2 &gic 0x0 116 0x4 
>                                          0x0 0x0 0x0 0x3 &gic 0x0 116 0x4 
>                                          0x0 0x0 0x0 0x4 &gic 0x0 116 0x4>;

The interrupt-map looks wrong, as you point to the gic rather than &nwl_pcie
here. Also, you seem to have only one interrupt for all INTx, so you
use an all-zeroes interrupt-map-mask and only one entry here.

>                         msi-parent = <&nwl_pcie>;
>                         reg = <0x0 0xfd0e0000 0x1000
>                                0x0 0xfd480000 0x1000
>                                0x0 0xE0000000 0x1000000>;
>                         reg-names = "breg", "pcireg", "cfg";
>                         ranges = <0x02000000 0x00000000 0xE1000000
> 0x00000000 0xE1000000 0 0x0F000000>;
>                           
> };
> 
> I have the above device tree node in root port driver i have two separate
> domains one for legacy and other is MSI hierarchy domain; in both domains
> I'm using same node to create domain, what i observed is: 
> 
> MSI interrupts are working only without interrupt-controller property,
> legacy is working with interrupt-controller property this is due to logic in
>  of_irq_parse_and_map_pci. 

Do you know what causes the MSI to not work when there is an
interrupt-controller property?

	Arnd
