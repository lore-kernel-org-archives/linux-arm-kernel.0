From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 08 May 2014 17:21:54 +0200
Subject: [PATCH] pci: rcar host needs OF
In-Reply-To: <CAMuHMdWBzBneDqyDxK5HU3Bt_5CyRfTM_f_6YGJHokG_v17_sw@mail.gmail.com>
References: <1399560433-1402630-1-git-send-email-arnd@arndb.de>
 <536B9D78.5000602@codethink.co.uk>
 <CAMuHMdWBzBneDqyDxK5HU3Bt_5CyRfTM_f_6YGJHokG_v17_sw@mail.gmail.com>
Message-ID: <9614403.Lyniq7F3TJ@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 08 May 2014 17:16:32 Geert Uytterhoeven wrote:
> On Thu, May 8, 2014 at 5:06 PM, Ben Dooks <ben.dooks@codethink.co.uk> wrote:
> > On 08/05/14 15:56, Arnd Bergmann wrote:
> >>
> >> The pci-rcar driver is enabled for compile tests, and this has
> >> now shown that the driver cannot build without CONFIG_OF,
> >> following the inclusion of f8f2fe7355fb "PCI: rcar: Use new OF
> >> interrupt mapping when possible":
> >>
> >> drivers/built-in.o: In function `rcar_pci_map_irq':
> >> :(.text+0x1cc7c): undefined reference to `of_irq_parse_and_map_pci'
> >>
> >> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> >> Cc: Bjorn Helgaas <bhelgaas@google.com>
> >> Cc: Magnus Damm <damm@opensource.se>
> >> Cc: linux-pci at vger.kernel.org
> >> Cc: linux-sh at vger.kernel.org
> >> ---
> >>   drivers/pci/host/Kconfig | 2 +-
> >>   1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/pci/host/Kconfig b/drivers/pci/host/Kconfig
> >> index fbbef0b..4675f47 100644
> >> --- a/drivers/pci/host/Kconfig
> >> +++ b/drivers/pci/host/Kconfig
> >> @@ -27,7 +27,7 @@ config PCI_TEGRA
> >>
> >>   config PCI_RCAR_GEN2
> >>         bool "Renesas R-Car Gen2 Internal PCI controller"
> >> -       depends on ARCH_SHMOBILE || (ARM && COMPILE_TEST)
> >> +       depends on ARCH_SHMOBILE || (ARM && OF && COMPILE_TEST)
> >>         help
> >>           Say Y here if you want internal PCI support on R-Car Gen2 SoC.
> >>           There are 3 internal PCI controllers available with a single
> >>
> >
> > This driver /should/ be able to be built for just the platform case
> > so it sounds like f8f2fe7355fb stopped this but no-one has yet to
> > notice.
> 
> You mean include/linux/of_pci.h should provide a dummy version of
> of_irq_parse_and_map_pci() returning 0 in case OF=n?

Good idea, I'll give this patch some testing in the randconfig builder,
replacing the one above.

	Arnd

diff --git a/include/linux/of_pci.h b/include/linux/of_pci.h
index 1a1f5ff..b6f2621 100644
--- a/include/linux/of_pci.h
+++ b/include/linux/of_pci.h
@@ -7,7 +7,6 @@
 struct pci_dev;
 struct of_phandle_args;
 int of_irq_parse_pci(const struct pci_dev *pdev, struct of_phandle_args *out_irq);
-int of_irq_parse_and_map_pci(const struct pci_dev *dev, u8 slot, u8 pin);
 
 struct device_node;
 struct device_node *of_pci_find_child_device(struct device_node *parent,
@@ -19,11 +18,14 @@ int of_pci_parse_bus_range(struct device_node *node, struct resource *res);
 int of_pci_msi_chip_add(struct msi_chip *chip);
 void of_pci_msi_chip_remove(struct msi_chip *chip);
 struct msi_chip *of_pci_find_msi_chip_by_node(struct device_node *of_node);
+int of_irq_parse_and_map_pci(const struct pci_dev *dev, u8 slot, u8 pin);
 #else
 static inline int of_pci_msi_chip_add(struct msi_chip *chip) { return -EINVAL; }
 static inline void of_pci_msi_chip_remove(struct msi_chip *chip) { }
 static inline struct msi_chip *
 of_pci_find_msi_chip_by_node(struct device_node *of_node) { return NULL; }
+static inline int
+of_irq_parse_and_map_pci(const struct pci_dev *dev, u8 slot, u8 pin) { return 0; }
 #endif
 
 #endif
