From: lukas-x@zapletalovi.com (Lukas Zapletal)
Date: Mon, 18 Mar 2013 09:16:34 +0000 (UTC)
Subject: Kirkwood NSA 310 does not boot with 3.8.3
References: <loom.20130316T213930-150@post.gmane.org>
 <20130316215530.GZ12700@titan.lakedaemon.net>
Message-ID: <loom.20130318T094229-725@post.gmane.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Jason Cooper <jason <at> lakedaemon.net> writes:
> You'll need to enable ARM_APPENDED_DTB, concatenate your dtb onto your
> zImage, then run mkimage on the result to get the uImage.

Jason, thanks for help. It worked great, just for completenes for googlers:

# grep "ARM_APPENDED_DTB|NSA" .config
CONFIG_ARM_APPENDED_DTB=y
CONFIG_MACH_NSA310_DT=y

# make zImage

# make dtbs

# cat arch/arm/boot/zImage arch/arm/boot/dts/kirkwood-nsa310.dtb > /tmp/X
# mv /tmp/X arch/arm/boot/zImage

# make uImage

...
Image Type:   ARM Linux Kernel Image (uncompressed)
Data Size:    3684110 Bytes = 3597.76 kB = 3.51 MB
Load Address: 00008000
Entry Point:  00008000
Image arch/arm/boot/uImage is ready

# cp arch/arm/boot/uImage /boot/uImage-nsa310

UBOOT# ide reset; ext2load ide 0:1 0x800000 /uImage-nsa310; bootm 0x800000

Compared to my patched NSA310 3.6 kernel I don't see console anymore, I guess is 
is just an config option I miss. And LEDs are not working yet.

Thank you
