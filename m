From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Thu, 15 Dec 2016 17:24:02 +0100
Subject: [PATCH v2 0/2] arm64: dts: r8a7796: salvator-x: Enable EthernetAVB
Message-ID: <1481819044-19605-1-git-send-email-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

	Hi Simon, Magnus,

This patch series enables networking on r8a7796/salvator-x.

Network performance is currently limited to 100 Mbps by the ravb driver.
Performance figures with nuttcp are ca. 94 Mbps for both receive and
transmit, at 12% vs. 4% CPU load. For receive, this is comparable to
sh_eth on Koelsch; for transmit, it's ca. 20% faster.

With "ravb: Support 1Gbps on R-Car H3 ES1.1+ and R-Car M3-W" applied,
network throughput is higher, but has a high variance:
  - receive: 245-426 Mbps, at 100% CPU load (ksoftirqd + nuttcp),
  - transmit: 426 Mbps, at 95% CPU load (nuttcp).
When limiting memory to 1 GiB, and thus avoiding swiotlb bounce buffers,
network throughput increases (CPU load is similar though) to 546 resp.
625 Mbps.
The 50% performance penalty of swiotlb is expected to be mitigated when
IOMMU support will become available.

Note that at high receive speeds, the driver sometimes prints:

    ravb e6800000.ethernet eth0: Receive Descriptor Empty

This may even cause nuttcp to fail with:

    nuttcp-t: v6.1.2: Error: server not ACKing data

NFS root survives fine, though.
I'm wondering if this is also seen on the R-Car Gen2 boards where
EthernetAVB is available?

Changes compared to v1, as sent by Laurent before:
  - Add pinctrl. Drive strength is not yet included, like on current
    r8a7795/salvator-x.

This series is based on renesas-devel-20161212-v4.9. To actually work,
you need to merge my sh-pfc-for-v4.10 branch, which is upstream and will
be in v4.10-rc1. As this is a pure runtime dependency, and does not
imply a regression, this series can be applied now.

Thanks for applying!

Laurent Pinchart (2):
  arm64: dts: renesas: r8a7796: Add EthernetAVB instance
  arm64: dts: r8a7796: salvator-x: Enable EthernetAVB

 arch/arm64/boot/dts/renesas/r8a7796-salvator-x.dts | 32 ++++++++++++++++
 arch/arm64/boot/dts/renesas/r8a7796.dtsi           | 43 ++++++++++++++++++++++
 2 files changed, 75 insertions(+)

-- 
1.9.1

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
