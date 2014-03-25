From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 25 Mar 2014 21:36:38 +0100
Subject: Intel I350 mini-PCIe card (igb) on Mirabox (mvebu / Armada 370)
In-Reply-To: <20140325202249.GA10378@obsidianresearch.com>
References: <CAAfodu1eC6=mKwfowW6bmTtf_DcOL_oNQg77kSz+ykfHkMTN-w@mail.gmail.com>
 <20140325202249.GA10378@obsidianresearch.com>
Message-ID: <20140325213638.5aba54b6@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Jason, Neil,

On Tue, 25 Mar 2014 14:22:49 -0600, Jason Gunthorpe wrote:

> > mirabox ~ # lspci
> > 00:01.0 PCI bridge: Marvell Technology Group Ltd. Device 6710 (rev 01)
> > 00:02.0 PCI bridge: Marvell Technology Group Ltd. Device 6710 (rev 01)
> > 02:00.0 USB controller: Fresco Logic FL1009 USB 3.0 Host Controller (rev 02)
> 
> A starting guess is that something to do with the reset sequence is
> not long enough. PCI requires a certain time in-reset before a device
> is required to respond to configuration... Depending on what your
> bootloader does Linux might be the first thing to enable the link. Add
> a 1 second sleep to the mvebu driver before the bus scan and see if
> that helps?
> 
> > Output from dmesg after boot: https://gist.github.com/ngreatorex/9769713
> > Output of "lspci -vvv" after boot: https://gist.github.com/ngreatorex/9769732
> > 
> > Now for the strange part - if I do an "echo 1 > /sys/bus/pci/rescan"
> > it detects the network card, but I get an oops. It doesn't work,
> > presumably due to the oops, but it shows up in lspci:
> > 
> > mirabox ~ # lspci
> > 00:01.0 PCI bridge: Marvell Technology Group Ltd. Device 6710 (rev 01)
> > 00:02.0 PCI bridge: Marvell Technology Group Ltd. Device 6710 (rev 01)
> > 01:00.0 Ethernet controller: Intel Corporation I350 Gigabit Network
> > Connection (rev 01)
> > 01:00.1 Ethernet controller: Intel Corporation I350 Gigabit Network
> > Connection (rev 01)
> 
> > 02:00.0 USB controller: Fresco Logic FL1009 USB 3.0 Host Controller (rev ff)
> > 03:00.0 USB controller: Fresco Logic FL1009 USB 3.0 Host Controller (rev 02) (prog-if 30 [XHCI])
>  ^^^^^^^^^^^
> 
> That is *really* weird looking - plus this:
> 
> 02:00.0 USB controller: Fresco Logic FL1009 USB 3.0 Host Controller (rev ff) (prog-if ff)
>         !!! Unknown header type 7f
>         Kernel driver in use: xhci_hcd
> 
> Something really wonky happend here during the rescan. It looks like
> for some reason the USB controller was seen on the wrong port for a
> short time!? It would be awesome to track this down..

We have recently identified a weird thing on Armada 38x, maybe previous
revisions are affected as well. We haven't fully understood the problem
yet, but the following patch allows PCIe devices to be detected in all
situations on Armada 38x. It seems like setting the local device number
requires "some time" to be taken into account.

Neil, could you test the below patch:

diff --git a/drivers/pci/host/pci-mvebu.c b/drivers/pci/host/pci-mvebu.c
index 13478ec..350b115 100644
--- a/drivers/pci/host/pci-mvebu.c
+++ b/drivers/pci/host/pci-mvebu.c
@@ -983,6 +983,7 @@ static int mvebu_pcie_probe(struct platform_device *pdev)
                }
 
                mvebu_pcie_set_local_dev_nr(port, 1);
+               udelay(100);
 
                port->dn = child;
                spin_lock_init(&port->conf_lock);

It will clearly not solve the MSI-X panic, but maybe the PCIe device
detection problem at boot time. It would be nice if you could check
this, and also see if the weird Fresco double instance disappears.

Thanks!

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
