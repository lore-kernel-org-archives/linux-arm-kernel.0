From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 31 Jul 2014 16:41:02 +0200
Subject: [PATCH v15 08/12] ARM: config: append lpae configuration
In-Reply-To: <CAD6h2NT5BP4Rmz+vfTLSsw19xCNSfXE6wwAhr1Fcrd9VuyXOeg@mail.gmail.com>
References: <1406555876-11989-1-git-send-email-haojian.zhuang@linaro.org>
 <CAOesGMhgWncQ9wafjjDiaZkT1ge-YPe5bjFs9Ebyj7Fg=3YhHQ@mail.gmail.com>
 <CAD6h2NT5BP4Rmz+vfTLSsw19xCNSfXE6wwAhr1Fcrd9VuyXOeg@mail.gmail.com>
Message-ID: <201407311641.02462.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 31 July 2014, Haojian Zhuang wrote:
> Maybe I didn't express this well. Let's check the memory layout in hip04.
> 
> <0x00000000-10000000, 0x00000000-c0000000> & <0x00000004-0xc0000000,
> 0x00000003-40000000> are two memory regions.
> 
> These memory address is 64-bit. When ARM_LPAE is disabled,
> memblock_add() parses memory base address & size with 32-bit. Since
> ARCH_PHYS_ADDR_T_64BIT is highly depend on ARM_LPAE.
> 
> Then these two memory regions become <0x10000000, 0xc0000000> &
> <0xc0000000, 0xffffffff>. Lots of IO space are in <0xe0000000,
> 0xefffffff>. So memory space conflicts when ARM_LPAE is disabled.
> Kernel panic will come since it believes IO space is memory.
> 
> Only two solutions are available in below.
> 1. Use hip04_defconfig to declare ARM_LPAE.
> 2. Use hi3xxx_defconfig, and only declare 2.9GB memory in DTS file
> without ARM_LPAE.
> 
> I think solution #1 is better. What's your opinion?
> 

I think it's a bug in the DT parsing code if incorrect memory
regions get added. It's supposed to parse the memory nodes using
"long enough" (u64 or arbitrary-length) data types and then
skip every range that doesn't fit into phys_addr_t.

	Arnd
