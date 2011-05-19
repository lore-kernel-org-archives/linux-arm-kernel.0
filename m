From: pavel@ucw.cz (Pavel Machek)
Date: Thu, 19 May 2011 14:35:08 +0200
Subject: [PATCH] MAX1111: Fix race condition causing NULL pointer exception
In-Reply-To: <20110518152935.GJ5913@n2100.arm.linux.org.uk>
References: <1305731918-20164-1-git-send-email-morpheus.ibis@gmail.com>
	<20110518152935.GJ5913@n2100.arm.linux.org.uk>
Message-ID: <20110519123507.GA4950@elf.ucw.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

On Wed 2011-05-18 16:29:35, Russell King - ARM Linux wrote:
> On Wed, May 18, 2011 at 05:18:38PM +0200, Pavel Herrmann wrote:
> > spi_sync call uses its spi_message parameter to keep completion information,
> > having this structure static is not thread-safe, potentially causing one
> > thread having pointers to memory on or above other threads stack. use
> > per-call spi_message on stack to fix this
> 
> I assume this has not been tested with DMA debugging enabled.
> 
> The DMA API does not like mapping memory from the stack, which is what
> you're potentially doing with this:

In some other mail, you said "just add the locking". Pavel H.
actually produced patch doing so...


From: Pavel Herrmann <morpheus.ibis@gmail.com>
To: Marek Vasut <marek.vasut@gmail.com>

>From 14063b017123233a8b56d6706a9ff046a791eaf4 Mon Sep 17 00:00:00 2001
From: Pavel Herrmann <morpheus.ibis@gmail.com>
Date: Mon, 16 May 2011 14:18:18 +0200
Subject: [PATCH] Fix NULL pointer exception in max1111

Signed-off-by: Pavel Herrmann <morpheus.ibis@gmail.com>
---
 drivers/hwmon/max1111.c |   16 ++++++++++++++++
 1 files changed, 16 insertions(+), 0 deletions(-)

diff --git a/drivers/hwmon/max1111.c b/drivers/hwmon/max1111.c
index 12a54aa..7be50e5 100644
--- a/drivers/hwmon/max1111.c
+++ b/drivers/hwmon/max1111.c
@@ -40,6 +40,7 @@ struct max1111_data {
 	struct spi_transfer	xfer[2];
 	uint8_t *tx_buf;
 	uint8_t *rx_buf;
+	struct mutex		msg_lock_mutex;
 };
 
 static int max1111_read(struct device *dev, int channel)
@@ -48,6 +49,11 @@ static int max1111_read(struct device *dev, int channel)
 	uint8_t v1, v2;
 	int err;
 
+	/* spi_sync requires data not to be freed before function returns
+	 * for static data, any access is dangerous, use locks
+	 */
+	mutex_lock(&data->msg_lock_mutex);
+
 	data->tx_buf[0] = (channel << MAX1111_CTRL_SEL_SH) |
 		MAX1111_CTRL_PD0 | MAX1111_CTRL_PD1 |
 		MAX1111_CTRL_SGL | MAX1111_CTRL_UNI | MAX1111_CTRL_STR;
@@ -55,12 +61,15 @@ static int max1111_read(struct device *dev, int channel)
 	err = spi_sync(data->spi, &data->msg);
 	if (err < 0) {
 		dev_err(dev, "spi_sync failed with %d\n", err);
+		mutex_unlock(&data->msg_lock_mutex);
 		return err;
 	}
 
 	v1 = data->rx_buf[0];
 	v2 = data->rx_buf[1];
 
+	mutex_unlock(&data->msg_lock_mutex);
+
 	if ((v1 & 0xc0) || (v2 & 0x3f))
 		return -EINVAL;
 
@@ -138,6 +147,8 @@ static int setup_transfer(struct max1111_data *data)
 		return -ENOMEM;
 	}
 
+	mutex_lock(&data->msg_lock_mutex);
+
 	m = &data->msg;
 	x = &data->xfer[0];
 
@@ -152,6 +163,8 @@ static int setup_transfer(struct max1111_data *data)
 	x->len = 2;
 	spi_message_add_tail(x, m);
 
+	mutex_unlock(&data->msg_lock_mutex);
+
 	return 0;
 }
 
@@ -172,6 +185,8 @@ static int __devinit max1111_probe(struct spi_device *spi)
 		return -ENOMEM;
 	}
 
+	mutex_init(&data->msg_lock_mutex);
+
 	err = setup_transfer(data);
 	if (err)
 		goto err_free_data;
@@ -213,6 +228,7 @@ static int __devexit max1111_remove(struct spi_device *spi)
 
 	hwmon_device_unregister(data->hwmon_dev);
 	sysfs_remove_group(&spi->dev.kobj, &max1111_attr_group);
+	mutex_destroy(data->msg_lock_mutex);
 	kfree(data->rx_buf);
 	kfree(data->tx_buf);
 	kfree(data);
-- 
1.7.5.rc1



----- End forwarded message -----


-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
