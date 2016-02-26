From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 26 Feb 2016 12:59:43 +0100
Subject: [PATCH] staging/goldfish: use 6-arg get_user_pages()
Message-ID: <1456488033-4044939-1-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

After commit cde70140fed8 ("mm/gup: Overload get_user_pages() functions"),
we get warning for this file, as it calls get_user_pages() with eight
arguments after the change of the calling convention to use only six:

drivers/platform/goldfish/goldfish_pipe.c: In function 'goldfish_pipe_read_write':
drivers/platform/goldfish/goldfish_pipe.c:312:3: error: 'get_user_pages8' is deprecated [-Werror=deprecated-declarations]

This removes the first two arguments, which are now the default.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
The API change is currently only in the mm/pkeys branch of the
tip tree, while the goldfish_pipe driver started using the
old API in the staging/next branch.

Andrew could pick it up into linux-mm in the meantime, or I can
resend it at some later point if nobody else does the change
after 4.6-rc1.
---
 drivers/platform/goldfish/goldfish_pipe.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/platform/goldfish/goldfish_pipe.c b/drivers/platform/goldfish/goldfish_pipe.c
index 9973cebb4d6f..07462d79d040 100644
--- a/drivers/platform/goldfish/goldfish_pipe.c
+++ b/drivers/platform/goldfish/goldfish_pipe.c
@@ -309,8 +309,7 @@ static ssize_t goldfish_pipe_read_write(struct file *filp, char __user *buffer,
 		 * much memory to the process.
 		 */
 		down_read(&current->mm->mmap_sem);
-		ret = get_user_pages(current, current->mm, address, 1,
-				     !is_write, 0, &page, NULL);
+		ret = get_user_pages(address, 1, !is_write, 0, &page, NULL);
 		up_read(&current->mm->mmap_sem);
 		if (ret < 0)
 			break;
-- 
2.7.0
