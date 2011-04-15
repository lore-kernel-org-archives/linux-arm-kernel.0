From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 15 Apr 2011 13:39:24 +0100
Subject: [PATCH] ARM: Davinci: Fix I2C build errors
In-Reply-To: <20110415123240.GK1611@n2100.arm.linux.org.uk>
References: <20110415123240.GK1611@n2100.arm.linux.org.uk>
Message-ID: <20110415123924.GL1611@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 15, 2011 at 01:32:40PM +0100, Russell King - ARM Linux wrote:
> Several Davinci platforms select the I2C EEPROM support, but don't
> select I2C support.  This causes I2C EEPROM support to be built into
> the kernel, but I2C support may not be configured to be built in.
> This leads to linker errors due to missing I2C symbols.
> 
> Arrange for I2C to be selected whenever EEPROM_AT24 is selected.

Although this fixes I2C build errors, it leaves these errors:

arch/arm/mach-davinci/built-in.o: In function `phy_read':
include/linux/phy.h:454: undefined reference to `mdiobus_read'
arch/arm/mach-davinci/built-in.o: In function `phy_write':
include/linux/phy.h:469: undefined reference to `mdiobus_write'
arch/arm/mach-davinci/built-in.o: In function `davinci_evm_init':
arch/arm/mach-davinci/board-dm644x-evm.c:708: undefined reference to `phy_register_fixup_for_uid'

which also look like a configuration problem.
