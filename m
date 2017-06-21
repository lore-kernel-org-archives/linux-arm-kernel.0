From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 21 Jun 2017 17:14:13 +0200
Subject: [RFT PATCH v2 00/42] PCI: ARM/ARM64: remove pci_fixup_irqs() usage
In-Reply-To: <20170621104538.GA8477@red-moon>
References: <20170608141342.2018-1-lorenzo.pieralisi@arm.com>
 <CACRpkdZ1rBq9eLJkz_gRuXAG=if+xXf-jPzDEPCfG8EgUmUG3A@mail.gmail.com>
 <20170621103042.GA1712@red-moon> <20170621104538.GA8477@red-moon>
Message-ID: <CACRpkda_6=qWRQDpTy67MFc=-fYRhqWDPx0NnNG5mjXQLyAAkw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 21, 2017 at 12:45 PM, Lorenzo Pieralisi
<lorenzo.pieralisi@arm.com> wrote:

> Sorry I miss yet another usage of struct pci_bus before bus is
> scanned in faraday_pci_parse_map_dma_ranges(), all these config
> accessors want is to access bus number 0 and writei/read some config
> values in there, please confirm.
>
> Updated patch here:

I fixed it. This was needed:
diff --git a/drivers/pci/host/pci-ftpci100.c b/drivers/pci/host/pci-ftpci100.c
index 86f8a3d1c1da..5162dffc102b 100644
--- a/drivers/pci/host/pci-ftpci100.c
+++ b/drivers/pci/host/pci-ftpci100.c
@@ -450,6 +450,8 @@ static int faraday_pci_probe(struct platform_device *pdev)
     struct resource *io;
     struct pci_host_bridge *host;
     struct clk *clk;
+    unsigned char max_bus_speed = PCI_SPEED_33MHz;
+    unsigned char cur_bus_speed = PCI_SPEED_33MHz;
     int ret;
     u32 val;
     LIST_HEAD(res);
@@ -553,27 +555,27 @@ static int faraday_pci_probe(struct platform_device *pdev)
         unsigned long rate;
         u32 val;

-        faraday_pci_read_config(p->bus, 0,
-                    FARADAY_PCI_STATUS_CMD, 4, &val);
+        faraday_raw_pci_read_config(p, 0, 0,
+                        FARADAY_PCI_STATUS_CMD, 4, &val);
         rate = clk_get_rate(p->bus_clk);

         if ((rate == 33000000) && (val & PCI_STATUS_66MHZ_CAPABLE)) {
             dev_info(dev, "33MHz bus is 66MHz capable\n");
-            p->bus->max_bus_speed = PCI_SPEED_66MHz;
+            max_bus_speed = PCI_SPEED_66MHz;
             ret = clk_set_rate(p->bus_clk, 66000000);
             if (ret)
                 dev_err(dev, "failed to set bus clock\n");
         } else {
             dev_info(dev, "33MHz only bus\n");
-            p->bus->max_bus_speed = PCI_SPEED_33MHz;
+            max_bus_speed = PCI_SPEED_33MHz;
         }

         /* Bumping the clock may fail so read back the rate */
         rate = clk_get_rate(p->bus_clk);
         if (rate == 33000000)
-            p->bus->cur_bus_speed = PCI_SPEED_33MHz;
+            cur_bus_speed = PCI_SPEED_33MHz;
         if (rate == 66000000)
-            p->bus->cur_bus_speed = PCI_SPEED_66MHz;
+            cur_bus_speed = PCI_SPEED_66MHz;
     }

     ret = faraday_pci_parse_map_dma_ranges(p, dev->of_node);
@@ -587,6 +589,8 @@ static int faraday_pci_probe(struct platform_device *pdev)
         return ret;
     }
     p->bus = host->bus;
+    p->bus->max_bus_speed = max_bus_speed;
+    p->bus->cur_bus_speed = cur_bus_speed;

     pci_bus_assign_resources(p->bus);
     pci_bus_add_devices(p->bus);


I'll send a modified and tested version of your patch.

Yours,
Linus Walleij
