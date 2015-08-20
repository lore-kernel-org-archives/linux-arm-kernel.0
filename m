From: clabbe.montjoie@gmail.com (Corentin LABBE)
Date: Thu, 20 Aug 2015 15:56:39 +0200
Subject: un4i-ss-cipher.c warning
In-Reply-To: <CAOMqctShdb9xEkBmuaQKfB1cwGupbfH5TS5ZB_P85Hwpn+4zAA@mail.gmail.com>
References: <CAOMqctShdb9xEkBmuaQKfB1cwGupbfH5TS5ZB_P85Hwpn+4zAA@mail.gmail.com>
Message-ID: <55D5DC97.1040209@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 19/08/2015 16:35, Michal Suchanek wrote:
> Hello,
>
> when building a kernel with sunxi crypto driver as merged into the
> sinxi-wip branch I get a compiler warning.
>
> I am not sure this is the latest version of the driver. It does not
> seem to be in mainline yet.
>
> Thanks
>
> Michal
>
> In file included from /scratch/build/linux/include/linux/printk.h:277:0,
>                   from /scratch/build/linux/include/linux/kernel.h:13,
>                   from /scratch/build/linux/include/linux/clk.h:16,
>                   from
> /scratch/build/linux/drivers/crypto/sunxi-ss/sun4i-ss.h:15,
>                   from
> /scratch/build/linux/drivers/crypto/sunxi-ss/sun4i-ss-cipher.c:17:
> /scratch/build/linux/drivers/crypto/sunxi-ss/sun4i-ss-cipher.c: In
> function ?sun4i_ss_cipher_poll?:
> /scratch/build/linux/include/linux/dynamic_debug.h:86:3: warning:
> ?todo? may be used uninitialized in this function
> [-Wmaybe-uninitialized]
>     __dynamic_dev_dbg(&descriptor, dev, fmt, \
>     ^
> /scratch/build/linux/drivers/crypto/sunxi-ss/sun4i-ss-cipher.c:144:15:
> note: ?todo? was declared here
>    unsigned int todo;
>

Hello

Thanks for the report, strange that I do not have that warning.
todo is always initialized, since oleft and ileft are always > 0 at start.
But setting todo to 0 is a simple fix.
The following patch will suppress the warning.

Regards

-- >8 --
 From 67f2d0749041b08c4c4ad671ab710b3b83f6dfd3 Mon Sep 17 00:00:00 2001
From: LABBE Corentin <clabbe.montjoie@gmail.com>
Date: Thu, 20 Aug 2015 12:18:46 +0200
Subject: [PATCH] crypto: sun4i-ss: suppress the todo uninitialized warning

Signed-off-by: LABBE Corentin <clabbe.montjoie@gmail.com>
---
  drivers/crypto/sunxi-ss/sun4i-ss-cipher.c | 4 ++--
  1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/crypto/sunxi-ss/sun4i-ss-cipher.c b/drivers/crypto/sunxi-ss/sun4i-ss-cipher.c
index e070c31..9299914 100644
--- a/drivers/crypto/sunxi-ss/sun4i-ss-cipher.c
+++ b/drivers/crypto/sunxi-ss/sun4i-ss-cipher.c
@@ -32,7 +32,7 @@ static int sun4i_ss_opti_poll(struct ablkcipher_request *areq)
  	int i, err = 0;
  	unsigned int ileft = areq->nbytes;
  	unsigned int oleft = areq->nbytes;
-	unsigned int todo;
+	unsigned int todo = 0;
  	struct sg_mapping_iter mi, mo;
  	unsigned int oi, oo; /* offset for in and out */

@@ -141,7 +141,7 @@ static int sun4i_ss_cipher_poll(struct ablkcipher_request *areq)
  	int i, err = 0;
  	unsigned int ileft = areq->nbytes;
  	unsigned int oleft = areq->nbytes;
-	unsigned int todo;
+	unsigned int todo = 0;
  	struct sg_mapping_iter mi, mo;
  	unsigned int oi, oo;	/* offset for in and out */
  	char buf[4 * SS_RX_MAX];/* buffer for linearize SG src */
-- 
2.4.6
