From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Thu, 3 Dec 2009 08:57:33 -0500
Subject: issue: failed to lauch /init in rootfs
Message-ID: <771cded00912030557s13e52f6k1205e667549e6132@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

I met an issue on launching /init in rootfs. The crash log is in below.

[    0.870233] VFP support v0.3: implementor 56 architecture 2 part 20 variant 5
[    0.881766] drivers/rtc/hctosys.c: unable to open rtc device (rtc0)
[    1.460338] eth0: link down
[    2.467895] IP-Config: Complete:
[    2.470991]      device=eth0, addr=192.168.1.101, mask=255.255.255.0, gw=255,
[    2.479290]      host=192.168.1.101, domain=, nis-domain=(none),
[    2.485294]      bootserver=192.168.1.100, rootserver=192.168.1.100, rootpat=
[    2.496410] Freeing init memory: 5184K
[    2.504035] init (1): undefined instruction: pc=000be29c
[    2.509566] Code: 0040000c 0a00002b e3100007 1afffff9 (ee399009)
[    2.516562] Kernel panic - not syncing: Attempted to kill init!
[    2.522697] [<c051ea80>] (unwind_backtrace+0x0/0xdc) from [<c0715e24>] (pani)
[    2.531161] [<c0715e24>] (panic+0x58/0x128) from [<c05335f8>] (do_exit+0x68/)
[    2.538908] [<c05335f8>] (do_exit+0x68/0x668) from [<c0533ca8>] (do_group_ex)
[    2.547212] [<c0533ca8>] (do_group_exit+0xb0/0xe4) from [<c053e8f0>] (get_si)
[    2.556792] [<c053e8f0>] (get_signal_to_deliver+0x39c/0x3f4) from [<c051b688)
[    2.566761] [<c051b688>] (do_notify_resume+0x5c/0x5f4) from [<c0518f8c>] (wo)

My machine is armv6. The kernel is 2.6.32-rc4. The toolchain is
codesourcey 2009-q1.
It always crash whatever kernel is built with EABI or without EABI. It
always crash whatever kernel is built with CONFIG_FPE_NWFPE or
CONFIG_VFP.

At last, I tried to build a new busybox with the same toolchain. Now
/init can be executed without error.

I compared elf head of these two busybox. The origin one is in below.
ELF Header:
  Magic:   7f 45 4c 46 01 01 01 00 00 00 00 00 00 00 00 00
  Class:                             ELF32
  Data:                              2's complement, little endian
  Version:                           1 (current)
  OS/ABI:                            UNIX - System V
  ABI Version:                       0
  Type:                              EXEC (Executable file)
  Machine:                           ARM
  Version:                           0x1
  Entry point address:               0x8100
  Start of program headers:          52 (bytes into file)
  Start of section headers:          1529568 (bytes into file)
  Flags:                             0x4000002, has entry point, Version4 EABI
  Size of this header:               52 (bytes)
  Size of program headers:           32 (bytes)
  Number of program headers:         5
  Size of section headers:           40 (bytes)
  Number of section headers:         26
  Section header string table index: 25

The new one is in below.
ELF Header:
  Magic:   7f 45 4c 46 01 01 01 00 00 00 00 00 00 00 00 00
  Class:                             ELF32
  Data:                              2's complement, little endian
  Version:                           1 (current)
  OS/ABI:                            UNIX - System V
  ABI Version:                       0
  Type:                              EXEC (Executable file)
  Machine:                           ARM
  Version:                           0x1
  Entry point address:               0xd5bc
  Start of program headers:          52 (bytes into file)
  Start of section headers:          752820 (bytes into file)
  Flags:                             0x5000002, has entry point, Version5 EABI
  Size of this header:               52 (bytes)
  Size of program headers:           32 (bytes)
  Number of program headers:         7
  Size of section headers:           40 (bytes)
  Number of section headers:         26
  Section header string table index: 25

It seems that v4 EABI failed on armv6. It's so strange. Do anybody
meet same issue like me? Does it mean that it's the compatible issue
of codesourcery toolchain?

Thanks
Haojian
