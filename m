From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Wed, 7 Feb 2018 01:15:44 +0000
Subject: Device tree bug in armada-8040-mcbin.dts
In-Reply-To: <alpine.LRH.2.02.1802061650060.4974@file01.intranet.prod.int.rdu2.redhat.com>
References: <alpine.LRH.2.02.1802061650060.4974@file01.intranet.prod.int.rdu2.redhat.com>
Message-ID: <20180207011544.GK9418@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 06, 2018 at 04:59:22PM -0500, Mikulas Patocka wrote:
> Hi
> 
> When the MacchiatoBIN kernel is compiled with CONFIG_PM=y, it is 
> frequently reporing this error (the error happens every time some I/O on 
> built-in eMMC happens):
> 
> "mmc0: Switching to 3.3V signalling voltage failed"

Yep, it's annoying.

> The problem is that the "&ap_sdhci0" device tree node asserts that the 
> controller doesn't support 1.8v, but it attaches it to the fixed voltage 
> regulator "v_vddo_h" that only supplies 1.8V.
> 
> Should it be attached to the 3.3V regulator instead? Or should the 
> "vqmmc-supply" statemet be deleted? Or should the statement "no-1-8-v" be 
> deleted?

Removing the "no-1-8-v" statement breaks it, and the reality is that the
signalling voltage is fixed at 1.8V, so the "vqmmc-supply" is correct.
The problem here is that the MMC layer doesn't understand that, and
always wants to do the initial probe at vqmmc=3.3V.  Hence the above
message.

It would be nice if MMC understood the concept of a bus operating at a
fixed voltage, then the "no-1-8-v" hack could be removed.

Which-ever way is chosen, the result is that we end up _not_ describing
the hardware, but we end up describing something suitable for the
implementation, which is not how DT is supposed to work.  MMC really
needs to be fixed.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 8.8Mbps down 630kbps up
According to speedtest.net: 8.21Mbps down 510kbps up
