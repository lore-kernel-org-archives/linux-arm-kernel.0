From: briannorris@chromium.org (Brian Norris)
Date: Thu, 12 Oct 2017 13:52:20 -0700
Subject: [PATCH 3/3] PCI: rockchip: Support configuring PERST# state via DT
In-Reply-To: <20171012205220.130048-1-briannorris@chromium.org>
References: <20171012205220.130048-1-briannorris@chromium.org>
Message-ID: <20171012205220.130048-4-briannorris@chromium.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I've found that different endpoints and board configurations have
required different behavior from the PCIe Reset (PERST#) signal when in
low-power system suspend (e.g., S3). Use the new of_pci helper to
request this state and assert (active low) PERST# before suspending.

Note that we reinitialize the link (including reconfiguring PERST#) at
resume time.

This requires that the board and system firmware supports driving this
signal low when the system is suspended, since PERST# may be pulled up
by the endpoint, and some GPIO banks are not active in S3.

Signed-off-by: Brian Norris <briannorris@chromium.org>
---
 drivers/pci/host/pcie-rockchip.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/pci/host/pcie-rockchip.c b/drivers/pci/host/pcie-rockchip.c
index 9051c6c8fea4..1ab58c1abb34 100644
--- a/drivers/pci/host/pcie-rockchip.c
+++ b/drivers/pci/host/pcie-rockchip.c
@@ -233,6 +233,7 @@ struct rockchip_pcie {
 	struct	regulator *vpcie1v8; /* 1.8V power supply */
 	struct	regulator *vpcie0v9; /* 0.9V power supply */
 	struct	gpio_desc *ep_gpio;
+	bool	suspend_reset;
 	u32	lanes;
 	u8      lanes_map;
 	u8	root_bus_nr;
@@ -1155,6 +1156,9 @@ static int rockchip_pcie_parse_dt(struct rockchip_pcie *rockchip)
 		dev_info(dev, "no vpcie0v9 regulator found\n");
 	}
 
+	/* Default not-asserted, to retain backward compatibility. */
+	rockchip->suspend_reset = of_pci_get_pcie_reset_suspend(node) > 0;
+
 	return 0;
 }
 
@@ -1463,6 +1467,9 @@ static int __maybe_unused rockchip_pcie_suspend_noirq(struct device *dev)
 		return ret;
 	}
 
+	if (rockchip->suspend_reset)
+		gpiod_set_value(rockchip->ep_gpio, 0);
+
 	rockchip_pcie_deinit_phys(rockchip);
 
 	rockchip_pcie_disable_clocks(rockchip);
-- 
2.15.0.rc0.271.g36b669edcc-goog
