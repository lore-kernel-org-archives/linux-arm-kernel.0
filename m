From: js@sig21.net (Johannes Stezenbach)
Date: Wed, 23 Mar 2016 16:40:49 +0100
Subject: dmaengine pl08x dt crash
Message-ID: <20160323154049.GA2170@sig21.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

I'm trying to use the new devicetree support for pl08x
added in commit aa4734da667442
(dmaengine: pl08x: support dt channel assignment).

It causes crash in the pl011 serial driver when it calls
dma_chan_name() because the dma_chan->dev->device is NULL.
I think the reason is dma_async_device_register() is called
during pl08x_probe(), but at this time the number of slave
channels is still 0 as these get allocated later in
pl08x_of_xlate() when clients request the channels.

[    0.420835] pl08xdmac dma8ch0: initialized 8 virtual memcpy channels
[    0.427380] pl08xdmac dma8ch0: initialized 0 virtual slave channels
[    0.436185] pl08xdmac dma8ch0: DMA: PL080s rev1 at 0xfec00000 irq 8
...
[    1.268140] Unable to handle kernel NULL pointer dereference at virtual address 00000034
...
[    1.306397] PC is at pl011_dma_probe+0x114/0x31c
[    1.311018] LR is at pl011_dma_probe+0x104/0x31c
...
[    1.630388] Backtrace:
[    1.632856] [<c01f1784>] (pl011_dma_probe) from [<c01f2cd4>] (pl011_startup+0xd4/0x2b8)
[    1.640856]  r7:00000000 r6:c78b3610 r5:00000000 r4:c78b3610
[    1.646559] [<c01f2c00>] (pl011_startup) from [<c01ef5bc>] (uart_startup.part.3+0x84/0x164)
[    1.654905]  r8:00000000 r7:00000000 r6:c78b3610 r5:c7b09400 r4:c78172e0 r3:c01f2c00
[    1.662701] [<c01ef538>] (uart_startup.part.3) from [<c01ef7c4>] (uart_open+0x128/0x16c)
[    1.670787]  r8:c786da00 r7:c7817358 r6:00000000 r5:c7b09400 r4:c78172e0 r3:00000000
[    1.678583] [<c01ef69c>] (uart_open) from [<c01e32a0>] (tty_open+0x338/0x550)


Johannes
