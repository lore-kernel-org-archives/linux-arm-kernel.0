From: bharatku@xilinx.com (bharat kumar gogada)
Date: Fri, 16 Oct 2015 11:27:15 +0000 (UTC)
Subject: Need help with device tree formation
Message-ID: <loom.20151016T121454-619@post.gmane.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

nwl_pcie: pcie at fd0e0000 {
                        #address-cells = <3>;
                        #size-cells = <2>;    
                        compatible = "xlnx,nwl-pcie-2.11";
                        #interrupt-cells = <1>;
                        interrupt-controller;  
                        msi-controller;
                        device_type = "pci";
                        interrupt-parent = <&gic>;
                        interrupts = < 0 118 4    
                                       0 116 4    
                                       0 115 4          // MSI_1 [63...32]
                                       0 114 4 >;       // MSI_0 [31...0]
                        interrupt-names = "misc", "intx", "msi_1", "msi_0";    
                        interrupt-map-mask = <0x0 0x0 0x0 0x7>;
                        interrupt-map = <0x0 0x0 0x0 0x1 &gic 0x0 116 0x4 
                                         0x0 0x0 0x0 0x2 &gic 0x0 116 0x4 
                                         0x0 0x0 0x0 0x3 &gic 0x0 116 0x4 
                                         0x0 0x0 0x0 0x4 &gic 0x0 116 0x4>;
    
                        msi-parent = <&nwl_pcie>;
                        reg = <0x0 0xfd0e0000 0x1000
                               0x0 0xfd480000 0x1000
                               0x0 0xE0000000 0x1000000>;
                        reg-names = "breg", "pcireg", "cfg";
                        ranges = <0x02000000 0x00000000 0xE1000000
0x00000000 0xE1000000 0 0x0F000000>;
                          
};

I have the above device tree node in root port driver i have two separate
domains one for legacy and other is MSI hierarchy domain; in both domains
I'm using same node to create domain, what i observed is: 

MSI interrupts are working only without interrupt-controller property,
legacy is working with interrupt-controller property this is due to logic in
 of_irq_parse_and_map_pci. 


So i tried to create following child node as following for legacy:
pcie_intc: interrupt-controller {
                                interrupt-controller;
                                #address-cells = <0>;
                                #interrupt-cells = <1>;
                        };  

but this is not working what i have debugged is, with this also
irq_domain_is_hierarchy(domain) is becoming true in irq_create_of_mapping.

we don't have separate reg space for MSI controller so we are making pcie
node as msi-controller. 

How to deal with this, so that i can have both domains working i.e 
switching back to legacy but kernel configured for MSI. In current code MSI
domains are formed only if MSI is enabled, legacy domain is always present. 

How to deal with interrupt-controller property ?


  
