From: lee.jones@linaro.org (Lee Jones)
Date: Fri, 11 Jul 2014 08:13:23 +0100
Subject: No uart output on my snowball board
In-Reply-To: <20140710223021.6e9c857f@gandalf.local.home>
References: <20140710223021.6e9c857f@gandalf.local.home>
Message-ID: <20140711071323.GG11948@lee--X1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> I decided to play with my snowball board as that's the easiest arm
> board I have to do testing on, and it was reported to me that I broke
> function graph tracing on the arm boards. But I haven't booted my
> snowball since 3.8. When I tried with the latest kernel, it didn't give
> me *any* output. I figured something was up with the uart, but the
> board also didn't boot.
> 
> I did a bisect to find out where the uart stopped working (I also
> stumbled on where the board stopped booting, but still need to find
> that commit). The uart died with this commit:
> 
> commit a0998b8321eb5f53ef51924f5ab6c69237ac1025
> Author: Lee Jones <lee.jones@linaro.org>
> Date:   Thu Aug 22 16:18:56 2013 +0100
> 
>     ARM: ux500: Remove UART support when booting without Device Tree
>     
>     It's time to remove all ATAG support from ux500 and rely solely on
>     Device Tree booting. This patch is part of that endeavour.
>     
>     Signed-off-by: Lee Jones <lee.jones@linaro.org>
>     Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> 
> This happened between 3.12 and 3.13.
> 
> Does this mean that I need to get device tree support for this. I have
> no idea how to fix it as a device tree to me is a christmas tree (a
> tree with little lighty devices on it). Thus I'll just go and throw
> this out at you.

This is a very slimmed down of my Makefile.  It should bootstrap you
with what you need.  If there are any issues with that that you can't
fix, ping me and I'll test it as-is.  Bear in mind that some of these
config options are probably deprecated by now.  If there are any holes
I'm sure LinusW will spot them.

CROSS_COMPILE	?= arm-linux-gnueabi-
build_dir       := $(CURDIR)/build-snowball
config_file     := $(build_dir)/.config
devicetree	:= $(build_dir)/arch/arm/boot/dts/ste-snowball.dtb
defconfig	:= u8500_defconfig
cpus		:= 4

make_options := -f Makefile \
                ARCH=arm \
                CROSS_COMPILE=$(CROSS_COMPILE) \
                KBUILD_OUTPUT=$(build_dir)

config-devicetree: config-base FORCE
	# Configure in the optional device tree if available
	@if [ -r $(devicetree) ] ; then \
	$(CURDIR)/scripts/config --file $(config_file) \
	  --enable USE_OF \
	  --enable ARM_APPENDED_DTB \
	  --enable ARM_ATAG_DTB_COMPAT \
	  --enable PROC_DEVICETREE \
	  --set-str ARM_APPENDED_DTB_FILE $(devicetree) ; \
	else \
	  echo "$(devicetree) not found, or not readable" ; \
	fi

build: config-devicetree FORCE
	@mkdir -p $(build_dir)
	$(MAKE) $(make_options) dtbs
	$(MAKE) $(make_options) $(defconfig)
	$(MAKE) $(make_options) -j $(cpus) zImage
	cat $(devicetree) >> $(build_dir)/arch/arm/boot/zImage

	mkimage -A arm -O linux -T kernel -C none \
	-a 0x00008000 -e 0x00008000 -n "Linux" 	  \
	-d $(build_dir)/arch/arm/boot/zImage	  \
	$(build_dir)/uImage

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
