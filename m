From: benoit.thebaudeau@advansee.com (=?utf-8?Q?Beno=C3=AEt_Th=C3=A9baudeau?=)
Date: Wed, 13 Jun 2012 18:15:34 +0200 (CEST)
Subject: [PATCH] ARM: mxc-rnga: fix data_present API
In-Reply-To: <20120613063650.GB32436@pengutronix.de>
Message-ID: <449445897.2590473.1339604134205.JavaMail.root@advansee.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, Jun 13, 2012 at 8:36:50AM +0200, Uwe Kleine-K?nig wrote:
> your changelog is very sparse. Maybe point out the commit that
> changed
> the API without fixing its users?

Done below.

> On Tue, Jun 12, 2012 at 11:07:47PM +0200, Beno?t Th?baudeau wrote:
> > +	int level, data, i;
> level is only used in the for loop, so it should be declared there,
> too.

Done below.

> > +
> > +	for (i = 0; i < 20; i++) {
> > +		/* how many random numbers is in FIFO? [0-16] */
> As you touch this comment can you fix the grammar, too? (i.e.
> s/is/are/)

Done below.

> > +		level = ((__raw_readl(rng_base + RNGA_STATUS) &
> > +				RNGA_STATUS_LEVEL_MASK) >> 8);
> > +		data = level > 0 ? 1 : 0;
> This statement is equivalent to:
> 
> 	data = level > 0;
> 
> so IMHO there is no need for the data variable.

Done below. I had kept that only to stick more closely to the original code, but
I did not like this either.

> > +		if (data || !wait)
> > +			break;
> > +		udelay(10);
> Apart from the magic 20 that Fabio already pointed out, these 10 us
> are
> magic, too. What is the requirement when wait evaluates to true? Are
> you
> allowed to sleep? If so, maybe better do that?

Both the magic 20 and the magic 10 ?s are simply the missing extension for RNGA
of commit 984e976. They first appear in commit 844dd05, which only says this is
polling time used to let RNG HW gather new entropy while rng_dev_read() is
waiting for it. Hence, at least the 10 ?s should be hardware-specific.

The requirement when wait evaluates to true should be to wait for entropy data
with a time-out. rng_dev_read() seems to run in a "sleep-able" context. The
issue is that there does not seem to be any source of information regarding the
time required by RNGA to gather entropy data, or the time after which it is
useless to expect entropy data. The RNGA chapter of the i.MX31 RM is very light.

IMHO, considering the information we have, it's better to keep this 20 * 10 ?s
behavior copied from the other RNG drivers since it works, it gives some time to
RNGA to gather new entropy, and at worst it wastes 0.2 ms each time. Should it
sleep for 10 ?s?

See my reworked patch below.

Regards,
Beno?t


[PATCH] ARM: mxc-rnga: fix data_present API

Commit 45001e9, which added support for RNGA, ignored the previous commit
984e976, which changed the data_present API.

Cc: Matt Mackall <mpm@selenic.com>
Cc: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Sascha Hauer <kernel@pengutronix.de>
Cc: Alan Carvalho de Assis <acassis@gmail.com>
Cc: <linux-arm-kernel@lists.infradead.org>
Signed-off-by: Beno?t Th?baudeau <benoit.thebaudeau@advansee.com>
---
 .../drivers/char/hw_random/mxc-rnga.c              |   21 ++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git linux-next-HEAD-aab6028.orig/drivers/char/hw_random/mxc-rnga.c linux-next-HEAD-aab6028/drivers/char/hw_random/mxc-rnga.c
index 187c6be..85074de 100644
--- linux-next-HEAD-aab6028.orig/drivers/char/hw_random/mxc-rnga.c
+++ linux-next-HEAD-aab6028/drivers/char/hw_random/mxc-rnga.c
@@ -24,6 +24,7 @@
 #include <linux/ioport.h>
 #include <linux/platform_device.h>
 #include <linux/hw_random.h>
+#include <linux/delay.h>
 #include <linux/io.h>
 
 /* RNGA Registers */
@@ -60,16 +61,20 @@
 
 static struct platform_device *rng_dev;
 
-static int mxc_rnga_data_present(struct hwrng *rng)
+static int mxc_rnga_data_present(struct hwrng *rng, int wait)
 {
-	int level;
 	void __iomem *rng_base = (void __iomem *)rng->priv;
-
-	/* how many random numbers is in FIFO? [0-16] */
-	level = ((__raw_readl(rng_base + RNGA_STATUS) &
-			RNGA_STATUS_LEVEL_MASK) >> 8);
-
-	return level > 0 ? 1 : 0;
+	int i;
+
+	for (i = 0; i < 20; i++) {
+		/* how many random numbers are in FIFO? [0-16] */
+		int level = (__raw_readl(rng_base + RNGA_STATUS) &
+				RNGA_STATUS_LEVEL_MASK) >> 8;
+		if (level || !wait)
+			return !!level;
+		udelay(10);
+	}
+	return 0;
 }
 
 static int mxc_rnga_data_read(struct hwrng *rng, u32 * data)
