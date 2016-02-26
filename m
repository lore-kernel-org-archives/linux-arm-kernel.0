From: akpm@linux-foundation.org (Andrew Morton)
Date: Fri, 26 Feb 2016 13:28:12 -0800
Subject: [PATCH] staging/goldfish: use 6-arg get_user_pages()
In-Reply-To: <1456488033-4044939-1-git-send-email-arnd@arndb.de>
References: <1456488033-4044939-1-git-send-email-arnd@arndb.de>
Message-ID: <20160226132812.a81d46c0151cb47f9433909f@linux-foundation.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 26 Feb 2016 12:59:43 +0100 Arnd Bergmann <arnd@arndb.de> wrote:

> After commit cde70140fed8 ("mm/gup: Overload get_user_pages() functions"),
> we get warning for this file, as it calls get_user_pages() with eight
> arguments after the change of the calling convention to use only six:
> 
> drivers/platform/goldfish/goldfish_pipe.c: In function 'goldfish_pipe_read_write':
> drivers/platform/goldfish/goldfish_pipe.c:312:3: error: 'get_user_pages8' is deprecated [-Werror=deprecated-declarations]
> 
> This removes the first two arguments, which are now the default.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
> The API change is currently only in the mm/pkeys branch of the
> tip tree, while the goldfish_pipe driver started using the
> old API in the staging/next branch.
> 
> Andrew could pick it up into linux-mm in the meantime, or I can
> resend it at some later point if nobody else does the change
> after 4.6-rc1.

This is one for Ingo.

From: Arnd Bergmann <arnd@arndb.de>
Subject: staging/goldfish: use 6-arg get_user_pages()

After commit cde70140fed8 ("mm/gup: Overload get_user_pages() functions"),
we get warning for this file, as it calls get_user_pages() with eight
arguments after the change of the calling convention to use only six:

drivers/platform/goldfish/goldfish_pipe.c: In function 'goldfish_pipe_read_write':
drivers/platform/goldfish/goldfish_pipe.c:312:3: error: 'get_user_pages8' is deprecated [-Werror=deprecated-declarations]

This removes the first two arguments, which are now the default.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Ingo Molnar <mingo@elte.hu>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 drivers/platform/goldfish/goldfish_pipe.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff -puN drivers/platform/goldfish/goldfish_pipe.c~staging-goldfish-use-6-arg-get_user_pages drivers/platform/goldfish/goldfish_pipe.c
--- a/drivers/platform/goldfish/goldfish_pipe.c~staging-goldfish-use-6-arg-get_user_pages
+++ a/drivers/platform/goldfish/goldfish_pipe.c
@@ -309,8 +309,7 @@ static ssize_t goldfish_pipe_read_write(
 		 * much memory to the process.
 		 */
 		down_read(&current->mm->mmap_sem);
-		ret = get_user_pages(current, current->mm, address, 1,
-				     !is_write, 0, &page, NULL);
+		ret = get_user_pages(address, 1, !is_write, 0, &page, NULL);
 		up_read(&current->mm->mmap_sem);
 		if (ret < 0)
 			break;
_
