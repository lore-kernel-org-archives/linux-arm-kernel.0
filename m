From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Sat, 11 Jul 2015 01:41:27 +0900
Subject: [PATCH] ARM: add boot image dependencies not to generate invalid
 images
In-Reply-To: <20150710102222.GP7557@n2100.arm.linux.org.uk>
References: <1436186224-6673-1-git-send-email-yamada.masahiro@socionext.com>
 <20150710102222.GP7557@n2100.arm.linux.org.uk>
Message-ID: <CAK7LNAS9L1GEpCfrA7YNzifFfwNbhHFy5ia=wy=Wyuho11BOnw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russel,


2015-07-10 19:22 GMT+09:00 Russell King - ARM Linux <linux@arm.linux.org.uk>:
> On Mon, Jul 06, 2015 at 09:37:04PM +0900, Masahiro Yamada wrote:
>> [3] Then, re-build "all" and "uImage" simultaneously.
>>     You will get an invalid uImage at random.
>>   $ make -s -j8 ARCH=arm UIMAGE_LOADADDR=0x80208000 all uImage
>>   Image Name:   Linux-4.2.0-rc1-00008-g1c4c715-d
>>   Created:      Mon Jul  6 17:52:22 2015
>>   Image Type:   ARM Linux Kernel Image (uncompressed)
>>   Data Size:    26768 Bytes = 26.14 kB = 0.03 MB
>>   Load Address: 80208000
>>   Entry Point:  80208000
>
> At no point in the above do I see an attempt to rebuild init/main.o,
> which there should be as you touched the corresponding .c file -
> because you're hiding that output with -s.  Please show what's going
> on without using -s.

Please see the log attached at the end of this message.


>> "make uImage" could descend into arch/arm/boot/Makefile before
>> "make zImage" is completed because arch/arm/Makefile describes no
>> dependency among boot targets.
>
> The uImage target should depend on vmlinux, which should force the
> rebuild of init/main.o, and relink of the top-level vmlinux file
> before decending into arch/arm/boot/Makefile for the
> arch/arm/boot/uImage target.
>
> That makefile contains the dependencies required to order things
> correctly - the arch/arm/boot/uImage target depends on
> arch/arm/boot/zImage, which in turn depends on
> arch/arm/boot/compressed/vmlinux, and then arch/arm/boot/Image.
>
> In other words, arch/arm/boot/Makefile deals with the dependencies
> between the targets it's responsible for building itself.

No, you do not understand what is happening in here.


The dependencies among targets such as Image, zImage, uImage,
are fully described in arch/arm/boot/Makefile, but it is not enough.

Because arch/arm/boot/Makefile is _not_ included from the top-level Makefile,
the top-level build cannot know the dependency between zImage and uImage.

arch/arm/Makefile, which is included from the top Makefile,
only describes that zImage depends on vmlinux,
and uImage depends on vmlinux as well.
But, no dependency between zImage and uImage is written in arch/arm/Makefile.

Consequently, we run make with the parallel option, first Kbuild
updates vmlinux,
and then two different threads descends into arch/arm/boot/Makefile
almost at the same time, one for updating zImage and the other for uImage.

The is a race between the two threads.

While one thread is re-generating zImage and also uImage on top of that,
the other thread tries to re-generate zImage independently.

zImage is overwritten by the slower thread, and then uImage is
re-generated based on the broken zImage.

See my detailed build log below:

Please note:
"Kernel: arch/arm/boot/zImage is ready"
is displayed twice,
the first one is shown before the uImage log, and the second one is
after uImage.

zImage is correct, but uImage is extremely small when this problem happens.



$ git describe
v4.2-rc1-62-gc4b5fd3


$ touch init/main.c
$ make -j8 ARCH=arm UIMAGE_LOADADDR=0x80208000 all uImage
  CHK     include/config/kernel.release
  CHK     include/generated/uapi/linux/version.h
  CHK     include/generated/utsrelease.h
make[1]: `include/generated/mach-types.h' is up to date.
  CHK     include/generated/timeconst.h
  CHK     include/generated/bounds.h
  CHK     include/generated/asm-offsets.h
  CALL    scripts/checksyscalls.sh
  CC      init/main.o
  CHK     include/generated/compile.h
  LD      init/built-in.o
  LINK    vmlinux
  LD      vmlinux.o
  MODPOST vmlinux.o
  GEN     .version
  CHK     include/generated/compile.h
  UPD     include/generated/compile.h
  CC      init/version.o
  LD      init/built-in.o
  KSYM    .tmp_kallsyms1.o
  KSYM    .tmp_kallsyms2.o
  LD      vmlinux
  SORTEX  vmlinux
  SYSMAP  System.map
  OBJCOPY arch/arm/boot/Image
  Building modules, stage 2.
  Kernel: arch/arm/boot/Image is ready
  GZIP    arch/arm/boot/compressed/piggy.gzip
  AS      arch/arm/boot/compressed/piggy.gzip.o
  Kernel: arch/arm/boot/Image is ready
  GZIP    arch/arm/boot/compressed/piggy.gzip
  LD      arch/arm/boot/compressed/vmlinux
  OBJCOPY arch/arm/boot/zImage
  Kernel: arch/arm/boot/zImage is ready
  UIMAGE  arch/arm/boot/uImage
Image Name:   Linux-4.2.0-rc1-00062-gc4b5fd3-d
Created:      Sat Jul 11 01:22:22 2015
Image Type:   ARM Linux Kernel Image (uncompressed)
Data Size:    26472 Bytes = 25.85 kB = 0.03 MB
Load Address: 80208000
Entry Point:  80208000
  Image arch/arm/boot/uImage is ready
  MODPOST 192 modules
  AS      arch/arm/boot/compressed/piggy.gzip.o
  LD      arch/arm/boot/compressed/vmlinux
  OBJCOPY arch/arm/boot/zImage
  Kernel: arch/arm/boot/zImage is ready
$ LANG=C ls -l arch/arm/boot/
total 19636
-rwxrwxr-x 1 masahiro masahiro 13766656 Jul 11 01:22 Image
-rw-rw-r-- 1 masahiro masahiro     3137 Jul  3 01:17 Makefile
drwxrwxr-x 2 masahiro masahiro     4096 Jul  3 01:17 bootp
drwxrwxr-x 2 masahiro masahiro     4096 Jul 11 01:22 compressed
drwxrwxr-x 3 masahiro masahiro   155648 Jul 11 00:58 dts
-rw-rw-r-- 1 masahiro masahiro     1648 Jul  3 01:17 install.sh
-rw-rw-r-- 1 masahiro masahiro    26536 Jul 11 01:22 uImage
-rwxrwxr-x 1 masahiro masahiro  6135048 Jul 11 01:22 zImage







-- 
Best Regards
Masahiro Yamada
