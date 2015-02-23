From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 23 Feb 2015 11:24:46 +0100
Subject: Build regressions/improvements in v4.0-rc1
In-Reply-To: <CAMuHMdVMCvw1euM0c2AYrYibO4ObZLV6F_-CDPZZ6x44D6Hwug@mail.gmail.com>
References: <1424680402-3477-1-git-send-email-geert@linux-m68k.org>
 <5900255.NhXvduRnha@wuerfel>
 <CAMuHMdVMCvw1euM0c2AYrYibO4ObZLV6F_-CDPZZ6x44D6Hwug@mail.gmail.com>
Message-ID: <5721217.aGU5oqfDWo@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 23 February 2015 10:14:55 Geert Uytterhoeven wrote:
> On Mon, Feb 23, 2015 at 10:03 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> >> >   + /home/kisskb/slave/src/fs/dax.c: error: implicit declaration of function 'copy_user_page' [-Werror=implicit-function-declaration]:  => 266:2
> >
> > DAX support was merged with 'depends on !(ARM || MIPS || SPARC)', so I don't
> > see how this could happen.
> 
> sh is not ARM, not MIPS, not SPARC, so...?

I misread your email and thought this was still under arm-randconfig.

I checked the other architectures, and found that the same is missing on
ARC, so we should add both:

diff --git a/fs/Kconfig b/fs/Kconfig
index ec35851e5b71..a24d496787d6 100644
--- a/fs/Kconfig
+++ b/fs/Kconfig
@@ -36,7 +36,7 @@ source "fs/nilfs2/Kconfig"
 config FS_DAX
 	bool "Direct Access (DAX) support"
 	depends on MMU
-	depends on !(ARM || MIPS || SPARC)
+	depends on !(ARC || ARM || MIPS || SH || SPARC)
 	help
 	  Direct Access (DAX) can be used on memory-backed block devices.
 	  If the block device supports DAX and the filesystem supports DAX,


It's also not implemented on c6x and blackfin, but both of them have
MMU=n, so they are already excluded.

> >> sh-randconfig
> 
> >> >   + /home/kisskb/slave/src/sound/soc/codecs/max98357a.c: error: implicit declaration of function 'devm_gpiod_get' [-Werror=implicit-function-declaration]:  => 55:2
> >> >   + /home/kisskb/slave/src/sound/soc/codecs/max98357a.c: error: implicit declaration of function 'gpiod_direction_output' [-Werror=implicit-function-declaration]:  => 61:2
> >> >   + /home/kisskb/slave/src/sound/soc/codecs/max98357a.c: error: implicit declaration of function 'gpiod_set_value' [-Werror=implicit-function-declaration]:  => 30:3
> >
> > Something wrong in arch/sh/include/asm/gpio.h? the codec is only
> > selectable when gpiolib is enabled, but the consumer.h header
> > apparently does not get included here.
> 
> I think it's an bad select, for which a patch has been available since
> about 2 weeks.

Ah, right. I was looking at linux-next, which has the fix, so I did not
see the problem at first.

	Arnd
