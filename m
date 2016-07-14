From: dennis.chen@arm.com (Dennis Chen)
Date: Thu, 14 Jul 2016 13:43:54 +0800
Subject: [PATCH v6 0/2] Fix acpi alignment fault with 'mem='
Message-ID: <1468475036-5852-1-git-send-email-dennis.chen@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

An ACPI alignment access fault has been observed on ARM platforms if one 
boots an ACPI enabled kernel with 'mem=' specificed. This was due to
memblock_enforce_memory_limit(.) throwing away NOMAP regions thus causing
acpi_os_ioremap(.) to map them as device memory (rather than normal memory).

This patch series fixes this issue by: 
 1) Introducing memblock_mem_limit_remove_map(.), which retains the NOMAP
    regions.
 2) Calling this function in arm64.

ChangeLog:
v5->v6: 
	- Truncate the reserved regions above the limit as suggested by
	  Steve Capper.
        - Drop the memblock debug fs related patch from this series since
	  it's independent logically. 
	- CC more relevant persons.
v4->v5:
        Fix a build warning.
v3->v4:
        Address some review comments from Mark Rutland.
v2->v3:
        Only keep the NOMAP regions above the limit while removing all other
        memblocks as suggested by Ard Biesheuvel.
v1->v2:
        Flag all regions above the limit as NOMAP as suggested by Mark Rutland.

Dennis Chen (2):
  mm:memblock Add new infrastructure to address the mem limit issue
  arm64:acpi Fix the acpi alignment exeception when 'mem=' specified

 arch/arm64/mm/init.c     |  2 +-
 include/linux/memblock.h |  1 +
 mm/memblock.c            | 57 +++++++++++++++++++++++++++++++++++++++++++-----
 3 files changed, 54 insertions(+), 6 deletions(-)

-- 
2.7.4
