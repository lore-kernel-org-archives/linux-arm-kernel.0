From: james.morse@arm.com (James Morse)
Date: Fri,  2 Dec 2016 14:49:07 +0000
Subject: [PATCH 0/2] Hibernate fixes for 'Fix memmap to be initialized for the
 entire section'
In-Reply-To: <1480530091-1092-1-git-send-email-rrichter@cavium.com>
Message-ID: <20161202144909.18405-1-james.morse@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Patch "arm64: mm: Fix memmap to be initialized for the entire section"
changes pfn_valid() in a way that breaks hibernate. These patches fix
hibernate, and provided struct page's are allocated for nomap pages,
can be applied before [0].

Hibernate core code belives 'valid' to mean "I can access this". It
uses pfn_valid() to test the page if the page is 'valid'.

pfn_valid() needs to be changed so that all struct pages in a numa
node have the same node-id. Currently 'nomap' pages are skipped, and
retain their pre-numa node-ids, which leads to a later BUG_ON().

These patches make hibernate's savable_page() take its escape route
via 'if (PageReserved(page) && pfn_is_nosave(pfn))'.


[0] https://lkml.org/lkml/2016/11/30/566

James Morse (2):
  arm64: mm: Mark nomap regions with the PG_reserved flag
  arm64: hibernate: report nomap regions as being pfn_nosave

 arch/arm64/kernel/hibernate.c |  6 +++++-
 arch/arm64/mm/init.c          | 14 ++++++++++++++
 2 files changed, 19 insertions(+), 1 deletion(-)

-- 
2.10.1
