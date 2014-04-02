From: neilb@suse.de (NeilBrown)
Date: Thu, 3 Apr 2014 10:28:11 +1100
Subject: Recent 3.x kernels: Memory leak causing OOMs
In-Reply-To: <20140401140401.GZ7528@n2100.arm.linux.org.uk>
References: <alpine.DEB.2.02.1402161406120.26926@chino.kir.corp.google.com>
 <20140216225000.GO30257@n2100.arm.linux.org.uk>
 <1392670951.24429.10.camel@sakura.staff.proxad.net>
 <20140217210954.GA21483@n2100.arm.linux.org.uk>
 <20140315101952.GT21483@n2100.arm.linux.org.uk>
 <20140317180748.644d30e2@notabene.brown>
 <20140317181813.GA24144@arm.com>
 <20140317193316.GF21483@n2100.arm.linux.org.uk>
 <20140401091959.GA10912@n2100.arm.linux.org.uk>
 <20140401113851.GA15317@n2100.arm.linux.org.uk>
 <20140401140401.GZ7528@n2100.arm.linux.org.uk>
Message-ID: <20140403102811.5e5110a8@notabene.brown>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 1 Apr 2014 15:04:01 +0100 Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:

> On Tue, Apr 01, 2014 at 12:38:51PM +0100, Russell King - ARM Linux wrote:
> > Consider what happens when bio_alloc_pages() fails.  j starts off as one
> > for non-recovery operations, and we enter the loop to allocate the pages.
> > j is post-decremented to zero.  So, bio = r1_bio->bios[0].
> > 
> > bio_alloc_pages(bio) fails, we jump to out_free_bio.  The first thing
> > that does is increment j, so we free from r1_bio->bios[1] up to the
> > number of raid disks, leaving r1_bio->bios[0] leaked as the r1_bio is
> > then freed.
> 
> Neil,
> 
> Can you please review commit a07876064a0b7 (block: Add bio_alloc_pages)
> which seems to have introduced this bug - it seems to have gone in during
> the v3.10 merge window, and looks like it was never reviewed from the
> attributations on the commit.
> 
> The commit message is brief, and inadequately describes the functional
> change that the patch has - we go from "get up to RESYNC_PAGES into the
> bio's io_vec" to "get all RESYNC_PAGES or fail completely".
> 
> Not withstanding the breakage of the error cleanup paths, is this an
> acceptable change of behaviour here?
> 
> Thanks.
> 

Hi Russell,
 thanks for finding that bug! - I'm sure I looked at that code, but obviously
 missed the problem :-(

Below is the fix that I plan to submit.  It is slightly different from yours
but should achieve the same effect.  If you could confirm that it looks good
to you I would appreciate it.

Thanks,
NeilBrown


>From 72dce88eee7259d65c6eba10c2e0beff357f713b Mon Sep 17 00:00:00 2001
From: NeilBrown <neilb@suse.de>
Date: Thu, 3 Apr 2014 10:19:12 +1100
Subject: [PATCH] md/raid1: r1buf_pool_alloc: free allocate pages when
 subsequent allocation fails.

When performing a user-request check/repair (MD_RECOVERY_REQUEST is set)
on a raid1, we allocate multiple bios each with their own set of pages.

If the page allocations for one bio fails, we currently do *not* free
the pages allocated for the previous bios, nor do we free the bio itself.

This patch frees all the already-allocate pages, and makes sure that
all the bios are freed as well.

This bug can cause a memory leak which can ultimately OOM a machine.
It was introduced in 3.10-rc1.

Fixes: a07876064a0b73ab5ef1ebcf14b1cf0231c07858
Cc: Kent Overstreet <koverstreet@google.com>
Cc: stable at vger.kernel.org (3.10+)
Reported-by: Russell King - ARM Linux <linux@arm.linux.org.uk>
Signed-off-by: NeilBrown <neilb@suse.de>

diff --git a/drivers/md/raid1.c b/drivers/md/raid1.c
index 4a6ca1cb2e78..56e24c072b62 100644
--- a/drivers/md/raid1.c
+++ b/drivers/md/raid1.c
@@ -97,6 +97,7 @@ static void * r1buf_pool_alloc(gfp_t gfp_flags, void *data)
 	struct pool_info *pi = data;
 	struct r1bio *r1_bio;
 	struct bio *bio;
+	int need_pages;
 	int i, j;
 
 	r1_bio = r1bio_pool_alloc(gfp_flags, pi);
@@ -119,15 +120,15 @@ static void * r1buf_pool_alloc(gfp_t gfp_flags, void *data)
 	 * RESYNC_PAGES for each bio.
 	 */
 	if (test_bit(MD_RECOVERY_REQUESTED, &pi->mddev->recovery))
-		j = pi->raid_disks;
+		need_pages = pi->raid_disks;
 	else
-		j = 1;
-	while(j--) {
+		need_pages = 1;
+	for (j = 0; j < need_pages; j++) {
 		bio = r1_bio->bios[j];
 		bio->bi_vcnt = RESYNC_PAGES;
 
 		if (bio_alloc_pages(bio, gfp_flags))
-			goto out_free_bio;
+			goto out_free_pages;
 	}
 	/* If not user-requests, copy the page pointers to all bios */
 	if (!test_bit(MD_RECOVERY_REQUESTED, &pi->mddev->recovery)) {
@@ -141,6 +142,14 @@ static void * r1buf_pool_alloc(gfp_t gfp_flags, void *data)
 
 	return r1_bio;
 
+out_free_pages:
+	while (--j >= 0) {
+		struct bio_vec *bv;
+
+		bio_for_each_segment_all(bv, r1_bio->bios[j], i)
+			__free_page(bv->bv_page);
+	}
+
 out_free_bio:
 	while (++j < pi->raid_disks)
 		bio_put(r1_bio->bios[j]);
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 828 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140403/d1ee0dec/attachment-0001.sig>
