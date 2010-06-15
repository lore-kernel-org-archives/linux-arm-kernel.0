From: ext-phil.2.carmody@nokia.com (Phil Carmody)
Date: Tue, 15 Jun 2010 15:46:38 +0300
Subject: [PATCH 1/1] ARM: unwind - optimise linked-list searches for modules
Message-ID: <1276605998-19275-1-git-send-email-ext-phil.2.carmody@nokia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

With several sections per module, and dozens of modules, the
searches down the linked list would dominate the lookup time,
dwarfing any savings from the binary search within the section.

A simple move-to-front optimisation exploits the commonality
of the code paths taken, and in simple real-world tests reduces
the number of steps in the search to barely more than 1.

Signed-off-by: Phil Carmody <ext-phil.2.carmody@nokia.com>
---
 arch/arm/kernel/unwind.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/arm/kernel/unwind.c b/arch/arm/kernel/unwind.c
index dd81a91..2e88abf 100644
--- a/arch/arm/kernel/unwind.c
+++ b/arch/arm/kernel/unwind.c
@@ -146,6 +146,8 @@ static struct unwind_idx *unwind_find_idx(unsigned long addr)
 			    addr < table->end_addr) {
 				idx = search_index(addr, table->start,
 						   table->stop - 1);
+				/* MTF with 50 modules: 80 steps becomes ~1 */
+				list_move(&table->list, &unwind_tables);
 				break;
 			}
 		}
-- 
1.6.0.4
