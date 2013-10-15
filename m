From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 15 Oct 2013 21:47:27 +0200
Subject: [RESEND PATCHv2 1/3] arm: socfpga: Set the SDMMC clock phase in
 system manager
In-Reply-To: <525D9532.6080503@gmail.com>
References: <1381780051-1826-1-git-send-email-dinguyen@altera.com>
 <201310152101.44669.arnd@arndb.de> <525D9532.6080503@gmail.com>
Message-ID: <201310152147.27569.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 15 October 2013, Dinh Nguyen wrote:
> >
> > 1 Create a "syscon" backend driver to control your "system manager", which
> >    lets other drivers hook into it without calling a private API.
> Yes, if you look at drivers/mmc/host/dw_mmc-socfpga.c that is in the 
> mainline,
> it is hooking into the "system manager" through "syscon". Is this what you
> mean here?

No, because you directly hook into the syscon driver, rather than using
a clock driver as the middle-man, see steps 2 and 3 below.
 
> The problem is because of the SYSMGR_SDMMCGRP_CTRL_OFFSET define
> in this file. This means the SD/MMC driver needs information that is 
> outside of its IP.

Yes, this is not ideal because you don't really want that information
in the sd/mmc driver. That driver should only know about the fact
that it talks to a clock controller, not how it's implemented.

	Arnd

> > 2 Create a trivial clock driver that is independent of your existing
> >    clock driver and independent of the other drivers using the system
> >    manager, by using syscon as the low-level interface.
> > 3 Make the sdmmc driver use the normal clock API and link its clock to the
> >    driver from step 2 in the device tree.
> >
> > Is this what you have tried before?
