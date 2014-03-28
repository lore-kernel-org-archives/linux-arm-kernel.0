From: neil@fatboyfat.co.uk (Neil Greatorex)
Date: Fri, 28 Mar 2014 01:03:55 +0000 (GMT)
Subject: Intel I350 mini-PCIe card (igb) on Mirabox (mvebu / Armada
 370)
In-Reply-To: <20140327044054.GA22681@obsidianresearch.com>
References: <20140325202249.GA10378@obsidianresearch.com>
 <20140325213638.5aba54b6@skate>
 <CAAfodu3RmoN9MYNahwv2kLz5=GvZvK6G9fJorsyVgU8C0J-NEg@mail.gmail.com>
 <20140325222404.GC14718@obsidianresearch.com>
 <20140325223510.GD14718@obsidianresearch.com>
 <CAAfodu3HuzBCAc3r=PPufjrFhEKUQK2b_WRow=GJuC6hSqiuKw@mail.gmail.com>
 <20140326201243.GA1536@obsidianresearch.com>
 <CAAfodu0xZ0V8ikJMT1Z+0JSLeD+nezWAcGNF2_ryvad5tsVDWA@mail.gmail.com>
 <20140326214259.GA12330@obsidianresearch.com>
 <alpine.DEB.2.10.1403270025160.1545@vroombuntu>
 <20140327044054.GA22681@obsidianresearch.com>
Message-ID: <alpine.DEB.2.10.1403280056250.4521@vroombuntu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Jason, Thomas,

With the help you've given, I think I've identified what the problem is. 
It is basically what Thomas suggested the problem was (that he'd seen with 
the Armada 38x). The call to mvebu_pcie_set_local_dev_nr causes the PCIe 
link to reset. In my tests with this Intel card, it takes ~25ms for the 
link to go down, and then another ~13ms for it to come back up.

I have put together a patch below that I would be interested to get your 
opinions on and also for you to test against any cards you may have. I 
only have the one mini PCIe card so it's not a great test!

With my card, it is now detected correctly, and there are no issues when 
rescanning the PCI bus.

Cheers,
Neil


>From a0ca1552e737c18b5651fe1f27ade76f512ca191 Mon Sep 17 00:00:00 2001
From: Neil Greatorex <neil@fatboyfat.co.uk>
Date: Fri, 28 Mar 2014 00:35:04 +0000
Subject: [PATCH] PCI: mvebu: Wait for PCIe link to reset after setting
  device number

After setting the local device nr, the PCIe link may go down briefly. If 
we don't wait for the link to come back up we may miss that device when we 
scan the bus (assuming it is not present).

This patch waits up to 40ms for the link to go down, and if it did go down,
waits up to 100ms for it to come back up. If the link was down to begin with,
it will not wait at all.

Signed-off-by: Neil Greatorex <neil@fatboyfat.co.uk>
---
  drivers/pci/host/pci-mvebu.c | 57 
++++++++++++++++++++++++++++++++++++++++++++
  1 file changed, 57 insertions(+)

diff --git a/drivers/pci/host/pci-mvebu.c b/drivers/pci/host/pci-mvebu.c
index 0e79665..afd0dce 100644
--- a/drivers/pci/host/pci-mvebu.c
+++ b/drivers/pci/host/pci-mvebu.c
@@ -891,6 +891,7 @@ static int mvebu_pcie_probe(struct platform_device 
*pdev)
  	for_each_child_of_node(pdev->dev.of_node, child) {
  		struct mvebu_pcie_port *port = &pcie->ports[i];
  		enum of_gpio_flags flags;
+		u32 link_present, retry_count = 0;

  		if (!of_device_is_available(child))
  			continue;
@@ -975,8 +976,64 @@ static int mvebu_pcie_probe(struct platform_device 
*pdev)
  			continue;
  		}

+		/* After setting the local dev number, the PCI-E link may go
+		 * down for a period of time. If we don't wait for it to come
+		 * back up, then we risk missing enumerating that device when
+		 * we scan the bus. However, if the link was down to begin with,
+		 * there's no point waiting, so check now.
+		 */
+		link_present = mvebu_pcie_link_up(port);
+
  		mvebu_pcie_set_local_dev_nr(port, 1);

+		if (link_present) {
+			/* In testing, the link took ~25ms to go down, and
+			 * another ~15ms to come back up, so wait ~40ms for the
+			 * link to go down, and then up to ~100ms for it to come
+			 * back up. If the link doesn't go down after ~40ms, then
+			 * it probably won't go down at all, so carry on.
+			 */
+			if (mvebu_pcie_link_up(port)) {
+				while (retry_count < 40) {
+					if (!mvebu_pcie_link_up(port))
+						break;
+					retry_count++;
+					mdelay(1);
+				}
+
+				if (retry_count == 40) {
+					dev_dbg(&pdev->dev,
+						"PCIe%d.%d: after setting dev nr, link stayed up\n",
+						port->port, port->lane);
+				} else {
+					dev_info(&pdev->dev,
+						 "PCIe%d.%d: after setting dev nr, link went down after %d polls\n",
+						 port->port, port->lane, retry_count);
+				}
+			}
+
+			retry_count = 0;
+
+			if (!mvebu_pcie_link_up(port)) {
+				while (retry_count < 100) {
+					if (mvebu_pcie_link_up(port))
+						break;
+					retry_count++;
+					mdelay(1);
+				}
+
+				if (retry_count == 100) {
+					dev_info(&pdev->dev,
+						"PCIe%d.%d: after setting dev nr, link failed to come back up (timeout)\n",
+						port->port, port->lane);
+				} else {
+					dev_info(&pdev->dev,
+						 "PCIe%d.%d: after setting dev nr, link came back up after %d polls ",
+						 port->port, port->lane, retry_count);
+				}
+			}
+		}
+
  		port->dn = child;
  		spin_lock_init(&port->conf_lock);
  		mvebu_sw_pci_bridge_init(port);
-- 
1.8.3.2
