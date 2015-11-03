From: huawei.libin@huawei.com (libin)
Date: Tue, 3 Nov 2015 08:58:47 +0800
Subject: [PATCH] recordmcount: fix endianness handling bug for nop_mcount
In-Reply-To: <20151102143324.071eee7e@gandalf.local.home>
References: <1446193864-24593-1-git-send-email-huawei.libin@huawei.com>
 <1446193864-24593-2-git-send-email-huawei.libin@huawei.com>
 <56338025.3060602@cogentembedded.com> <5634226A.9060208@huawei.com>
 <20151102143324.071eee7e@gandalf.local.home>
Message-ID: <563806C7.7070606@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In nop_mcount, shdr->sh_offset and welp->r_offset should handle
endianness properly, otherwise it will trigger Segmentation fault
if the recordmcount main and file.o have different endianness.

Cc: <stable@vger.kernel.org> # 3.0+
Signed-off-by: Li Bin <huawei.libin@huawei.com>
---
 scripts/recordmcount.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/scripts/recordmcount.h b/scripts/recordmcount.h
index 49b582a..b9897e2 100644
--- a/scripts/recordmcount.h
+++ b/scripts/recordmcount.h
@@ -377,7 +377,7 @@ static void nop_mcount(Elf_Shdr const *const relhdr,

 		if (mcountsym == Elf_r_sym(relp) && !is_fake_mcount(relp)) {
 			if (make_nop)
-				ret = make_nop((void *)ehdr, shdr->sh_offset + relp->r_offset);
+				ret = make_nop((void *)ehdr, _w(shdr->sh_offset) + _w(relp->r_offset));
 			if (warn_on_notrace_sect && !once) {
 				printf("Section %s has mcount callers being ignored\n",
 				       txtname);
-- 
1.7.1
