From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 22 Jun 2011 17:10:39 +0200
Subject: i.MX consolidation patches
In-Reply-To: <20110622145828.GL6069@pengutronix.de>
References: <1305823648-2428-1-git-send-email-s.hauer@pengutronix.de>
	<20110622090321.GO23234@n2100.arm.linux.org.uk>
	<20110622145828.GL6069@pengutronix.de>
Message-ID: <201106221710.39687.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 22 June 2011, Sascha Hauer wrote:
> --- a/arch/arm/boot/Makefile
> +++ b/arch/arm/boot/Makefile
> @@ -59,6 +59,11 @@ $(obj)/zImage:       $(obj)/compressed/vmlinux FORCE
>  
>  endif
>  
> +ifneq ($(words $(ZRELADDR)), 1)
> +$(obj)/uImage: FORCE
> +       @echo 'Multiple zreladdrs, cannot build uImage'
> +       exit 1
> +else

Failing the build for a possible configuration is not nice, I would
be happier if this could be prevented in Kconfig. I have recently
worked on getting all 'randconfig' build working for a bunch of platforms
(patches will follow), so it would be a shame to have another
guaranteed failure built into the kernel.

Your patch is ok by itself, in order to detect the case when Kconfig
logic has failed, but we should also have a way to prevent enabling
uImage building in Kconfig for configurations that are known to
not work.

	Arnd
