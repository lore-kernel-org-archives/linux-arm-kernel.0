From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 01 Jan 2016 15:21:54 +0100
Subject: [PATCH v2] udf: avoid uninitialized variable use
In-Reply-To: <9221187.T0u8gszVyj@wuerfel>
References: <9221187.T0u8gszVyj@wuerfel>
Message-ID: <5491623.oZlI0zcRmi@wuerfel>
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
sorry for missing another instance the first time around. The warning is
a bit unreliable and it seems in my first configuration I got it only
for one of the two instances that show it in other configuration.

After checking the remaining functions in this file for the same possible
problem, I found that the other functions use either 'BUG()' or 'return -EIO'
in the 'else' path, so I assume the two functions here should one of those
as well, but I don't know which.

diff --git a/fs/udf/inode.c b/fs/udf/inode.c
index 5b83351041a4..42f68dd7e6ef 100644
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
@@ -1963,6 +1965,8 @@ int __udf_add_aext(struct inode *inode, struct extent_position *epos,
 		adsize = sizeof(struct short_ad);
 	else if (iinfo->i_alloc_type == ICBTAG_FLAG_AD_LONG)
 		adsize = sizeof(struct long_ad);
+	else
+		adsize = 0;
 
 	if (!epos->bh) {
 		WARN_ON(iinfo->i_lenAlloc !=
