From: computersforpeace@gmail.com (Brian Norris)
Date: Sat, 11 Jan 2014 16:04:14 -0800
Subject: [PATCH 3/4] mtd: nand: kill the the
 NAND_MAX_PAGESIZE/NAND_MAX_OOBSIZE for nand_buffers{}
In-Reply-To: <20140111234353.GO15937@n2100.arm.linux.org.uk>
References: <1387555350-989-1-git-send-email-shijie8@gmail.com>
 <1387555350-989-4-git-send-email-shijie8@gmail.com>
 <20140111233937.GF1992@norris-Latitude-E6410>
 <20140111234353.GO15937@n2100.arm.linux.org.uk>
Message-ID: <20140112000414.GH1992@norris-Latitude-E6410>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jan 11, 2014 at 11:43:53PM +0000, Russell King - ARM Linux wrote:
> On Sat, Jan 11, 2014 at 03:39:37PM -0800, Brian Norris wrote:
> > When you move this after nand_scan_ident(), you forgot to move all the code
> > that uses dmabuf and dmabuf:
> > 
> >         /* Set up DMA address */
> >         cafe_writel(cafe, cafe->dmaaddr & 0xffffffff, NAND_DMA_ADDR0);
> >         if (sizeof(cafe->dmaaddr) > 4)
> >                 /* Shift in two parts to shut the compiler up */
> >                 cafe_writel(cafe, (cafe->dmaaddr >> 16) >> 16, NAND_DMA_ADDR1);
> >         else
> >                 cafe_writel(cafe, 0, NAND_DMA_ADDR1);
> > 
> >         cafe_dev_dbg(&cafe->pdev->dev, "Set DMA address to %x (virt %p)\n",
> >                 cafe_readl(cafe, NAND_DMA_ADDR0), cafe->dmabuf);
> > 
> > This code needs to stay after the point where you actually allocate the buffer.
> 
> You may wish to evaluate generated code differences between the above and
> implementing it like this:
> 
> 	u64 dmaaddr = cafe->dmaaddr;
> 
> 	cafe_writel(cafe, dmaaddr, NAND_DMA_ADDR0);
> 	cafe_writel(cafe, dmaaddr >> 32, NAMD_DMA_ADDR1);

Well, that's not the primary concern of this patch, but that looks good.
Thanks for the idea. I'll take a look sometime.

Brian
