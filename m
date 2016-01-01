From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 01 Jan 2016 13:47:41 +0100
Subject: [PATCH] udf: avoid uninitialized variable use
Message-ID: <9221187.T0u8gszVyj@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

A new warning about a real bug has come up from a recent cleanup:

fs/udf/inode.c: In function 'udf_setup_indirect_aext':
fs/udf/inode.c:1927:28: warning: 'adsize' may be used uninitialized in this function [-Wmaybe-uninitialized]

If the alloc_type is neither ICBTAG_FLAG_AD_SHORT nor ICBTAG_FLAG_AD_LONG,
the value of adsize is undefined. This changes the code to use zero for adsize
in that case, which may be the correct solution, though I have not looked
at the code in enough detail to know if it should be something else instead.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Fixes: fcea62babc81 ("udf: Factor out code for creating indirect extent")
---
Found on ARM randconfig kernels starting with yesterday's linux-next

diff --git a/fs/udf/inode.c b/fs/udf/inode.c
index 5b83351041a4..a1cc074c656f 100644
--- a/fs/udf/inode.c
+++ b/fs/udf/inode.c
@@ -1890,6 +1890,8 @@ int udf_setup_indirect_aext(struct inode *inode, int block,
 		adsize = sizeof(struct short_ad);
 	else if (UDF_I(inode)->i_alloc_type == ICBTAG_FLAG_AD_LONG)
 		adsize = sizeof(struct long_ad);
+	else
+		adsize = 0;
 
 	neloc.logicalBlockNum = block;
 	neloc.partitionReferenceNum = epos->block.partitionReferenceNum;
