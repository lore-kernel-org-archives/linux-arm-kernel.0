From: eric.y.miao@gmail.com (Eric Miao)
Date: Sat,  5 Jun 2010 15:55:34 +0800
Subject: [PATCH 0/4] [ARM] Reduce the defconfig numbers for PXA
Message-ID: <1275724538-5075-1-git-send-email-eric.y.miao@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

1. dma_needs_bounce() prevents it8152.c and sa1111.c from being built 
   together. Actually it8152.c is sane and dma_needs_bounce() can be
   removed simply. (Mike, could you give it a test?)

2. Currently, zaurus is not able to be built into a single kernel with
   other boards, since arch/arm/boot/compressed/head-sharpsl.S will
   try detecting the machine ID and will cause a dead loop on other
   boards at run-time. (if we stick with kexecboot or u-boot on
   zaurus, maybe we can remove head-sharpsl.S as well, and merge them
   into pxa2xx_defconfig as well)

3. All board configs with CONFIG_PXA2[57]x=y are now merged into pxa2xx_defconfig

4. All board configs with CONFIG_PXA3xx=y are now merged into pxa3xx_defconfig

The merge is rough, pxa2xx_defconfig as an example:

  1. $> cat mainstone_defconfig > .config
  2. $> for i in $(pxa2xx board defconfigs other than mainstone_defconfig); do
	    sed '/# CONFIG.*is not set/d' $i >> pxa2xx_defconfig
	done
  3. $> make oldconfig
  4. $> cp .config arch/arm/configs/pxa2xx_defconfig

The idea is to use mainstone_defconfig as a base, append all those
inclusive config options (not those "# CONFIG.*is not set").

Conflicts can happen with:

  - CONFIG_* being 'y' or 'm', this is less important provided the
    platform is sane enough to support both builtin and modules

  - CONFIG_* being a value type, the former will always be overwritten
    e.g. CONFIG_CMDLINE

That's why it's rough. I don't have time to look into those conflicts
though, I'd like each board maintainer to give it a test.
