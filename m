From: mark.rutland@arm.com (Mark Rutland)
Date: Mon,  5 Nov 2018 13:06:39 +0000
Subject: [PATCH 00/10] arm64: assembly export cleanup
Message-ID: <20181105130649.29429-1-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When exporting a C function, we place the EXPORT_SYMBOL() immediately after the
function definition. Historically we couldn't do this with assembly functions,
and hence we collected all of these exports in arm64ksyms.c. Over time, this
has retained redundant includes and exports for items defined in C code.

For a while now it has been possible to export functions directly from assembly
files, which is beneficial for ongoing maintenance.

These patches move the exports from arm64ksyms.c into their relevant assembly
files, and remove the newly redundant arm64ksyms.c. I've pushed the series to
my arm64/export-cleanup branch [1] on kernel.org.

Thanks,
Mark.

[1] git://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git arm64/export-cleanup

Mark Rutland (10):
  arm64: remove bitop exports
  arm64: move memstart_addr export inline
  arm64: add <asm/export.h>
  arm64: tishift: use asm EXPORT_SYMBOL()
  arm64: smccc: use asm EXPORT_SYMBOL()
  arm64: page: use asm EXPORT_SYMBOL()
  arm64: uaccess: use asm EXPORT_SYMBOL()
  arm64: string: use asm EXPORT_SYMBOL()
  arm64: frace: use asm EXPORT_SYMBOL()
  arm64: remove arm64ksyms.c

 arch/arm64/include/asm/export.h  | 13 ++++++
 arch/arm64/kernel/Makefile       |  2 +-
 arch/arm64/kernel/arm64ksyms.c   | 88 ----------------------------------------
 arch/arm64/kernel/entry-ftrace.S |  6 +++
 arch/arm64/kernel/smccc-call.S   |  4 ++
 arch/arm64/lib/clear_page.S      |  5 ++-
 arch/arm64/lib/clear_user.S      |  2 +
 arch/arm64/lib/copy_from_user.S  |  4 +-
 arch/arm64/lib/copy_in_user.S    |  4 +-
 arch/arm64/lib/copy_page.S       |  9 ++--
 arch/arm64/lib/copy_to_user.S    |  4 +-
 arch/arm64/lib/memchr.S          |  3 ++
 arch/arm64/lib/memcmp.S          |  3 ++
 arch/arm64/lib/memcpy.S          |  4 ++
 arch/arm64/lib/memmove.S         |  4 ++
 arch/arm64/lib/memset.S          |  4 ++
 arch/arm64/lib/strchr.S          |  3 ++
 arch/arm64/lib/strcmp.S          |  3 ++
 arch/arm64/lib/strlen.S          |  3 ++
 arch/arm64/lib/strncmp.S         |  3 ++
 arch/arm64/lib/strnlen.S         |  3 ++
 arch/arm64/lib/strrchr.S         |  3 ++
 arch/arm64/lib/tishift.S         |  5 +++
 arch/arm64/mm/init.c             |  2 +
 24 files changed, 88 insertions(+), 96 deletions(-)
 create mode 100644 arch/arm64/include/asm/export.h
 delete mode 100644 arch/arm64/kernel/arm64ksyms.c

-- 
2.11.0
