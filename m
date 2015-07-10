From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 10 Jul 2015 11:22:23 +0100
Subject: [PATCH] ARM: add boot image dependencies not to generate invalid
 images
In-Reply-To: <1436186224-6673-1-git-send-email-yamada.masahiro@socionext.com>
References: <1436186224-6673-1-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <20150710102222.GP7557@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 06, 2015 at 09:37:04PM +0900, Masahiro Yamada wrote:
> [3] Then, re-build "all" and "uImage" simultaneously.
>     You will get an invalid uImage at random.
>   $ make -s -j8 ARCH=arm UIMAGE_LOADADDR=0x80208000 all uImage
>   Image Name:   Linux-4.2.0-rc1-00008-g1c4c715-d
>   Created:      Mon Jul  6 17:52:22 2015
>   Image Type:   ARM Linux Kernel Image (uncompressed)
>   Data Size:    26768 Bytes = 26.14 kB = 0.03 MB
>   Load Address: 80208000
>   Entry Point:  80208000

At no point in the above do I see an attempt to rebuild init/main.o,
which there should be as you touched the corresponding .c file -
because you're hiding that output with -s.  Please show what's going
on without using -s.

> "make uImage" could descend into arch/arm/boot/Makefile before
> "make zImage" is completed because arch/arm/Makefile describes no
> dependency among boot targets.

The uImage target should depend on vmlinux, which should force the
rebuild of init/main.o, and relink of the top-level vmlinux file
before decending into arch/arm/boot/Makefile for the
arch/arm/boot/uImage target.

That makefile contains the dependencies required to order things
correctly - the arch/arm/boot/uImage target depends on
arch/arm/boot/zImage, which in turn depends on
arch/arm/boot/compressed/vmlinux, and then arch/arm/boot/Image.

In other words, arch/arm/boot/Makefile deals with the dependencies
between the targets it's responsible for building itself.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
