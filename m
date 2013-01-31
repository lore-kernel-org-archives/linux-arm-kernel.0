From: p.pisati@gmail.com (Paolo Pisati)
Date: Thu, 31 Jan 2013 12:36:27 +0100
Subject: [REGRESSION+BISECT] imx6: 3.8+: sata failure with 24d340ac "ARM
 i.MX6: Fix ethernet PLL clocks"
Message-ID: <20130131113627.GA5452@luxor.wired.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

sata doesn't work anymore in 3.8rcX (while it was ok in 3.7 + 1 patch[1]) and i've bisected
it down to:

>From 24d340ac43882583024ffcce1cd38b9b2391eb51 Mon Sep 17 00:00:00 2001
From: Sascha Hauer <s.hauer@pengutronix.de>
Date: Wed, 21 Nov 2012 14:42:31 +0100
Subject: [PATCH 132/144] ARM i.MX6: Fix ethernet PLL clocks
In current code the ethernet PLL is not handled correctly. The PLL runs at
500MHz
and has different outputs. Only the enet reference clock is implemented. This
patch changes the PLL so that it outputs 500MHz and adds the additional outputs
as dividers. This now matches the datasheet which says:

...
ahci 2200000.ahci: forcing PORTS_IMPL to 0x1
ahci 2200000.ahci: AHCI 0001.0300 32 slots 1 ports 3 Gbps 0x1 impl platform mode
ahci 2200000.ahci: flags: ncq sntf pm led clo only pmp pio slum part ccc apst
scsi0 : ahci_platform
ata1: SATA max UDMA/133 mmio [mem 0x02200000-0x02203fff] port 0x100 irq 71
...
ata1: link is slow to respond, please be patient (ready=0)
ata1: softreset failed (device not ready)
ata1: SATA link down (SStatus 0 SControl 300)
...

without that patch, it works like a charm.
Here is my kernel config:

http://people.canonical.com/~ppisati/imx6_sata/config

Anyone else seeing this?

1: http://people.canonical.com/~ppisati/imx6_sata/0001-Add-IMX6Q-AHCI-support.patch
-- 
bye,
p.
