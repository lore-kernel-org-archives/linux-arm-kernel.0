From: hartleys@visionengravers.com (H Hartley Sweeten)
Date: Wed, 13 Jan 2010 19:11:44 -0500
Subject: Question: __ARM_EABI__
In-Reply-To: <19278.22412.764361.337948@pilspetsen.it.uu.se>
References: <BD79186B4FD85F4B8E60E381CAEE190902089C63@mi8nycmail19.Mi8.com><19278.11469.95923.629825@pilspetsen.it.uu.se><BD79186B4FD85F4B8E60E381CAEE190902089C95@mi8nycmail19.Mi8.com><20100113210503.GG28292@n2100.arm.linux.org.uk><BD79186B4FD85F4B8E60E381CAEE190902089C9B@mi8nycmail19.Mi8.com><20100113211725.GH28292@n2100.arm.linux.org.uk><BD79186B4FD85F4B8E60E381CAEE190902089CA8@mi8nycmail19.Mi8.com>
	<19278.22412.764361.337948@pilspetsen.it.uu.se>
Message-ID: <BD79186B4FD85F4B8E60E381CAEE190902089CD2@mi8nycmail19.Mi8.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday, January 13, 2010 4:30 PM, Mikael Pettersson wrote:
> H Hartley Sweeten writes:
>> But, I'm actually getting the wrong message.
>> 
>> Alessandro Rubini pointed out that I could use "-dM" in the preprocessor
>> to dump the defines.  My toolchain has these particular defines:
>> 
>> #define __GNUC__ 4
>> #define __GNUC_MINOR__ 3
>> #define __ARM_EABI__ 1
>> 
>> 4.3.2 might not support unwinding correctly but I still should not get
>> any of the warning messages.
>> 
>> Confused...
>
> Indeed, I dug out my old gcc-4.3 eabi cross-gcc and it produced no such
> warnings, with or without CONFIG_ARM_UNWIND.
>
> make ARCH=arm mrproper, reinstate your .config, make V=1 and show us
> the complete command-line and messages for the compilation of unwind.c.
>
> Do you have CONFIG_AEABI=y in your .config?

CONFIG_AEABI=y is in my .config

Looks like this might be a sparse issue.

A normal build of the kernel (make or make V=1) does not produce the
Warning messages.  But a sparse build (make C=2 or make C=2 V=1) does
make the warnings appear.

The complete command line with V=1 for both is quite long.  The only
differences are (broken down for readability):

$ make V=1
...
  /home/bigguiness/toolchain/x-tools/arm-unknown-linux-gnueabi/bin/arm-unknown-linux-gnueabi-gcc
	# common command-line options removed
 	-c 
  	-o arch/arm/kernel/unwind.o arch/arm/kernel/unwind.c
...

$ make C=2 V=1
...
  sparse 
  	-D__linux__ 
  	-Dlinux 
  	-D__STDC__ 
  	-Dunix 
  	-D__unix__ 
  	-Wbitwise 
  	-Wno-return-void  
  	-D__arm__  
  	-nostdinc 
  	-isystem /home/bigguiness/toolchain/x-tools/arm-unknown-linux-gnueabi/lib/gcc/arm-unknown-linux-gnueabi/4.3.2/include 
	# common command-line options removed
   	arch/arm/kernel/unwind.c ;
arch/arm/kernel/unwind.c:30:2: warning: Your compiler does not have EABI support.
arch/arm/kernel/unwind.c:31:2: warning: ARM unwind is known to compile only with EABI compilers.
arch/arm/kernel/unwind.c:32:2: warning: Change compiler or disable ARM_UNWIND option.
arch/arm/kernel/unwind.c:51:6: warning: symbol '__aeabi_unwind_cpp_pr0' was not declared. Should it be static?
arch/arm/kernel/unwind.c:56:6: warning: symbol '__aeabi_unwind_cpp_pr1' was not declared. Should it be static?
arch/arm/kernel/unwind.c:61:6: warning: symbol '__aeabi_unwind_cpp_pr2' was not declared. Should it be static?
...

Following are the actual command-lines.

$ make V=1
...
  /home/bigguiness/toolchain/x-tools/arm-unknown-linux-gnueabi/bin/arm-unknown-linux-gnueabi-gcc -Wp,-MD,arch/arm/kernel/.unwind.o.d  -nostdinc -isystem /home/bigguiness/toolchain/x-tools/arm-unknown-linux-gnueabi/lib/gcc/arm-unknown-linux-gnueabi/4.3.2/include -Iinclude  -I/home/bigguiness/buildroot/output/build/linux-2.6.32.3/arch/arm/include -include include/linux/autoconf.h -D__KERNEL__ -mlittle-endian -Iarch/arm/mach-ep93xx/include -Wall -Wundef -Wstrict-prototypes -Wno-trigraphs -fno-strict-aliasing -fno-common -Werror-implicit-function-declaration -Wno-format-security -fno-delete-null-pointer-checks -Os -marm -mabi=aapcs-linux -mno-thumb-interwork -funwind-tables -D__LINUX_ARM_ARCH__=4 -march=armv4t -mtune=arm9tdmi -msoft-float -Uarm -fno-stack-protector -fomit-frame-pointer -g -Wdeclaration-after-statement -Wno-pointer-sign -fno-strict-overflow   -D"KBUILD_STR(s)=#s" -D"KBUILD_BASENAME=KBUILD_STR(unwind)"  -D"KBUILD_MODNAME=KBUILD_STR(unwind)"  -c -o arch/arm/kernel/unwind.o arch/arm/kernel/unwind.c
...

$ make C=2 V=1
...
  sparse -D__linux__ -Dlinux -D__STDC__ -Dunix -D__unix__ -Wbitwise -Wno-return-void  -D__arm__  -nostdinc -isystem /home/bigguiness/toolchain/x-tools/arm-unknown-linux-gnueabi/lib/gcc/arm-unknown-linux-gnueabi/4.3.2/include -Wp,-MD,arch/arm/kernel/.unwind.o.d  -nostdinc -isystem /home/bigguiness/toolchain/x-tools/arm-unknown-linux-gnueabi/lib/gcc/arm-unknown-linux-gnueabi/4.3.2/include -Iinclude  -I/home/bigguiness/buildroot/output/build/linux-2.6.32.3/arch/arm/include -include include/linux/autoconf.h -D__KERNEL__ -mlittle-endian -Iarch/arm/mach-ep93xx/include -Wall -Wundef -Wstrict-prototypes -Wno-trigraphs -fno-strict-aliasing -fno-common -Werror-implicit-function-declaration -Wno-format-security -fno-delete-null-pointer-checks -Os -marm -mabi=aapcs-linux -mno-thumb-interwork -funwind-tables -D__LINUX_ARM_ARCH__=4 -march=armv4t -mtune=arm9tdmi -msoft-float -Uarm -fno-stack-protector -fomit-frame-pointer -g -Wdeclaration-after-statement -Wno-pointer-sign -fno-strict-overflow   -D"KBUILD_STR(s)=#s" -D"KBUILD_BASENAME=KBUILD_STR(unwind)"  -D"KBUILD_MODNAME=KBUILD_STR(unwind)"  arch/arm/kernel/unwind.c ;
arch/arm/kernel/unwind.c:30:2: warning: Your compiler does not have EABI support.
arch/arm/kernel/unwind.c:31:2: warning: ARM unwind is known to compile only with EABI compilers.
arch/arm/kernel/unwind.c:32:2: warning: Change compiler or disable ARM_UNWIND option.
arch/arm/kernel/unwind.c:51:6: warning: symbol '__aeabi_unwind_cpp_pr0' was not declared. Should it be static?
arch/arm/kernel/unwind.c:56:6: warning: symbol '__aeabi_unwind_cpp_pr1' was not declared. Should it be static?
arch/arm/kernel/unwind.c:61:6: warning: symbol '__aeabi_unwind_cpp_pr2' was not declared. Should it be static?
...

Regards,
Hartley
