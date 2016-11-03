From: shijie.huang@arm.com (Huang Shijie)
Date: Thu, 3 Nov 2016 10:51:36 +0800
Subject: [PATCH 0/2] mm: fix the "counter.sh" failure for libhugetlbfs 
Message-ID: <1478141499-13825-1-git-send-email-shijie.huang@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

(1) Background
   For the arm64, the hugetlb page size can be 32M (PMD + Contiguous bit).
   In the 4K page environment, the max page order is 10 (max_order - 1),
   so 32M page is the gigantic page.    

   The arm64 MMU supports a Contiguous bit which is a hint that the TTE
   is one of a set of contiguous entries which can be cached in a single
   TLB entry.  Please refer to the arm64v8 mannul :
       DDI0487A_f_armv8_arm.pdf (in page D4-1811)

(2) The bug   
   After I tested the libhugetlbfs, I found the test case "counter.sh"
   will fail with the gigantic page (32M page in arm64 board).

   This patch set adds support for gigantic surplus hugetlb pages,
   allowing the counter.sh unit test to pass.   


Huang Shijie (2):
  mm: hugetlb: rename some allocation functions
  mm: hugetlb: support gigantic surplus pages

 mm/hugetlb.c | 35 ++++++++++++++++++++---------------
 1 file changed, 20 insertions(+), 15 deletions(-)

-- 
2.1.4
