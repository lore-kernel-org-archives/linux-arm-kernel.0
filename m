From: dedekind1@gmail.com (Artem Bityutskiy)
Date: Wed, 18 Jul 2012 10:09:19 +0300
Subject: [PATCH 1/5] ubi: introduce ubi->bad_peb_limit
In-Reply-To: <1341389164-24409-2-git-send-email-shmulik.ladkani@gmail.com>
References: <1341389164-24409-1-git-send-email-shmulik.ladkani@gmail.com>
 <1341389164-24409-2-git-send-email-shmulik.ladkani@gmail.com>
Message-ID: <1342595359.31927.11.camel@brekeke>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2012-07-04 at 11:06 +0300, Shmulik Ladkani wrote:
> Introduce 'ubi->bad_peb_limit', which specifies an upper limit of PEBs
> ubi expects to go bad.
> Currently, it is initialized to a fixed percentage of total PEBs in the
> ubi device (configurable via CONFIG_MTD_UBI_BEB_LIMIT).
> 
> The 'bad_peb_limit' is intended to be used for calculating the amount of
> PEBs ubi needs to reserve for bad eraseblock handling.
> 
> Signed-off-by: Shmulik Ladkani <shmulik.ladkani@gmail.com>

Created branch "beb" and pushed this patch there with minor amendments
(see diff below). Let's use this branch in UBI tree for this work and
merge it as soon as it is ready.

diff --git a/drivers/mtd/ubi/build.c b/drivers/mtd/ubi/build.c
index c33e25b..dee90b7 100644
--- a/drivers/mtd/ubi/build.c
+++ b/drivers/mtd/ubi/build.c
@@ -668,13 +668,12 @@ static int io_init(struct ubi_device *ubi)
                ubi->bad_allowed = 1;
                if (CONFIG_MTD_UBI_BEB_LIMIT > 0) {
                        int percent = CONFIG_MTD_UBI_BEB_LIMIT;
-                       int beb_limit;
+                       int limit = mult_frac(ubi->peb_count, percent, 100);
 
-                       beb_limit = mult_frac(ubi->peb_count, percent, 100);
-                       /* round it up */
-                       if (mult_frac(beb_limit, 100, percent) < ubi->peb_count)
-                               beb_limit++;
-                       ubi->bad_peb_limit = beb_limit;
+                       /* Round it up */
+                       if (mult_frac(limit, 100, percent) < ubi->peb_count)
+                               limit += 1;
+                       ubi->bad_peb_limit = limit;
                }
        }

-- 
Best Regards,
Artem Bityutskiy
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: This is a digitally signed message part
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120718/fff33c14/attachment-0001.sig>
