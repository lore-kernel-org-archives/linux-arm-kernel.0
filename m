From: keescook@chromium.org (Kees Cook)
Date: Thu, 13 Feb 2014 17:04:08 -0800
Subject: [PATCH 0/2] ARM: mm: allow for stricter kernel memory perms
Message-ID: <1392339850-18686-1-git-send-email-keescook@chromium.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series of patches allows the ARM kernel page tables to gain better
permission separation. With a fixed[1] CONFIG_ARM_PTDUMP enabled, you
can see the before and after in /sys/kernel/debug/kernel_page_tables.

Before:
---[ Kernel Mapping ]---
0xc0000000-0xc0800000           8M     RW x  SHD
0xc0800000-0xc1e00000          22M     RW NX SHD
0xc2000000-0xc3000000          16M     RW x  SHD
0xc3800000-0xd1000000         216M     RW x  SHD
0xd1800000-0xef800000         480M     RW x  SHD

After:
---[ Kernel Mapping ]---
0xc0000000-0xc0100000           1M     RW NX SHD
0xc0100000-0xc0700000           6M     ro x  SHD
0xc0700000-0xc0a00000           3M     ro NX SHD
0xc0a00000-0xc1e00000          20M     RW NX SHD
0xc2000000-0xc3000000          16M     RW NX SHD
0xc3800000-0xd1000000         216M     RW NX SHD
0xd1800000-0xef800000         480M     RW NX SHD

This is available via CONFIG_ARM_KERNMEM_PERMS and CONFIG_DEBUG_RODATA.
The latter exists to match the x86 option of the same name, and is
left as a configurable since each additional region adds more potential
memory padding.

The series is based on earlier work from Brad Spengler, Larry Bassel,
and Laura Abbott.

Thanks,

-Kees

[1] these patches are needed to get the correct output:
    https://lkml.org/lkml/2014/2/12/662
    https://lkml.org/lkml/2014/2/12/663
