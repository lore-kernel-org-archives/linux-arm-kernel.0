From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Thu, 11 Feb 2016 17:47:59 +0100
Subject: [PATCH v2 0/3] arm64: avoid early __va translations
Message-ID: <1455209282-9596-1-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is a somewhat cleaner approach for dealing with the issue that the
early FDT performs __va() translations before the linear mapping has been
set up. Being able to defer the assignment of memstart_addr until after we
have discovered all of memory is an important piece of functionality, not
only for KASLR but also for mapping the linear region as efficiently as
possible.

Patch #1 refactors the early FDT code so that the actual assignment of
initrd_start and initrd_end (which is where the __va() translations are
performed) is moved into a __weak function which can be overridden.

Patch #2 overrides the __weak function to only record the physical addresses
as they are found in the /chosen node, or on the command line, and defers
the __va() translation until after memstart_addr has been assigned.

Patch #3 is some test code I used to verify that all __va() translations
are gone. Note that the open coded BUG_ON() implementation is required to
avoid .h dependency hell.

Ard Biesheuvel (3):
  of/fdt: factor out assignment of initrd_start/initrd_end
  arm64: defer __va translation of initrd_start and initrd_end
  arm64: prevent __va() translations before memstart_addr is assigned

 arch/arm64/include/asm/memory.h | 10 +++++++++-
 arch/arm64/mm/init.c            | 21 +++++++++++++++-----
 drivers/of/fdt.c                | 12 ++++++++---
 3 files changed, 34 insertions(+), 9 deletions(-)

-- 
2.5.0
