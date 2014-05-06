From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 6 May 2014 14:42:42 +0200
Subject: [PATCH v3 06/20] usb: host: xhci-plat: Add support for the
 Armada 38x
In-Reply-To: <4660313.evfclGtT1x@wuerfel>
References: <1399335255-589-1-git-send-email-gregory.clement@free-electrons.com>
 <61061197.hLhKsFqJLF@wuerfel> <20140506141023.715b932d@skate>
 <4660313.evfclGtT1x@wuerfel>
Message-ID: <20140506144242.1b098f30@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Arnd Bergmann,

On Tue, 06 May 2014 14:21:55 +0200, Arnd Bergmann wrote:

> > That's not what we do for any of the other drivers that use the
> > MVEBU_MBUS functions.
> 
> Fair enough. I guess using ARCH_MVEBU as the dependency works as well
> because it implies MVEBU_MBUS. However, you can't use COMPILE_TEST
> then because the driver itself needs the interfaces provided by MBUS.
> 
> It could be
> 
> 	depends on ARCH_MVEBU || (MVEBU_MBUS && COMPILE_TEST)
> 
> to describe the dependency most accurately.

Right, that would work indeed, but is in fact not necessary, at least
for this driver. The only mbus function used by this driver is
mv_mbus_dram_info(), and <linux/mbus.h> provides an empty stub for this
function (returning NULL) when MVEBU_MBUS is disabled. So from a
compile time point of view, there is no problem with compiling the
xhci-plat driver with MVEBU_MBUS disabled, so in fact:

	depends on ARCH_MVEBU || COMPILE_TEST

will work just fine.

The only case where this doesn't work is for drivers that use the other
mbus functions to create/remove windows, because no stubs are provided
for these ones. However, as things are today, the only driver in this
situation is the pci-mvebu driver, and its dependency is:

	depends on ARCH_MVEBU || ARCH_DOVE || ARCH_KIRKWOOD

For this one, we could indeed add || (MVEBU_MBUS && COMPILE_TEST)

Best regards,

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
