From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 13 Jul 2011 10:07:54 +0100
Subject: [PATCH V2 01/12] DMA: PL330: Add support runtime PM for PL330 DMAC
In-Reply-To: <1310546857-6304-2-git-send-email-kgene.kim@samsung.com>
References: <1310546857-6304-1-git-send-email-kgene.kim@samsung.com>
	<1310546857-6304-2-git-send-email-kgene.kim@samsung.com>
Message-ID: <20110713090754.GH23270@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 13, 2011 at 05:47:26PM +0900, Kukjin Kim wrote:
> @@ -688,7 +691,8 @@ pl330_probe(struct amba_device *adev, const struct amba_id *id)
>  	pi->mcbufsz = pdat->mcbuf_sz;
>  
>  	res = &adev->res;
> -	request_mem_region(res->start, resource_size(res), "dma-pl330");
> +	request_mem_region(res->start,
> +		resource_size(res), dev_name(&adev->dev));

The convention that we've been using is:

10004000-10004fff : mb:aaci
  10004000-10004fff : aaci-pl041
10005000-10005fff : mb:mmci
  10005000-10005fff : mmci-pl18x
10006000-10006fff : mb:kmi0
  10006000-10006fff : kmi-pl050
10007000-10007fff : mb:kmi1
  10007000-10007fff : kmi-pl050
10009000-10009fff : mb:uart0
  10009000-10009fff : uart-pl011
1000a000-1000afff : mb:uart1
  1000a000-1000afff : uart-pl011
1000b000-1000bfff : mb:uart2
  1000b000-1000bfff : uart-pl011
1000c000-1000cfff : mb:uart3
  1000c000-1000cfff : uart-pl011

The parent resource uses the device name.  The child resource is the
driver name.  That (a) avoids useless duplication of data in /proc/iomem
and (b) is more informative when you look at /proc/iomem about what's
where.
