From: joerg.krause@embedded.rocks (=?ISO-8859-1?Q?J=F6rg?= Krause)
Date: Sun, 20 Nov 2016 13:27:49 +0100
Subject: mmc: core: complete/wait_for_completion performance
Message-ID: <1479644869.2653.3.camel@embedded.rocks>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

I started the discussion on this mailing list in another thread [1],
but I'd like to move it to a new thread, because it might be mmc
specific.

The issue is that I am noticed low wifi network throughput on an i.MX28
board with the mainline kernel (v4.7.10, about 6 Mbps) compared to the
vendor kernel (Freescale v2.6.35.3, about 20 Mbps). The wifi chip is
attached using the SDIO interface.

I started investigation where the bottleneck in the mainline
kernel?might come from. Therefore I checked that the configs and
settings for the interfaces and drivers are the same. They are.

For comparing both kernel version I measured the latency for the
different parts in the code flow by adding some GPIOs to toggle and
useing an osci.

It turns out, that the time needed do pass a mmc request from the wifi
driver to the dma and waiting for the response of the dma is almost the
same for both kernel versions. So the path from the wifi driver to the
dma driver is not the issue.

However, the major difference was the time needed to signal the
completion of the request back to the mmc core driver.

For mainline, the time elapsed?from calling complete() in
mmc_wait_done() [2] in the mmc core driver until actually receiving the
completion signal in mmc_wait_for_req_done() [3] is about 120 us. 

Whereas, for the vendor kernel,?the elapsed time for this notifcation
is about 100 us less!

I wonder why the notification takes so much longer in the mainline
kernel than in the vendor kernel? Where should I start looking at to
eliminate this bottleneck? Is it a scheduling issue?

[1] http://lists.infradead.org/pipermail/linux-arm-kernel/2016-October/
461137.html
[2] http://lxr.free-electrons.com/source/drivers/mmc/core/core.c#L386
[3] http://lxr.free-electrons.com/source/drivers/mmc/core/core.c#L492

Best regards,
J?rg Krause
