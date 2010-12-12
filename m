From: cjb@laptop.org (Chris Ball)
Date: Sun, 12 Dec 2010 13:52:24 +0000
Subject: [PATCH] dw_mmc: Add Synopsys DesignWare mmc host driver.
In-Reply-To: <AANLkTin5aVPz5Y=jS89V00XS=rje3gqeUb2VTYt2A_9=@mail.gmail.com>
References: <AANLkTi=0RtvsGX+Q3goL3mdG6oKeNidYtiudTZ8ZTpRP@mail.gmail.com>
	<20101208115510.GD10998@console-pimps.org>
	<AANLkTi=KqOa-MRQiptCtZGvoafRCgULfE3QFs=hmGpdi@mail.gmail.com>
	<AANLkTi=PpTi1_JO9Q=ph7w9Jim8iXMf9LbCfmEkWuo-h@mail.gmail.com>
	<20101209064751.GA21128@void.printf.net>
	<AANLkTimMgrawcndvUTYYjq9BGFqs-sbRsZkwVQ0Uvhvb@mail.gmail.com>
	<20101209160157.GA28586@void.printf.net>
	<AANLkTim3Rj2tTbqvT8nM4L=p=Wx8bdOnGq=EDv+cs02g@mail.gmail.com>
	<20101211192320.GA24430@void.printf.net>
	<AANLkTin5aVPz5Y=jS89V00XS=rje3gqeUb2VTYt2A_9=@mail.gmail.com>
Message-ID: <20101212135224.GA31812@void.printf.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Will,

On Sun, Dec 12, 2010 at 10:57:44AM +0000, Will Newton wrote:
> > drivers/mmc/host/dw_mmc.c: In function ?dw_mci_pull_data64?:
> > drivers/mmc/host/dw_mmc.c:998: error: implicit declaration of function ?__raw_readq?
> >
> > because arch/arm doesn't implement raw versions of these 64-bit accesses.
> > I'm surprised that this driver hasn't been compiled on ARM before! ?What
> 
> That particular bit of code has been added since it was last built for
> arm. Our architecture can do 64bit accesses so we implement readq.
> Unfortunately there doesn't seem to be a sane way to conditionalize
> code for architectures that have or don't have readq, so I suspect
> I'll have to just remove that branch of the if statement for now.

(Russell, thanks for the excellent explanation.)

Other drivers (MTD, gpio/basic_mmio_gpio.c, fs/fuse, pcm_oss.c)
conditionalize uses of {read,write}q on BITS_PER_LONG >= 64, so
something like this:

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index 7de6b42..526b5cb 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -988,10 +988,11 @@ static void dw_mci_pull_data32(struct dw_mci *host, void *buf, int cnt)
 		*pData++ = mci_readl(host, DATA);
 		cnt--;
 	}
 }
 
+#if BITS_PER_LONG >= 64
 static void dw_mci_push_data64(struct dw_mci *host, void *buf, int cnt)
 {
 	u64 *pData = (u64 *)buf;
 
 	WARN_ON(cnt % 8 != 0);
@@ -1013,10 +1014,11 @@ static void dw_mci_pull_data64(struct dw_mci *host, void *buf, int cnt)
 	while (cnt > 0) {
 		*pData++ = mci_readq(host, DATA);
 		cnt--;
 	}
 }
+#endif
 
 static void dw_mci_read_data_pio(struct dw_mci *host)
 {
 	struct scatterlist *sg = host->sg;
 	void *buf = sg_virt(sg);
@@ -1591,15 +1593,17 @@ static int dw_mci_probe(struct platform_device *pdev)
 	if (!i) {
 		host->push_data = dw_mci_push_data16;
 		host->pull_data = dw_mci_pull_data16;
 		width = 16;
 		host->data_shift = 1;
+#if BITS_PER_LONG >= 64
 	} else if (i == 2) {
 		host->push_data = dw_mci_push_data64;
 		host->pull_data = dw_mci_pull_data64;
 		width = 64;
 		host->data_shift = 3;
+#endif
 	} else {
 		/* Check for a reserved value, and warn if it is */
 		WARN((i != 1),
 			"HCON reports a reserved host data width!\n"
 			"Defaulting to 32-bit access.\n");


This is only useful if you just want the driver to compile (it compiles
on ARM after the above) and don't expect a working device if you find
the HCON programmed with 64-bit width on an ARM board, though.

Thanks,

-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
