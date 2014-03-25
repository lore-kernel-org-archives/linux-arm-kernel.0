From: jgunthorpe@obsidianresearch.com (Jason Gunthorpe)
Date: Tue, 25 Mar 2014 14:22:49 -0600
Subject: Intel I350 mini-PCIe card (igb) on Mirabox (mvebu / Armada 370)
In-Reply-To: <CAAfodu1eC6=mKwfowW6bmTtf_DcOL_oNQg77kSz+ykfHkMTN-w@mail.gmail.com>
References: <CAAfodu1eC6=mKwfowW6bmTtf_DcOL_oNQg77kSz+ykfHkMTN-w@mail.gmail.com>
Message-ID: <20140325202249.GA10378@obsidianresearch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 25, 2014 at 08:07:59PM +0000, Neil Greatorex wrote:

> mirabox ~ # lspci
> 00:01.0 PCI bridge: Marvell Technology Group Ltd. Device 6710 (rev 01)
> 00:02.0 PCI bridge: Marvell Technology Group Ltd. Device 6710 (rev 01)
> 02:00.0 USB controller: Fresco Logic FL1009 USB 3.0 Host Controller (rev 02)

A starting guess is that something to do with the reset sequence is
not long enough. PCI requires a certain time in-reset before a device
is required to respond to configuration... Depending on what your
bootloader does Linux might be the first thing to enable the link. Add
a 1 second sleep to the mvebu driver before the bus scan and see if
that helps?

> Output from dmesg after boot: https://gist.github.com/ngreatorex/9769713
> Output of "lspci -vvv" after boot: https://gist.github.com/ngreatorex/9769732
> 
> Now for the strange part - if I do an "echo 1 > /sys/bus/pci/rescan"
> it detects the network card, but I get an oops. It doesn't work,
> presumably due to the oops, but it shows up in lspci:
> 
> mirabox ~ # lspci
> 00:01.0 PCI bridge: Marvell Technology Group Ltd. Device 6710 (rev 01)
> 00:02.0 PCI bridge: Marvell Technology Group Ltd. Device 6710 (rev 01)
> 01:00.0 Ethernet controller: Intel Corporation I350 Gigabit Network
> Connection (rev 01)
> 01:00.1 Ethernet controller: Intel Corporation I350 Gigabit Network
> Connection (rev 01)

> 02:00.0 USB controller: Fresco Logic FL1009 USB 3.0 Host Controller (rev ff)
> 03:00.0 USB controller: Fresco Logic FL1009 USB 3.0 Host Controller (rev 02) (prog-if 30 [XHCI])
 ^^^^^^^^^^^

That is *really* weird looking - plus this:

02:00.0 USB controller: Fresco Logic FL1009 USB 3.0 Host Controller (rev ff) (prog-if ff)
        !!! Unknown header type 7f
        Kernel driver in use: xhci_hcd

Something really wonky happend here during the rescan. It looks like
for some reason the USB controller was seen on the wrong port for a
short time!? It would be awesome to track this down..

> I'm afraid that I have zero knowledge of PCI so I'm not sure where to
> start with debugging this. I would appreciate it if someone could give
> me some pointers? If you want any extra debugging information then
> just ask...

Hopefully Thomas can comment on the MSI oops.. But it might very well
be related to the xhci controller going insane.

Jason
