From: holler@ahsoftware.de (Alexander Holler)
Date: Thu, 24 Sep 2015 11:06:38 +0200
Subject: depmod (kmod 21 and older) fails for allmodconfig on ARM
In-Reply-To: <CAKi4VAJAmCP7jEoVYzjm4yQLsEZPC6+GGLDtm7pM-2i=-CnXPQ@mail.gmail.com>
References: <560282C6.6050702@ahsoftware.de>
 <CAKi4VAJAmCP7jEoVYzjm4yQLsEZPC6+GGLDtm7pM-2i=-CnXPQ@mail.gmail.com>
Message-ID: <5603BD1E.5030003@ahsoftware.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am 24.09.2015 um 03:24 schrieb Lucas De Marchi:
> On Wed, Sep 23, 2015 at 7:45 AM, Alexander Holler <holler@ahsoftware.de> wrote:
>> Hello,
>>
>> make allmodconfig
>> make -j4 zImage modules && make modules_install
>>
>> fails here on an ARM system with a malloc bug in depmod (after finding some
>> circles).
>
> The bug in kmod should be fixed indeed, but if you have dep cycles you
> have other things to fix too.  What tree are you building? Do you have

Currently I don't intend to fix these cycles. Sorry, but I'm unable to 
fix the world and instead I try to fix stuff (including writing bug 
reports) according to my very limited resources. Maybe I will try to 
debug kmod/depmod with some memory checkers, but I thought it makes 
sense to ask people with more knowledge about depmod before wasting time.

> any changes on top? malloc bug... looks like corrupted memory, but
> very difficult to debug any further without more info.

I've used it on 4.2.1. It fails on an ARM box as well as on a x86_64 
Fedora 21 system using a cross-compiler.

Here are the steps to reproduce on a x86 system:

cp -ar linux.git /tmp
cd /tmp/linux.git
make clean
git checkout -b depmod_bug v4.2.1
ARCH=arm CROSS_COMPILE=arm-linux-gnu- make multi_v7_defconfig
ARCH=arm CROSS_COMPILE=arm-linux-gnu- make allmodconfig
# the following two steps will need quiet some time
ARCH=arm CROSS_COMPILE=arm-linux-gnu- make -j4 zImage modules
ARCH=arm INSTALL_MOD_PATH=/tmp CROSS_COMPILE=arm-linux-gnu- make -j4 
modules_install
(...)
   DEPMOD  4.2.1
depmod: ERROR: Found 10 modules in dependency cycles!
depmod: ERROR: Cycle detected: drm_kms_helper -> syscopyarea
*** Error in `/sbin/depmod': free(): invalid next size (fast): 
0x0000000003e0c370 ***
======= Backtrace: =========
/lib64/libc.so.6(+0x77d9e)[0x7f3ec21c1d9e]
/lib64/libc.so.6(cfree+0x5b5)[0x7f3ec21cd9f5]
/sbin/depmod[0x409805]
/lib64/libc.so.6(__libc_start_main+0xf0)[0x7f3ec2169fe0]
/sbin/depmod[0x40262c]
======= Memory map: ========
00400000-00423000 r-xp 00000000 00:0f 1633727 
  /usr/bin/kmod
00622000-00623000 r--p 00022000 00:0f 1633727 
  /usr/bin/kmod
00623000-00624000 rw-p 00023000 00:0f 1633727 
  /usr/bin/kmod
01c9e000-03e21000 rw-p 00000000 00:00 0 
  [heap]
7f3ec1f2a000-7f3ec1f41000 r-xp 00000000 00:0f 2706024 
  /usr/lib64/libpthread-2.20.so
7f3ec1f41000-7f3ec2140000 ---p 00017000 00:0f 2706024 
  /usr/lib64/libpthread-2.20.so
7f3ec2140000-7f3ec2141000 r--p 00016000 00:0f 2706024 
  /usr/lib64/libpthread-2.20.so
7f3ec2141000-7f3ec2142000 rw-p 00017000 00:0f 2706024 
  /usr/lib64/libpthread-2.20.so
7f3ec2142000-7f3ec2146000 rw-p 00000000 00:00 0
7f3ec214a000-7f3ec22fd000 r-xp 00000000 00:0f 2705998 
  /usr/lib64/libc-2.20.so
7f3ec22fd000-7f3ec24fd000 ---p 001b3000 00:0f 2705998 
  /usr/lib64/libc-2.20.so
7f3ec24fd000-7f3ec2501000 r--p 001b3000 00:0f 2705998 
  /usr/lib64/libc-2.20.so
7f3ec2501000-7f3ec2503000 rw-p 001b7000 00:0f 2705998 
  /usr/lib64/libc-2.20.so
7f3ec2503000-7f3ec2507000 rw-p 00000000 00:00 0
7f3ec250a000-7f3ec2520000 r-xp 00000000 00:0f 2570841 
  /usr/lib64/libgcc_s-4.9.2-20150212.so.1
7f3ec2520000-7f3ec271f000 ---p 00016000 00:0f 2570841 
  /usr/lib64/libgcc_s-4.9.2-20150212.so.1
7f3ec271f000-7f3ec2720000 r--p 00015000 00:0f 2570841 
  /usr/lib64/libgcc_s-4.9.2-20150212.so.1
7f3ec2720000-7f3ec2721000 rw-p 00016000 00:0f 2570841 
  /usr/lib64/libgcc_s-4.9.2-20150212.so.1
7f3ec2722000-7f3ec2737000 r-xp 00000000 00:0f 1510512 
  /usr/lib64/libz.so.1.2.8
7f3ec2737000-7f3ec2936000 ---p 00015000 00:0f 1510512 
  /usr/lib64/libz.so.1.2.8
7f3ec2936000-7f3ec2937000 r--p 00014000 00:0f 1510512 
  /usr/lib64/libz.so.1.2.8
7f3ec2937000-7f3ec2938000 rw-p 00015000 00:0f 1510512 
  /usr/lib64/libz.so.1.2.8
7f3ec293a000-7f3ec295e000 r-xp 00000000 00:0f 1510471 
  /usr/lib64/liblzma.so.5.0.99
7f3ec295e000-7f3ec2b5d000 ---p 00024000 00:0f 1510471 
  /usr/lib64/liblzma.so.5.0.99
7f3ec2b5d000-7f3ec2b5e000 r--p 00023000 00:0f 1510471 
  /usr/lib64/liblzma.so.5.0.99
7f3ec2b5e000-7f3ec2b5f000 rw-p 00024000 00:0f 1510471 
  /usr/lib64/liblzma.so.5.0.99
7f3ec2b62000-7f3ec2b83000 r-xp 00000000 00:0f 2705991 
  /usr/lib64/ld-2.20.so
7f3ec2d83000-7f3ec2d84000 r--p 00021000 00:0f 2705991 
  /usr/lib64/ld-2.20.so
7f3ec2d84000-7f3ec2d85000 rw-p 00022000 00:0f 2705991 
  /usr/lib64/ld-2.20.so
7f3ec2d85000-7f3ec2d86000 rw-p 00000000 00:00 0
7f3ec2d87000-7f3ec2d8d000 rw-p 00000000 00:00 0
7fffa72ea000-7fffa730d000 rw-p 00000000 00:00 0 
  [stack]
7fffa7342000-7fffa7344000 r--p 00000000 00:00 0 
  [vvar]
7fffa7344000-7fffa7346000 r-xp 00000000 00:00 0 
  [vdso]
ffffffffff600000-ffffffffff601000 r-xp 00000000 00:00 0 
  [vsyscall]
./scripts/depmod.sh: Zeile 57: 30419 Abgebrochen 
(Speicherabzug geschrieben) "$DEPMOD" "$@" "$KERNELRELEASE" $SYMBOL_PREFIX
Makefile:1142: recipe for target '_modinst_post' failed
make: *** [_modinst_post] Error 134

Regards,

Alexander Holler
