From: joel@jms.id.au (Joel Stanley)
Date: Tue, 13 Oct 2009 01:16:46 +1030
Subject: [PATCH] [ARM] kirkwood: combine support for openrd base/client
	support
In-Reply-To: <200910120946.01628.dk-arm-linux@gmx.de>
References: <20091009123956.GA6085@chipmunk>
	<200910120836.03584.dk-arm-linux@gmx.de>
	<20091012073122.GH6085@chipmunk>
	<200910120946.01628.dk-arm-linux@gmx.de>
Message-ID: <ad9478410910120746g2ce82af1t71a84ea02e9eecb7@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Mon, Oct 12, 2009 at 18:16, Dieter Kiermaier <dk-arm-linux@gmx.de> wrote:
>> If you can point out where I should be looking, I will have a look and
>> if I can find it I will enable it.
>
> I'm sorry, but I haven't an openrd-client board :(
> Maybe someone else can help us?

I have tested Alexander's patch on my openrd-client board, applied to
Linus' tree.  It boots and networking works fine.

I also added calls to initialise i2c and pcie based on the patch by
Simon Kagstrom, and both devices appear to work.  The diff I added is
attached.

# i2cdetect -l
i2c-0	i2c       	mv64xxx_i2c adapter             	I2C adapter

# lspci -v
00:00.0 Memory controller: Marvell Technology Group Ltd. Device 6281 (rev 02)
	Subsystem: Marvell Technology Group Ltd. Device 11ab
	Flags: bus master, fast devsel, latency 0, IRQ 9
	Memory at <ignored> (64-bit, prefetchable)
	Capabilities: [40] Power Management version 3
	Capabilities: [50] MSI: Enable- Count=1/1 Maskable- 64bit+
	Capabilities: [60] Express Root Port (Slot-), MSI 00
	Capabilities: [100] Advanced Error Reporting

00:01.0 VGA compatible controller: XGI Technology Inc. (eXtreme
Graphics Innovation) Z11/Z11M (prog-if 00 [VGA controller])
	Flags: bus master, fast devsel, latency 0
	BIST result: 00
	Memory at e0000000 (32-bit, prefetchable) [size=64M]
	Memory at e4000000 (32-bit, non-prefetchable) [size=256K]
	I/O ports at f2000000 [size=128]
	[virtual] Expansion ROM at e4040000 [disabled] [size=64K]
	Capabilities: [40] Power Management version 2
	Capabilities: [a0] Express Endpoint, MSI 01
	Capabilities: [c0] MSI: Enable- Count=1/1 Maskable- 64bit-
	Capabilities: [100] Advanced Error Reporting

Joel

--

Author: Joel Stanley <joel@jms.id.au>
Date:   Tue Oct 13 00:02:04 2009 +1030

    Add pcie and i2c initalisation

diff --git a/arch/arm/mach-kirkwood/openrd-setup.c
b/arch/arm/mach-kirkwood/openrd-setup.c
index 6bdeeab..d5504e2 100644
--- a/arch/arm/mach-kirkwood/openrd-setup.c
+++ b/arch/arm/mach-kirkwood/openrd-setup.c
@@ -80,6 +80,10 @@ static void __init openrd_init(void)
 #endif
        kirkwood_sata_init(&openrd_sata_data);
        kirkwood_sdio_init(&openrd_mvsdio_data);
+
+       kirkwood_i2c_init();
+
+       kirkwood_pcie_init();
 }

 #ifdef CONFIG_MACH_OPENRD_BASE
