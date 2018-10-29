From: f.fainelli@gmail.com (Florian Fainelli)
Date: Mon, 29 Oct 2018 12:00:12 -0700
Subject: [PATCH 0/2 v5] arm64: Get rid of __early_init_dt_declare_initrd()
Message-ID: <20181029190014.6455-1-f.fainelli@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

I numbered this v5 because this is still revolving around the same
initial desire to cut the build time of an ARM64 kernel when toggling
CONFIG_BLK_DEV_INITRD. This 4th version is basically the 3rd possible
way to just get rid of __early_init_dt_declare_initrd() for ARM64.

I previously mentioned that I was working on making
phys_initrd_start/phys_initrd_size generic across architectures that
make use of it, which would cover ARM (32-bit), unicore32 and possibly
arm64, but upon second glance, this does not necessarily help, or rather
this patch series actually helps make a smoother conversion in the
future.

Previous discussions/submissions list here:

v3:
https://www.spinics.net/lists/arm-kernel/msg683566.html
v2:
https://lkml.org/lkml/2018/10/25/4

Changes in v5:

- incorporate Mike's version which properly takes care of command-line
  specified and FDT specified initrd location

Changes in v4:

- perform the physical to virtual initrd conversion straight within
  arm64_memblock_init() to get the correct memblock reservation to occur

Changes in v3:
- attempt to change drivers/of/fdt.c to absorb ARM64's specific behavior

Changes in v2:

- put an /* empty */ comment in the asm-generic/initrd.h file
- trim down the CC list to maximize the chances of people receiving this

Florian Fainelli (2):
  arm64: Get rid of __early_init_dt_declare_initrd()
  of/fdt: Remove definition check for __early_init_dt_declare_initrd()

 arch/arm64/include/asm/memory.h |  8 -------
 arch/arm64/mm/init.c            | 42 +++++++++++++++++++++------------
 drivers/of/fdt.c                |  2 --
 3 files changed, 27 insertions(+), 25 deletions(-)

-- 
2.17.1
