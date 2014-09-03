From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 03 Sep 2014 20:28:42 +0200
Subject: [PATCH v2 5/7] arm64: dts: Add initial device tree support for
 EXYNOS7
In-Reply-To: <043401cfc794$7f228650$7d6792f0$@samsung.com>
References: <1409672143-8574-1-git-send-email-ch.naveen@samsung.com>
 <3382034.5ADO0F7naY@wuerfel> <043401cfc794$7f228650$7d6792f0$@samsung.com>
Message-ID: <118816680.lTOkj0TsFJ@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 04 September 2014 01:31:21 Kukjin Kim wrote:
> > This is the board specific file, so it seems ok.
> > 
> I mean there are many espresso boards are having different exynos7
> SoC. I mean exynos7-espresso cannot represent all of espresso boards.
> 

Ah, I see, that makes sense.

We definitely need a top-level .dts file for each board that is different
in a nondiscoverable way then.

If the mmc settings and possibly some other nodes (to be added later)
are common across them, those can be in a board specific .dtsi file.

For the memory node, I would actually expect that to be filled by
the boot loader, so we could leave it out entirely. The same applies
to the command line: the parts that are in there at the moment (
"console=ttySAC2,115200n8 root=/dev/ram0 ramdisk=16384 initrd=0x42000000,16M")
clearly don't belong into a generic dts file and none of them should be
set that way.

For the initial version, that would mean that the file comes down to having
as its only contents

/dts-v1/;
#include <dt-bindings/gpio/gpio.h>
#include "exynos7123.dtsi"
#include "exynos7-espresso.dtsi" // for the mmc nodes

/ {
       model = "Samsung ESPRESSO board based on EXYNOS7123";
       compatible = "samsung,espresso", "samsung,exynos7123", "samsung,exynos7";
};

One more thing I just noticed is the GPL statement in the dts files.
Can we please change that to a permissive license in order to allow
including it in non-GPL boot loaders and operating systems?

Dual GPL+MIT or GPL+BSD would make most sense here.

	Arnd
