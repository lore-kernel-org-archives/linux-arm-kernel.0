From: vladimir.murzin@arm.com (Vladimir Murzin)
Date: Tue, 22 Nov 2016 09:40:39 +0000
Subject: [RFC PATCH 04/11] PCI: tegra: limit to MMU build only
In-Reply-To: <11637152.Dd0IBkEQ8q@wuerfel>
References: <1479806768-39911-1-git-send-email-vladimir.murzin@arm.com>
 <1479806768-39911-5-git-send-email-vladimir.murzin@arm.com>
 <11637152.Dd0IBkEQ8q@wuerfel>
Message-ID: <58341297.9090303@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 22/11/16 09:31, Arnd Bergmann wrote:
> On Tuesday, November 22, 2016 9:26:01 AM CET Vladimir Murzin wrote:
>> This driver uses functionality which available for MMU build only,
>> thus add dependency on MMU.
>>
>> Cc: Thierry Reding <thierry.reding@gmail.com>
>> Signed-off-by: Vladimir Murzin <vladimir.murzin@arm.com>
>>
> 
> Can you be more specific about what requires the MMU here?
> 
> Is it the I/O space remapping or something else?

Yes it comes from I/O space remapping.

The fill error log:

  CC      drivers/pci/host/pci-tegra.o
In file included from ./arch/arm/include/asm/page.h:22:0,
                 from ./arch/arm/include/asm/thread_info.h:17,
                 from ./include/linux/thread_info.h:58,
                 from ./include/asm-generic/current.h:4,
                 from ./arch/arm/include/generated/asm/current.h:1,
                 from ./include/linux/mutex.h:13,
                 from ./include/linux/notifier.h:13,
                 from ./include/linux/clk.h:17,
                 from drivers/pci/host/pci-tegra.c:29:
drivers/pci/host/pci-tegra.c: In function 'tegra_pcie_bus_alloc':
drivers/pci/host/pci-tegra.c:388:27: error: 'L_PTE_PRESENT' undeclared (first use in this function)
  pgprot_t prot = __pgprot(L_PTE_PRESENT | L_PTE_YOUNG | L_PTE_DIRTY |
                           ^
./arch/arm/include/asm/page-nommu.h:41:26: note: in definition of macro '__pgprot'
 #define __pgprot(x)     (x)
                          ^
drivers/pci/host/pci-tegra.c:388:27: note: each undeclared identifier is reported only once for each function it appears in
  pgprot_t prot = __pgprot(L_PTE_PRESENT | L_PTE_YOUNG | L_PTE_DIRTY |
                           ^
./arch/arm/include/asm/page-nommu.h:41:26: note: in definition of macro '__pgprot'
 #define __pgprot(x)     (x)
                          ^
drivers/pci/host/pci-tegra.c:388:43: error: 'L_PTE_YOUNG' undeclared (first use in this function)
  pgprot_t prot = __pgprot(L_PTE_PRESENT | L_PTE_YOUNG | L_PTE_DIRTY |
                                           ^
./arch/arm/include/asm/page-nommu.h:41:26: note: in definition of macro '__pgprot'
 #define __pgprot(x)     (x)
                          ^
drivers/pci/host/pci-tegra.c:388:57: error: 'L_PTE_DIRTY' undeclared (first use in this function)
  pgprot_t prot = __pgprot(L_PTE_PRESENT | L_PTE_YOUNG | L_PTE_DIRTY |
                                                         ^
./arch/arm/include/asm/page-nommu.h:41:26: note: in definition of macro '__pgprot'
 #define __pgprot(x)     (x)
                          ^
drivers/pci/host/pci-tegra.c:389:6: error: 'L_PTE_XN' undeclared (first use in this function)
      L_PTE_XN | L_PTE_MT_DEV_SHARED | L_PTE_SHARED);
      ^
./arch/arm/include/asm/page-nommu.h:41:26: note: in definition of macro '__pgprot'
 #define __pgprot(x)     (x)
                          ^
drivers/pci/host/pci-tegra.c:389:17: error: 'L_PTE_MT_DEV_SHARED' undeclared (first use in this function)
      L_PTE_XN | L_PTE_MT_DEV_SHARED | L_PTE_SHARED);
                 ^
./arch/arm/include/asm/page-nommu.h:41:26: note: in definition of macro '__pgprot'
 #define __pgprot(x)     (x)
                          ^
drivers/pci/host/pci-tegra.c:389:39: error: 'L_PTE_SHARED' undeclared (first use in this function)
      L_PTE_XN | L_PTE_MT_DEV_SHARED | L_PTE_SHARED);
                                       ^
./arch/arm/include/asm/page-nommu.h:41:26: note: in definition of macro '__pgprot'
 #define __pgprot(x)     (x)
                          ^
drivers/pci/host/pci-tegra.c: At top level:
drivers/pci/host/pci-tegra.c:501:10: error: 'pci_generic_config_read32' undeclared here (not in a function)
  .read = pci_generic_config_read32,
          ^
drivers/pci/host/pci-tegra.c:502:11: error: 'pci_generic_config_write32' undeclared here (not in a function)
  .write = pci_generic_config_write32,
           ^
drivers/pci/host/pci-tegra.c: In function 'tegra_pcie_relax_enable':
drivers/pci/host/pci-tegra.c:609:2: error: implicit declaration of function 'pcie_capability_set_word' [-Werror=implicit-function-declaration]
  pcie_capability_set_word(dev, PCI_EXP_DEVCTL, PCI_EXP_DEVCTL_RELAX_EN);
  ^
drivers/pci/host/pci-tegra.c: In function 'tegra_pcie_setup':
drivers/pci/host/pci-tegra.c:626:8: error: implicit declaration of function 'pci_remap_iospace' [-Werror=implicit-function-declaration]
  err = pci_remap_iospace(&pcie->pio, pcie->io.start);
        ^
drivers/pci/host/pci-tegra.c:628:3: error: implicit declaration of function 'pci_add_resource_offset' [-Werror=implicit-function-declaration]
   pci_add_resource_offset(&sys->resources, &pcie->pio,
   ^
drivers/pci/host/pci-tegra.c:634:2: error: implicit declaration of function 'pci_add_resource' [-Werror=implicit-function-declaration]
  pci_add_resource(&sys->resources, &pcie->busn);
  ^
drivers/pci/host/pci-tegra.c:636:8: error: implicit declaration of function 'devm_request_pci_bus_resources' [-Werror=implicit-function-declaration]
  err = devm_request_pci_bus_resources(dev, &sys->resources);
        ^
cc1: some warnings being treated as errors
make[1]: *** [drivers/pci/host/pci-tegra.o] Error 1
make: *** [drivers/pci/host/pci-tegra.o] Error 2

Cheers
Vladimir

> 
> 	Arnd
> 
> 
