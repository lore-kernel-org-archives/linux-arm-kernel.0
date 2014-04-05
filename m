From: w@1wt.eu (Willy Tarreau)
Date: Sat, 5 Apr 2014 20:04:16 +0200
Subject: Intel I350 mini-PCIe card (igb) on Mirabox (mvebu / Armada 370)
In-Reply-To: <20140405193435.50d8dd81@skate>
References: <20140325223510.GD14718@obsidianresearch.com>
 <CAAfodu3HuzBCAc3r=PPufjrFhEKUQK2b_WRow=GJuC6hSqiuKw@mail.gmail.com>
 <20140326201243.GA1536@obsidianresearch.com>
 <CAAfodu0xZ0V8ikJMT1Z+0JSLeD+nezWAcGNF2_ryvad5tsVDWA@mail.gmail.com>
 <20140326214259.GA12330@obsidianresearch.com>
 <alpine.DEB.2.10.1403270025160.1545@vroombuntu>
 <20140327044054.GA22681@obsidianresearch.com>
 <alpine.DEB.2.10.1403280056250.4521@vroombuntu>
 <alpine.DEB.2.10.1404041408280.8617@vroombuntu>
 <20140405193435.50d8dd81@skate>
Message-ID: <20140405180416.GB29787@1wt.eu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Thomas,

On Sat, Apr 05, 2014 at 07:34:35PM +0200, Thomas Petazzoni wrote:
> Also, can you detail how you tested with just one port?

OK I just found this ugly method, I'm not sure it's the best one but it
does the job :-) It simply refuses to configure any controller but the
first one on the chip.

diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
index 46d31a4..88bf1d5 100644
--- a/drivers/net/ethernet/intel/igb/igb_main.c
+++ b/drivers/net/ethernet/intel/igb/igb_main.c
@@ -2208,6 +2208,9 @@ static int igb_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 		return -EINVAL;
 	}
 
+	if (PCI_FUNC(pdev->devfn) != 0)
+		return -ENODEV;
+
 	err = pci_enable_device_mem(pdev);
 	if (err)
 		return err;

Best regards,
Willy
