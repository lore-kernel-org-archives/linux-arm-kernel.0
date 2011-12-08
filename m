From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 8 Dec 2011 15:48:08 +0000
Subject: [PATCH] arm,
 davinci: configure davinci aemif chipselects through OF
In-Reply-To: <DF0F476B391FA8409C78302C7BA518B6040CBB@DBDE01.ent.ti.com>
References: <1322991679-20947-1-git-send-email-hs@denx.de>
 <4EE07E27.8090602@denx.de>
 <DF0F476B391FA8409C78302C7BA518B6040CBB@DBDE01.ent.ti.com>
Message-ID: <201112081548.08548.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 08 December 2011, Nori, Sekhar wrote:
> DaVinci AEMIF is an async memory interface peripheral implemented
> in arch/arm/mach-davinci/aemif.c. It helps interface to NAND, NOR
> and other asynchronous memories. Currently it just provides an API
> for timing value configuration. The API is invoked by the MTD NAND
> driver.
> 
> Specification here: http://www.ti.com/lit/ug/sprue20c/sprue20c.pdf
> 
> We are looking at a place for this outside of architecture code.

I think the best place depends on how you plan to use the sram
interface. If all memory behind the aemif is handled by mtd, I would
put the entire driver somewhere in the mtd infrastructure.

If you want it to provide endpoint devices that are handled by
distinct subsystems in Linux, I would make it an mfd multifunction
device and make the common code a driver that scans the connected
memories in order to register its child devices for each of the
subsystems.

	Arnd
