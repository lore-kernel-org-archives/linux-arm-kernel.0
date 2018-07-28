From: gregkh@linuxfoundation.org (gregkh at linuxfoundation.org)
Date: Sat, 28 Jul 2018 12:07:22 +0200
Subject: Patch "EDAC,
 altera: Fix ARM64 build warning" has been added to the 4.14-stable
 tree
Message-ID: <1532772442216105@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


This is a note to let you know that I've just added the patch titled

    EDAC, altera: Fix ARM64 build warning

to the 4.14-stable tree which can be found at:
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary

The filename of the patch is:
     edac-altera-fix-arm64-build-warning.patch
and it can be found in the queue-4.14 subdirectory.

If you, or anyone else, feels it should not be added to the stable tree,
please let <stable@vger.kernel.org> know about it.


>From foo at baz Sat Jul 28 10:25:26 CEST 2018
From: Thor Thayer <thor.thayer@linux.intel.com>
Date: Mon, 14 May 2018 12:04:01 -0500
Subject: EDAC, altera: Fix ARM64 build warning

From: Thor Thayer <thor.thayer@linux.intel.com>

[ Upstream commit 9ef20753e044f7468c4113e5aecd785419b0b3cc ]

The kbuild test robot reported the following warning:

  drivers/edac/altera_edac.c: In function 'ocram_free_mem':
  drivers/edac/altera_edac.c:1410:42: warning: cast from pointer to integer
	of different size [-Wpointer-to-int-cast]
    gen_pool_free((struct gen_pool *)other, (u32)p, size);
                                             ^

After adding support for ARM64 architectures, the unsigned long
parameter is 64 bits and causes a build warning on 64-bit configs. Fix
by casting to the correct size (unsigned long) instead of u32.

Reported-by: kbuild test robot <lkp@intel.com>
Signed-off-by: Thor Thayer <thor.thayer@linux.intel.com>
Cc: linux-arm-kernel at lists.infradead.org
Cc: linux-edac <linux-edac@vger.kernel.org>
Fixes: c3eea1942a16 ("EDAC, altera: Add Altera L2 cache and OCRAM support")
Link: http://lkml.kernel.org/r/1526317441-4996-1-git-send-email-thor.thayer at linux.intel.com
Signed-off-by: Borislav Petkov <bp@suse.de>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/edac/altera_edac.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/edac/altera_edac.c
+++ b/drivers/edac/altera_edac.c
@@ -1106,7 +1106,7 @@ static void *ocram_alloc_mem(size_t size
 
 static void ocram_free_mem(void *p, size_t size, void *other)
 {
-	gen_pool_free((struct gen_pool *)other, (u32)p, size);
+	gen_pool_free((struct gen_pool *)other, (unsigned long)p, size);
 }
 
 static const struct edac_device_prv_data ocramecc_data = {


Patches currently in stable-queue which might be from thor.thayer at linux.intel.com are

queue-4.14/edac-altera-fix-arm64-build-warning.patch
