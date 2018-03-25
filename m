From: sebastian_ml@gmx.net (Sebastian Kemper)
Date: Sun, 25 Mar 2018 09:32:57 +0200
Subject: Fix compile failures due to arm64 includes in stable kernels
Message-ID: <20180325073255.GA2923@hotdamn.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello all,

Some older stable kernels provide some arm64 headers like opcodes.h,
that include their non-64bit equivalents. For example:

arch/arm64/include/asm/opcodes.h

tries to include

<../../arm/include/asm/opcodes.h>

It's obvious that there is one hierarchy level missing. This causes
build failures:

    CC [M]  /build/lede-snapshots/aarch64_cortex-a53/build/sdk/build_dir/target-aarch64_cortex-a53_musl/linux-brcm2708_bcm2710/dahdi-linux-2.11.1-20180111/drivers/dahdi/dahdi-base.o
  In file included from ./arch/arm64/include/asm/sysreg.h:25:0,
                   from ./arch/arm64/include/asm/cputype.h:94,
                   from ./arch/arm64/include/asm/cachetype.h:19,
                   from ./arch/arm64/include/asm/cache.h:19,
                   from ./include/linux/cache.h:5,
                   from ./include/linux/printk.h:8,
                   from ./include/linux/kernel.h:13,
                   from /build/lede-snapshots/aarch64_cortex-a53/build/sdk/build_dir/target-aarch64_cortex-a53_musl/linux-brcm2708_bcm2710/dahdi-linux-2.11.1-20180111/drivers/dahdi/dahdi-base.c:38:
  ./arch/arm64/include/asm/opcodes.h:5:10: fatal error: ../../arm/include/asm/opcodes.h: No such file or directory
   #include <../../arm/include/asm/opcodes.h>
            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  compilation terminated.

Some example packages that fail to build are dahdi-linux and
cryptodev-linux.

linux-3.16.56:
  - does not have opcodes.h, but the xen headers

      hypercall.h
      interface.h
      hypervisor.h
      page.h
      
    have the wrong include lines.
    
linux-4.1.50:
  - affected (needs a small change in the patch for opcodes.h due to slightly different layout)
  
linux-4.4.123:
  - affected
  
linux-4.9.89:
  - affected

The attached patch fixes the includes.

I understand that to get a patch accepted into the stable series one
needs to provide a commit to master. But in this case that doesn't seem
possible as these headers do not exist anymore in newer kernels.

What do you think? Does the above make sense to you to backport to the
stable kernels?

Thanks!
Sebastian
-------------- next part --------------
A non-text attachment was scrubbed...
Name: 930-fix-arm64-asm-headers.patch
Type: text/x-diff
Size: 1288 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180325/a28efa21/attachment-0001.bin>
