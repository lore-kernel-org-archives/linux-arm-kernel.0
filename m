From: huawei.libin@huawei.com (Li Bin)
Date: Fri, 30 Oct 2015 16:31:02 +0800
Subject: [PATCH 1/3] recordmcount: fix endianness handling bug for nop_mcount
In-Reply-To: <1446193864-24593-1-git-send-email-huawei.libin@huawei.com>
References: <1446193864-24593-1-git-send-email-huawei.libin@huawei.com>
Message-ID: <1446193864-24593-2-git-send-email-huawei.libin@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In nop_mcount, shdr->sh_offset and welp->r_offset should handle
endianness properly, otherwise it will trigger Segmentation fault
if the recordmcount main and file.o have different endianness.

Cc: <stable@vger.kernel.org> # 3.0+
Signed-off-by: Li Bin <huawei.libin@huawei.com>
---
 scripts/recordmcount.h | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/scripts/recordmcount.h b/scripts/recordmcount.h
index 49b582a..dda9dba 100644
--- a/scripts/recordmcount.h
+++ b/scripts/recordmcount.h
@@ -376,8 +376,9 @@ static void nop_mcount(Elf_Shdr const *const relhdr,
 			mcountsym = get_mcountsym(sym0, relp, str0);
 
 		if (mcountsym == Elf_r_sym(relp) && !is_fake_mcount(relp)) {
-			if (make_nop)
-				ret = make_nop((void *)ehdr, shdr->sh_offset + relp->r_offset);
+			if (make_nop) {
+				ret = make_nop((void *)ehdr, _w(shdr->sh_offset) + _w(relp->r_offset));
+			}
 			if (warn_on_notrace_sect && !once) {
 				printf("Section %s has mcount callers being ignored\n",
 				       txtname);
-- 
1.7.12.4
