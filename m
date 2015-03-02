From: lsanfil@marvell.com (Lino Sanfilippo)
Date: Mon, 2 Mar 2015 11:01:42 +0100
Subject: [RFC PATCH 1/1] ARM: Ensure correct structure alignment when using
 compiler attribute "section"
In-Reply-To: <1425290502-2322-1-git-send-email-lsanfil@marvell.com>
References: <1425290502-2322-1-git-send-email-lsanfil@marvell.com>
Message-ID: <1425290502-2322-2-git-send-email-lsanfil@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In some cases structures are placed into dedicated sections by means of the
"section" compiler attribute and then accessed as elements of an array (e.g when
the __clk_of_table is set up which contains all potential clock providers - see
CLK_OF_DECLARE).
But even if the size of such a structure is a multiple of the processors word
size, the linker may decide to use an even greater alignment and thus use
padding in between the structures. In this case accessing a structure as an
array element is not possible. To avoid such padding and thus allow to access
such a structure as an array element enforce an alignment of processor word size
by means of the "aligned" attribute.

Signed-off-by: Lino Sanfilippo <lsanfil@marvell.com>
---
 include/linux/compiler.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/linux/compiler.h b/include/linux/compiler.h
index 33063f8..6f32128 100644
--- a/include/linux/compiler.h
+++ b/include/linux/compiler.h
@@ -371,7 +371,8 @@ static __always_inline void __write_once_size(volatile void *p, void *res, int s
 
 /* Simple shorthand for a section definition */
 #ifndef __section
-# define __section(S) __attribute__ ((__section__(#S)))
+# define __section(S) __attribute__ ((__section__(#S))) \
+		      __aligned(sizeof(void *))
 #endif
 
 #ifndef __visible
-- 
1.9.1
