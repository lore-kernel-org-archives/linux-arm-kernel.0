From: neil@fatboyfat.co.uk (Neil Greatorex)
Date: Tue, 25 Mar 2014 20:07:59 +0000
Subject: Intel I350 mini-PCIe card (igb) on Mirabox (mvebu / Armada 370)
Message-ID: <CAAfodu1eC6=mKwfowW6bmTtf_DcOL_oNQg77kSz+ykfHkMTN-w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

I've recently acquired a mini-PCIe Intel dual Gigabit Ethernet card
and was hoping to add it to my Globalscale Mirabox (based on the
Marvell Armada 370 SoC).

I have built the kernel from
git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux based on
v3.14.0-rc8, with CONFIG_PCI_MVEBU=y and CONFIG_IGB=m.

When the system boots, it doesn't detect the PCIe card. Here's the
output of lspci:

mirabox ~ # lspci
00:01.0 PCI bridge: Marvell Technology Group Ltd. Device 6710 (rev 01)
00:02.0 PCI bridge: Marvell Technology Group Ltd. Device 6710 (rev 01)
02:00.0 USB controller: Fresco Logic FL1009 USB 3.0 Host Controller (rev 02)

Output from dmesg after boot: https://gist.github.com/ngreatorex/9769713
Output of "lspci -vvv" after boot: https://gist.github.com/ngreatorex/9769732

Now for the strange part - if I do an "echo 1 > /sys/bus/pci/rescan"
it detects the network card, but I get an oops. It doesn't work,
presumably due to the oops, but it shows up in lspci:

mirabox ~ # lspci
00:01.0 PCI bridge: Marvell Technology Group Ltd. Device 6710 (rev 01)
00:02.0 PCI bridge: Marvell Technology Group Ltd. Device 6710 (rev 01)
01:00.0 Ethernet controller: Intel Corporation I350 Gigabit Network
Connection (rev 01)
01:00.1 Ethernet controller: Intel Corporation I350 Gigabit Network
Connection (rev 01)
02:00.0 USB controller: Fresco Logic FL1009 USB 3.0 Host Controller (rev ff)
03:00.0 USB controller: Fresco Logic FL1009 USB 3.0 Host Controller (rev 02)

Output from dmesg including the oops: https://gist.github.com/ngreatorex/9769438
Output of "lspci -vvv" now: https://gist.github.com/ngreatorex/9769327

I'm afraid that I have zero knowledge of PCI so I'm not sure where to
start with debugging this. I would appreciate it if someone could give
me some pointers? If you want any extra debugging information then
just ask...

Cheers,
Neil

PS. I suspect the problem is with the pci-mvebu driver rather than the
igb driver, so I haven't sent to the igb maintainers...
