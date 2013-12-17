From: b32955@freescale.com (Huang Shijie)
Date: Tue, 17 Dec 2013 10:56:47 +0800
Subject: [PATCH v3 3/7] mtd: spi-nor: add the framework for SPI NOR
In-Reply-To: <52AF4976.7090305@ti.com>
References: <1387184330-14448-1-git-send-email-b32955@freescale.com>
 <1387184330-14448-4-git-send-email-b32955@freescale.com>
 <52AF4976.7090305@ti.com>
Message-ID: <20131217025646.GD12575@shlinux2.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 17, 2013 at 12:11:58AM +0530, Sourav Poddar wrote:
> >+static int spi_nor_read(struct mtd_info *mtd, loff_t from, size_t len,
> >+			size_t *retlen, u_char *buf)
> >+{
> >+	struct spi_nor *nor = mtd_to_spi_nor(mtd);
> >+	int ret;
> >+
> >+	dev_dbg(nor->dev, "from 0x%08x, len %zd\n", (u32)from, len);
> >+
> >+	ret = spi_nor_lock_and_prep(nor, SPI_NOR_OPS_READ);
> >+	if (ret)
> >+		return ret;
> >+
> >+	/* Wait till previous write/erase is done. */
> >+	ret = wait_till_ready(nor);
> >+	if (ret)
> >+		goto read_err;
> >+
> 
> Can you shift "wait_till_ready" above spi_nor_lock_and_prep?
> One usecase for asking for above change is that I am planning to
> use this _prep api for switching to memory mapped mode for read and once
> I am switched to mmap mode, read_sr calls in wait_till_ready will not
> work for me.
> 
you can implement your own wait_till_ready here.

Only we have grabbed the lock, then we can do the transactions with the NOR.

We can not call the wait_till_ready before we grab the lock, it is wrong.


If you really can not implement your own wait_till_ready, the final solution
is removing the wait_till_ready in this function, and add the wait_till_ready
in the nor->read() hook.


thanks
Huang Shijie
     
