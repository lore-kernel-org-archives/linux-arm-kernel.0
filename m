From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Thu, 9 Mar 2017 09:20:42 +0000
Subject: [Question] devm_kmalloc() for DMA ?
In-Reply-To: <CAK7LNARYbqmwgYftjZeBkWsETczLUWdeLoTZRugLUJos_eyWNQ@mail.gmail.com>
References: <CAK7LNARbD262isY7yOgQKAcbWQHV+3dsoRjtu6S+qUpPr98qSQ@mail.gmail.com>
 <b7dd01e6-ddcd-a34a-c26c-05ce6ae4015a@arm.com>
 <CAK7LNAQ3FbicgoV1Q70T2gZQS0j1Z8LffXquSM=v6DYcHP_m4Q@mail.gmail.com>
 <fd2097a1-c9b5-e6ab-f3b3-04b432bda0a3@metafoo.de>
 <20170308195901.GD21222@n2100.armlinux.org.uk>
 <456e0515-b9d7-e1b6-fc25-a2ec5244d9db@metafoo.de>
 <20170308211900.GE21222@n2100.armlinux.org.uk>
 <d941e1cd-1803-ab8a-9dfc-f22650227465@metafoo.de>
 <CAK7LNARYbqmwgYftjZeBkWsETczLUWdeLoTZRugLUJos_eyWNQ@mail.gmail.com>
Message-ID: <20170309092042.GH21222@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 09, 2017 at 12:25:07PM +0900, Masahiro Yamada wrote:
> (c) Use kmalloc() and kfree().   (be careful for memory leak)

This is quite simple.  For the first one, it doesn't seem that it's
DMA'd into, so there's no need to use GFP_DMA.

-	/* allocate a temporary buffer for nand_scan_ident() */
-	denali->buf.buf = devm_kzalloc(denali->dev, PAGE_SIZE,
-					GFP_DMA | GFP_KERNEL);
-	if (!denali->buf.buf)
-		return -ENOMEM;

...

+	denali->buf.buf = kzalloc(PAGE_SIZE, GFP_KERNEL);
+	if (!denali->buf.buf)
+		return -ENOMEM;
+
	/*
	 * scan for NAND devices attached to the controller
	 * this is the first stage in a two step process to register
	 * with the nand subsystem
	 */
	ret = nand_scan_ident(mtd, denali->max_banks, NULL);
+	kfree(denali->buf.buf);
+
	if (ret)
		goto failed_req_irq;

-	/* allocate the right size buffer now */
-	devm_kfree(denali->dev, denali->buf.buf);

For the second one, I think the first thing to do is to move the
dma_set_mask() to the very beginning of the probe function - if that
fails, then we can't use DMA, and it's not something that requires
any cleanup.

With that gone, convert the other devm_kzalloc() there for buf.buf to
kzalloc(), and ensure that it's appropriately freed.  Note that this
driver is _already_ buggy in that if:

        } else if (mtd->oobsize < (denali->bbtskipbytes +
                        ECC_8BITS * (mtd->writesize /
                        ECC_SECTOR_SIZE))) {
                pr_err("Your NAND chip OOB is not large enough to contain 8bit ECC correction codes");
                goto failed_req_irq;

fails, or these:

        ret = nand_scan_tail(mtd);
        if (ret)
                goto failed_req_irq;

        ret = mtd_device_register(mtd, NULL, 0);
        if (ret) {
                dev_err(denali->dev, "Failed to register MTD: %d\n", ret);
                goto failed_req_irq;
        }

it doesn't unmap the buffer.  So, the driver is already broken.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
