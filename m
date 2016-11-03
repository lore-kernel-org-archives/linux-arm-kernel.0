From: shijie.huang@arm.com (Huang Shijie)
Date: Thu, 3 Nov 2016 10:27:37 +0800
Subject: [PATCH 0/2] arm64: fix the bugs found in the hugetlb test
Message-ID: <1478140059-13829-1-git-send-email-shijie.huang@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

(1) Backgroud
   For the arm64, the hugetlb page size can be 32M (PMD + Contiguous bit).
   In the 4K page environment, the max page order is 10 (max_order - 1),
   so 32M page is the gigantic page.    

   The arm64 MMU supports a Contiguous bit which is a hint that the PTE
   is one of a set of contiguous entries which can be cached in a single
   TLB entry.  Please refer to the arm64v8 mannul :
       DDI0487A_f_armv8_arm.pdf (in page D4-1811)

(2) The bugs   
   After I tested the libhugetlbfs, I found several bugs in arm64 code.
   This patch set has all the bug fixes for the arm64.
   
(3) The test result in the Softiron and Juno-r1 boards:

   This detail test result shows below (both the "make func" & "make stress"):

    4KB granule:

        1.1) PTE + Contiguous bit : 4K x 16 = 64K (per huge page size)
             Test result          : PASS

        1.2) PMD                  : 2M x  1 = 2M  (per huge page size)
             Test result          : PASS

        1.3) PMD + Contiguous bit : 2M x 16 = 32M (per huge page size)
             Test result          : PASS

    64KB granule:

        3.1) PTE + Contiguous bit : 64K x 32 = 2M (per huge page size)
             Test result          : PASS

        3.2) PMD + Contiguous bit : 512M x 32 = 16G (per huge page size)
             Test result          : no hardware to support this test


Huang Shijie (2):
  arm64: hugetlb: remove the wrong pmd check in find_num_contig()
  arm64: hugetlb: fix the wrong address for several functions

 arch/arm64/mm/hugetlbpage.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

-- 
2.5.5
