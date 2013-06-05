From: magnus.damm@gmail.com (Magnus Damm)
Date: Wed, 05 Jun 2013 19:44:27 +0900
Subject: [PATCH 00/03] ARM: 64-bit memory fixes, APE6EVM second memory bank
Message-ID: <20130605104427.1720.68752.sendpatchset@w520>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ARM: 64-bit memory fixes, APE6EVM second memory bank

[PATCH 01/03] ARM: Let arm_add_memory() always use 64-bit arguments
[PATCH 02/03] ARM: Handle 64-bit memory in case of 32-bit phys_addr_t
[PATCH 03/03] ARM: shmobile: Add second memory bank to DTS for APE6EVM

This patch set contains two fixes and one mach-shmobile specific patch
to add a second memory bank. The fixes attempt to improve the memory bank
handling in the ARM kernel in case of 64-bit addresses.

Without patch 1/3 and 2/3 but with patch 3/3 by itself:

HIGHMEM=n, LPAE=n - OK (busted, second bank ignored with message [1])
HIGHMEM=y, LPAE=n - NG (busted, board hangs on boot)
HIGHMEM=n, LPAE=y - OK
HIGHMEM=y, LPAE=y - OK

[1] Ignoring RAM at 00000000-3fffffff (vmalloc region overlap).

With all patches applied:

HIGHMEM=n, LPAE=n - OK
HIGHMEM=y, LPAE=n - OK
HIGHMEM=n, LPAE=y - OK
HIGHMEM=y, LPAE=y - OK

My opinion is that LPAE should be handled in a similar way to x86 PAE.
This means the kernel should boot regardless of kernel config but 64-bit
memory banks may be truncated if needed like when LPAE=n or HIGHMEN=n.

Comments on how to implement this in a nicer way are very welcome!

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 Written against renesas.git renesas-next-20130604v2

 arch/arm/boot/dts/r8a73a4-ape6evm.dts |    5 +++++
 arch/arm/include/asm/setup.h          |    2 +-
 arch/arm/kernel/setup.c               |   22 +++++++++++++++-------
 3 files changed, 21 insertions(+), 8 deletions(-)
