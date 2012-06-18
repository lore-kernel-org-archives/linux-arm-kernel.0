From: monstr@monstr.eu (Michal Simek)
Date: Mon, 18 Jun 2012 20:15:43 +0200
Subject: [RFC PATCH 7/8] ARM: vmlinux.lds: Setup physical load address not
 virtual
In-Reply-To: <alpine.LFD.2.02.1206181000540.23555@xanadu.home>
References: <1340019011-18642-1-git-send-email-monstr@monstr.eu>
 <1340019011-18642-8-git-send-email-monstr@monstr.eu>
 <alpine.LFD.2.02.1206181000540.23555@xanadu.home>
Message-ID: <CAHTX3dJS9zNejv-oLGpbZdXdkJndwR1pcBd9yn3OAobGy3ZLjA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2012/6/18 Nicolas Pitre <nicolas.pitre@linaro.org>

> On Mon, 18 Jun 2012, Michal Simek wrote:
>
> > Setup correct virtual and physical address in ELF LOAD section.
>
> We are moving to a single kernel binary for multiple targets, including
> targets with different physical load addresses.  The kernel code figures
> out at run time what the actual physical address is when
> CONFIG_ARM_PATCH_PHYS_VIRT is set which is the default these days.  In
> other words, we don't know the physical offset at build time in that
> case and CONFIG_PHYS_OFFSET is simply not defined.
>

ok. good to know and nice features. In that case I expect that you are
using any binary format
and you copy it to memory and run it. Code find out where it runs and based
on that setup things.
(BTW: This is very interesting for me to implement it on Microblaze. Can
you point me to that kernel code part? or any doc?)

But can you do it with elf? From my experience elf loaders are reading
physical address from program headers
and load all load sections. At the end they read entry point address and
setup PC on it and run it
(readelf -l -h). If these values are setup incorrectly to virtual addresses
elf loader just load them to virtual memory address
or just failed.


Why do you need this change?  Your patch comments are lacking
> justification for them.
>
> The main reason is to elf loaders.
Please correct me if I am wrong IRC ARM Qemu uses zImage but it is no
problem to use elf file. For this case
Qemu elf loader also uses physical addresses from ELF and also entry point.

There is one more thing in connection with this patch which is that exactly
the same description is done
in asm-generic/vmlinux.lds.h macros which arm lds.S includes. For example
INIT_TEXT_SECTION.

If you look at vmlinux before and after my changes you will see some
differences which shouldn't affect your binary format
at all. Look below to readelf outputs.

I haven't played with CONFIG_ARM_PATCH_PHYS_VIRT option but what is elf
entry point for this case?

Thanks,
Michal



Before:

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
  Entry point address:               0x80008000
  Start of program headers:          52 (bytes into file)
  Start of section headers:          84873104 (bytes into file)
  Flags:                             0x5000002, has entry point, Version5
EABI
  Size of this header:               52 (bytes)
  Size of program headers:           32 (bytes)
  Number of program headers:         3
  Size of section headers:           40 (bytes)
  Number of section headers:         37
  Section header string table index: 34

Program Headers:
  Type           Offset   VirtAddr   PhysAddr   FileSiz MemSiz  Flg Align
  LOAD           0x008000 0x80008000 0x80008000 0x254a204 0x255e814 RWE
0x8000
  NOTE           0x25521e0 0x825521e0 0x825521e0 0x00024 0x00024 R E 0x4
  GNU_STACK      0x000000 0x00000000 0x00000000 0x00000 0x00000 RWE 0x4


After:

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
  Entry point address:               0x10008000
  Start of program headers:          52 (bytes into file)
  Start of section headers:          84873088 (bytes into file)
  Flags:                             0x5000002, has entry point, Version5
EABI
  Size of this header:               52 (bytes)
  Size of program headers:           32 (bytes)
  Number of program headers:         3
  Size of section headers:           40 (bytes)
  Number of section headers:         37
  Section header string table index: 34

Program Headers:
  Type           Offset   VirtAddr   PhysAddr   FileSiz MemSiz  Flg Align
  LOAD           0x008000 0x80008000 0x10008000 0x254a204 0x255e814 RWE
0x8000
  NOTE           0x25521e0 0x825521e0 0x125521e0 0x00024 0x00024 R E 0x4
  GNU_STACK      0x000000 0x00000000 0x00000000 0x00000 0x00000 RWE 0x4
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120618/f66f580d/attachment-0001.html>
