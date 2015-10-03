From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Sat, 03 Oct 2015 19:13:12 +0100
Subject: [PATCH 4/9] pci: mvebu: use gpio_set_value_cansleep()
In-Reply-To: <20151003181228.GI21513@n2100.arm.linux.org.uk>
References: <20151003181228.GI21513@n2100.arm.linux.org.uk>
Message-ID: <E1ZiRJ2-0004Ir-HU@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We are in a context where we can sleep, and the PCIe reset gpio may be
on an I2C expander.  Use the cansleep() variant when setting the GPIO
value.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/pci/host/pci-mvebu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/host/pci-mvebu.c b/drivers/pci/host/pci-mvebu.c
index 92c777e1aa3c..00467c5a58ac 100644
--- a/drivers/pci/host/pci-mvebu.c
+++ b/drivers/pci/host/pci-mvebu.c
@@ -1111,8 +1111,8 @@ static int mvebu_pcie_probe(struct platform_device *pdev)
 			of_property_read_u32(child, "reset-delay-us",
 					     &reset_udelay);
 
-			gpio_set_value(port->reset_gpio,
-				       (port->reset_active_low) ? 1 : 0);
+			gpio_set_value_cansleep(port->reset_gpio,
+						!!port->reset_active_low);
 			msleep(reset_udelay/1000);
 		}
 
-- 
2.1.0
