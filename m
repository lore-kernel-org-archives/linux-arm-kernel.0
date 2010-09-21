From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 21 Sep 2010 17:03:50 +0200
Subject: [PATCH v2 2/3] [ARM] tegra: add PCI Express support
In-Reply-To: <4C98C2AB.5060409@compulab.co.il>
References: <cover.1285070872.git.mike@compulab.co.il>
	<201009211430.00325.arnd@arndb.de>
	<4C98C2AB.5060409@compulab.co.il>
Message-ID: <201009211703.50542.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 21 September 2010, Mike Rapoport wrote:
> No one should call __io without PCI. However, there are drivers that do not 
> build without __io, e.g.:
> 
>    CC      drivers/serial/8250.o
> drivers/serial/8250.c: In function 'hub6_serial_in':
> drivers/serial/8250.c:397: error: implicit declaration of function 'outb'
> drivers/serial/8250.c:398: error: implicit declaration of function 'inb'
> 
> These references to inb and outb will not be called in runtime anyway, but they 
> are required for the 8250 driver to build.
> I believe there are other drivers except 8250 that require to have __io, 
> although  it will be never actually called on, e.g. Tegra-based platform.

Right, I've seen this before. I'll try to cook up a patch to fix it.
The hub6 support depends on ISA anyway, so we shouldn't be building that
code.

	Arnd
